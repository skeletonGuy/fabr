#!/bin/bash

#argIndex = 1;
audioBitrate="96"

while getopts b:i:o: flag
do
    case "${flag}" in
        i) input=${OPTARG};;
        o) output=${OPTARG};;
    esac
done

echo "Input: $input"
echo "Output $output"

for((i = 5; i <=$#; i++)); do
    bitrateTotalK=$(expr ${!i} + $audioBitrate)
    ffmpeg -r 60 -stream_loop -1 -i $input -vf scale=640:380 -vcodec libx264 -profile:v baseline -pix_fmt yuv420p -f flv $output
done
