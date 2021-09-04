#!/bin/sh

# Prelim setup:
# Set gnuradio version to 3.7 for compatibility with gr-dvbs
add-apt-repository ppa:gnuradio/gnuradio-releases-3.7
# Update repos
apt update

# Install everything installable from repos:
apt install -y libhackrf-dev libavutil-dev libavdevice-dev libswresample-dev libswscale-dev libavformat-dev libavcodec-dev hackrf gr-osmosdr git cmake pkg-config cmake-data swig gnuradio libpcap-dev pybind11-dev liborc-dev libcurl4-openssl-dev opencaster ffmpeg libpcsclite-dev vlc

# Install gr-dvbs (DVB-S modulation modules for GNU Radio) from github:
git clone https://github.com/drmpeg/gr-dvbs
cd gr-dvbs
mkdir build
cd build
cmake ../
make
make install
ldconfig

# Install tsduck (TS manipulation tools for generating DVB-compliant streams) from github:
cd ../..
git clone https://github.com/tsduck/tsduck
cd tsduck
make NOPCSC=1 NOCURL=1 NODTAPI=1 NOSRT=1 -j8 # Takes a while, give it 8 threads
make install

# Install gr-dvbc (specific commit for gnuradio 3.7 compatibility)
cd ./..
git clone -n https://github.com/drmpeg/gr-dvbc
cd gr-dvbc
git checkout 8d7a6b21d7fce83eb46c58769dde91ad976c4ae1
mkdir build
cd build
cmake ../
make
make install
ldconfig

cd ../..
chmod +x ./ondigital/tx.py
chmod +x ./ntl-cr1/tx.py
chmod +x ./virgin-samsung/tx.py
chmod +x ./playout.sh
chmod +x ./battersea.sh
