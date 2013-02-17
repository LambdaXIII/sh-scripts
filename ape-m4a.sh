#!/bin/sh
#与 ape-splite配套使用，依赖ffmpeg


a=$1
mkdir bb
cd kk
for x in *.$a
do
  ffmpeg -i "$x" -ab 256k "${x%%.*}.m4a"
  mv "$x" ../bb/
done
 
echo "全部音乐转换完毕，备份在bb目录内。"