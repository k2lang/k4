FROM debian:bullseye-slim

# Install build dependencies
RUN apt-get update && apt-get install -y \
    g++ \
    make \
    cmake \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /k2

# Copy source code
COPY . .

# Build K2
RUN ./scripts/build.sh

# Set entrypoint
ENTRYPOINT ["./bin/k2"]

# Default command
CMD ["--help"]