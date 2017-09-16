#	this is how you kill rogue ffmpeg processes
# no quote input searched your processes and kills them

ps -ef | grep "$@" #| cut -d " " -f 2 | xargs kill;
