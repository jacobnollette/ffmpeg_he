sudo apt-get -y install cifs-util tmux vim iotop iftop htop openvpn
sudo apt-get -y install autoconf automake build-essential libass-dev libfreetype6-dev libtheora-dev libtool libvorbis-dev pkg-config texinfo zlib1g-dev
sudo apt-get install -y libfdk-aac-dev
sudo apt-get install -y libmp3lame-dev
sudo apt-get install -y yasm
sudo apt-get install -y libx264-dev libx265-dev libmp3lame-dev libopus-dev libvpx-dev

sudo add-apt-repository ppa:jonathonf/ffmpeg-3
apt-get install -y x264 x265;

sudo apt-get install -y cmake mercurial
cd ~/ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd ~/ffmpeg_sources/x265/build/linux
PATH="$HOME/bin:$PATH" cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$HOME/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install


apt-get install -y x264 x265;
