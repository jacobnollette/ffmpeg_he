#!/bin/bash
quality="2_high";
size="0720";

source ../../core/templates/$quality/baseline.sh;
source ../../core/utilities.sh;
source ../../core/templates/$quality/$size.sh;
source ../../core/superrecursive_no_subs.sh;

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

find "$sourceInput" -type f | grep -E "\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp4$|\.m?v$|\.svi$|\.3gp$|\.flv$|\.f4v$|\.mkv$" | cut -d ':' -f 1 | sed 's/.*/"&"/' | sort -n | { while read -r line || [[ -n "$line" ]]; do my_array=("${my_array[@]}" "$line"); done; processVideo "$sourceInput" "$filenameExtension" "$filetype" "$videocodec" "$audiocodec" "$videobitrate" "$audiobitrate" "$audiosamplerate" "$preset" "$threads" "$width" "${my_array[@]}"; };
