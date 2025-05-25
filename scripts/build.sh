#!/bin/bash

# Build script for K2 language

# Set the working directory to the repository root
cd "$(dirname "$0")/.."

# Check if g++ is installed
if ! command -v g++ &> /dev/null; then
    echo "Error: g++ is required but not installed."
    echo "Please install g++ (on Debian/Ubuntu: sudo apt install g++)"
    exit 1
fi

# Create build directory if it doesn't exist
mkdir -p build

# Compile K2
echo "Compiling K2 language interpreter..."
g++ -std=c++17 -O3 src/k2.cpp -o build/k2

# Check if compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful!"
    echo "K2 interpreter built at: build/k2"
    
    # Copy to bin directory
    cp build/k2 bin/k2
    echo "Binary copied to: bin/k2"
else
    echo "Compilation failed!"
    exit 1
fi