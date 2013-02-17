#!/bin/sh
#文件名：script-man3.sh
#简介：第三代脚本管理器交互版。
#作者 xiii_1991
#创建时间：2011-01-23
#END
dialog --title "Hello" --msgbox "hkaaaaaaaaa" 9 18
dialog --title "Confirm" --yesno "R U willing to take part?" 9 18
if [ $? != 0 ] ; then
  dialog --infobox "Thank  you any way" 5 20
  sleep 2
  dialog --clear
  exit 0
fi