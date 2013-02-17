#!/bin/sh
#文件名：musicfolder.sh
#简介：播放音乐文件夹中的音乐
#创建时间：2011-01-22
#END
ver='2.0'
x='0'
help(){
echo "h 帮助"
echo "0 退出"
}

#主程序
if [ -z $1 ];then
	dir="`pwd`"
else
	dir=$1
fi
if [ -d $dir ];then
	for file in $dir/*.mp3
	do
		x=$((x+1))
		mplayer "$file"
	done
else
	echo "目录$dir不存在！"
fi

echo "目录 $dir 中 $x 首曲目播放完毕。"
