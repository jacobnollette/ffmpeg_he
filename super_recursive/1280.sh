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

	#	here is our input folder;
	rootItem="$1";
	rootItemUgly="$( echo "$rootItem" | sed 's/ /\\ /g' )";

	#echo $rootItem;
	theItems="${@:2}";
	for item in "${@:2}"; do

		#	here is the found file
		echo "$item";
		original_item=$item;
		# add escape characters
		item="$( echo "$item" | sed 's/ /\\ /g' )";

		#	create proper file name, quotes will be needed
		season_folder=`dirname "$item"`;
		#remove escape characters,- honestly I don't know why we had to do this
		season_folder="$( echo "$season_folder" | sed "s@\\\\@@g" )";
		#echo $original_item;

		#	this is the series folder, parent to season
		season_root=`dirname "$original_item"`;
		#echo $season_root;

		#	season folder - season name or number
		season_parent_folder_name=`basename "$season_folder"`;
		root_parent_folder=`basename "$rootItem"`;

		if [[ "$season_parent_folder_name" == "$root_parent_folder" ]]; then
			print_folder="$rootItem/print";
		else

			print_folder="$rootItem/print/$season_parent_folder_name";
		fi

		#	fucking os x
		doubleBase=`basename "$print_folder"`;
		if [[ "$doubleBase" == ".AppleDouble" ]]; then
			print_folder=`dirname $print_folder`;
		fi

		#	create print folder
		mkdir -p "$print_folder";
		#echo $print_folder;
		#echo $season_parent_folder_name;
		#echo $season_parent_folder_name;


		#echo "$print_folder";


		# get the filename without extension
		filename=`basename "$original_item"`;
		fn_no_extension=${filename%.*};

		#generate print file
		print_file="$print_folder/$fn_no_extension";
		print_file="$print_file$filenameExtension";

		# strict 2 for aac, because it's experimental
		ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" \
		-c:v $videocodec -preset $preset -b:v $videobitrate -c:a $audiocodec \
		-b:a $soundBitrate -pass 1 -strict -2 -threads $threads -f $filetype "$print_file";

	done;

	}


	export -f processVideo480;
	sourceInput="$@";
	export sourceInput;


	find "$sourceInput" -type f | grep -E "\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp4$|\.m?v$|\.svi$|\.3gp$|\.flv$|\.f4v$|\.mkv$" | cut -d ':' -f 1 | sed 's/.*/"&"/' | xargs bash -c 'processVideo1280 "$sourceInput" "$@"';
