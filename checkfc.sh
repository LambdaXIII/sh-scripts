#!/bin/zsh
#文件名 checkfc.sh
#作者  xiii_1991
#简介 检查fc杂志是不是下载全了，方便我手动下载。
#创建时间 2011-01-26
#END
ver='1.0'
help(){
echo "1"
echo "1"
echo "1"
echo "1"
echo "1"
echo "1"
echo "1"
echo "1"
echo "h 帮助"
echo "0 退出"
}



#初始化
begin(){

}

#main函数
main(){

}

#主程序
n=0
while [ $n -le 43 ];do
	if [ ! -f "issue${n}_zh-CN.pdf" -a ! -f "issue${n} zh-CN.pdf" ];then
		echo $n >> quede.txt
	fi
	((n=n+1))
done

