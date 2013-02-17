#!/bin/sh
#sd=正剧干音
td=处理
mkdir $td
for x in *.mp3
do
ffmpeg -i "$x" "$td/${x%%.*}.ogg"
done
