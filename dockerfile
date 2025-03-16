# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Set the architecture argument
ARG ARCH
RUN echo "Building for architecture: $ARCH"

# Install required dependencies
RUN apt update && apt install -y libicu-dev pkg-config python3 ninja-build build-essential cmake g++ git curl zip unzip tar

# Copy the precompiled binary (or build from source)
COPY nlp /usr/local/bin/nlp
RUN chmod +x /usr/local/bin/nlp

# Set the entrypoint to the nlp binary
CMD ["nlp", "--version"]