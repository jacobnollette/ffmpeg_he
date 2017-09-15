
preset="medium";
threads=0;
width=720;
bitrate="225k";


processVideo () {
	ffmpeg -y -i "$1" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v libx265 -preset $preset -b:v $bitrate -c:a aac -b:a 192k -pass 1 -strict -2 -c:s copy -threads $threads -f matroska "$2";
	#ffmpeg -i "$1" -vf scale="$width:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -p pass 2 -c:a copy -c:s copy -threads $threads -f matroska "$2";


	#ffmpeg -y -i "$1" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -pass 1 -c:a copy -c:s copy -threads $threads -f matroska /dev/null && \
	#ffmpeg -i "$1" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -p pass 2 -c:a copy -c:s copy -threads $threads -f matroska "$2";
}

processFolder () {
	for i in "$@"
		do
			the_base="$(pwd)";
			the_base="$(basename "$the_base")";
		#mkdir "$input_folder/../print/$the_base";
			filename=`basename "$i"`;
			t=${filename%.*};
			print_file_name="$input_folder/../print/$the_base/$t.mkv";
			echo "$i";
		#processVideo "$i" "$print_file_name";
	done

}

mkdir "$@/print";


input_folder="$@"
output_folder=$@/print
mkdir $output_folder;

for folder in "$input_folder/*"
	do
		season_folder="$folder";
		cd $season_folder;
		season_base="$(pwd)";
		season_base="$(basename "$season_base")";


		case "$season_base" in
		    print);;
		    *) processFolder "$folder";;
		esac

		#echo $season_base;

	done
