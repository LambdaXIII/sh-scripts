#!/bin/sh
#文件名：script-man3.sh
#简介：第三代脚本管理器交互版。
#作者 xiii_1991
#创建时间：2011-01-23
#END
ver='3.5'
help(){
  echo "Shell脚本管理程序 $ver"
  echo "n 从模板新建脚本"
  echo "e 使用 $editor 编辑脚本"
  echo "x 给予/取消脚本运行权限"
  echo "l 查看脚本列表"
  echo "f 刷新脚本目录"
  echo "m 查看脚本信息"
  echo "r 重命名脚本文件"
  echo "d 删除某脚本"
  echo "b 备份现有的全部自定义脚本"
  echo "rmtrash 清除内建回收站"
  echo "clear 清屏幕"
  echo "0 退出"
  echo ""
}



#初始化
begin(){
clear
selfname="script-man3.sh" #自身得文件名
#filename=$0
myfunc="$HOME/myscripts" #保存所有脚本得目录

if [ -f $myfunc/.scriptmanrc ];then
  owner="`awk '/^owner/{print $2}' "$myfunc/.scriptmanrc"`"
  editor="`awk '/^editor/{print $2}' "$myfunc/.scriptmanrc"`"
else
  echo "未发现设置文件，现在开始初始化。"
  [ ! -d $myfunc ]&& mkdir $myfunc
  echo "请输入您的称呼：\c";read owner
  echo "owner $owner" >> $myfunc/.scriptmanrc

  echo "请输入默认编辑器： \c";read editor
  echo "editor $editor" >> $myfunc/.scriptmanrc

  [ -f $selfname ]&& cp $selfname $myfunc/$selfname
  touch $myfunc/模板文件
fi
[ "$myfunc" != "`pwd`" ]&& echo "注意：一切操作都在$myfunc里进行"
[ ! -d "$myfunc/backup" ]&& mkdir "$myfunc/backup"
[ ! -d "$myfunc/trash" ]&& mkdir "$myfunc/trash"

}

#错误处理
errorcode(){
case $error in
  '1') echo "输入不能为空！" ;;
  '2') echo "输入的文件已存在！" ;;
  '3') echo "输入的文件不存在！" ;;
  '4') echo "操作取消。" ;;
  '5') echo "脚本目录文件不存在，请使用指令f创建。"
esac
}


#处理扩展名
nosh(){
	file="$myfunc/${filename%%.*}.sh"
}

#从模板新建
new_sh(){
echo "请输入脚本文件名(不包含\".\")：\c";read filename
if [ -z $filename ];then error='1'
else
  nosh
  if [ -f $file ];then error='2'
  else
    echo "请输入一段说明：\c";read filememo
    echo "#!/bin/sh" > $file
    echo "#文件名 ${filename%%.*}.sh">>$file
    echo "#作者 "${owner}"" >>$file
    echo "#简介 $filememo">>$file
    echo "#创建时间 `date +%F`">>$file
    echo "#END">>$file
    cat $myfunc/model >>$file
    echo "新脚本 ${filename%%.*}创建完毕。可以使用指令e进行查看和编辑。"
  fi
fi
}

#重命名
rename(){
echo "请输入脚本文件名(不包含扩展名)：\c";read filename
if [ -z $filename ];then error='1'
else
  nosh
  if [ ! -f $file ];then error='3'
  else
    echo "请输入新名称：\c";read newname
    newfile="$myfunc/${newname%%.*}.sh"
    mv $file $newfile
    #sed -n -e '/^#文件名/d;1a"#文件名 $newfile";w' $newfile
    echo "${filename&&.*}已更名为${newname%%.*}"

  fi
fi
}

#删除
del(){
echo "请输入脚本文件名(不包含扩展名)：\c";read filename
if [ -z $filename ];then error='1'
else
  nosh
  if [ ! -f $file ];then error='3'
  else
    echo "即将删除${filename},请确认（y）:\c";read choice
    if [ "$choice" = 'y' ];then mv $file $myfunc/trash ; echo "${filename%%.*}.sh已移动至内建回收站。"
    else error='4'
    fi
  fi
fi
}


