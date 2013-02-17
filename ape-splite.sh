#!/bin/sh
# 分割ape wv flac wav等大型音频
# ape-mp3.sh ape-aac.sh
# apt-splite.sh CUE APE flac

a=$1
b=$2
c=$3

echo "新建临时文件夹kk"
mkdir kk
 
shntool split -f "$a" -t '%n %t' -o "$c"  -d kk  "$b"
echo "转换完毕，全部分割后的文件都在kk目录下。"
