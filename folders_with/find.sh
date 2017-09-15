#!/bin/bash





processVideo() {
	
	
	filenameExtension="mkv";
	preset="medium";
	threads=0;
	width=720;
	bitrate="225k";
	
	
	for item in "$@"; do
		original_item=$item;
		item="$( echo "$item" | sed 's/ /\\ /g' )";
		
		
		#	create proper file name, quotes will be needed
		season_folder=`dirname "$item"`;
		season_folder="$( echo "$season_folder" | sed "s@\\\\@@g" )";
		
		#	this is the series folder, parent to season
		season_root=`dirname "$season_folder"`;
		
		#	season folder
		season_parent_folder_name=`basename "$season_folder"`;
		
		
		# create print folder;
		cd "$season_root";
		mkdir -p "print";
		cd print;
		mkdir -p "$season_parent_folder_name";
		cd "$season_parent_folder_name";
		print_dir=`pwd`;							#	here's our print directory
		
		
		
		
		
		filename=`basename "$item"`;
		tFilename=${filename%.*};
		
		
		print_file="$print_dir/$tFilename.";
		print_file="$print_file$filenameExtension";
		#echo $print_file;

		
		

		ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v libx265 -preset $preset -b:v $bitrate -c:a aac -b:a 256k -pass 1 -strict -2 -threads $threads -f matroska "$print_file";

		
	done;

}



















export -f processVideo;
find "$@" -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p' | sed 's/ /\\ /g' | xargs bash -c 'processVideo "$@"'	
