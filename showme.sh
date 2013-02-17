#!/bin/sh
#文件名：showme.sh
#简介：使用dialog实现的脚本列表显示工具
#作者 xiii_1991
#创建时间：2011-06-20
#END

rm *.tmp
tc=0
for x in *.sh
do
  tc=$(($tc+1))
  echo "$tc $x" >> _1.tmp
done
echo $tc
mmm=$(cat _1.tmp)

while true 
do
  dialog --menu "Choose a script:" 30 30 $tc $mmm 2>_2.tmp
  if [ $? = 0 ] ; then
    choice=$(cat _2.tmp)
    cc=$(grep ^$choice _1.tmp)
    filename=${cc##*\ }
    dialog --title $filename --textbox $filename 40 80
  else
    break
  fi
done
dialog --clear
rm *.tmp
exit 0