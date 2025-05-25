#!/bin/bash

# Script to push the K2 language repository to GitHub

# Set the working directory to the repository root
cd "$(dirname "$0")/.."

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed."
    echo "Please install git: sudo apt install git"
    exit 1
fi

# Check if the repository is already initialized
if [ ! -d ".git" ]; then
    echo "Initializing git repository..."
    git init
fi

# Add all files
echo "Adding files to git..."
git add .

# Commit changes
echo "Committing changes..."
git commit -m "Initial commit of K2 language"

# Add GitHub remote
echo "Adding GitHub remote..."
git remote add origin https://github.com/JJPEOPLES/k2lang.git

# Push to GitHub
echo "Pushing to GitHub..."
echo "You may be prompted for your GitHub credentials."
git push -u origin master

echo "Repository pushed to GitHub successfully!"
echo "Visit https://github.com/JJPEOPLES/k2lang to see your repository."