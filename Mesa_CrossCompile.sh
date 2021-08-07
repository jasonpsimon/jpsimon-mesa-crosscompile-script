#!/bin/bash

# Declare Variables
Architecture=""
UserInput=0

# Ask for Architecture
echo "What Architecture of Windows would you like to compile for? (Press 1 for 32bit and press 2 for 64bit): "
read UserInput

# Convert UserInput to Architecture
if [ $UserInput = 1 ]; then
Architecture="x86"
fi
if [ $UserInput = 2 ]; then
Architecture="x86_64"
fi

# Download Dependencies
sudo pacman -S --noconfirm base-devel xorg llvm python python-mako python2 python2-mako bison scons mingw-w64 mingw-w64-toolchain libxml2

# Create Mesa Working Directory in the Home Folder
mkdir mesa

# Go to Working Mesa Directory
cd mesa

# Get Current Mesa Version
wget https://mesa.freedesktop.org/archive/$(wget -O- https://mesa.freedesktop.org/archive | egrep -o 'mesa-[0-9\.]+.tar.gz' | sort -V  | tail -1)

# Unpack Mesa Archive
tar zxf mesa-*.tar.gz

# Remove Tarball
rm mesa-*.tar.gz

# Navigate to Extracted Mesa Directory
cd mesa*

# Cross-Compile Mesa Driver for Windows
LDFLAGS="-static -s" scons build=release platform=windows 
toolchain=crossmingw machine=$Architecture libgl-gdi

# Copy 
cp ~/mesa/mesa*/build/windows-x86/gallium/targets/libgl-gdi/opengl32.dll ~/mesa/

# Remove Unnecessary Files
rm -rf ~/mesa/mesa*

# Final User Instructions
echo "Your opengl32.dll file can be retrieved from the following location: ~/mesa/opengl32.dll"
echo "Your opengl32.dll file can be retrieved from the following location: ~/mesa/opengl32.dll"
echo "Your opengl32.dll file can be retrieved from the following location: ~/mesa/opengl32.dll"
