FROM debian:trixie
COPY windows.sh /tmp/setup.sh
COPY windows.reg /tmp/setup.reg
COPY windows-libs.7z /tmp/windows-libs.7z
RUN apt-get update --yes \
    && apt-get -y install git wget unzip p7zip xvfb \
    && dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/trixie/winehq-trixie.sources \
    && apt-get update \
    && apt-get -y install winehq-devel \
    && export WINEDEBUG=-all \
    && wine winecfg \
    && /tmp/setup.sh \
    && rm /tmp/setup.sh \
    && apt-get -y autopurge wget unzip p7zip xvfb \
    && apt-get clean
