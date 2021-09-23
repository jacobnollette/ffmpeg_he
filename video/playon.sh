#!/bin/bash

#!/bin/bash

_utility_readme() {
	echo "-f directory";
}
_process_playon () {
        rootItem="$1";


	for item in "${@:2}"; do

		#	here is the found file
		original_item=$item;
		original_item="$( echo $item | sed -e 's/^"//' -e 's/"$//' )";

		# add escape characters
		item="$( echo "$item" | sed 's/ /\\ /g' )";

		#	create proper file name, quotes will be needed
		season_folder=`dirname "$item"`;
		#season_folder="/home/hd1/jacobnollette/print";

		#	remove escape characters,- honestly I don't know why we had to do this
		#	not sure if we use this anymore
		season_folder="$( echo "$season_folder" | sed "s@\\\\@@g" )";
		season_folder="$( echo "$season_folder" | tr -d '"' )";

		#	get filepath of the given item
		the_directory_of_the_file=$(dirname "$original_item");

		# generate the recusive folder, based on given root
		suffix_folder=$(echo $the_directory_of_the_file | awk -F "$rootItem" '{print $2}' );
		print_folder="$rootItem/print/$suffix_folder";
		#print_folder="/home/hd1/jacobnollette/print$suffix_folder";

		#	this is the series folder, parent to season
		#	not sure if we use this anymore...
		season_root=`dirname "$original_item"`;

		# get the filename without extension
		filename=`basename "$original_item"`;
		fn_no_extension=${filename%.*};

		#generate print file
		print_file="$print_folder/$fn_no_extension.";
		print_file="$print_file.mp4";

		
		if [ ! -f "$print_file" ]; then
			mkdir -p "$print_folder";

					#	without subtitles
				echo "$original_item" > /tmp/ffmpeg_last




dur=$(ffprobe -i "$original_item" -show_entries format=duration -v quiet -of csv="p=0")
trim=$(echo $dur | awk '{print $1-10}');
ffmpeg -y -i "$original_item" -ss 5 -t $trim -vcodec copy -acodec copy "$print_file";
		fi;

	done;

}


# defaults
files="";

if [ $# -eq 0 ]
  then
		echo " ";
		_utility_readme;
		echo " ";
		exit 1;
fi
while getopts ':f:' flag; do
  case "${flag}" in
    f) files="$OPTARG" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

if [ -z ${files+x} ];
	then
		echo " ";
		echo "Please provide files";
		echo " ";
		_utility_readme;
		echo " "
		exit 1;
fi;




export -f _process_playon;

#	pass out root input as a variables
sourceInput="$files";
#echo $sourceInput;



find "$sourceInput" -type f -not -path "*/print*" | grep -E "\.MKV$|\.m2ts$|\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp4$|\.m?v$|\.svi$|\.3gp$|\.flv$|\.f4v$|\.mkv$" | cut -d ':' -f 1 | sed 's/.*/"&"/' | sort -n | { while read -r line || [[ -n "$line" ]]; do my_array=("${my_array[@]}" "$line"); done; _process_playon "$sourceInput" "${my_array[@]}"; };
