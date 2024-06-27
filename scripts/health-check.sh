#!/bin/bash

# Check if the web server is running
curl -f http://localhost:8080 || exit 1

# Check if the application returns the correct page
curl -f http://localhost:8080/health || exit 1

echo "Health check passed!"
