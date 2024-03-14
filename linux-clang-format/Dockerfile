FROM ubuntu:20.04
LABEL maintainer="suyu"

RUN apt-get update && apt-get -y full-upgrade && \
    apt-get install -y git gpg-agent wget && \
    wget https://apt.llvm.org/llvm-snapshot.gpg.key && apt-key add ./llvm-snapshot.gpg.key && \
    echo "deb http://apt.llvm.org/focal/ llvm-toolchain-focal-15 main" >> /etc/apt/sources.list && \
    apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y clang-format-15 && \
    apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log
