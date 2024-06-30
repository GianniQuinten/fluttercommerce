# Stage 1: Build the backend
FROM node:14 AS backend-builder

WORKDIR /app/backend
COPY backend/package.json backend/package-lock.json ./
RUN npm install
COPY backend/ ./

# Stage 2: Build the frontend
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

# Stage 3: Serve the frontend with nginx
FROM nginx:latest AS frontend-server

COPY --from=builder /app/build/web /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Stage 4: Final stage
FROM ubuntu:20.04

# Copy backend build artifacts
COPY --from=backend-builder /app/backend /app/backend

# Copy frontend build artifacts
COPY --from=frontend-server /usr/share/nginx/html /usr/share/nginx/html
COPY --from=frontend-server /etc/nginx/nginx.conf /etc/nginx/nginx.conf

# Install dependencies
RUN apt-get update && apt-get install -y \
    supervisor \
    nginx \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    sudo \
    -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

# Setup supervisor to manage processes
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Expose port
EXPOSE 80

# Command to start supervisor
CMD ["/usr/bin/supervisord"]
