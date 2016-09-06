





FILEPATH=$1;
PRESET="medium";
THREADS=0;
#NEWFILEPATH=$2/$filename.mpg;
CRF=30;
WIDTH=1280;
HEIGHT=720;
BITRATE="750k";



#  full filename
fullfile=$1
filename=$(basename "$fullfile")
extension="${filename##*.}"
filename="${filename%.*}"
#$filename

NEWFILEPATH=$2/$filename.mpg;


#ffmpeg -y -i "$FILEPATH" -c:v libx264 -preset $PRESET -crf $CRF -pass 1 -c:a copy -c:s copy -threads $THREADS -f mp4 /dev/null && \

ffmpeg -y -i "$FILEPATH" -vf scale=w=$WIDTH:h=$HEIGHT:force_original_aspect_ratio=decrease -c:v libx264 -preset $PRESET -b:v $BITRATE -pass 1 -c:a copy -c:s copy -threads $THREADS -f mp4 /dev/null && \
ffmpeg -i "$FILEPATH" -vf scale=w=$WIDTH:h=$HEIGHT:force_original_aspect_ratio=decrease -c:v libx264 -preset $PRESET -b:v $BITRATE -pass 2 -c:a copy -c:s copy -threads $THREADS -f mp4 "$NEWFILEPATH";




#ffmpeg -y -i "$FILEPATH" -vf scale=320:-1 -c:v libx264 -preset $PRESET -b:v 350k -pass 1 -c:a copy -c:s copy -threads $THREADS -f mp4 /dev/null && \
#ffmpeg -i "$FILEPATH" -vf scale=320:-1 -c:v libx264 -preset $PRESET -b:v 350k -pass 2 -c:a copy -c:s copy -threads $THREADS -f mp4 "$NEWFILEPATH";

#ffmpeg -y -i $FILEPATH -c:v libx264 -preset medium -b:v 555k -pass 1 -c:a libfdk_aac -b:a 128k -f mp4 /dev/null && \
#ffmpeg -i $FILEPASTH -c:v libx264 -preset medium -b:v 555k -pass 2 -c:a libfdk_aac -b:a 128k output.mp4

#filename=$(basename "$1")
#echo $filename



