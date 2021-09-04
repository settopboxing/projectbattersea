![project battersea logo](/logo-h.png)

Project Battersea: DVB transmission platform for obsolete UK digital terrestrial, cable, and satellite receivers using the HackRF SDR peripheral.

# Usage:

1. Install Ubuntu 18.04
2. sudo apt install git
3. git clone https://github.com/settopboxing/projectbattersea
4. cd projectbattersea
5. chmod +x ./setup.sh
6. sudo ./setup.sh
7. Edit HACKRFSERIAL variable in battersea.sh to match your HackRF serial number (last 8 digits, use hackrf_info)
8. Place videos in video folder (named 1000.mp4 and 2000.mp4 if using the default configuration, can be renamed with config file tweaks)
9. Run playout.sh and battersea.sh

# Description:

Project Battersea is part of an effort to enable continued use and historical demonstration of obsolete set top box receivers produced for use by customers of digital broadcasting services such as ONdigital, NTL, Telewest, and Cable & Wireless. Many of these receivers are no longer compatible with the services they launched on or the services they were built for no longer exist, rendering the receivers useless and unable to be used to demonstrate the early years of digital television in the UK. Full compatibility is difficult to achieve given the lack of transport stream dumps from many years ago which would give insight into the technical requirements of each platform's features and many boxes, even within the same service, have firmware version quirks which prevent that which works on one box from working on another, otherwise similar box.

# Compatibility:

It currently fully supports:
* None (ONdigital is the most supported but lacks secondary functionality such as MHEG-5 support)

It currently partially supports:
* ONdigital (audio/video, EPG data, clock)
* Virgin (audio/video, partial EPG data, clock)
* Early NTL (no audio/video, partial EPG data, clock)
* Early Cable & Wireless (untested due to the lack of receivers with C&W firmware, but suspected to work as early NTL)
* Early Telewest (untested due to the lack of receivers with Telewest firmware, but suspected to work as early NTL)

It currently does not support:
* Sky Digital
* Any interactive services
* Any box firmware update functionality

# Todo:

* More documentation
* Better support for existing platforms and inclusion of more platforms

# Credits:

* settopboxing (R&D)
* Chelmsford IT (Testing)
* drmpeg (gnuradio DVB flowgraphs)
* HackTV Club Discord (Moral support/technical inspiration)
* Teletext Discord (Moral support)
* VLC/ffmpeg/tsduck/OpenCaster/gnuradio teams (Existing)
