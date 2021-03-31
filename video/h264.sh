#!/bin/bash

_utility_readme() {
	echo "-s subtitles(true / false)";
	echo "-i image width (1920)";
	echo "-q quality (low / medium / high)";
	echo "-f files (directory or file)";
}
_utility_round() {
    # $1 is expression to round (should be a valid bc expression)
    # $2 is number of decimal figures (optional). Defaults to three if none given
    local df=${2:-3}
    #printf '%.*f\n' "$df" "$(bc -l <<< "a=$1; if(a>0) a+=5/10^($df+1) else if (a<0) a-=5/10^($df+1); scale=$df; a/1")"
    #awk  "BEGIN { rounded = sprintf('%.0f', $df); print rounded }";
	echo $1 | awk '{print int($1+0.5)}';
}

_utility_video_dimensions () {

  eval $(ffprobe -v error -of flat=s=_ -select_streams v:0 -show_entries stream=height,width "$@");
  size=${streams_stream_0_width}x${streams_stream_0_height};
  echo $size;
}

_utility_dot_clean() {
	find "$@" -depth -name ".DS_Store" -exec rm {} \;
	find "$@" -depth -name ".AppleDouble" -exec rm -Rf {} \;
}

_utility_file_space_clear() {
	#	this removes excess whitespace (2) or (3) in file names
	#	if you have an atomic white space fix, submit pull request
	givenFolder="$@";
	for file in `find "$givenFolder" -type f -name '*  *'`
		do
			rename 's/  / /g' "$file";
		done;
	for file in `find "$givenFolder" -type f -name '*   *'`
		do
			rename 's/   / /g' "$file";
		done
}



_process_video_recursive() {

	#	here is our input folder;
	rootItem="$1";
	rootItemUgly="$( echo "$rootItem" | sed 's/ /\\ /g' )";

	filenameExtension="$2";
	filetype="$3";
	videocodec="$4";
	audiocodec="$5";
	videobitrate="$6";
	audiobitrate="$7";
	audiosamplerate="$8"
	preset="$9";
	threads="${10}";
	width="${11}";
	subtitles="${12}";

	audioAudioCodec="${13}";
	audioAudioProfile="${14}";
	audioAudioSamplerate="${15}";
	audioAudiobitrate="${16}";


	for item in "${@:17}"; do

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
		print_file="$print_file$filenameExtension";

		#	specs
		if ! [ -z ${width+x} ];
			then
				video_dimensions=$(_utility_video_dimensions "$original_item")
				video_width=$( echo $video_dimensions | cut -d 'x' -f 1 );
				width=$video_width;
		fi;

		bitratemultiplier=$(($width/480));
		bitratemultiplier="$(_utility_round "$bitratemultiplier" "0")";
		_the_videobitrate=$(($videobitrate * $bitratemultiplier));
		_the_videobitrate="${_the_videobitrate}k";


#eicho $width;
		#strict 2 for aac, because it's experimental
		
		if [ ! -f "$print_file" ]; then
			mkdir -p "$print_folder";
			if [ "$subtitles" = true ];
				then




					#	with subtitles
					# OLD heaac - ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v "$videocodec" -preset "$preset" -b:v "$_the_videobitrate" -ar "$audioAudioSamplerate" -ab "$audioAudiobitrate" -c:a "$audiocodec" -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" -profile:a "$audioAudioProfile" -pass 1 -c:s copy -threads "$threads" -f "$filetype" -strict -2 "$print_file";
					echo "$original_item" > /tmp/ffmpeg_last
					ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v "$videocodec" -preset "$preset" -b:v "$_the_videobitrate" -ar "$audioAudioSamplerate" -ab "$audioAudiobitrate" -c:a "$audiocodec" -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" -pass 1 -c:s copy -threads "$threads" -f "$filetype" -strict -2 "$print_file";

				else

					#	without subtitles
					# OLD heaac - ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v "$videocodec" -preset "$preset" -b:v "$_the_videobitrate" -ar "$audioAudioSamplerate" -ab "$audioAudiobitrate" -c:a "$audiocodec" -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" -profile:a "$audioAudioProfile" -pass 1 -threads "$threads" -f "$filetype" -strict -2 "$print_file";
					echo "$original_item" > /tmp/ffmpeg_last
					ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v "$videocodec" -preset "$preset" -b:v "$_the_videobitrate" -ar "$audioAudioSamplerate" -ab "$audioAudiobitrate" -c:a "$audiocodec" -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" -pass 1 -threads "$threads" -f "$filetype" -strict -2 "$print_file";
				fi
		fi;

	done;

}


