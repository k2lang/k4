cmake_minimum_required(VERSION 3.10)
project(K2Language VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Set optimization flags for Release build
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O3")

# Add executable
add_executable(k2 src/k2.cpp)

# Install targets
install(TARGETS k2 DESTINATION bin)
install(TARGETS k2 DESTINATION lib/k2)
install(DIRECTORY examples/ DESTINATION share/k2/examples)
install(DIRECTORY docs/ DESTINATION share/k2/docs)

# Add custom target for running tests
add_custom_target(test
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/scripts/run_tests.sh
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Running K2 language tests"
)

# Add custom target for building Debian package
add_custom_target(deb
    COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/scripts/build_deb.sh
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "Building Debian package"
)

# Output information
message(STATUS "K2 Language configuration:")
message(STATUS "  C++ standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "  Install prefix: ${CMAKE_INSTALL_PREFIX}")
message(STATUS "")
message(STATUS "Build targets:")
message(STATUS "  k2 - Build the K2 interpreter")
message(STATUS "  test - Run the test suite")
message(STATUS "  deb - Build a Debian package")
message(STATUS "")
message(STATUS "Install targets:")
message(STATUS "  install - Install K2 to ${CMAKE_INSTALL_PREFIX}")
message(STATUS "")
message(STATUS "Example usage:")
message(STATUS "  mkdir build && cd build")
message(STATUS "  cmake ..")
message(STATUS "  make")
message(STATUS "  sudo make install")