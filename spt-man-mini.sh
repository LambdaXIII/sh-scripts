#!/bin/sh
#文件名：spt-man-mini
#作者 xiii_1991
#简介：脚本管理器的命令行迷你版
#错误码：1-输入参数为空 2-输入的文件或目录不存在 3-1+2 4-exist
#创建时间：2011-01-22
#END
ver='2.2'
myfunc="$HOME/myscripts"
error='0'
unset dir file filename line

help(){
echo "collect 收录脚本到目录"
echo "collect-all 收录全部sh脚本"
echo "memo 查看脚本说明"
echo "show 查看脚本正文"
echo "x 添加/去除可执行权限"
echo "1ist 列出目录中的脚本情况"
echo "new 从模板新建脚本"
echo "read-help 尝试读取help函数"
echo "check 调试脚本"
echo "del-empty 删除空脚本"
echo "ver 版本信息"
}


#ver
ver(){
echo "版本$ver"
}

#收录脚本
collect(){
file=$1
temp=${file%%.*}
filename=${temp##*/}
if [ -f $file ];then
	cp $file "${myfunc}/${filename}.sh"
	echo "$file已拷贝为$myfunc/$filename.sh"
else
	error='3'
fi
}

#收录all脚本
collect_all(){
if [ -z $1 ];then
	dir="`pwd`"
else
	dir=$1
fi

if [ -d $dir ];then
	for file in `ls $dir/*.sh`;do
		collect "$file"
	done
fi
}

#脚本说明
memo(){
if [ -z $1 ];then
	error='1'
else
	file=$1
fi

if [ -f $file ];then
	sed -n -e '1d;1,/#END/p' $file
else
	error='2'
fi
}

#正文
show(){

if [ -z $1 ];then
	error='1'
else
	file=$1
fi
if [ -f $file ];then
	sed -n -e '/^#/d;1,20p' $file
else
	error='2'
fi
}

#权限
x(){
file=$1
if [ -f $file ];then
	if [ -x $file ];then
		chmod -x $file
		echo "已去除运行权限"
	else
		chmod +x $file
		echo "已添加运行权限"
	fi
else
error='3'
fi
}

#列表
list_folder(){

if [ -z $1 ];then
	dir="`pwd`"
else
	dir=$1
fi

if [ -d $dir ];then
	echo $dir
	for file in `ls $dir/*.sh` ;do
		line=`wc -l $file`
		if [ -x $file ];then xx='[可执行]'
		else xx='';fi
		echo "${file##*/}    共${line%% *}行    $xx"
	done
else
	error='1'
fi

}

#新建
new(){
if [ -z $1 ];then
	error='1'
else
	file=$1
fi

if [ -f $file ];then
	error='4'
else
	cp $myfunc/model $file
fi
}

#帮助
read_help(){
if [ -z $1 ];then
	error='1'
else
	file=$1
fi

if [ -f $file ];then
	sed -n -e '/^help/,/}/p' $file
else
	error='2'
fi
}

#检查
check(){
if [ -z $1 ];then
	error='1'
else
	file=$1
fi

if [ -f $file ];then
	sh -x $file
else
	error='2'
fi
}

#删除空文件
del_empty(){
if [ -z $1 ];then
	dir="`pwd`"
else
	dir=$1
fi

if [ -d $dir ];then
	for file in `ls $dir/*.sh` ;do
		if [ ! -s $file ];then
			rm $file
			echo "${file##*/}已删除"
		fi
	done
else
	error='2'
fi
}


#主程序
case $1 in
	'collect') collect $2 ;;
	'collect-all') collect_all $2 ;;
	'memo') memo $2 ;;
	'show') show $2 ;;
	'x') x $2 ;;
	'list') list_folder $2 ;;
	'new') new $2 ;;
	'read-help') read_help $2 ;;
	'check') check $2 ;;
	'del-empty') del_empty $2 ;;
	'ver') ver ;;
	*) help ;;
esac

if [ $error != '0' ];then echo "错误码 $error";fi
