# Use official Ubuntu 20.04 image
FROM ubuntu:20.04

# Set environment to non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt update && apt install -y \
    git build-essential cmake g++ curl unzip zip tar \
    autoconf-archive pkg-config python3 ninja-build \
    libicu-dev \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Clone your project
RUN git clone --recurse-submodules https://github.com/rafayshahood/nlp-engine-test.git /nlp-engine-test

# Set working directory
WORKDIR /nlp-engine-test

# Bootstrap vcpkg
RUN ./vcpkg/bootstrap-vcpkg.sh

# Install libraries via vcpkg
RUN ./vcpkg/vcpkg install

# Build the project
RUN mkdir -p build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DVCPKG_BUILD_TYPE=release \
          -B build -S . \
          -DCMAKE_TOOLCHAIN_FILE="/nlp-engine-test/vcpkg/scripts/buildsystems/vcpkg.cmake" && \
    cmake --build build --target all

# Fix permissions for bin
RUN chmod +w /nlp-engine-test/bin

# Set default workdir for running commands
WORKDIR /nlp-engine-test

# ✅ Set runtime environment variables (Optional but good practice)
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
