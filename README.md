# ffmpeg-h265 - THIS IS RECURSIVE AUTOMATION

Okay, this script operates in two modes right now, and only with h265 video.
####	Mode 1) Singleton mode - Pass it a single file, and it will create a print folder, and compress the file into the print folder... DONE.
####	Mode 2)	Recursive mode - Pass it a absolute path to a folder, and it will find all of the video files below, and create a print folder, organized exactly how your given folder is organized.

##	H265
Every video file will be compressed in HEVC, H265. So basically the same quality as H264, but half the file size, or sometimes even less. I've seen results as much as 1/5 the size, with great quality. The low setting is tolerable for archival footage. The medium and high settings are better. If you're not happy with the results, bump up the base line defaults. All bitrates are calculated, as if they're comparatively multiplied from 480 pixels wide. So (given_width / 480) * (baseline_bitrate). Lastly, I'm pretty happy with these results, and you should enjoy this automation program.

##	Flags - The only required flag is -f
*	-s (true / false) - defaults true
* -i (image width) - defaults to autosize to current size
* -q (quality, low, medium, high) - defaults to low, which is pretty good IMO. 256k or greater audio quality.
* -f (pass it a file path) - must be absolute path

##	Building ffmpeg
####	OS X
`brew install ffmpeg --with-x265 --with-fdk-acc`
####	Ubuntu 16.04
```sudo apt-get -y install cifs-util tmux vim iotop iftop htop openvpn
sudo apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev libtheora-dev libtool libvorbis-dev pkg-config texinfo zlib1g-dev
sudo apt-get install -y libfdk-aac-dev
sudo apt-get install -y libmp3lame-dev
sudo apt-get install -y yasm
sudo apt-get install -y libx264-dev libx265-dev libmp3lame-dev libopus-dev libvpx-dev

sudo add-apt-repository ppa:jonathonf/ffmpeg-3
apt-get install -y x264 x265;

mkdir ~/ffmpeg_sources;
cd ~/ffmpeg_sources
wget http://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
--prefix="$HOME/ffmpeg_build" \
--pkg-config-flags="--static" \
--extra-cflags="-I$HOME/ffmpeg_build/include" \
--extra-ldflags="-L$HOME/ffmpeg_build/lib" \
--bindir="$HOME/bin" \
--enable-gpl \
--enable-libass \
--enable-libfdk-aac \
--enable-libfreetype \
--enable-libmp3lame \
--enable-libopus \
--enable-libtheora \
--enable-libvorbis \
--enable-libvpx \
--enable-libx264 \
--enable-libx265 \
--enable-nonfree
PATH="$HOME/bin:$PATH" make
make install
make distclean
hash -r
```
Then copy the files from ~/bin, to /usr/bin...
