# Contributing to K2 Language

Thank you for your interest in contributing to the K2 programming language! This document provides guidelines and instructions for contributing to the project.

## Code of Conduct

Please be respectful and considerate of others when contributing to this project. We aim to foster an inclusive and welcoming community.

## How to Contribute

### Reporting Bugs

If you find a bug in K2, please report it by creating an issue on GitHub. When reporting a bug, please include:

1. A clear and descriptive title
2. A detailed description of the bug
3. Steps to reproduce the bug
4. Expected behavior
5. Actual behavior
6. K2 version and operating system information
7. Any relevant code snippets or example files

### Suggesting Enhancements

We welcome suggestions for enhancements to K2. To suggest an enhancement:

1. Create an issue on GitHub with a clear and descriptive title
2. Provide a detailed description of the enhancement
3. Explain why this enhancement would be useful
4. Provide examples of how the enhancement would work

### Pull Requests

We welcome pull requests for bug fixes, enhancements, and documentation improvements. To submit a pull request:

1. Fork the repository
2. Create a new branch for your changes
3. Make your changes
4. Run the tests to ensure your changes don't break existing functionality
5. Submit a pull request with a clear description of your changes

## Development Setup

### Prerequisites

- C++ compiler with C++17 support (GCC 7+ or Clang 5+)
- CMake 3.10+ (optional, for CMake build)
- Bash (for scripts)

### Building K2

#### Using the build script

```bash
./scripts/build.sh
```

#### Using CMake

```bash
mkdir build
cd build
cmake ..
make
```

### Running Tests

```bash
./scripts/run_tests.sh
```

Or with CMake:

```bash
cd build
make test
```

## Coding Guidelines

### C++ Style

- Use C++17 features where appropriate
- Follow a consistent indentation style (4 spaces)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused on a single task

### Commit Messages

- Use clear and descriptive commit messages
- Start with a short summary line (50 characters or less)
- Optionally, follow with a blank line and a more detailed explanation

## Documentation

When adding new features or making significant changes, please update the documentation accordingly. This includes:

- Updating the README.md file if necessary
- Adding or updating documentation in the docs/ directory
- Adding examples for new features in the examples/ directory

## License

By contributing to K2, you agree that your contributions will be licensed under the project's MIT License.