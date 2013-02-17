#!/bin/sh
# soft-man
#作者 xiii_1991
# 简化apt操作的脚本
# 2011年 01月 21日 星期五 11:00:35 CST
#END
ver='0.1'
#操作提示
help(){
echo "-a 自动安装软件包(install)"
echo "-r 重新安装软件包"
echo "-u 更新当前源"
echo "-v 更新现有的软件包版本"
echo "-g 自动更新系统"
echo "-e 强制解锁"
echo "-h 帮助"
#echo "0 退出"
}


#主循环
#echo "请输入操作代码：\c"
#read user
case $1 in
	'-a') apt-get install $2 ;;
	'-r') apt-get reinstall $2 ;;
	'-u') apt-get update ;;
	'-v') apt-get upgrade ;;
	'-g') apt-get dist-upgrade ;;
	'-h') help ;;
	'-e') rm /var/lib/dpkg/lock ; echo "解锁完毕";;
	*) break ;;
esac
