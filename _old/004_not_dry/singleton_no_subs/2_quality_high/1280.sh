#!/bin/bash
quality="2_high";
size="1280";

source ../../core/templates/$quality/baseline.sh;
source ../../core/utilities.sh;
source ../../core/templates/$quality/$size.sh;
source ../../core/singleton_no_subs.sh;

export -f processVideo;

#	here is out input stack
export filenameExtension;
export filetype;
export videocodec;
export audiocodec;
export videobitrate;
export audiobitrate; 
export audiosamplerate;
export preset;
export threads;
export width;


#	pass out root input as a variables
sourceInput="$@";
export sourceInput;

processVideo "$sourceInput" "$filenameExtension" "$filetype" "$videocodec" "$audiocodec" "$videobitrate" "$audiobitrate" "$audiosamplerate" "$preset" "$threads" "$width" "$sourceInput";
