# Use an official Ubuntu image as a parent image
FROM ubuntu:20.04 as builder

# Set the timezone environment variable non-interactively
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install required dependencies
RUN apt-get update && apt-get install -y \
  tzdata \
  curl \
  git \
  unzip \
  xz-utils \
  zip \
  libglu1-mesa \
  sudo \
  nginx

# Copy your nginx.conf to the appropriate location
COPY nginx.conf /etc/nginx/nginx.conf

# Create a new user 'flutteruser'
RUN useradd -m flutteruser && echo 'flutteruser ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/flutteruser
USER flutteruser

# Install Flutter (latest stable)
RUN git clone https://github.com/flutter/flutter.git /home/flutteruser/flutter --branch stable --depth 1
ENV PATH="/home/flutteruser/flutter/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Change ownership of all files
RUN sudo chown -R flutteruser:flutteruser /app

# Install Flutter dependencies
RUN flutter pub get

# Build the Flutter web application
RUN flutter clean && flutter build web --release

# Install Goss for testing
RUN curl -fsSL https://goss.rocks/install | sudo sh

# Use an official Nginx image as the base image for serving content
FROM nginx:alpine

# Copy built Flutter web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy Goss configuration file
COPY --from=builder /app/goss.yaml /goss.yaml

# Copy the nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx and serve the content
CMD ["nginx", "-g", "daemon off;"]
