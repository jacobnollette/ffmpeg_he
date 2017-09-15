#!/bin/bash





processVideo() {
	echo "$@";
	for item in "$@"; do
		echo "bang $item";
	done;

}



















export -f processVideo;
find "$@" -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p' | sed 's/ /_/g' | xargs bash -c 'processVideo "$@"'	
