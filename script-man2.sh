#!/bin/sh
#script-man2.sh
#一个管理自定义脚本的中文程序
#这是第二版了，第二版可以不用另外的注释文件，自动读取脚本开头的几行注释文件。注释以END结束。
#END

ver='2.2'

main_menu(){
	echo "Shell脚本管理程序 $ver"
	echo "1 从模板新建脚本"
	echo "2 使用Gvim编辑脚本"
	echo "3 给予/取消脚本运行权限"
	echo "4 检查脚本错误并将结果输入文本文件"
	echo "5 查看Shell脚本列表"
	echo "6 读取指定脚本注释和其他信息"
	echo "7 刷新/新建脚本模板文件"
	echo "d 删除某脚本"
	echo "b 备份现有的全部自定义脚本"
	echo "0 退出"
}

#判断并新建模板 以及注释文件夹
new_model(){
	if [ ! -f model ] ; then
		#echo "#!/bin/sh" >model.sh
		touch model
		echo "未发现脚本模板，已经自动创建。文件名 model 。"
	fi
	if [ ! -d error ] ; then
		mkdir error
		echo "未发现错误报告目录，已自动创建。目录名 error。"
	fi
	if [ ! -d backup ] ; then
		mkdir backup
		echo "未发现备份目录，已自动创建。目录名backup。"
	fi
#	if [ ! -d ./memo ] ; then
#		mkdir ./memo
#		echo "未发现脚本注释文件夹，已经自动建立。目录名：memo"
#	fi
}

#新建脚本的模块
new_script(){
	if_ls
	echo "请输入脚本文件名(不包含扩展名)：\c"
	read filename

	if [ -z $filename ]
	then
		echo "文件名不能为空！"
	else
		if [ -f "${filename}.sh" ]
		then
			echo "对不起，该文件已经存在！"
		else
			#cp model.sh "${filename}.sh"
			echo "请输入脚本简介:"
			read filememo
			echo '#!/bin/sh' > ${filename}.sh
			echo "#文件名：$filename" >> ${filename}.sh
			echo "#简介：$filememo" >> ${filename}.sh
			echo "#创建时间：`date +%F`" >> ${filename}.sh
			echo "#END" >> ${filename}.sh
			cat model >> ${filename}.sh
			echo "新脚本 ${filename}.sh 创建完毕。可以使用2号指令进行查看和编辑。"
		#	echo " 文件名： ${filename}.sh " > "./memo/${filename}.memo"
		#	echo " 简介: $filememo " >> "./memo/${filename}.memo"
		#	echo " 创建日期：`date` " >> "./memo/${filename}.memo"

		fi
	fi
	
}

#查看脚本列表
dir_sh(){
echo "脚本名单如下："
for filename in *.sh
do
	if [ -x $filename ];then
		echo "${filename%%.*} (可执行)"
	else
		echo ${filename%%.*}
	fi
done

}
#是否要查看脚本名单
if_ls(){
echo "是否要查看脚本名单？(N)\c"
read choice
if [ "$choice" = "y" ]
then 
	dir_sh
fi
}


#选择编辑程序并编辑
edit_it(){
if_ls
echo "请输入您想要编辑的脚本名称:\c"
read filename

	if [ -f "${filename}.sh" ]
	then
		gvim ${filename}.sh
	else
		echo "文件名${filename}.sh不存在！"
	fi
}

#给予运行权限
give_rights(){
if_ls
echo "请输入想要修改权限的脚本名称："
read filename
if [ -x "${filename}.sh" ]
then
	chmod -x ${filename}.sh
	echo " $filename 已经解除运行权限"
else
	chmod +x ${filename}.sh
	echo " $filename 已经添加运行权限"
fi
}

#检查脚本错误
check_it(){

if_ls
echo "请输入需要检查的程序名：\c"
read filename
if [ -n $filename ];then
	sh -n ${filename}.sh > ./error/$filename.error
	echo "测试报道写入完毕。报告名${filename}.error"
else
	echo "操作取消"
fi

}

#读取对应的注释
read_mem(){
if_ls
echo "请输入需要查看信息的文件名:\c"
read filename
if [ -f ${filename}.sh ] ; then
	sed -n -e '/^#/{1d;1,/#END/{/#END/d;s/#//;p}}' $filename.sh
	fline="`wc -l $filename.sh`"
	echo "脚本共有${fline%% *}行。"
	if [ -x $filename.sh ];then
		echo "脚本具有可执行权限。"
	else
		echo "脚本没有可执行权限。"
	fi
else
	echo "对不起，文件${filename}.sh不存在。"
fi

}

#刷新脚本模板
fresh_model(){
echo "确定要重置模板文件为初始状态吗？请输入YES：\c"
read choice
if [ "$choice"="YES" ] ; then
	if [ -f model ] ; then
		cp model model.old
		echo "之前的模板已经备份为model.old"
	fi
	rm model
	echo "模板已经删除。"
fi
}

#删除某脚本和注释
rm_sh(){
if_ls
echo "请输入需要删除的脚本名：\c"
read filename
if [ -n $filename ] ; then
	if [ -f ${filename}.sh ] ; then
		echo "即将删除脚本 ${filename}.sh,请输入 YES：\c"
		read choice
		if [ "$choice"="YES" ] ; then
			rm ${filename}.sh
		#	touch ./memo/${filename}.memo
		#	rm ./memo/${filename}.memo
		else
			echo "操作取消。"
		fi
	else
		echo "脚本${filename}.sh不存在!"
	fi
else
	echo "文件名为空，操作取消。"
fi
}



#备份
back_up(){
#if [ ! -d ./backup ];then mkdir ./backup ; fi
if [ -f "./backup/sh`date +%F`.tar" ];then
rm "./backup/sh`date +%F`.tar"
fi
echo "即将备份全部自定义sh脚本。"
tar -cvf "sh.tar" ./*.sh
mv "sh.tar" "./backup/sh`date +%F`.tar" 
cp .scriptmanrc backup/scriptmanrc"`date +%F`"
cp model backup/model"`date +%F`"
echo "备份完毕。"
}







#主循环
running='1'
#user='6'
if [ "`pwd`" = ~/myfunc ] ; then
	new_model
	main_menu
	while [ "$running"="1" ]
	do
		echo
		echo "请输入操作代号(h帮助)：\c"
		read user
		case "$user" in
		'1') new_script ;;
		'2') edit_it ;;
		'3') give_rights ;;
		'4') check_it ;;
		'5') dir_sh ;;
		'6') read_mem ;;
		'h') main_menu ;;
		'7') fresh_model ;;
		'd') rm_sh ;;
		'b') back_up ;;
		'0') break ;;
		*) echo "对不起，本程序暂时没有 $user 这个选项。"
		echo "有任何意见请联系作者 xiii.1991@gmail.com" ;;
		esac
	done
else
#	mkdir ~/myfunc
#	cp ./.script-manager.sh ~/myfunc
	echo "对不起本程序只能在~/myfunc目录下运行。"
	echo "请到~/myfunc目录下重新运行本程序"
fi
echo "程序结束"



