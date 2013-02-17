#!/bin/sh

dir1=~/temp/videompg
#mkdir $dir1

for x in *.MOD
do
    cp $x ${dir1}/${x%%.*}.mpg
    echo ${x%%.*}.mpg

done
