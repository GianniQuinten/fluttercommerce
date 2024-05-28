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

# Set the working directory and ensure it is owned by flutteruser
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY --chown=flutteruser:flutteruser . .

# Install Flutter dependencies
RUN flutter pub get

# Build the Flutter web application
RUN flutter clean && flutter build web --release

# Install Goss for testing
USER root
RUN curl -fsSL https://goss.rocks/install | sh

# Use an official Nginx image as the base image for serving content
FROM nginx:latest

# Copy built Flutter web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy Goss configuration file from local context
COPY goss.yaml /goss.yaml

# Copy the nginx.conf file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx and serve the content
CMD ["nginx", "-g", "daemon off;"]
