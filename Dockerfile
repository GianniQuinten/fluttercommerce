# Stage 1: Build Flutter frontend
FROM ubuntu:20.04 as flutter-builder

# Install necessary dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    sudo

# Set up Flutter environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV PATH="/flutter/bin:${PATH}"

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter --branch stable --depth 1

# Set working directory
WORKDIR /app

# Copy Flutter frontend source code
COPY . .

# Install Flutter dependencies
RUN flutter pub get

# Build Flutter web application
RUN flutter clean && flutter build web --release

# Stage 2: Build Node.js backend
FROM node:14 as backend-builder

# Set working directory
WORKDIR /app/backend

# Copy backend source code
COPY backend/package.json backend/package-lock.json ./
RUN npm install

# Copy backend source code
COPY backend .

# Build backend (if needed)
RUN npm run build  # Adjust as per your backend build command

# Stage 3: Production image with Nginx serving frontend and proxying to backend
FROM nginx:latest

# Install supervisord
RUN apt-get update && apt-get install -y supervisor

# Copy built Flutter web app from flutter-builder stage
COPY --from=flutter-builder /app/build/web /usr/share/nginx/html

# Copy built Node.js backend from backend-builder stage
COPY --from=backend-builder /app/backend /usr/src/app

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy supervisord configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose port 80
EXPOSE 80

# Start supervisord
CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
