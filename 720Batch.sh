
input_folder="$@"
#input_extension=$3;
output_folder=$@/print

preset="medium";
threads=0;
width=1280;
bitrate="750k";


processVideo () {
	ffmpeg -y -i "$1" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -pass 1 -c:a copy -c:s copy -threads $threads -f matroska /dev/null && \
	ffmpeg -i "$1" -vf scale="$width:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -p pass 2 -c:a copy -c:s copy -threads $threads -f matroska "$2";


	#ffmpeg -y -i "$1" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -pass 1 -c:a copy -c:s copy -threads $threads -f matroska /dev/null && \
	#ffmpeg -i "$1" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -p pass 2 -c:a copy -c:s copy -threads $threads -f matroska "$2";
}

mkdir "$input_folder/../print";
cd "$@";
#for i in `find "$input_folder" -type f`;
for i in *;
	do

		#echo $i | cut -d '.' --complement -f2-
		#filename=${i##*/};
		filename=`basename "$i"`;

		#filename=`basename "$i" | cut -f 1 -d '.'`;
		echo $filename;
		t=${filename%.*};
		print_file_name="$input_folder/print/$t.mkv";
		#echo $print_file_name;
		processVideo "$i" "$print_file_name";

		#echo $t;
		#echo $i;
	done



