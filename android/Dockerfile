FROM ubuntu:jammy
ENV ANDROID_HOME=/usr/lib/android-sdk/
RUN apt-get update --yes \
    && apt-get install --yes ccache apksigner glslang-dev glslang-tools git sdkmanager android-sdk bash openjdk-17-jdk openjdk-17-jre curl zip unzip tar cmake ninja-build pkg-config \
    && apt-get install --yes --no-install-recommends clang-14 lld-14 llvm-14 llvm-14-linker-tools \
    && apt-get clean \
    && ln -s $(which clang-14) /usr/bin/clang && ln -s $(which clang++-14) /usr/bin/clang++ \
    && echo y | sdkmanager --sdk_root=/usr/lib/android-sdk --licenses