_process_video_singleton () {

		# pass it a season or group folder.
		# it will go through the seasons, and process everything
		# creates a print folder in the group folder.

		#	here is our input folder;
		rootItem="$1";
		rootItem="$(dirname "$1")";
		rootItemUgly="$( echo "$rootItem" | sed 's/ /\\ /g' )";

		filenameExtension="$2";
		filetype="$3";
		videocodec="$4";
		audiocodec="$5";
		videobitrate="$6";
		audiobitrate="$7";
		audiosamplerate="$8";
		preset="$9";
		threads="${10}";
		width="${11}";
		subtitles="${12}"

		audioAudioCodec="${13}";
		audioAudioProfile="${14}";
		audioAudioSamplerate="${15}";
		audioAudiobitrate="${16}";

		#	here is the found file
		item=${17};
		original_item=$item;

		# add escape characters
		item="$( echo "$item" | sed 's/ /\\ /g' )";

		#	create proper file name, quotes will be needed
		season_folder=`dirname "$item"`;

		#remove escape characters,- honestly I don't know why we had to do this
		season_folder="$( echo "$season_folder" | sed "s@\\\\@@g" )";

		#	this is the series folder, parent to season
		season_root=`dirname "$original_item"`;

		print_folder="$season_root/print";

		#	create print folder
		mkdir -p "$print_folder";

		# get the filename without extension
		filename=`basename "$original_item"`;
		fn_no_extension=${filename%.*};

		#generate print file
		print_file="$print_folder/$fn_no_extension.";
		print_file="$print_file$filenameExtension";

		#	video width
		if ! [ -z ${width+x} ];
			then
				video_dimensions=$(_utility_video_dimensions "$original_item")
				video_width=$( echo $video_dimensions | cut -d 'x' -f 1 );
				width=$video_width;
		fi;

		# video bitrate calculator
		bitratemultiplier=$(($width/480));
		bitratemultiplier="$(_utility_round "$bitratemultiplier" "0")";
		_the_videobitrate=$(($videobitrate * $bitratemultiplier));
		_the_videobitrate="${_the_videobitrate}k";

		#	if we have subtitles
		if [ "$subtitles" = true ];
			then


				#	with subtitles
				echo "$original_item" > /tmp/ffmpeg_last
				ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v "$videocodec" -preset "$preset" -b:v "$_the_videobitrate" -ar "$audioAudioSamplerate" -ab "$audioAudiobitrate" -c:a "$audiocodec" -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" -profile:a "$audioAudioProfile" -pass 1 -c:s copy -threads "$threads" -f "$filetype" "$print_file";
			else
				#	without subtitles
				echo "$original_item" > /tmp/ffmpeg_last
				ffmpeg -y -i "$original_item" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v "$videocodec" -preset "$preset" -b:v "$_the_videobitrate" -ar "$audioAudioSamplerate" -ab "$audioAudiobitrate" -c:a "$audiocodec"  -ac 2 -af "pan=stereo|FL=FC+0.30*FL+0.30*BL|FR=FC+0.30*FR+0.30*BR" -profile:a "$audioAudioProfile" -pass 1 -threads "$threads" -f "$filetype" "$print_file";
		fi

}




#  defaults
isAudio="false";
subtitles='true';
imagewidth='false';
quality='low';
files="";

if [ $# -eq 0 ]
  then
		echo " ";
		_utility_readme;
		echo " ";
		exit 1;
fi
while getopts ':s:i:q:f:' flag; do
  case "${flag}" in
    s) subtitles="${OPTARG}" ;;
    i) imagewidth="${OPTARG}" ;;
    q) quality="${OPTARG}" ;;
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


