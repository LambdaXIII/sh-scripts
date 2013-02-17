#! /bin/sh

backupdir="~/Backup"

musicdir="音乐"
docdir="文档"
picdir="图片"
configfiles="cpufreqd.conf .emacs .easystroke .moc"
otherdir1="org myfunc mypy"
otherdir2="资料/漫画 资料/myfonts 资料/各种书籍 资料/源代码"
secs="secs"

ff1="7z a -mx9 "
ff2="tar cvpzf "

cd ~
# $ff1 ${backupdir}/${musicdir}.7z ${musicdir}
 $ff1 ${backupdir}/${docdir}.7z ${docdir}
 $ff1 ${backupdir}/${picdir}.7z ${picdir}

 $ff2 ${backupdir}/others_有权限.tar.gz ${otherdir1}
 $ff1 ${backupdir}/others_无权限.7z ${otherdir2}

 $ff2 ${backupdir}/$configfiles.tar.gz ${configfiles}

# $ff1 ${backupdir}/secs.7z ${secs}