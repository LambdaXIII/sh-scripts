#!/bin/sh
#文件名 mradio.sh
#作者  xiii_1991
#简介 听电台
#创建时间 2011-01-26
#END
ver='1.0'
help(){
echo "1 天津人民电台音乐广播"
echo "2 台湾流行音乐广播"
echo "3 猫扑电台"
echo "h 帮助"
}

#自动读入函数库
autoload myfunc.lib


#初始化
begin(){

}

#main函数
main(){

}

#主程序

case $1 in
	'1') mplayer -loop 0 mms://61.136.19.228/live2 ;;
	'2') mplayer -loop 0  mms://media.iwant-in.net/pop ;;
	'3') mplayer -loop 0 mms://ting.mop.com/mopradio ;;
	*) help ;;
esac
