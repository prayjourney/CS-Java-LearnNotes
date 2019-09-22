### 常用的Linux命令
---

#### 学习链接: 
[linux命令学习1](http://man.linuxde.net/linux-%E6%96%87%E4%BB%B6%E4%B8%8E%E7%9B%AE%E5%BD%95%E7%AE%A1%E7%90%86)
[linux命令学习2](http://man.linuxde.net/linux%E6%96%87%E4%BB%B6%E5%92%8C%E7%9B%AE%E9%8C%84%E7%AE%A1%E7%90%86%E7%9A%84%E5%9F%BA%E6%9C%AC%E5%91%BD%E4%BB%A4)


#### 常用命令: 
##### history
history命令就是历史记录. 它显示了在终端中所执行过的所有命令的历史. 
参考链接:
1.[对Linux新手非常有用的 20个命令](https://www.cnblogs.com/Blog-Yang/p/3247292.html)

##### grep
管道, 过滤, 作为linux中最为常用的三大文本(awk, sed, grep)处理工具之一, grep命令的常用格式为: `grep [选项] "模式" [文件]`, grep家族总共有三个: `grep`, `egrep`, `fgrep`, 一般常用grep. 扩展选项如下:　
```shell
-E : 开启扩展Extend的正则表达式. 
-i : 忽略大小写ignore case. 
-n : 显示行号
-w : 被匹配的文本只能是单词, 而不能是单词中的某一部分, 如文本中有liker, 而我搜寻的只是like, 就可以使用-w选项来避免匹配liker
--color :将匹配到的内容以颜色高亮显示. 
```
参考链接:
1.[linux中grep命令的用法](https://www.cnblogs.com/flyor/p/6411140.html)

##### awk
1.[awk学习](https://www.cnblogs.com/jiqianqian/p/7944013.html)

##### sed
1.[sed学习](https://www.cnblogs.com/wangqiguo/p/6718512.html)

##### xxx --help(man xxx)
xxx --help, 是对xxx命令的常用选项和用法格式的一个介绍,  man xxx也是介绍,  man的内容比较复杂是详细介绍, xxx --help比较简洁, 简单介绍

##### pwd 
当前路径(dirs)

##### l(ls) 
显示给出路径之中的文档列表 
```shell
Usage: ls [OPTION]... [FILE]...
参数: 
-a:                          do not ignore entries starting with .
-A:                          do not list implied . and ..
-s, --size                   print the allocated size of each file, in blocks
-l:                          use a long listing format
-t:                          sort by modification time
-h, --human-readable         with -l, print sizes in human readable format (e.g., 1K 234M 2G)
-d, --directory              list directory entries instead of contents, and do not dereference symbolic links
-R, --recursive              list subdirectories recursively(列出子文件夹之中的文件)
```
例子: 
```shell
ls -lh      //可以将文件的大小从字节, 转换成为KB,MB,GB等常见熟悉的情况类型
```
参考链接: 
1.[每天一个linux命令(3):ls命令](https://www.cnblogs.com/xqzt/p/5380627.html),   2.[Linux中ls命令用法](https://www.cnblogs.com/aijianshi/p/5756346.html).

##### ifconfig 
查看当前的ip信息
```shell
add/del netmask
```
例子:
```shell
ifconfig eth0 192.168.1.1 netmask 255.255.255.0   临时配置ip
ifconfig eth1 down    停止网卡
ifconfig eth1 up      启动网卡
```
参考链接:
1.[linux下配置临时IP](https://blog.csdn.net/lv302677589/article/details/79087893)
			

##### ip 
查看ip的信息
```shell
// 参数:
link          网络设备
address       设备上的协议(IP或IPv6)地址
addrlabel     协议地址选择的标签配置
neighbour     ARP或NDISC缓存条目
route         路由表条目
rule          路由策略数据库中的规则
maddress      组播地址
```
例子:
```shell
ip a/addr/address add 192.168.78.130/24 dev eth1          增加ip
ip a/addr/address del/delete 192.168.78.130/24 dev eth1   删除ip
```
参考链接:
1.[Linux命令之ip](https://www.cnblogs.com/diantong/p/9511072.html), 2.[linux ip命令和ifconfig命令](https://blog.csdn.net/freeking101/article/details/68939059)



#### 系统:
命令检查, 设置服务
##### chkconfig
命令检查, 设置系统的各种服务, 常用的有如下的几种, 增加一个服务的时候, 脚本必须在/etc/init.d/的目录下
```shell
chkconfig --list             #列出所有的系统服务.
chkconfig --add httpd        #增加httpd服务.
chkconfig --del httpd        #删除httpd服务.
```
参考链接:
1.[chkconfig命令软件包管理](http://man.linuxde.net/chkconfig)

##### uname
查看系统信息,`uname -a`, 等价的有: `lsb_release -a`, `cat /etc/issue`, `cat /proc/version`
例子:

```shell
uname -a
Linux version 3.0.76-0.11-default (geeko@buildhost) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Fri Jun 14 08:21:43 UTC 2013 (ccab990)
Welcome to SUSE Linux Enterprise Server 11 SP3  (x86_64) - Kernel \r (\l).
```

##### ssh
远程登录的命令, ssh开启root登录方法: 
修改`/etc/ssh/sshd_config`文件,` PermitRootLogin yes`, `PasswordAuthentication yes`, 重启ssh服务 `/etc/init.d/ssh start`,  查看状态`/etc/init.d/ssh status`
例子:

```shell
// 登录服务器
ssh DRManager@100.133.187.169
```
参考链接:
1.[kali linux 开启SSH服务 容许root登陆](https://blog.csdn.net/u010953692/article/details/80312751),   2.[Linux ssh登录命令](https://www.cnblogs.com/joshua317/articles/4740881.html),   3.[SSH简介及两种远程登录的方法](https://blog.csdn.net/li528405176/article/details/82810342)

##### who
显示关于当前在本地系统上的所有用户的信息
```shell
a  处理 /etc/utmp 文件或有全部信息的指定文件. 等同于指定 -bdlprtTu 标志. 
-b 指出最近系统启动的时间和日期. 
-l 列出任何登录进程. 
-m 仅显示关于当前终端的信息. who -m 命令等同于 who am i 和 who am I 命令. 
-q 打印一份在本地系统上的用户和用户数的快速清单. 
```
参考链接:
1.[Linux who命令详解](https://www.cnblogs.com/ftl1012/p/who.html)

##### whoami
显示当前登陆的用户名

##### which
查看可执行文件的位置, 从全局环境变量PATH里面查找对应的路径, 默认是找 bash内所规范的目录. 
如`which cp`, 返回cp命令的位置`./bin/cp`
参考链接:
1.[Linux which/whereis/locate命令详解](https://www.cnblogs.com/ftl1012/p/which.html)

##### whereis
只能用于搜索程序名在什么地方, 配合-b, 只搜索二进制, -m搜索在manual之中的位置
```shell
xww:~/Desktop/rrr # whereis cp
cp: /bin/cp /usr/share/man/man1p/cp.1p.gz /usr/share/man/man1/cp.1.gz
xww:~/Desktop/rrr # whereis -b cp
cp: /bin/cp
```
##### reboot
重启系统

##### poweroff
关机且断电

##### shutdown
关机(halt)

##### ctrlaltdel
设置组合键Ctrl+Alt+Del的功能

##### type
type命令用来区分某个命令到底是由shell自带的, 还是由shell外部的独立二进制文件提供的.   	
如果一个命令是外部命令, 那么使用-p参数, 会显示该命令的路径, 相当于which命令. 
参考链接:
1.[linux命令中which、whereis、locate有什么区别？](https://www.cnblogs.com/jycjy/p/6940544.html)

##### free
free命令可以显示Linux系统中空闲的, 已用的物理内存及swap内存, 及被内核使用的buffer. 
```shell
用法: free [-b | -k | -m | -g | -h] [-o] [-s delay ] [-c count ] [-a] [-t] [-l] [-V]
参数: 
    -b 　以Byte为单位显示内存使用情况.  
    -k 　以KB为单位显示内存使用情况.  
    -m 　以MB为单位显示内存使用情况. 
    -g   以GB为单位显示内存使用情况.  
    -h   以human readable方式输出(有的可能不支持)
    -o 　不显示缓冲区调节列.  
    -s<间隔秒数> 　持续观察内存使用状况.  
    -t 　显示内存总和列.  RAM+SWAP
    -V 　显示版本信息.
```
参考链接:
1.[每天一个linux命令:free](https://www.cnblogs.com/xqzt/p/5448916.html)

##### df
df (disk free) 其功能显示每个文件所在的文件系统的信息, 默认是显示所有文件系统. 
```shell
参数: 
    -a: 显示所有的磁盘使用情况
    -h: 以人性化的方式显示磁盘使用情况, GB, MB, KB这些单位,  
        常用df -a -h或者缩写 df -ah, 所有的-x都可以缩写,  所有的--x也可以缩写在一起
```
参考链接:
1.[每天一个linux命令:df](https://www.cnblogs.com/xqzt/p/5436967.html)

##### du
du (Disk usage) 用来计算每个文件的磁盘用量, 目录则取总用量. 默认是当前的目录, 也可以在du 后面指定目录, 显示文件的大小
```shell
    -a: 相应文件夹下所有的文件的大小
    -h: 以人性化的方式显示磁盘使用情况, GB, MB, KB这些单位,  
        常用du -a -h或者缩写 du -ah
    -s: 求和, 默认是当前文件夹下面的所有的大小 du -sh,  du -sh name.py
```
参考链接:
1.[每天一个linux命令:du](https://www.cnblogs.com/xqzt/p/5436970.html)

##### vmstat
vmstat(Virtual Memory Statistics 虚拟内存统计) 命令用来显示Linux系统虚拟内存状态, 也可以报告关于进程, 内存, I/O等系统整体运行状态. 
```shell
    -a: 显示活跃和非活跃内存
    -f: 显示从系统启动至今的fork数量 . 
    -S: 使用指定单位显示. 参数有 k , K , m , M , 分别代表1000, 1024, 1000000, 1048576字节byte. 默认单位为K1024 bytes
    -V: 显示vmstat版本信息. 
```
参考链接:
1.[每天一个linux命令:vmstat](https://www.cnblogs.com/xqzt/p/5448983.html)

##### iostat
iostat(I/O statistics 输入/输出统计) 命令对系统的磁盘操作活动进行监视. 它的特点是汇报磁盘活动统计情况, 同时也会汇报出CPU使用情况
```shell
    -c: 仅显示CPU使用情况； 
    -d: 仅显示设备利用率；一般不和-c一起使用 
    -k: 显示状态以千字节每秒为单位, 而不使用块每秒； 
    -m: 显示状态以兆字节每秒为单位；
    -N 显示磁盘阵列(LVM) 信息
    -n 显示NFS 使用情况
    -p: 仅显示块设备和所有被使用的其他分区的状态； 
    -t: 显示每个报告产生时的时间； 
    -V: 显示版号并退出； 
    -x: 显示扩展状态. 
```
例子:
```shell
    iostat -d -k 2 3:  每2秒钟检查一次, 一共检查3次
    iostat -d -k    :  查看磁盘读写速度, 以k为单位
```
参考链接:
1.[每天一个linux命令:iostat](https://www.cnblogs.com/xqzt/p/5449034.html)



#### 文件:
##### cp
```shell
cp /home/xxx.txt /opt/mg/123.txt
```
##### mv
可以直接移动文件夹,  可以重命名文件

##### rm
```shell
rm -rf  rm -rf /home/zgy,  递归删除/home/zgy文件夹,  -r, -R参数是递归的意思 
```

##### mkdir
```shell
mkdir xxx,  在当前目录下创建了xxx文件夹
```

##### rmdir
```shell
rmdir, rmdir xxx,  删除当前目录下的xxx文件夹
```

##### touch
touch(当文件不存在的时候创建文件), 当文件存在时, 更新文件的访问和修改时间,  touch命令将每个文件的访问时间和修改时间改为当前时间.
```shell
参数选项: 
    -a              只更改访问时间
    -t STAMP        使用[[CC]YY]MMDDhhmm[.ss] 格式的时间而非当前时间
```
例子: 
```shell
touch a.log                更新a.log的修改时间为当前时间, 没有a.log则创建
touch -r a.log   b.log     更新log1.log的时间和log2.log时间戳相同
touch -t 201601011200.50 log.log        设定文件的时间戳
```
参考链接: 
1.[每天一个linux命令(9):touch](https://www.cnblogs.com/xqzt/p/5399407.html)

##### scp
scp命令是安全复制
```shell
格式: 
    scp [-12346BCpqrv] [-c cipher] [-F ssh_config] [-i identity_file] [-l limit] [-o ssh_option] [-P port] [-S program] [[user@]host1:]file1 ... [[user@]host2:]file2
```
scp = ssl+cp, 安全的复制,  可以从本机--->远程,  也可以从远程--->本机, 或者从远程主机1--->远程主机2
例子: 

```shell
scp etc/fgg.tar DRManager@100.133.187.169:/home/DRManager/ff 
# 把etc下面的fgg.tar文件复制到远程主机的相应文件夹之中

scp DRManager@100.133.187.169:/home/DRManager/ff/etc.tar ./  
# 把远程主机的文件复制到本主机上
```
参考链接:
1.[每天一个linux命令：scp命令](https://www.cnblogs.com/webnote/p/5877920.html),   2.[linux scp 使用方法](https://www.cnblogs.com/z977690557/p/6826495.html),   3.[Linux——scp的用法](https://blog.csdn.net/cyl101816/article/details/81170732)

##### tar
打包和解包[不是压缩], 压缩有zip命令, 因此有如下两个名字需要注意:
**打包**: 将一大堆文件或目录变成一个总的文件【tar命令】
**压缩**: 将一个大的文件通过一些压缩算法变成一个小文件【gzip, bzip2等】
例子:

```shell
tar -cf archive.tar foo bar  # Create archive.tar from files foo and bar. 创建archive.tar,  把foo, bar文件或者文件夹打包到其中. 
tar -tvf archive.tar         # List all files in archive.tar verbosely.   列出archive.tar文件之中的文件列表. 
tar -xf archive.tar          # Extract all files from archive.tar.
```
Linux中很多压缩程序只能针对一个文件进行压缩, 这样当你想要压缩一大堆文件时, 你得将这一大堆文件先打成一个包tar命令, 然后再用压缩程序进行压缩gzip bzip2命令. 
tar语法: 
```shell
语法: 
    tar [主选项+辅选项] 文件或目录
    使用该命令时, 主选项必须有, 它告诉tar要做什么事情, 辅选项是辅助使用的, 可以选用. 
    主选项: 【一条命令以下5个参数只能有一个】
        -c: --create 新建一个压缩文档, 即打包
        -x: --extract,--get解压文件
        -t: --list,查看压缩文档里的所有内容
        -r:--append 向压缩文档里追加文件
        -u:--update 更新原压缩包中的文件
    
    辅助选项: 
        -z:是否同时具有gzip的属性?即是否需要用gzip压缩或解压?一般格式为xxx.tar.gz或xx.tgz
        -j:是否同时具有bzip2的属性?即是否需要用bzip2压缩或解压?一般格式为xx.tar.bz2
        -v:显示操作过程！这个参数很常用
        -f:使用文档名, 注意, 在f之后要立即接文档名, 不要再加其他参数！
        -C:切换到指定目录
        --exclude FILE:在压缩过程中, 不要将FILE打包
```
参考链接: 
1.[linux tar命令简介](https://www.cnblogs.com/starof/p/4229017.html) ,   2.[Linux tar 命令用法]( https://www.cnblogs.com/GyForever1004/p/8491071.html) ,   3.[linux中tar命令用法](https://www.cnblogs.com/newcaoguo/p/5896975.html),   4. [linux下tar命令详解](https://www.cnblogs.com/wuxiang/p/4799959.html)



#### 日志查看: 
##### cat
cat命令是linux下的一个文本输出命令, 通常是用于观看某个文件的内容的；cat主要有三大功能: 

1. 一次显示整个文件. `cat filename`
2. 从键盘创建一个文件.  `cat  >  filename`,   写完内容后,  **Control-D**结束写入, 只能创建新文件,不能编辑已有文件.
3. 将几个文件合并为一个文件.  `cat   file1   file2  > file`

说明: 
**tac是从最后一行输出全部的内容,  和cat的功能类似, 只是相反的方向. **
参数: 

```shell
cat [-AbeEnstTuv] [--help] [--version] fileName -n  # 从1开始对于所有的输出行数编号
```
参考链接: 
1.[Linux cat命令详解](https://www.cnblogs.com/zhangchenliang/p/7717602.html),   2.[（linux）使用cat命令时如何退出](https://blog.csdn.net/songlang90/article/details/46397679),   3.[Linux_cat_使用cat 和 结束符 输出多行文本](https://blog.csdn.net/u010003835/article/details/53331385),   4. [每天一个linux命令(10):cat](https://www.cnblogs.com/xqzt/p/5410283.html)

##### less
less 工具也是对文件或其它输出进行分页显示的工具, 是linux正统查看文件内容的工具, 功能极其强大. 比起 more 更加的有弹性. less命令可以对文件或其它输出进行分页显示, 与moe命令相似, 但是比more命令要强大许多. 应该说是linux正统查看文件内容的工具. 
**less的功能和more相似, 但是使用more无法向前翻页, 只能向后翻, 而less可以任意切换**

```shell
命令格式:
less  [选项]... [文件]...
参数: 
    -g 只标志最后搜索的关键词
    -i 忽略搜索时的大小写
    -m 显示类似more命令的百分比
    -N 显示每行的行号
```
less命令进入之后也有内部操作使用的命令, 如下:
```shell
内部的命令: 
    ctrl + F - 向前移动一屏ctrl-f作用和ctrl-F正好相反,  下面的几个也都是一样, 大写和小写是相反的作用
    ctrl + B - 向后移动一屏
    ctrl + D - 向前移动半屏
    ctrl + U - 向后移动半屏
    /字符串: 向下搜索"字符串"的功能
    ?字符串: 向上搜索"字符串"的功能
    n:       重复前一个搜索与 / 或 ? 有关
    N:       反向重复前一个搜索与 / 或 ? 有关
    space:   空格表示向后移动一屏
    enter:   回车表示向下移动一行
    j:       向前移动一行
    k:       向后移动一行
    g:       移动到最开始一行
    G:       移动到最后一行
    q:       退出
    :e       在看本文件的时候, 去打开另一个文件看[相当牛逼的功能]
```
其他: less 版 tail -f
在 Linux 动态查看日志文件常用的命令非 tail -f 莫属, 其实 less 也能完成这项工作, 使用 F 命令. 
使用 less file-name 打开日志文件, 执行命令 F, 可以实现类似 tail -f 的效果. 多个文件的显示效果一般, 一个文件效果和tailf相同,  非常不错的功能.
例子: 

```shell
ps -ef|less -N                    # 显示行数, 分页显示所有的进程
less test2.log test.log           # 同时查看多个日志  
less -N fcd.txt, 进入后 :e msg.txt # 在查看fcd.txt的同时间, 然后 去查看msg.txt, 使用q退出
less fcd.log 进入后按F             # 实时显示fcd.log的内容
history | less                    # 执行命令的历史记录分页查看
```
参考链接: 
1.[Linux less命令详解](https://www.cnblogs.com/luxiaojun/p/6439663.html) ,   2.[Linux less命令详解](https://www.cnblogs.com/GNblog/p/6932252.html),   3.[Linux less命令详解](https://www.cnblogs.com/GNblog/p/6932252.html) ,   4.[less命令](http://man.linuxde.net/less),   5.[每天一个linux命令(13):less命令](https://www.cnblogs.com/xqzt/p/5424866.html), 6. [Linux学习笔记--less命令(显示文件内容的命令)](https://blog.csdn.net/daidaineteasy/article/details/51017270),   7.[LESS命令简单介绍以及使用](https://www.cnblogs.com/molao-doing/articles/6541455.html),   8.[less 分页显示文件内容](https://www.cnblogs.com/joechu/p/8947411.html),   9.[每天一个Linux命令](https://www.cnblogs.com/xqzt/category/813892.html)



##### more
less的功能和more相似, 但是使用more无法向前翻页, 只能向后翻, 而less可以任意切换. more命令, 类似cat, 该命令一次显示一屏文本, 满屏后停下来, 并且在屏幕的底部出现一个提示信息, 给出至今己显示的该文件的百分比,
**方便逐页阅读(file perusal filter for crt viewing) . more名单中内置了若干快捷键, 按空白键space就往下一页显示, 按 b 键就会往回back一页显示, 而且还有搜寻字串的功能与 vi 相似, 使用中按h可以查看说明文件** . 
```shell
命令格式: 	
more [-dlfpcsu] [-num] [+/pattern] [+linenum] [fileNames..]
参数: 
    ctrl-b向前翻一页(back
    ctrl-f向后翻一页
    space空格 向后翻一页
    enter回车 向下一行
    -num 一次显示的行数 
    -d 提示使用者, 在画面下方显示 [Press space to continue, 'q' to quit.] 如果按错键, 则会显示 [Press 'h' for instructions.] 而不是 '哔' 声 
    -l 取消遇见特殊字元 ^L送纸字元时会暂停的功能 忽略Ctrl+l换页字符 
    -f 计算行数时, 以实际上的行数, 而非自动换行过后的行数有些单行字数太长的会被扩展为两行或两行以上 
    +/ 在每个档案显示前搜寻该字串pattern, 然后从该字串之后开始显示 
    +num 从第 num 行开始显示  fileNames 欲显示内容的档案, 可为复数个数
```
例子: 
```shell
more 001.txt kkk.txt # 首先显示 001.txt的内容,  完后显示kkk.txt的内容, 
more -10 001.txt     # 显示20行
```
参考链接: 
1.[每天一个linux命令(12):more命令](https://www.cnblogs.com/xqzt/p/5414814.html),   2.[在Linux下查看文件内容的命令大致有以下几种](https://www.cnblogs.com/luxiaojun/p/6439663.html),   3.[linux more 上一页，下一页](https://www.cnblogs.com/cocoajin/p/3741016.html)



##### tail
查看后面几行的代码,  一般配合grep使用, 通过grep实现过滤, tail -100 xxx.log|grep java 查看xxx.log之中后100行关于Java的部分
```shell
参数: 
    -n 行数, -10表示查看10行
    -f 连续滚动输出,  后续的输出当做流,  继续输出,  也就是可以实时持续输出,  可以简写为tailf
```
说明: 
**使用的时候,  可以同时显示多个文件**
例子: 
```shell
tail -n 10 xxx.log|grep java = 	 tail -10 xxx.log|grep java
tail -f startLog.log|grep ERROR
tail -n 5 legoStart.log  commandrun.log  # 这个可以同时显示多个文件的内容,  此时用-10, 就失效了,  需要用-n 10来表示行数
```
展示情况: 
```shell
root:/opt/FC/Runtime/logs # tail -n 5 legoStart.log  commandrun.log 
==> legoStart.log <==
[2019/05/25 19:12:47.775][INFO][getStartStatus start...][LEGO_START][getStartStatus,299][main]
[2019/05/25 19:12:47.776][ERROR][flagFile is not exist][LEGO_START][getStartStatus,307][main]
[2019/05/25 19:12:47.776][INFO][startup status is null!][LEGO_START][main,90][main]
[2019/05/25 19:12:47.776][ERROR][Test failed, retry after sleep five seconds .][LEGO_START][main,97][main]
[2019/05/25 19:12:57.776][ERROR][Server Start failed!][LEGO_START][main,106][main]
==> commandrun.log <==
user: [ICUser] time: [2019/05/23 00:58:29:320439192] command:[run.sh]
user: [ICUser] time: [2019/05/23 01:06:47:279925537] command:[run.sh]
user: [ICUser] time: [2019/05/23 01:23:17:127594376] command:[run.sh]
user: [ICUser] time: [2019/05/25 18:43:55:706642386] command:[run.sh]
root:/opt/FC/Runtime/logs #
```
参考链接: 
1.[每天一个linux命令(15):tail命令](https://www.cnblogs.com/xqzt/p/5425331.html)



##### head
head用来显示档案的开头至标准输出中, 一般配合grep使用, 通过grep实现过滤, head -100 xxx.log|grep java 查看xxx.log之中开头100行关于java 的部分
参数含义: 
```shell
-n 行数, -10表示查看10行,  一个文件的时候写成 -10,  多个文件操作需要写成 -n 10
```
说明: 
**使用的时候,  可以同时显示多个文件**
例子: 
```shell
head -n 5 log.txt = head -5 log.txt
head -n 10 log.txt fc.txt
```
参考链接: 
1.[每天一个linux命令(14):head命令](https://www.cnblogs.com/xqzt/p/5425287.html)



##### od
od命令用于输出文件的八进制, 十六进制或其它格式编码的字节, 通常用于显示或查看文件中不能直接显示在终端的字符. 常见的文件为文本文件和二进制文件. 此命令主要用来查看保存在二进制文件中的值. 
```shell
d 十进制 
o 八进制系统默认值 
x 十六进制 
-c     same as -t c,  select ASCII characters or backslash escapes 按照ascii的方式显示
```
参考链接: 
1.[Linux之od命令详解](https://www.cnblogs.com/hdk1993/p/4395574.html) ,   2.[linux之od命令](https://www.cnblogs.com/kex1n/p/6101626.html),   3.[linux od命令](https://blog.csdn.net/youmatterhsp/article/details/80298470) ,   4.[使用od命令，linux下以ASCII方式查看文件](https://blog.csdn.net/yaoshenjie/article/details/77494171),   5.[Linux之od命令详解](https://www.cnblogs.com/hdk1993/p/4395574.html)


##### find
查找命令
```shell
格式: 
    find [查找目录] [查找规则] [查找完后的操作] find pathname -option [-print -exec -ok …]
参数: 
    查找规则: 
    -name:  按照文件名搜索；(?表示  通配任意的单个字符, *表示任意个字符)
    -iname: 按照文件名搜索, 不区分文件名大小；
    -user:  根据属主Owner来查找文件, 也有-uid, 是用户编号
    -group: 根据属组group来查找文件, 也有-gid, 是属组编号
    -atime: 根据文件时间戳的相关属性来查找文件, *time的单位是天,  *min的单位是分钟
    -atime, -ctime, -mtime,  a访问,  m修改内容, c修改属性
    -amin, -cmin, -mmin
    -type:  按照文件类型来查找文件, f 普通文件, d 目录文件, l 链接文件,  p 管道文件,  s socket文件  -type f
    -size:  按照大小来查找文件, +大于, -小于, 无等于 +2M, 表示大于2M
    -perm:  按照文件权限查找文件, 777,222等
查找完后的操作: 
    -print                # 默认情况下的动作
    -ls                   # 查找到后用ls 显示出来
    -ok  [commend]        # 查找后执行命令的时候询问用户是否要执行
    -exec [commend]       # 查找后执行命令的时候不询问用户, 直接执行
```
例子: 
```shell
find /root /etc /tmp -iname hello.txt  # 在这三个目录下面查找hello.txt文件, 不区分大小写
find /root /etc /tmp -iname avr?.txt   # 在这三个目录下面查找hello.txt文件, 不区分大小写
find  /tmp  -size  +2M                 # 查找在/tmp 目录下大于2M的文件
find  /tmp  -perm  +222                # 表示只要有一类用户属主, 属组, 其他的匹配写权限就行
find  /tmp  -uid  500                  # 查找uid是500 的文件
find  /tmp  -name hello.txt -ls        # 查找在/tmp目录下名字是hello.txt的文档, 并且输出详细情况
```
参考链接: 
1.[linux下find（文件查找）命令的用法总结](http://blog.chinaunix.net/uid-24648486-id-2998767.html),   2.[Linux下的find指令](https://blog.csdn.net/m0_38121874/article/details/77019127),   3.[Linux find命令：在目录中查找文件（超详解）](http://c.biancheng.net/view/779.html),   4.[妈咪，我找到了! -- 15个实用的Linux find命令示例](https://www.oschina.net/translate/15-practical-linux-find-command-examples)



##### cut
cut根据指定的定界符, 切分文件, 并将选中的列输出到标准输出. 
```shell
格式:
    cut [选项]... [文件]...
参数: 
    -b: 仅显示行中指定直接范围的内容;
    -c: 仅显示行中指定范围的字符;
    -d: 指定字段的分隔符, 默认的字段分隔符为"TAB";
    -f: 显示指定字段的内容;
    -n: 与"-b"选项连用, 不分割多字节字符;
    --complement: 补足被选择的字节, 字符或字段;
    --out-delimiter=<字段分隔符>: 指定输出内容是的字段分割符;
```
例子:
```shell
    cat /etc/passwd | cut -b1-3　# 取每行的第1-3字字节
    cut -f2,3 test.txt           # 显示每行2-3内容
    tail -n 5 /etc/passwd |cut -d ":" -f 3,4   -f n-m  # 打印第n-m个字段,  分隔符换成了:
```
参考链接: 
1.[【一天一个shell命令】【cut】](https://www.cnblogs.com/xqzt/p/5858309.html),   2.[linux cut 命令](https://www.cnblogs.com/siqi/p/3608893.html),   3.[Linux：cut命令详解](https://www.cnblogs.com/Spiro-K/p/6361646.html)




#### 网络:
监听状态, 端口监听, 端口操作:
##### netstat
netstat命令用于显示与IP, TCP, UDP和ICMP协议相关的统计数据, 一般用于检验本机各端口的网络连接情况. netstat是在内核中访问网络及相关信息的程序, 它能提供TCP连接, TCP和UDP监听, 进程内存管理的相关报告.
```shell
参数:
    -a或–all: 显示所有连线中的Socket;
    -c或–continuous: 持续列出网络状态; 
    -l或–listening: 显示监控中的服务器的Socket;
    -n或–numeric: 直接使用ip地址, 而不通过域名服务器;
    -p或–programs: 显示正在使用Socket的程序识别码和程序名称; 
    -t或–tcp: 显示TCP传输协议的连线状况;
    -u或–udp: 显示UDP传输协议的连线状况;
    -o或者--timers: 显示计时器
```
常用命令:
```shell
    netstat -ano
    netstat -anpo
    netstat -lntup
    netstat -r :显示路由信息
```
常见网络连接状态:
```shell
    LISTEN: 侦听来自远方的TCP端口的连接请求
    SYN-SENT: 再发送连接请求后等待匹配的连接请求如果有大量这样的状态包, 检查是否中招了
    SYN-RECEIVED: 再收到和发送一个连接请求后等待对方对连接请求的确认如有大量此状态, 估计被flood攻击了
    ESTABLISHED: 代表一个打开的连接
    FIN-WAIT-1: 等待远程TCP连接中断请求, 或先前的连接中断请求的确认
    FIN-WAIT-2: 从远程TCP等待连接中断请求
    CLOSE-WAIT: 等待从本地用户发来的连接中断请求
    CLOSING: 等待远程TCP对连接中断的确认
    LAST-ACK: 等待原来的发向远程TCP的连接中断请求的确认不是什么好东西, 此项出现, 检查是否被攻击
    TIME-WAIT: 等待足够的时间以确保远程TCP接收到连接中断请求的确认
    CLOSED: 没有任何连接状态
```
例子:
```shell
zuiguangyin:~ # netstat -an
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 127.0.0.1:61806         0.0.0.0:*               LISTEN      
tcp        0      0 127.0.0.1:6432          0.0.0.0:*               LISTEN      
tcp        0    624 100.133.175.197:22      8.46.214.227:61370      ESTABLISHED 
tcp        0      0 :::111                  :::*                    LISTEN      
tcp        0      0 :::22                   :::*                    LISTEN      
tcp        0      0 ::1:631                 :::*                    LISTEN      
tcp        0      0 ::1:25                  :::*                    LISTEN      
tcp        0      0 127.0.0.1:25410         :::*                    LISTEN      
tcp        0      0 100.133.175.197:25411   :::*                    LISTEN      
udp        0      0 0.0.0.0:631             0.0.0.0:*                                   
udp        0      0 0.0.0.0:784             0.0.0.0:*                   
```

参考链接:
1.[Linux netstat命令详解](https://www.cnblogs.com/ftl1012/p/netstat.html),   2.[netstat命令](http://man.linuxde.net/netstat),   3.[Netstat 命令详解](https://blog.csdn.net/freeking101/article/details/53520974),   4.[netstat 的10个基本用法](https://blog.csdn.net/u010739551/article/details/80736032),   5.[Linux查看端口、进程情况及kill进程](https://www.cnblogs.com/liuzhengliang/p/4609632.html),   6.[linux用netstat查看服务及监听端口](https://www.cnblogs.com/chenweichu/articles/6441710.html)



##### telnet
远程登录, 通常可以判断端口是不是通了, 默认23端口, 
```shell
telnet 100.133.138.67 8239 # 测试100.133.138.67的8239端口是否是通的,比如
telnet 14.29.122.153 80  # 连接失败, 就表示是80端口不通
```

参考链接:
1.[telnet命令判断端口是否通不通](https://www.cnblogs.com/walter371/p/3973579.html),   2.[telnet 命令使用方法详解，telnet命令怎么用？](https://www.cnblogs.com/ylcms/p/7250129.html),   3.[telnet命令使用示例](https://www.cnblogs.com/linuxprobe/p/5381554.html),   4.[Linux 出现telnet: 127.0.0.1: Connection refused错误解决办法](https://blog.csdn.net/weixin_33716154/article/details/86018627),   5.[telnet 命令使用方法详解，telnet命令怎么用？](https://www.cnblogs.com/ylcms/p/7250129.html),   6.[telnet命令使用示例](https://www.cnblogs.com/linuxprobe/p/5381554.html),   7.[linux：telnet命令安装](https://blog.csdn.net/doubleqinyan/article/details/80492421),   8.[使用Telnet的主要目的是什么](https://zhidao.baidu.com/question/130016945.html),   9.[**suse下打开telnet功能**](https://blog.csdn.net/junmail/article/details/5429458),   10.[SUSE 开启ssh、telnet](https://www.cnblogs.com/duyy/p/3637782.html)



##### lsof
lsof命令用于查看你进程开打的文件, 打开文件的进程, 进程打开的端口(TCP, UDP). 找回/恢复删除的文件. 是十分方便的系统监视工具, 因为lsof命令需要访问核心内存和各种文件, 所以需要root用户执行.
参数含义:

```shell
COMMAND: 进程的名称
PID: 进程标识符
PPID: 父进程标识符(需要指定-R参数)
USER: 进程所有者
PGID: 进程所属组
FD: 文件描述符, 应用程序通过文件描述符识别该文件.
```
常用命令:
```shell
lsof 文件名 :查看谁正在使用某个文件lsof 文件名
lsof -i 22 :查看端口22现在的运行情况
lsof -p 12 :列出进程号为12的进程打开了哪些文件
lsof -a -u root -d txt :查看所属root用户进程所打开的文件类型为txt的文件
```
例子:
```shell
zuiguangyin:~ # lsof |grep sshd
sshd       7481       root  cwd       DIR                8,2     4096          2 /
sshd       7481       root  rtd       DIR                8,2     4096          2 /
sshd       7481       root  txt       REG                8,2   571568    3023009 /usr/sbin/sshd
sshd       7481       root  mem       REG                8,2   135124    2261027 /lib64/libpthread-2.11.3.so
sshd       7481       root  mem       REG                8,2    35800    2834502 /usr/lib64/libkrb5support.so.0.1
sshd       7481       root  mem       REG                8,2   351360     642021 /usr/lib64/libssl.so.0.9.8
sshd       7481       root  mem       REG                8,2   110440    2834532 /usr/lib64/libsasl2.so.2.0.22
```
参考链接:
1.[lsof命令的应用](https://blog.csdn.net/yr137157/article/details/87112312),   2.[lsof命令详解](https://blog.csdn.net/lemontree1945/article/details/80742522),   3.[linux lsof命令详解](https://www.cnblogs.com/sparkbj/p/7161669.html)



#### 权限:
rwx: r=4, w=2, x=1
```shell
group: 
    chgrp Tomcat xxx.txt  # 修改属组
owner:
    chown ICUser xxx.txt; chown ICUser abc*; 改变xxx.txt文件的所有者为 ICUser   #修改所有者
right:
    chmod 777 XXX         #修改权限
```



#### 进程:
##### ps 
program status, ps是显示瞬间进程的状态, 将某个进程显示出来, 并不动态连续; 如果想对进程进行实时监控应该用top命令. grep是查找, "|"是管道命令, 让ps与grep同时执行, grep命令是查找, 是一种强大的文本搜索工具,  它能使用正则表达式搜索文本, 并把匹配的行打印出来. grep表示全局正则表达式, 它的使用权限是所有用户.
                
以下这条命令是检查java 进程是否存在:
```shell
ps -ef |grep java
```
字段含义如下: 
```shell
UID           PID       PPID        C     STIME      TTY         TIME         CMD
zzw           14124     13991       0     00:38      pts/0       00:00:00     grep --color=auto dae
UID是执行者, PID是进程号, PPID:其上级父程序的ID, C是cpu占用资源, TTY是登入者的终端机位置, TIME是使用掉的CPU时间, CMD是下达的指令名称
```
常用参数:
```shell
    -A: 所有的进程均显示出来, 与 -e 具有同样的效用;
    -a: 显示现行终端机下的所有进程, 包括其他用户的进程;
    -u: 以用户为主的进程状态; 
    x: 通常与 a 这个参数一起使用, 可列出较完整信息. 
    输出格式规划:  
        l: 较长, 较详细的将该 PID 的的信息列出;
        j: 工作的格式(jobs format)
        -f: 做一个更为完整的输出.
```
常用命令:
```shell
ps -ef |grep java                   # 检查java进程
ps aux                              # 列出所有正在内存中的程序
ps aux |grep java
```
参考链接:
1.[ps -ef|grep详解](https://www.cnblogs.com/freinds/p/8074651.html),   2.[Linux 中ps命令详解](https://blog.csdn.net/u011641865/article/details/71435510),   3.[Linux查看端口、进程情况及kill进程](https://www.cnblogs.com/liuzhengliang/p/4609632.html)



##### top
Linux系统可以通过top命令查看系统的CPU, 内存, 运行时间, 交换分区, 执行的线程等信息. 通过top命令可以有效的发现系统的缺陷出在哪里, 是内存不够, CPU处理能力不够, IO读写过高等,
例子:
```shell
zuiguangyin:~ # top
top - 00:12:54 up 22 days,  5:22,  1 user,  load average: 0.01, 0.04, 0.31
Tasks: 149 total,   1 running, 148 sleeping,   0 stopped,   0 zombie
 Cpu(s): 24.5%us, 17.3%sy,  0.0%ni, 58.2%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
Mem:   8062708k total,  3135080k used,  4927628k free,   238292k buffers
Swap:  8394744k total,        0k used,  8394744k free,  2398544k cached
    
PID          USER      PR  NI  VIRT  RES  SHR S   %CPU %MEM    TIME+  COMMAND                                                                                       
18327        root      20   0 3544m  59m  13m S     54  0.8   0:01.13 java                                                                                           
17670        gaussdb   20   0 12944 3012 1296 S      2  0.0   0:00.05 gaussdb.sh                                                                                     
4462         root      20   0  8364 4584  320 S      0  0.1  40:00.14 haveged                                                                                        
6736         gdm       20   0  261m  36m  12m S      0  0.5  45:29.09 gdm-simple-gree                                                                                                                                                              
3        root      20   0     0    0    0 S      0  0.0   5:59.61 ksoftirqd/0                     
```

参数说明:
```shell
前5行为系统总体资源统计情况
    top - 　　　　　　   系统当前时间
    up     　　　　　    系统已开机多长时间
    user       　　　　  当前用户数
    load average        cpu平均负载, 三个数值分别为, 1分钟, 5分钟, 15分钟
    Tasks         　　  系统当前进程数, total: 总进程数, running: 正在运行的进程数, sleeping: 睡眠的进程数, stopped: 停止的进程数, zombie: 僵尸进程数
    %Cpu(s)             cpu使用率, us: 用户使用cpu百分百, sy: 系统内核使用cpu百分百, id: 剩余的cpu百分百
    Mem           　　　 内存使用信息, total: 总内存大小, free: 空闲的内存, used: 已使用的内存, buff/cache: 缓存的内存大小
    Swap         　　    虚拟内存信息
                    
    PID　　　　         进程id
    USER　　　　        进程所有者
    PR　　　　　　      优先级
    NI　　　　　　　    nice值, 负值表示高优先级, 正值表示低优先级
    VIRT 　　　　　     进程使用的虚拟内存总量
    RES 　　　　　      进程使用的物理内存大小
    SHR 　　　　　      共享内存大小
    S 　　　　　　      进程状态, D: 不可中断的睡眠状态, R: 运行, S: 睡眠, T: 跟踪/停止, Z: 僵尸进程
    %CPU 　　　　       进程使用的CPU占用百分比
    %MEM 　　　　       进程使用的物理内存百分比
    TIME+ 　　　　      进程使用的CPU时间总计
    COMMAND　　        命令名
```
参考链接:
1.[**Linux中top显示的信息详解**](https://blog.csdn.net/csdn066/article/details/77171018),   2.[Linux top命令详解](https://www.cnblogs.com/ftl1012/p/top.html),   3.[Linux top命令](https://www.cnblogs.com/yhongji/p/9355290.html)



##### kill
杀死进程,  一般而言, 杀掉进程之前, 需要查找进程, 就需要使用`ps -ef |grep java, ps -ef|grep tomcat`等命令, 找到了之后杀掉. 
```shell
语法如下:
kill: usage: kill [-s 信号声明 | -n 信号编号 | -信号声明] 进程号 | 任务声明 ... or kill -l [信号声明]
```
通过kill -l我们可以找到相应的信号, 然后用相应的数字, 比如常用的`kill -9 pid`, 9表示立即强制杀死. 比如` kill -9 1234`.
参考链接:
1.[Linux kill、kill-15、kill-9区别](https://www.cnblogs.com/xiaojinniu425/p/9429716.html),   2.[Linux kill -9 和 kill -15 的区别](https://www.cnblogs.com/liuhouhou/p/5400540.html)