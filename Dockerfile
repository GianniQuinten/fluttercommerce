# Use an official Ubuntu image
FROM ubuntu:latest as builder

# Install required tools
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa sudo

# Create a new user and set up sudo
RUN useradd -m flutteruser && echo 'flutteruser ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/flutteruser
USER flutteruser

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /home/flutteruser/flutter --branch stable --depth 1
ENV PATH="/home/flutteruser/flutter/bin:${PATH}"

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Change ownership of all files
RUN sudo chown -R flutteruser:flutteruser /app

# Install dependencies
RUN flutter pub get

# Build the Flutter web application
RUN flutter build web

# Install Goss
RUN curl -fsSL https://goss.rocks/install | sudo sh

# Use nginx to serve the static content
FROM nginx:alpine

# Copy static assets from builder stage
COPY --from=builder /app/build/web /usr/share/nginx/html

# Copy Goss files
COPY --from=builder /app/goss.yaml /goss.yaml

# Expose port 80 to the outside world
EXPOSE 80

# Start nginx and serve the content
CMD ["nginx", "-g", "daemon off;"]
