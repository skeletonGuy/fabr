#!/bin/bash

audioBitrate="96"
defaultRes="1920:1080"
appleEncoding=false

while getopts i:o:r:p:a flag

do
    case "${flag}" in
        i) input=${OPTARG};;
        o) output=${OPTARG};;
        r) res=${OPTARG};;
        p) profile=${OPTARG};;
        a) appleEncoding=true
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
outputProfile=${profile:-baseline}

for((i = 5; i <=$#; i++)); do
    if [ $appleEncoding = false ]; then
        ffmpeg -r 60 -stream_loop -1 -i $input -vf scale=$outputRes -vcodec libx264 -profile:v $outputProfile -pix_fmt yuv420p -b:v ${!i}k -b:a 96k -f flv $output
    else
        ffmpeg -r 60 -stream_loop -1 -i $input -vf scale=$outputRes -vcodec h264_videotoolbox -pix_fmt yuv420p -b:v ${!i}k -b:a 96k -f flv $output
    fi
done
