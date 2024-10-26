FROM ubuntu:16.04
ENV DEBIAN_FRONTEND=noninteractive

# Add repositories for older SSL libraries needed in 16.04
RUN apt-get update && apt-get install -y software-properties-common && \
    apt-add-repository universe

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    git \
    fuse \
    sudo \
    desktop-file-utils \
    libglib2.0-bin \
    curl \
    ca-certificates \
    build-essential \
    automake \
    autoconf \
    libtool \
    python3 \
    python3-pip \
    libfuse2 \
    zsync \
    file \
    patchelf \
    strace \
    binutils \
    libssl-dev \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash builder && \
    echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN git clone https://github.com/AppImage/pkg2appimage.git /opt/pkg2appimage && \
    chmod +x /opt/pkg2appimage/pkg2appimage

ENV PATH="/opt/pkg2appimage:${PATH}"

USER builder
WORKDIR /home/builder
CMD ["/bin/bash"]
