FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    g++ \
    git \
    curl \
    zip \
    unzip \
    autoconf-archive \
    pkg-config \
    python3 \
    ninja-build \
    bison \
    gawk \
    libicu-dev \
    texinfo \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /nlp-engine-test

# Clone your repo and submodules
RUN git clone --recurse-submodules https://github.com/rafayshahood/nlp-engine-test.git .

# Bootstrap vcpkg
RUN ./vcpkg/bootstrap-vcpkg.sh && ./vcpkg/vcpkg install

# Build the project
RUN mkdir -p build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DVCPKG_BUILD_TYPE=release \
          -B build -S . \
          -DCMAKE_TOOLCHAIN_FILE=/nlp-engine-test/vcpkg/scripts/buildsystems/vcpkg.cmake && \
    cmake --build build --target all

# Set binary location
ENV PATH="/nlp-engine-test/bin:${PATH}"