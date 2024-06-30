#!/bin/bash

# Check if the web server is running
curl -f http://localhost:8080 || exit 1

echo "Smoke tests passed!"
