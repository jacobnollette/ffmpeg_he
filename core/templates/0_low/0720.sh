source baseline.sh;
source ../utilities.sh;

multiplebitrate="1.5";
videobitrate="$(echo $videobitrate*$multiplebitrate|bc -l)";
videobitrate="$(round "$videobitrate" "0")";
videobitrate="${videobitrate}k"

filenameExtension="mkv";
filetype="matroska";
videocodec="libx265";         # always h265
audiocodec="aac";             # aac is alright
audiobitrate="192k";
preset="medium";
threads=0;                    #unlimited threads
width=720;