#查看信息
memo(){
echo "请输入脚本文件名(不包含扩展名)：\c";read filename
if [ -z $filename ];then error='1'
else
	nosh
	if [ ! -f $file ];then error='3'
	else
		echo "\n"
		echo $file
		echo "\n"
		sed -n -e '1d;1,/#END/{/#END/d;s/#//;1,25p}' $file
		line="`wc -l $file`"
		sine="`sed -n -e '/#END/p' $file`"
		echo "\n\n"
		[ -z $sine ]&& echo "脚本没有可识别的注释标记。"
		echo "脚本共有${line%% *}行"
		[ ! -x $file ] && echo "没有运行权限"
	fi
fi
}

#权限
x(){
echo "请输入脚本文件名(不包含扩展名)：\c";read filename
if [ -z $filename ];then error='1'
else
	nosh
	if [ ! -f $file ];then error='3'
	else
		if [ -x $file ];then chmod -x $file;echo "${filename%%.*} 已取消运行权限。"
		else chmod +x $file;echo "${filename%%.*} 已添加运行权限";fi
	fi
fi
}


#gvim编辑
edit_it(){
echo "请输入脚本文件名(不包含扩展名)：\c";read filename
if [ -z $filename ];then error='1'
else
	nosh
	if [ ! -f $file ];then error='3'
	else
		$editor $file
	fi
fi
}


#刷新脚本目录
fresh(){
[ -f $myfunc/scriptlist ]&& rm $myfunc/scriptlist

for file in $myfunc/*.sh
do
	date="`sed -n -e '/^#创建时间*/{s/#创建时间//;s/ //g;s/://g;s/：//g;p}' $file`"
	[ -z $date ]&&date='-'

	owner="`sed -n -e '/^#作者*/{s/#作者//;p}' $file`"
	[ -z $owner ]&&owner='-'

	filen="${file##*/}"

	line="`wc -l $file`"

	ifx='-'
	[ -x $file ]&& ifx='x'

	echo "$filen $ifx $owner $date ${line%% *}" >> $myfunc/scriptlist
	echo "$filen \c"
done
echo "脚本扫描完毕。"
}

#格式化显示目录
list(){
if [ -f $myfunc/scriptlist ];then
	awk 'BEGIN{print "序号 文件名              权限 作者       创建日期   行数"}{printf("%4s %-20s [%1s] %-10s %-10s %4s \n",NR,$1,$2,$3,$4,$5)}END{print "\n 共有脚本" NR "个"}' $myfunc/scriptlist | more
	echo "详细信息请使用指令m查看。"
else
	error='5'
fi
}

#备份
backup(){

backname="myscripts-snapshot-`date +%m-%d-%k-%M`.tar.bz2"
[ -f "$myfunc/backup/$backname" ]&& rm "$myfunc/backup/$backname"
echo "即将备份全部自定义sh脚本。"
cd $myfunc
tar -cvpjf "backup/$backname" *.sh .scriptmanrc model

echo "全部脚本文件、配置文件、模板文件已备份为 $backname"
}


#清除回收站
rmtrash(){
echo "请输入YES，即将清空内建回收站。\c" ; read choice
if [ choice = 'YES' ] ; then
  rm -rf $myfunc/trash
else
  error='4'
fi
}

#main处理
main(){
error='0'
echo
echo "请输入操作指令：\c" ; read user
case $user in
  'n') new_sh ;; #从模板新建脚本
  'e') edit_it ;; #使用Gvim编辑脚本
  'x') x ;; #给予/取消脚本运行权限
  'l') list ;; #查看Shell脚本列表
  'f') fresh ;; #刷新脚本目录
  'm') memo ;; #查看脚本信息
  'r') rename ;; #重命名脚本文件
  'd') del ;; #删除某脚本
  'b') backup ;; #备份现有的全部自定义脚本
  'rmtrash') rmtrash ;; #清除内建回收站
  '0') break ;;
  'h') help ;;
  'clear') clear ;;
  *) echo "代码错误。输入h查看."
esac
}




#主程序
begin
loopp='1'
lock=$myfunc/script-man3.lock  #加一个运行锁
if [ -f $lock ] ; then
  echo "发现有另一个脚本管理器正在运行，请确认！！"
  echo "也有可能是上一次没有正常退出，请删除 $lock 后再试。"
  loopp='0'
  echo "按Enter退出。" ; read ss
else
  touch $lock
  while [ $loopp = '1' ] ; do main ;errorcode ;done
  rm $lock
fi

