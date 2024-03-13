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

# Install registry file
echo " -- Updating PATH environment variable"
wine regedit 'Z:\tmp\setup.reg'
rm /tmp/setup.reg

# Print versions
echo " -- Tools installed:"
echo -n " - " ; wine cmake.exe --version | head -1
echo -n " - " ; wine ccache.exe --version | head -1
echo -n " - Ninja " ; wine ninja.exe --version
#echo -n " - " ; wine clang.exe --version | head -1

# Unpack out-of-tree dependencies
echo " --- Unpacking out-of-tree dependencies"
cd ~/.wine/drive_c/
7z x /tmp/windows-libs.7z > /dev/null
rm /tmp/windows-libs.7z

# Finally
echo " --- Done! Finally killing wineserver"
wineserver -k || exit 0
