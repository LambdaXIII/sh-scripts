#!/bin/sh
#文件名 convert_mpg.sh
#作者 xiii_1991
#简介 转换一个视频为同名的mpg文件，视频码率5000k,声音256k。
#创建时间 2011-04-05
#END
ver='1.0'
help(){
echo "用法：convert_mpg.sh <参数> <文件名|目录名|空白>"
echo "空白表示的是当前目录。"
echo "参数："
echo "h help 帮助"
}


one(){
    filename=$1
    ffmpeg -i $filename -vb 5000k -ab 256k ${filename%%.*}.mpg
}

dir(){
    dirname=$1
    for filename in $dirname ; do
	one $filename
    done
}



menu(){
    if [ -f $1 ];then
	echo "转换文件$1?" ; read choice
	[ choice = 'y' ] && one $1
    elif [ -d $1 ];then
	echo "转换目录$1的全部文件 ?" ; read choice
	[ choice = 'y' ] && dir $1
    elif [ -z $1 ];then
	echo "转换当前目录全部文件？" ; read choice
	[ choice = 'y' ] && dir "."
    fi
}


#主程序
case $1 in
    'h') help ;;
    'help') help ;;
  #  '') help ;;
    *) menu $1 ;;
esac
    
