#!/bin/sh
#文件名：musicfolder2.sh
#简介：播放音乐文件夹中的音乐.利用播放列表的版本。
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
	ls *.mp3 > $dir/list.txt
	mplayer -playlist $dir/list.txt
else
	echo "目录$dir不存在！"
fi

rm list.txt
