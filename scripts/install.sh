#!/bin/bash

# Installation script for K2 language

# Set the working directory to the repository root
cd "$(dirname "$0")/.."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script with sudo: sudo ./scripts/install.sh"
  exit 1
fi

# Check if the binary exists
if [ ! -f "bin/k2" ]; then
    echo "K2 binary not found. Building from source..."
    ./scripts/build.sh
    
    # Check if build was successful
    if [ ! -f "bin/k2" ]; then
        echo "Build failed. Please check the error messages above."
        exit 1
    fi
fi

# Create installation directories
echo "Creating installation directories..."
mkdir -p /usr/local/bin
mkdir -p /usr/local/lib/k2
mkdir -p /usr/local/share/k2/examples
mkdir -p /usr/local/share/k2/docs
mkdir -p /usr/local/share/man/man1

# Install K2
echo "Installing K2..."
cp bin/k2 /usr/local/bin/
cp bin/k2 /usr/local/lib/k2/

# Install example programs
echo "Installing example programs..."
cp -r examples/* /usr/local/share/k2/examples/

# Install documentation
echo "Installing documentation..."
cp -r docs/* /usr/local/share/k2/docs/

# Create man page
echo "Creating man page..."
cat > /usr/local/share/man/man1/k2.1 << 'EOF'
.TH K2 1 "2023" "K2 Language" "K2 Language Manual"
.SH NAME
k2 \- ultra-fast programming language interpreter
.SH SYNOPSIS
.B k2
[\fIFILENAME\fR]
.br
.B k2
\fB-e\fR "\fIEXPRESSION\fR"
.SH DESCRIPTION
.B k2
is an ultra-fast programming language designed to execute operations in the range of 70 nanoseconds to 9 milliseconds.
.SH OPTIONS
.TP
.BR \-e " " \fIEXPRESSION\fR
Execute a single K2 expression.
.SH EXAMPLES
.TP
Execute a K2 program file:
.B k2 program.k2
.TP
Execute a single expression:
.B k2 -e "print 100 + 200"
.SH FILES
.TP
.I /usr/local/share/k2/examples/
Example K2 programs
.TP
.I /usr/local/share/k2/docs/
K2 language documentation
.SH AUTHOR
K2 Language Team
EOF

# Update man database
if command -v mandb &> /dev/null; then
    mandb -q
fi

echo
echo "K2 language has been installed successfully!"
echo "You can now run K2 programs from anywhere using the 'k2' command:"
echo "  k2 program.k2"
echo "  k2 -e \"print 100 + 200\""
echo
echo "Example programs are available in /usr/local/share/k2/examples/"
echo "Documentation is available in /usr/local/share/k2/docs/"
echo "Man page is available via 'man k2'"
echo
echo "Thank you for installing K2!"