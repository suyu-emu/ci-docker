FROM debian:trixie
RUN apt-get update --yes \
    && apt-get install --yes wget ccache cmake gcc g++ nasm git patchelf xz-utils ninja-build autoconf glslang-tools pkg-config catch2 libtool nlohmann-json3-dev qtbase5-dev qtbase5-private-dev qtmultimedia5-dev libqt5gui5 libva-dev libavcodec-dev libavfilter-dev libboost-dev libboost-context-dev libfmt-dev zlib1g-dev libzstd-dev libcurl4-openssl-dev liblz4-dev llvm-17-dev libedit-dev libssl-dev mesa-common-dev libzydis-dev libusb-dev libpulse-dev
    && apt-get clean
