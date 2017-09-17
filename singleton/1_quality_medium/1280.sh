#!/bin/bash
quality="1_medium";
size="1280";

source ../../core/templates/$quality/baseline.sh;
source ../../core/utilities.sh;
source ../../core/templates/$quality/$size.sh;
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
