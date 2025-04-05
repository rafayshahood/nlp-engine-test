# Use official Ubuntu 20.04 base
FROM ubuntu:20.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary tools and libraries
RUN apt update && apt install -y \
    git build-essential cmake g++ curl unzip zip tar \
    autoconf-archive pkg-config python3 ninja-build libicu-dev

# Clone your repository (deep clone)
RUN git clone --recurse-submodules https://github.com/rafayshahood/nlp-engine-test.git /nlp-engine-test

# Set working directory
WORKDIR /nlp-engine-test

# Bootstrap vcpkg (required to install libraries later)
RUN ./vcpkg/bootstrap-vcpkg.sh && \
    ./vcpkg/vcpkg install
    
# Create build directory
RUN mkdir build

# Configure the project
RUN cmake -DCMAKE_BUILD_TYPE=Release \
          -DVCPKG_BUILD_TYPE=release \
          -B build -S . \
          -DCMAKE_TOOLCHAIN_FILE="/nlp-engine-test/vcpkg/scripts/buildsystems/vcpkg.cmake"

# Compile the project
RUN cmake --build build --target all

# Create a writable bin/ folder just in case
RUN chmod +w /nlp-engine-test/bin

# Change default directory again
WORKDIR /nlp-engine-test

# Default shell when container runs
CMD [ "bash" ]