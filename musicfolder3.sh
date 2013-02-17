#!/bin/sh
#文件名：musicfolder3.sh
#作者 xiii_1991
#简介：播放音乐文件夹中的音乐.利用播放列表的版本。
#      在第二版的基础上，增加了判断目录中有没有音乐文件的功能。避免出错。
#创建时间：2011-01-23
#END
ver='3.0'
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
	ls $dir/*.mp3 > list.txt
	if [ -s "list.txt" ];then
	mplayer -playlist list.txt
	else
		echo "貌似目录$dir里面没有音乐！"
	fi
else
	echo "目录$dir不存在！"
fi

#rm list.txt
