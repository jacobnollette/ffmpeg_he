
input_folder="$@"
#input_extension=$3;
output_folder=$@/print

preset="medium";
threads=0;
width=1920;
bitrate="900k";


processVideo () {
	ffmpeg -y -i "$1" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v libx265 -preset $preset -b:v $bitrate -c:a aac -b:a 256k -pass 1 -strict -2 -c:s copy -threads $threads -f matroska "$2";
	#ffmpeg -i "$1" -vf scale="$width:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -p pass 2 -c:a copy -c:s copy -threads $threads -f matroska "$2";


	#ffmpeg -y -i "$1" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -pass 1 -c:a copy -c:s copy -threads $threads -f matroska /dev/null && \
	#ffmpeg -i "$1" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $preset -b:v $bitrate -p pass 2 -c:a copy -c:s copy -threads $threads -f matroska "$2";
}

mkdir "$input_folder/../print";
cd "$@";


the_base="$(pwd)";
#echo $the_base;
the_base="$(basename "$the_base")";
mkdir "$input_folder/../print/$the_base";

#for i in `find "$input_folder" -type f`;
for i in *;
	do

		#echo $i | cut -d '.' --complement -f2-
		#filename=${i##*/};
		filename=`basename "$i"`;

		#filename=`basename "$i" | cut -f 1 -d '.'`;
		#echo $filename;
		t=${filename%.*};
		print_file_name="$input_folder/../print/$the_base/$t.mkv";
		#echo $print_file_name;
		
		processVideo "$i" "$print_file_name";

		#echo $t;
		#echo $i;
	done



