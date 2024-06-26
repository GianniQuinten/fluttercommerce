# Use an official Ubuntu image as a parent image
FROM ubuntu:20.04 as builder

# Set the timezone environment variable non-interactively
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install required dependencies
RUN apt-get update && apt-get install -y \
  curl \
  git \
  unzip \
  xz-utils \
  libglu1-mesa \
  sudo

# Create the sudoers.d directory if it doesn't exist and create a new user 'flutteruser'
RUN mkdir -p /etc/sudoers.d && \
    useradd -m flutteruser && echo 'flutteruser ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/flutteruser

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

# Use an official Nginx image as the base image for serving content
FROM nginx:latest

# Copy built Flutter web app from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 8080

# Start Nginx and serve the content
CMD ["nginx", "-g", "daemon off;"]
