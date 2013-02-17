#!/bin/sh
#与ape-splite配套使用，依赖lame
a=$1

mkdir bb

cd kk
for x in *.$a
do
  lame -h -b 192 -v "$x" "${x%%.*}.mp3"
  mv "$x" ../bb/
done
echo "转换完毕，备份在bb目录下。"
