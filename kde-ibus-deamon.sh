#!/bin/sh
#文件名 kde-ibus-deamon.sh
#作者 xiii
#简介 进入kde之后，重新启动一下ibus。
#创建时间 2011-06-12
#END

#ibus-daemon -dxr
export GTK_IM_MODULE=ibus                                                                   
export XMODIFIERS=@im=ibus                                                                  
export QT_IM_MODULE=ibus