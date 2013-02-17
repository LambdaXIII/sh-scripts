#!/bin/sh
#文件名 script-clean.sh
#作者 xiii
#简介 清除脚本目录里不需要的文件。
#创建时间 2011-06-10
#END
myfunc=$HOME/myscripts

cd $myfunc
rm *~
echo "Done"