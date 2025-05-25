#!/bin/bash

# Test script for K2 language

# Set the working directory to the repository root
cd "$(dirname "$0")/.."

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

# Function to run a test
run_test() {
    local test_file="$1"
    local test_name=$(basename "$test_file" .k2)
    
    echo "Running test: $test_name"
    bin/k2 "$test_file"
    
    if [ $? -eq 0 ]; then
        echo "✅ Test passed: $test_name"
        return 0
    else
        echo "❌ Test failed: $test_name"
        return 1
    fi
}

# Run all tests in the tests directory
echo "Running K2 language tests..."
echo "============================"

# Check if tests directory exists and has .k2 files
if [ ! -d "tests" ] || [ -z "$(find tests -name '*.k2' 2>/dev/null)" ]; then
    echo "No tests found in the tests directory."
    echo "Creating example tests..."
    
    # Create tests directory if it doesn't exist
    mkdir -p tests
    
    # Create some basic test files
    cat > tests/basic.k2 << 'EOF'
# Basic test
x = 42
y = x
print y
# Expected output: 42
EOF

    cat > tests/arithmetic.k2 << 'EOF'
# Arithmetic test
a = 10
b = 5
sum = a + b
diff = a - b
prod = a * b
quot = a / b
print sum
print diff
print prod
print quot
# Expected output:
# 15
# 5
# 50
# 2
EOF

    cat > tests/complex.k2 << 'EOF'
# Complex expression test
a = 2
b = 3
c = 4
result = a + b * c
print result
# Expected output: 14
EOF

    echo "Example tests created in the tests directory."
fi

# Run all tests
failed_tests=0
total_tests=0

for test_file in tests/*.k2; do
    if [ -f "$test_file" ]; then
        total_tests=$((total_tests + 1))
        run_test "$test_file"
        failed_tests=$((failed_tests + $?))
    fi
done

echo "============================"
echo "Test summary: $((total_tests - failed_tests))/$total_tests tests passed"

if [ $failed_tests -eq 0 ]; then
    echo "All tests passed! 🎉"
    exit 0
else
    echo "$failed_tests tests failed. 😢"
    exit 1
fi