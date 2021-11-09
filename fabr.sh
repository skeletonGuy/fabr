#!/bin/bash

audioBitrate="96"
defaultRes="1920:1080"

while getopts i:o:r: flag

do
    case "${flag}" in
        i) input=${OPTARG};;
        o) output=${OPTARG};;
        r) res=${OPTARG};;
    esac
done

if [ -z $input ]; then
    echo "ERROR: no source input was provided"
    exit 1
fi

if [ -z $output ]; then
    echo "ERROR: no output destination was provided"
    exit 1
fi

outputRes=${res:-$defaultRes}

for((i = 5; i <=$#; i++)); do
    ffmpeg -r 60 -stream_loop -1 -i $input -vf scale=$outputRes -vcodec libx264 -profile:v baseline -pix_fmt yuv420p -b:v ${!i}k -b:a 96k -f flv $output
done
