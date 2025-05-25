# K2 Programming Language

K2 is an ultra-fast programming language with execution times between 70 nanoseconds and 9 milliseconds. It features a simple syntax for basic arithmetic operations and variable management.

## Features

- **Ultra-Fast Execution**: Most operations complete in under 1000 nanoseconds
- **Simple Syntax**: Easy to learn and use
- **Performance Monitoring**: Built-in execution time display
- **File-Based Execution**: Run programs from files
- **Direct Expression Mode**: Execute single expressions from the command line
- **Minimal Footprint**: The entire interpreter is under 30KB

## Quick Start

### Installation

#### From Source

```bash
# Clone the repository
git clone https://github.com/JJPEOPLES/k2lang.git
cd k2lang

# Build and install
./scripts/build.sh
sudo ./scripts/install.sh
```

#### Using the Debian Package

```bash
# Build the Debian package
./scripts/build_deb.sh

# Install the package
sudo dpkg -i k2-language_1.0.0-1_amd64.deb
```

### Running K2 Programs

```bash
# Run a K2 program file
k2 examples/basic.k2

# Execute a single expression
k2 -e "print 100 + 200"
```

## Examples

### Basic Example

```
# Basic K2 program
x = 42
print x
```

Output:
```
42
Execution time: 1230 nanoseconds
```

### Arithmetic Example

```
# Arithmetic operations
a = 10
b = 5

sum = a + b
diff = a - b
product = a * b
quotient = a / b

print sum
print diff
print product
print quotient
```

Output:
```
15
Execution time: 1150 nanoseconds
5
Execution time: 1120 nanoseconds
50
Execution time: 1130 nanoseconds
2
Execution time: 1140 nanoseconds
```

## Repository Structure

- `src/` - Source code for the K2 language
- `bin/` - Precompiled binary
- `docs/` - Documentation
- `examples/` - Example K2 programs
- `scripts/` - Build and installation scripts
- `tests/` - Test files

## Scripts

- `scripts/build.sh` - Builds the K2 interpreter from source
- `scripts/install.sh` - Installs K2 on your system
- `scripts/build_deb.sh` - Creates a Debian package
- `scripts/run_tests.sh` - Runs the test suite

## Documentation

For complete documentation, see the [K2 Language Documentation](docs/k2-documentation.md).

## Performance

K2 is designed for speed. Here are typical execution times:

| Operation Type | Execution Time Range |
|----------------|----------------------|
| Variable assignment | 100-400 nanoseconds |
| Simple arithmetic | 70-500 nanoseconds |
| Print operation | 1000-2000 nanoseconds |
| Complex expressions | 300-5000 nanoseconds |

## License

K2 is released under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.