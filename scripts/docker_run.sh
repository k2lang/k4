#!/bin/bash

# Script to run K2 in Docker

# Set the working directory to the repository root
cd "$(dirname "$0")/.."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Error: Docker is required but not installed."
    echo "Please install Docker: https://docs.docker.com/get-docker/"
    exit 1
fi

# Build the Docker image if it doesn't exist
if ! docker image inspect k2-language &> /dev/null; then
    echo "Building Docker image..."
    docker build -t k2-language .
fi

# Run K2 in Docker
if [ $# -eq 0 ]; then
    # If no arguments are provided, run an interactive shell
    echo "Starting K2 interactive shell in Docker..."
    docker run -it --rm -v "$(pwd)/examples:/examples" -w /examples k2-language -e "print 42"
else
    # If arguments are provided, run K2 with those arguments
    docker run -it --rm -v "$(pwd)/examples:/examples" -w /examples k2-language "$@"
fi