### 图解常用Linux命令

***

#### 1.ls – List

ls会列举出当前工作目录的内容（文件或文件夹），就跟你在GUI中打开一个文件夹去看里面的内容一样。
[![image](../images/lc1.png)](https://cloud.githubusercontent.com/assets/7871813/17410252/6af07b14-5aa5-11e6-8aa3-49846aae81be.png)

#### 2.mkdir – Make Directory

mkdir 用于新建一个新目录
[![image](../images/lc2.png)](https://cloud.githubusercontent.com/assets/7871813/17410274/7e44fcbc-5aa5-11e6-8224-59a714cd1769.png)

#### 3.pwd – Print Working Directory

pwd显示当前工作目录
[![image](../images/lc3.png)](https://cloud.githubusercontent.com/assets/7871813/17410280/889ef1ea-5aa5-11e6-85a0-45579db3a811.png)

#### 4.cd – Change Directory

对于当前在终端运行的会中中，cd 将给定的文件夹（或目录）设置成当前工作目录。
[![image](../images/lc4.png)](https://cloud.githubusercontent.com/assets/7871813/17410292/93cce658-5aa5-11e6-9249-ceb0b7eab09d.png)

#### 5.rmdir – Remove Directory

rmdir 删除给定的目录。
[![image](../images/lc5.png)](https://cloud.githubusercontent.com/assets/7871813/17410303/a0bc94a8-5aa5-11e6-8094-1a17cbd25805.png)

#### 6.rm – Remove

rm 会删除给定的文件或文件夹，可以使用rm -r 递归删除文件夹
[![image](../images/lc6.png)](https://cloud.githubusercontent.com/assets/7871813/17410306/a899b9da-5aa5-11e6-8034-70fad7a79056.png)

#### 7.cp – Copy

cp 命令对文件或文件夹进行复制，可以使用cp -r 选项来递归复制文件夹。
[![image](../images/lc7.jpg)](https://camo.githubusercontent.com/3d76f192d8fc9f3d68f2ef8b691473d2de0ac1b2/687474703a2f2f6d6564696130322e686f6e676b6961742e636f6d2f62617369632d6c696e75782d636f6d6d616e64732f372d63702e6a7067)

#### 8.mv – MoVe

mv 命令对文件或文件夹进行移动，如果文件或文件夹存在于当前工作目录，还可以对文件或文件夹进行重命名。
[![image](../images/lc8.jpg)](https://camo.githubusercontent.com/85452bda1e5d25c8df8dd979c2fd33334cb6112e/687474703a2f2f6d6564696130322e686f6e676b6961742e636f6d2f62617369632d6c696e75782d636f6d6d616e64732f382d6d762e6a7067)

#### 9.cat – concatenate and print files

cat 用于在标准输出（监控器或屏幕）上查看文件内容
[![image](../images/lc9.jpg)](https://camo.githubusercontent.com/10d592b8a341570f5b39d222e7fcbd620b305c3e/687474703a2f2f6d6564696130322e686f6e676b6961742e636f6d2f62617369632d6c696e75782d636f6d6d616e64732f392d6361742e6a7067)

#### 10.tail – print TAIL (from last) 

tail 默认在标准输出上显示给定文件的最后10行内容，可以使用tail -n N 指定在标准输出上显示文件的最后N行内容。
[![image](../images/lc10.jpg)](https://camo.githubusercontent.com/3d7ae9e0e8ce65a09dbd4c963e618e7014e2bcb5/687474703a2f2f6d6564696130322e686f6e676b6961742e636f6d2f62617369632d6c696e75782d636f6d6d616e64732f31302d7461696c2e6a7067)

#### 11.less – print LESS

less 按页或按窗口打印文件内容。在查看包含大量文本数据的大文件时是非常有用和高效的。你可以使用Ctrl+F向前翻页，Ctrl+B向后翻页。
[![image](../images/lc11.png)](https://cloud.githubusercontent.com/assets/7871813/17410407/22d4e5c6-5aa6-11e6-999e-ddcbf2725445.png)

#### 12.grep

grep "" 在给定的文件中搜寻指定的字符串。grep -i "" 在搜寻时会忽略字符串的大小写，而grep -r "" 则会在当前工作目录的文件中递归搜寻指定的字符串。
[![image](../images/lc12.png)](https://cloud.githubusercontent.com/assets/7871813/17410414/2a457e9c-5aa6-11e6-890b-38d65b627ce7.png)

#### 13.Find

这个命令会在给定位置搜寻与条件匹配的文件。你可以使用find -name 的-name选项来进行区分大小写的搜寻，find -iname 来进行不区分大小写的搜寻。

```
find <folder-to-search> -iname <file-name>
```

[![image](../images/lc13.png)](https://cloud.githubusercontent.com/assets/7871813/17410432/3a98454a-5aa6-11e6-8497-bd4cfd54e7b5.png)

#### 14.tar

tar命令能创建、查看和提取tar压缩文件。tar -cvf <archive-name.tar> 是创建对应压缩文件，tar -tvf <archive-to-view.tar> 来查看对应压缩文件，tar -xvf <archive-to-extract.tar>来提取对应压缩文件。
[![image](../images/lc14.png)](https://cloud.githubusercontent.com/assets/7871813/17410441/46ff3442-5aa6-11e6-900b-07c423ba3da7.png)

#### 15.gzip

gzip 命令创建和提取gzip压缩文件，还可以用gzip -d 来提取压缩文件。
[![image](../images/lc15.png)](https://cloud.githubusercontent.com/assets/7871813/17410445/4e5f38b8-5aa6-11e6-941e-0f335fa743dc.png)

#### 16.unzip

unzip <archive-to-extract.zip>对gzip文档进行解压。在解压之前，可以使用unzip -l <archive-to-extract.zip>命令查看文件内容。
[![image](../images/lc16.png)](https://cloud.githubusercontent.com/assets/7871813/17410457/55caa394-5aa6-11e6-94c1-74349ebfb8a7.png)

#### 17.help

--help会在终端列出所有可用的命令,可以使用任何命令的-h或-help选项来查看该命令的具体用法。
[![image](../images/lc17.png)](https://cloud.githubusercontent.com/assets/7871813/17410464/5e45d25a-5aa6-11e6-9aa8-0c48c0913c31.png)

#### 18.whatis – What is this command

whatis 会用单行来描述给定的命令。
[![iamge](../images/lc18.jpg)](https://camo.githubusercontent.com/c45cb58fd75b28f976b41a3aaafac5c3f9e8b5c5/687474703a2f2f6d6564696130322e686f6e676b6961742e636f6d2f62617369632d6c696e75782d636f6d6d616e64732f31382d7768617469732e6a7067)

#### 19.man – Manual

man 会为给定的命令显示一个手册页面。
[![image](../images/lc19.png)](https://cloud.githubusercontent.com/assets/7871813/17410484/73788762-5aa6-11e6-84c4-30c23d96aa32.png)

#### 20.exit

exit用于结束当前的终端会话。
[![image](../images/lc20.png)](https://cloud.githubusercontent.com/assets/7871813/17410486/7b1ed4a8-5aa6-11e6-8e76-41fae5b0cc4a.png)

#### 21.ping

ping 通过发送数据包ping远程主机(服务器)，常用与检测网络连接和服务器状态。
[![image](../images/lc21.png)](https://cloud.githubusercontent.com/assets/7871813/17410494/81b78e0e-5aa6-11e6-8ff7-e63ad9ca3ff6.png)

#### 22.who – Who Is logged in

who能列出当前登录的用户名。
[![image](../images/lc22.png)](https://cloud.githubusercontent.com/assets/7871813/17410500/88b30648-5aa6-11e6-8166-2937f11ea57b.png)

#### 23.su – Switch User

su 用于切换不同的用户。即使没有使用密码，超级用户也能切换到其它用户。
[![image](../images/lc23.png)](https://cloud.githubusercontent.com/assets/7871813/17410506/923d8a8a-5aa6-11e6-9034-e3cbf5adf480.png)

#### 24.uname

uname会显示出关于系统的重要信息，如内核名称、主机名、内核版本、处理机类型等等，使用uname -a可以查看所有信息。
[![image](../images/lc24.png)](https://cloud.githubusercontent.com/assets/7871813/17410513/986a60cc-5aa6-11e6-84d6-dd4fec5e95a5.png)

#### 25.free – Free memory

free会显示出系统的空闲内存、已经占用内存、可利用的交换内存等信息，free -m将结果中的单位转换成KB，而free –g则转换成GB。
[![image](../images/lc25.png)](https://cloud.githubusercontent.com/assets/7871813/17410521/9f998a62-5aa6-11e6-80ce-03ab0bb29c26.png)

#### 26.df – Disk space Free

df查看文件系统中磁盘的使用情况–硬盘已用和可用的存储空间以及其它存储设备。你可以使用df -h将结果以人类可读的方式显示。
[![image](../images/lc26.png)](https://cloud.githubusercontent.com/assets/7871813/17410528/a595c412-5aa6-11e6-8c43-081b9cbd6195.png)

#### 27.ps – ProcesseS

ps显示系统的运行进程。
[![image](../images/lc27.png)](https://cloud.githubusercontent.com/assets/7871813/17410537/ac573fec-5aa6-11e6-9717-1cf8b53c07f1.png)

#### 28.Top – TOP processes

top命令会默认按照CPU的占用情况，显示占用量较大的进程,可以使用top -u 查看某个用户的CPU使用排名情况。
[![image](../images/lc28.png)](https://cloud.githubusercontent.com/assets/7871813/17410543/b5e0aa08-5aa6-11e6-8103-3b594c66a982.png)

#### 29.shutdown

shutdown用于关闭计算机，而shutdown -r用于重启计算机。




ref : 

1.50个最常用的Unix/Linux命令,   2.linux下各文件夹的作用,   3.初窥Linux 之 我最常用的20条命令,   4.29个你必须知道的Linux命令,   5.Linux 新手应该知道的 26 个命令,   6.linux中常用操作命令,   7.linLINUX中常用操作命令,   8.linux常用基本命令

