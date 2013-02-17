#!/bin/sh
#清理ape系列工具产生的临时文件。

rm -f *.ape *.wav *~ *.log *.flac *.cue
mv kk/* ./
rm -rf bb kk
