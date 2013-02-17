#!/bin/sh
#文件名：script-man4.sh
#简介：第四代脚本管理器交互版。在3代的基础上，使用dialog制作ui。
#作者 xiii_1991
#创建时间：2011-06-20
#END

#初始化
begin(){
clear
selfname="script-man4.sh" #自身得文件名
myfunc="$HOME/myscripts" #保存所有脚本得目录

if [ -f $myfunc/.scriptmanrc ];then
  owner="`awk '/^owner/{print $2}' "$myfunc/.scriptmanrc"`"
  editor="`awk '/^editor/{print $2}' "$myfunc/.scriptmanrc"`"
  password="`awk '/^password/{print $2}' "$myfunc/.scriptmanrc"`"
else
  dialog --title 脚本管理器 --infobox "未发现配置文件，现在开始初始化。" 9 40 ; sleep 2
  [ ! -d $myfunc ]&& mkdir $myfunc
  dialog --title 脚本管理器 --inputbox "请输入你的称呼：" 9 40 "xiii_1991" 2>_tmp
  owner=$(cat  _tmp)
  echo "owner $owner" >> $myfunc/.scriptmanrc

  dialog --title 脚本管理器 --inputbox "请输入默认编辑命令" 9 40 "kate" 2>_tmp
  editor=$(cat _tmp)
  echo "editor $editor" >> $myfunc/.scriptmanrc
  
  dialog --title 脚本管理器 --inputbox "请输入密码：" 9 40 "" 2>_tmp
  password=$(cat _tmp)
  echo "password $password" >> $myfunc/.scriptmanrc

  [ -f $selfname ]&& cp $selfname $myfunc/$selfname
  touch $myfunc/模板文件
  dialog --title 初始化 --infobox "配置文件生成完毕，位于$myfunc/.scriptmanrc。你可以手动修改。" 9 40
  sleep 5
fi

[ "$myfunc" != "`pwd`" ]&& echo "注意：一切操作都在$myfunc里进行"
[ ! -d "$myfunc/backup" ]&& mkdir "$myfunc/backup"
[ ! -d "$myfunc/trash" ]&& mkdir "$myfunc/trash"


}

#main处理
main(){
error='0'
dialog --no-cancel --title 脚本管理器 --menu "请选择操作：" 20 40 11 \
n "从模板新建脚本" \
e "使用 $editor 编辑脚本" \
x "给予或取消运行权限" \
l "查看脚本情况" \
f "fresh 刷新脚本目录" \
m "查看某脚本信息" \
r "重命名一个脚本" \
d "删除某脚本" \
b "备份现有的全部脚本" \
9 "清空内建回收站" \
0 "退出" \
2>_tmp

user=$(cat _tmp)
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
esac

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







begin
main

rm _tmp