# Script to convert all videos in <input_folder> to mp4 videos with constant frame rate of 30fps.
# The output videos are saved in <output_folder>. By setting [flat] (with any string), the output folder will be flattened.
#
# usage: bash standardize_video_to_constant_30fps_mp4.sh <input_folder> <output_folder> [flat]

if [ "$#" -lt 2 ]; then
    echo "Illegal number of parameters"
    echo "usage: bash standardize_video_to_constant_30fps_mp4.sh <input_folder> <output_folder> [flat]"
    exit 1
fi

#for ARGUMENT in "$@"; do
#        KEY=$(echo $ARGUMENT | cut -f1 -d=)
#
#        KEY_LENGTH=${#KEY}
#        VALUE="${ARGUMENT:$KEY_LENGTH+1}"
#
#        export "$KEY"="$VALUE"
#done


INPUT_FOLDER=$1
OUTPUT_FOLDER=$2
flat=$3

#mkdir -p $OUTPUT_FOLDER

for input_video_path in $(find "${INPUT_FOLDER}" -wholename "*video*.mp4");
do
	#video_filename=$(basename $input_video_path)
	#video_name="${video_filename%.*}"
	#output_video_path="$OUTPUT_FOLDER/$video_name.mp4"
  
  if [[ $flat ]]; then
    output_video_path=${input_video_path/$INPUT_FOLDER/""}
    output_video_path=${OUTPUT_FOLDER}${output_video_path//"/"/"_"}
  else
    output_video_path=${input_video_path/$INPUT_FOLDER/$OUTPUT_FOLDER}
  fi

  #output_video_path="${input_video_path/"$INPUT_FOLDER"/"$OUTPUT_FOLDER"}"

  #output_video_path=${input_video_path/$INPUT_FOLDER/""}
  #output_video_path=${INPUT_FOLDER}${output_video_path//"/"/"_"}

  mkdir -p $(dirname $output_video_path)
  #echo $input_video_path $output_video_path

	echo "ffmpeg -y -i $input_video_path -filter:v fps=fps=30 $output_video_path"
	ffmpeg -y -i $input_video_path -filter:v fps=fps=30 $output_video_path
done
