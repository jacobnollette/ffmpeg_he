

preset="medium";
threads=0;
width=720;
videoBitrate="225k";
audioBitrate="256k";
videoCodec="libx265";
audoCodec="aac";



processVideo () {
	ffmpeg -y -i "$1" -vf scale="w=$width:trunc(ow/a/2)*2" -c:v $videoCodec -preset $preset -b:v $videoBitrate -c:a $audioCodec -b:a $audioBitrate -pass 1 -strict -2 -c:s copy -threads $threads -f matroska "$2";
}

input_folder="$@"
output_folder=$@/print

mkdir "$input_folder/print";
cd "$@";


the_base="$(pwd)";
the_base="$(basename "$the_base")";
for i in *;
	do

		filename=`basename "$i"`;

		t=${filename%.*};

		print_file_name="$input_folder/print/$the_base/$t.mkv";
		echo $print_file_name;
		#processVideo "$i" "$print_file_name";

	done