#	template defaults
#	these are the baseline figure for 480 wide
#	multiplied accordingly
	#	low - 190, audio 256k, 44100k
	#	medium - 215, audio 256k, 44100k
	# high - 240, audio 320k, bitrate 48000k


case "$quality" in
	low)
		videobitrate="600";

		audiovideobitrate="256k";		#	no longer used
		audiosamplerate="44100";		#	no longer used
		preset="medium";
		audioaudiosamplerate="44100";
		audioaudiochannels="2";
		audioaudiobitrate="320k";
		;;
	medium)
		videobitrate="900";
		audiovideobitrate="256k";		#	no longer used
		audiosamplerate="44100";		#	no longer used
		preset="slow";
		audioaudiosamplerate="44100";
		audioaudiochannels="2";
		audioaudiobitrate="320k";
		;;
	high)
		videobitrate="1700";

		audiovideobitrate="320k";		#	no longer used
		audiosamplerate="48000";		#	no longer used
		preset="slow";
		audioaudiosamplerate="48000";
		audioaudiochannels="2";
		audioaudiobitrate="320k";
		;;
	*)
		echo " ";
		echo "Wrong file quality";
		echo " ";
		_utility_readme;
		echo " "
		exit 1;
		;;
esac;

#	global defaults
filenameExtension="mkv";
audioVideocodec="aac";	#	we don't use this anymore
audioFilenameExtension="m4a";
audioAudioCodec="libfdk_aac";
audioAudioProfile="aac_he_v2";
audioVideoProfile="aac_he";


filetype="matroska";
videocodec="libx264";         # always h265
threads=0;                    #unlimited threads



export -f _process_video_recursive;
export -f _process_video_singleton;

#	pass out root input as a variables
sourceInput="$files";
#echo $sourceInput;

export filenameExtension;
export filetype;
export videocodec;
export audioVideocodec;
export videobitrate;
export audiovideobitrate;
export audiosamplerate;
export preset;
export threads;
export width;
export subtitles;
export sourceInput;

#	audio
export audioFilenameExtension;
export audioAudioCodec;
export audioAudioProfile;
export audioVideoProfile;
export audioaudiosamplerate;
export audioaudiochannels;
export audioaudiobitrate;


	if [[ -d "$sourceInput" ]]; then
		#	we have a directory
		_utility_dot_clean "$sourceInput";
		_utility_file_space_clear "$sourceInput";
		find "$sourceInput" -type f -not -path "*/print*" | grep -E "\.MKV$|\.m2ts$|\.webm$|\.flv$|\.vob$|\.ogg$|\.ogv$|\.drc$|\.gifv$|\.mng$|\.avi$|\.mov$|\.qt$|\.wmv$|\.yuv$|\.rm$|\.rmvb$|/.asf$|\.amv$|\.mp4$|\.m4v$|\.mp4$|\.m?v$|\.svi$|\.3gp$|\.flv$|\.f4v$|\.mkv$" | cut -d ':' -f 1 | sed 's/.*/"&"/' | sort -n | { while read -r line || [[ -n "$line" ]]; do my_array=("${my_array[@]}" "$line"); done; _process_video_recursive "$sourceInput" "$filenameExtension" "$filetype" "$videocodec" "$audioVideocodec" "$videobitrate" "$audiovideobitrate" "$audiosamplerate" "$preset" "$threads" "$width" "$subtitles" "$audioAudioCodec" "$audioVideoProfile" "$audioaudiosamplerate" "$audioaudiobitrate" "${my_array[@]}"; };
	elif [[ -f "$sourceInput" ]]; then
		_process_video_singleton "$sourceInput" "$filenameExtension" "$filetype" "$videocodec" "$audioVideocodec" "$videobitrate" "$audiovideobitrate" "$audiosamplerate" "$preset" "$threads" "$width" "$subtitles" "$audioAudioCodec" "$audioVideoProfile" "$audioaudiosamplerate" "$audioaudiobitrate" "$sourceInput";
		#echo "bang";
	else
		echo "$sourceInput is not valid";
		exit 1;
	fi
