#!/bin/ksh
#文件名 locktty
#作者 javalee
#简介：锁定tty的工具，脚本出自linuxsir论坛。
#END

reset;clear    #清除屏幕
password='910404'
info="System will be locked!!! Press Waitting....."
print "\n\n\n\n\n\n\n"
for i in 9 8 7 6 5 4 3 2 1 0
do
print -n "                \a$info$i\r"
sleep 1
done
clear
#加上这个倒记时的小东东,;)

trapper () {	#建立个函数
trap ' ' 2 3 20 #忽略CTRL+C CTRL+\ CTRL+Z信号
}
while :	#进入死循环
do
trapper	#调用函数
print "\n\n\n\n\n\n\n\n\t\t\tPlease enter unlock code:"
stty -echo	#屏蔽输入的字符
read input
case $input in
"$password")
print "\t\t     Hello $USER,Today is $(date +%T)\n"
stty echo	
break ;;	#输入正确,挑出循环回到命令行
*)
clear
continue ;;	#否则,继续循环
esac
done
#script over
