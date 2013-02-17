#!/bin/zsh
#文件名 downfc.sh
#作者 xiii_1991
#简介 批量下载杂志的。
#创建时间 2011-01-25
#END
ver='1.0'

#主程序
n=1
while [ $n -le 43 ];do
	if [ $n -lt 10 ];then m="0$n"
	else m=$n;fi

	wget -nc "http://fullcirclectt.googlecode.com/files/issue${m}_zh-CN.pdf"
	wget -nc "http://fullcirclectt.googlecode.com/files/issue${m} zh-CN.pdf"
	echo $n
	((n=n+1))
done
