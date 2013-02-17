#!/bin/sh

num=23
gue=0

echo '请输入你猜测的数字：'
read gue

if [ "$gue"="$num" ] ;then
echo 'Yes'
fi



