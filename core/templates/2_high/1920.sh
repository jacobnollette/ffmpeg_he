multiplebitrate="4";
videobitrate="$(echo $videobitrate*$multiplebitrate|bc -l)";
videobitrate="$(round "$videobitrate" "0")";
videobitrate="${videobitrate}k";

filenameExtension="mkv";
filetype="matroska";
videocodec="libx265";         # always h265
audiocodec="aac";             # aac is alright
audiobitrate="320k";
#preset="medium";
threads=0;                    #unlimited threads
width=1920;
