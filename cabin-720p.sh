





FILEPATH=$1;
PRESET="medium";
THREADS=0;
#NEWFILEPATH=$2/$filename.mpg;
CRF=30;
WIDTH=1280;
HEIGHT=720;
BITRATE="750k";
ASPECT="decrease";



#  full filename
fullfile=$1
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"
#$filename

NEWFILEPATH=$2/$filename.mkv;


#ffmpeg -y -i "$FILEPATH" -c:v libx264 -preset $PRESET -crf $CRF -pass 1 -c:a copy -c:s copy -threads $THREADS -f mp4 /dev/null && \

ffmpeg -y -i "$FILEPATH" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $PRESET -b:v $BITRATE -pass 1 -c:a copy -c:s copy -threads $THREADS -f matroska /dev/null && \
ffmpeg -i "$FILEPATH" -vf scale="$WIDTH:trunc(ow/a/2)*2" -c:v libx264 -preset $PRESET -b:v $BITRATE -pass 2 -c:a copy -c:s copy -threads $THREADS -f matroska "$NEWFILEPATH";




#ffmpeg -y -i "$FILEPATH" -vf scale=320:-1 -c:v libx264 -preset $PRESET -b:v 350k -pass 1 -c:a copy -c:s copy -threads $THREADS -f mp4 /dev/null && \
#ffmpeg -i "$FILEPATH" -vf scale=320:-1 -c:v libx264 -preset $PRESET -b:v 350k -pass 2 -c:a copy -c:s copy -threads $THREADS -f mp4 "$NEWFILEPATH";

#ffmpeg -y -i $FILEPATH -c:v libx264 -preset medium -b:v 555k -pass 1 -c:a libfdk_aac -b:a 128k -f mp4 /dev/null && \
#ffmpeg -i $FILEPASTH -c:v libx264 -preset medium -b:v 555k -pass 2 -c:a libfdk_aac -b:a 128k output.mp4

#filename=$(basename "$1")
#echo $filename



