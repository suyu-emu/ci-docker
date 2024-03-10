#! /bin/bash
echo

# Exit on error, rather than continuing with the rest of the script
set -e

# Utility functions
function min {
    echo $(( $1 > $2 ? $2 : $1 ))
}

# Leave wineserver running in the background
setsid wineserver -p -f &

# Install tools
echo " --- Installing tools"
cd ~/.wine/drive_c/Program\ Files/

# Install CMake
echo " -- Installing CMake"
wget -q https://github.com/Kitware/CMake/releases/download/v3.28.3/cmake-3.28.3-windows-x86_64.zip
unzip -q *.zip
rm *.zip
mv cmake-*-windows-x86_64 cmake

# Install ccache
echo " -- Installing ccache"
wget -q https://github.com/ccache/ccache/releases/download/v4.9.1/ccache-4.9.1-windows-x86_64.zip
unzip -q *.zip
rm *.zip
mv ccache-*-windows-x86_64 ccache

# Install Ninja
echo " -- Installing Ninja"
wget -q https://github.com/ninja-build/ninja/releases/download/v1.11.1/ninja-win.zip
mkdir ninja
pushd ninja/ > /dev/null
unzip -q ../ninja-win.zip
popd > /dev/null
rm *.zip

# Install LLVM toolchain
echo " -- Installing LLVM toolchain"
wget -q https://github.com/mstorsjo/llvm-mingw/releases/download/20240308/llvm-mingw-20240308-msvcrt-x86_64.zip
unzip -q *.zip
rm *.zip
mv llvm-mingw-*-x86_64 llvm

# Install registry file
echo " -- Updating PATH environment variable"
wine regedit 'Z:\tmp\setup.reg'

# Print versions
echo " -- Tools installed:"
echo -n " - " ; wine cmake.exe --version | head -1
echo -n " - " ; wine ccache.exe --version | head -1
echo -n " - Ninja " ; wine ninja.exe --version
echo -n " - " ; wine clang.exe --version | head -1

# Download and compile out-of-tree dependencies
echo " --- Installing out-of-tree dependencies"
cd ~/.wine/drive_c/

# Download and compile Boost
echo " -- Downloading Boost"
wget -q https://boostorg.jfrog.io/artifactory/main/release/1.84.0/source/boost_1_84_0.zip
unzip -q *.zip
rm *.zip
mv boost_* boost-src
cd boost-src/
echo " -- Bootstrapping Boost (no output due to Wine workarounds)"
xvfb-run wineconsole ./bootstrap.bat clang &> /dev/null
echo " -- Compiling boost"
wine ./b2.exe -j1 --with-context install # Limiting to 2 to avoid "Too many open files"
echo " -- Deleting boost sources"
cd ../
rm -rf boost-src

# Download and compile fmt
echo " -- Downloading fmt"
wget -q -Ofmt.zip https://github.com/fmtlib/fmt/archive/refs/tags/10.2.1.zip
unzip -q *.zip
rm *.zip
mv fmt-* fmt-src
cd fmt-src/
echo " -- Configuring fmt"
mkdir build
cd build/
wine cmake.exe .. -G Ninja
echo " -- Compiling fmt"
wine ninja.exe install
echo " -- Deleting fmt sources"
cd ../../
rm -rf fmt-src

# Download LZ4
echo " -- Downloading LZ4"
wget -q https://github.com/lz4/lz4/releases/download/v1.9.4/lz4_win64_v1_9_4.zip
mkdir lz4
pushd lz4/ > /dev/null
unzip -q ../lz4_win64_*.zip
popd > /dev/null
rm *.zip