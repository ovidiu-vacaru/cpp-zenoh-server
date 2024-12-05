# Use an official C++ build environment
FROM ubuntu:22.04

# Set up environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    curl \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
    
# Install Rust using rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
ENV PATH="/root/.cargo/bin:${PATH}"


# Clone and build Zenoh C library
WORKDIR /opt
RUN git clone https://github.com/eclipse-zenoh/zenoh-c.git && \
    mkdir -p build && \ 
    cd build && \
    cmake ../zenoh-c && \
    cmake --build . --target install


RUN git clone https://github.com/eclipse-zenoh/zenoh-cpp.git && \
    cd zenoh-cpp && \
    mkdir build  &&\
    cd build && \
    cmake .. -DZENOHCXX_ZENOHC=ON -DZENOHCXX_ZENOHPICO=OFF && \
    cmake --install .

WORKDIR /app
COPY . /app

RUN mkdir build && cd build && cmake .. && cmake --build .


CMD ["./build/main"]



