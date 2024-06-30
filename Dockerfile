# Stage 1: Build the backend
FROM node:14 AS backend-builder

WORKDIR /app/backend
COPY backend/package.json backend/package-lock.json ./
RUN npm install
COPY backend/ ./

# Stage 2: Build the frontend (assuming you have a frontend part)
FROM node:14 AS frontend-builder

WORKDIR /app/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm install
COPY frontend/ ./

# Stage 3: Serve the frontend with nginx
FROM nginx:latest AS stage-2

COPY --from=frontend-builder /app/frontend/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf

# Stage 4: Final stage
FROM ubuntu:20.04

# Copy backend build artifacts
COPY --from=backend-builder /app/backend /app/backend

# Install dependencies
RUN apt-get update && apt-get install -y \
    supervisor \
    curl \
    git \
    unzip \
    xz-utils \
    libglu1-mesa \
    sudo

# Setup supervisor to manage processes
COPY supervisord.conf /etc/supervisor/supervisord.conf

# Expose ports
EXPOSE 80

# Command to start supervisor
CMD ["/usr/bin/supervisord"]
