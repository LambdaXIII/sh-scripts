#!/bin/sh
#文件名：conv.sh
#简介：批量转换视频的脚本。使用的时候建议复制到目标目录后在做相应修改。
#作者 xiii_1991
#创建时间：2011-5
#END

for x in *.avi
do
#    echo ${x%%.*}
#    echo ""
    ffmpeg -i $x -vb 6000k -ab 256k -deinterlace encoded/${x%%.*}.mpg

done