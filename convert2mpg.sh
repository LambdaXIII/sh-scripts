filename=$1
if [ -f "$filename" ] ; then
    ffmpeg -i "$filename" -vb 5000k -ab 256k "${filename%%.*}.mpg"
else
    echo "$filename 不是一个有效的文件名。"
fi