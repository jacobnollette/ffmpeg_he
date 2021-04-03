# HE_FFMPEG_AUTOMATION

# Pre-reqs
- ffmpeg
- bc
- rename


##	THIS IS RECURSIVE & SINGLETON AUTOMATION

install ffmpeg with homebrew; install scripts no longer work with catalina+
H265 and he-aac... YMMV

Created by Jacob Nollette

Okay, this script operates in two modes right now. It works with video or audio. H265 for video, HE_AAC for audio.
####	Mode 1) Singleton mode - Pass it a single file, and it will create a print folder, and compress the file into the print folder... DONE.
####	Mode 2)	Recursive mode - Pass it a absolute path to a folder, and it will find all of the video files below, and create a print folder, organized exactly how your given folder is organized.

##	H265
Every video file will be compressed in HEVC, H265. So basically the same quality as H264, but half the file size, or sometimes even less. I've seen results as much as 1/5 the size, with great quality. The low setting is tolerable for archival footage. The medium and high settings are better. If you're not happy with the results, bump up the base line defaults. All bitrates are calculated, as if they're comparatively multiplied from 480 pixels wide. So (given_width / 480) * (baseline_bitrate). Lastly, I'm pretty happy with these results, and you should enjoy this automation program.

##	HE_AAC
All audio is compressed with HE_AAC. Generally 320 kbps, because why not. Audio fidely is key. Also I've noticed that rates lower then 256; there tends to be a few microseconds of saturation at the begining of the clip. This issue is less significant or non-existant with 320 / high.

##	Flags - The only required flag is -f
*	-a (true / false) - is audio, defaults to true
*	-s (true / false) - subtitles, defaults to true
* -i (image width) - defaults to autosize to current size
* -q (quality, low, medium, high) - defaults to low, which is pretty good IMO. 256k or greater audio quality. Do high quality for music.
* -f (pass it a file or directory path) - must be absolute path

##	Building ffmpeg
```OS X and Ubuntu 16.04 install script in /install```
