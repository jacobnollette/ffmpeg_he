subtitles='false';
imagewidth='';
quality='low';
files="";


while getopts ':s:i:q:f' flag; do
  case "${flag}" in
    s) subtitles="${OPTARG}" ;;
    i) imagewidth="${OPTARG}" ;;
    q) quality="${OPTARG}" ;;
    f) files="${OPTARG}" ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

echo $subtitles;
echo $imagewidth;
