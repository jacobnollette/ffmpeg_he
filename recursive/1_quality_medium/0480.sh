#!/bin/bash
source ../../core/templates/1_medium/0480.sh;
source ../../core/superrecursive.sh;

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

find "$sourceInput" -type f | grep -E "\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp4$|\.m?v$|\.svi$|\.3gp$|\.flv$|\.f4v$|\.mkv$" | cut -d ':' -f 1 | sed 's/.*/"&"/' | xargs bash -c 'processVideo "$sourceInput" "$filenameExtension" "$filetype" "$videocodec" "$audiocodec" "$videobitrate" "$audiobitrate" "$preset" "$threads" "$width" "$@"';
