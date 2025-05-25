#!/bin/bash

# Script to build a Debian package for K2 language

# Set the working directory to the repository root
cd "$(dirname "$0")/.."

# Package details
PKG_NAME="k2-language"
PKG_VERSION="1.0.0"
PKG_RELEASE="1"
PKG_ARCH="amd64"
PKG_MAINTAINER="K2 Language Team <info@k2-language.org>"
PKG_DESCRIPTION="Ultra-fast programming language with execution times between 70 nanoseconds and 9 milliseconds"

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

# Create package directory structure
PKG_DIR="${PKG_NAME}-${PKG_VERSION}"
rm -rf "$PKG_DIR"
mkdir -p "$PKG_DIR/DEBIAN"
mkdir -p "$PKG_DIR/usr/bin"
mkdir -p "$PKG_DIR/usr/lib/k2"
mkdir -p "$PKG_DIR/usr/share/k2/examples"
mkdir -p "$PKG_DIR/usr/share/k2/docs"
mkdir -p "$PKG_DIR/usr/share/man/man1"
mkdir -p "$PKG_DIR/usr/share/doc/${PKG_NAME}"

# Create control file
cat > "$PKG_DIR/DEBIAN/control" << EOF
Package: $PKG_NAME
Version: $PKG_VERSION-$PKG_RELEASE
Section: devel
Priority: optional
Architecture: $PKG_ARCH
Maintainer: $PKG_MAINTAINER
Description: $PKG_DESCRIPTION
 K2 is a minimalist programming language designed for ultra-fast execution
 with operations completing in 70 nanoseconds to 9 milliseconds.
 .
 Features:
  * Ultra-fast execution times
  * Simple, clean syntax
  * Built-in execution time measurement
  * Minimal memory footprint
  * No external dependencies
EOF

# Copy files
echo "Copying files to package directory..."
cp bin/k2 "$PKG_DIR/usr/bin/"
cp bin/k2 "$PKG_DIR/usr/lib/k2/"
cp -r examples/* "$PKG_DIR/usr/share/k2/examples/"
cp -r docs/* "$PKG_DIR/usr/share/k2/docs/"

# Create man page
cat > "$PKG_DIR/usr/share/man/man1/k2.1" << 'EOF'
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
.I /usr/share/k2/examples/
Example K2 programs
.TP
.I /usr/share/k2/docs/
K2 language documentation
.SH AUTHOR
K2 Language Team
EOF

# Compress man page
gzip -9 "$PKG_DIR/usr/share/man/man1/k2.1"

# Copy copyright and changelog
cat > "$PKG_DIR/usr/share/doc/${PKG_NAME}/copyright" << 'EOF'
Format: https://www.debian.org/doc/packaging-manuals/copyright-format/1.0/
Upstream-Name: k2-language
Upstream-Contact: K2 Language Team <info@k2-language.org>
Source: https://github.com/JJPEOPLES/k2lang

Files: *
Copyright: 2023 K2 Language Team
License: MIT
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 .
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 .
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
EOF

cat > "$PKG_DIR/usr/share/doc/${PKG_NAME}/changelog.Debian" << EOF
$PKG_NAME ($PKG_VERSION-$PKG_RELEASE) unstable; urgency=low

  * Initial release.

 -- $PKG_MAINTAINER  $(date -R)
EOF

# Compress changelog
gzip -9 "$PKG_DIR/usr/share/doc/${PKG_NAME}/changelog.Debian"

# Set permissions
find "$PKG_DIR" -type d -exec chmod 755 {} \;
find "$PKG_DIR" -type f -exec chmod 644 {} \;
chmod 755 "$PKG_DIR/usr/bin/k2"
chmod 755 "$PKG_DIR/usr/lib/k2/k2"
chmod 755 "$PKG_DIR/DEBIAN/control"

# Build the package
echo "Building Debian package..."
dpkg-deb --build "$PKG_DIR"

# Rename the package to follow Debian conventions
mv "${PKG_DIR}.deb" "${PKG_NAME}_${PKG_VERSION}-${PKG_RELEASE}_${PKG_ARCH}.deb"

echo "Debian package created: ${PKG_NAME}_${PKG_VERSION}-${PKG_RELEASE}_${PKG_ARCH}.deb"
echo "You can install it with: sudo dpkg -i ${PKG_NAME}_${PKG_VERSION}-${PKG_RELEASE}_${PKG_ARCH}.deb"