#!/bin/bash

processVideo1280() {

	# pass it a season or group folder.
	# it will go through the seasons, and process everything
	# creates a print folder in the group folder.

	# find doesn't work the same on OS X;
	# tested in ubuntu 16.04

	filenameExtension="mkv";
	filetype="matroska";
	audiocodec="aac";             # aac is alright
	videocodec="libx265";         # always h265
	preset="medium";
	threads=0;                    #unlimited threads
	width=1280;
	videobitrate="450k";
  soundBitrate="256k"

	for item in "$@"; do
		original_item=$item;
		item="$( echo "$item" | sed 's/ /\\ /g' )";     # add escape characters

		#	create proper file name, quotes will be needed
		season_folder=`dirname "$item"`;
		season_folder="$( echo "$season_folder" | sed "s@\\\\@@g" )";   #remove escape characters,- honestly I don't know why we had to do this

		#	this is the series folder, parent to season
		season_root=`dirname "$season_folder"`;

		#	season folder - season name or number
		season_parent_folder_name=`basename "$season_folder"`;


		# create print folder;
		cd "$season_root";
		mkdir -p "print";
		cd print;
		mkdir -p "$season_parent_folder_name";
		cd "$season_parent_folder_name";
		print_dir=`pwd`;							#	here's our print directory


		# get the filename without extension
		filename=`basename "$item"`;
		fn_no_extension=${filename%.*};

		#generate print file
		print_file="$print_dir/$fn_no_extension.";
		print_file="$print_file$filenameExtension";

		# strict 2 for aac, because it's experimental
		ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" \
		-c:v $videocodec -preset $preset -b:v $videobitrate -c:a $audiocodec \
		-b:a $soundBitrate -pass 1 -strict -2 -threads $threads -f $filetype "$print_file";

	done;

}


export -f processVideo1280;

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	#	linux-gnu
	find "$@" -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p' | sed 's/ /\\ /g' | xargs bash -c 'processVideo1280 "$@"';
elif [[ "$OSTYPE" == "darwin"* ]]; then
	# Mac OSX
	find "$@" -type f | grep -E "\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp4$|\.m?v$|\.svi$|\.3gp$|\.flv$|\.f4v$" | cut -d ':' -f 1 | sed 's/.*/"&"/' | xargs bash -c 'processVideo1280 "$@"';
elif [[ "$OSTYPE" == "freebsd"* ]]; then
	#	Freebsd
	echo "Not yes supported";
else
	# Unknown.
	echo "Not yes supported";
fi
