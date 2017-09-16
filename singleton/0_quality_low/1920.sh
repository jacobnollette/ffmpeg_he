#!/bin/bash
filenameExtension="mkv";
filetype="matroska";
videocodec="libx265";         # always h265
audiocodec="aac";             # aac is alright
videobitrate="1000k";
audiobitrate="256k"
preset="medium";
threads=0;                    #unlimited threads
width=1920;




source ../../core/singleton.sh;

export -f processVideo;



#	here is out input stack
export filenameExtension;
export filetype;
export videocodec;
export audiocodec;
export videobitrate;
export audiobitrate;
export preset;
export threads;
export width;


#	pass out root input as a variables
sourceInput="$@";
export sourceInput;

processVideo "$sourceInput" "$filenameExtension" "$filetype" "$videocodec" "$audiocodec" "$videobitrate" "$audiobitrate" "$preset" "$threads" "$width" "$sourceInput";
