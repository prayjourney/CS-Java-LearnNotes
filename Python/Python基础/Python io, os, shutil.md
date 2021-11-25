### Python IO

***
#### 基本

##### 从键盘输入
**input([prompt])** 函数可以接收一个Python表达式作为输入，并将运算结果返回，可以将数据**从键盘输入**

```python
# -*- coding: UTF-8 -*-
str = input("请输入：");
print ("你输入的内容是: "+str)
```
这会产生如下的对应着输入的结果，我们可以对输入的结果进行操作
```python
请输入：[x*5 for x in range(2,10,2)]
你输入的内容是:  [10, 20, 30, 40]
```

#### built-in open函数

##### 文件的打开与读写
在Python中，文件读写是通过**open()**函数打开的文件对象完成的。读写是使用io包的**read()**和**write()**一类函数来完成的，使用with语句操作文件IO是个好习惯，可以避免忘记关闭文件流的情况

```python
#读
try:
    path='d:\\poem.txt'
    ff=open(path,'r')#打开文件
    for x in ff:#这样也是一种读文件的方式
        print(x)
    ff.close()#需要手动关闭
finally:
    ff.close()

with open('d:\\poem.txt', 'r') as f1:
    fr4=f1.readlines()#按照行读出来，保存到列表里面，如果设了值，则表示读多少行，如果没有值，则读取所有行
    for line in fr4:
        print(line)

#写：
with open('d:\\hello.txt','a') as ww:
    ww.write('werwerwerew')
    ww.writelines("你好，加油吧，少年！")#虽然是str,但仍然包装成list,进行加入
    prt=['123','mtk','何须风月凑哀愁']
    ww.writelines(prt)#使用list列表方式写入，但不会自动加入分隔符号，如果要换行，需要自己加入'\n'
    nnn=['黄鹤楼送孟浩然\n','烟花三月下扬州。\n','孤帆远影碧空尽，\n','唯见长江天际流。']
    ww.writelines(nnn)

```



##### 读写模式

| **模式** | **描述**                                   |
| ------ | ---------------------------------------- |
| r      | 以读方式打开文件，可读取文件信息。                        |
| w      | 以写方式打开文件，可向文件写入信息。如文件存在，则清空该文件，再写入新内容    |
| a      | 以追加模式打开文件（即一打开文件，文件指针自动移到文件末尾），如果文件不存在则创建 |
| r+     | 以读写方式打开文件，可对文件进行读和写操作。                   |
| w+     | 消除文件内容，然后以读写方式打开文件。                      |
| a+     | 以读写方式打开文件，并把文件指针移到文件尾。                   |
| b      | 以二进制模式打开文件，而不是以文本模式。该模式只对Windows或Dos有效，类Unix的文件是用二进制模式进行操作的。 |



#### IO模块
##### 读写方法说明
如果文件很小，read()一次性读取最方便；如果不能确定文件大小，反复调用read(size)比较保险；如果是配置文件，调用readlines()最方便，具体的情况需要根据文件的大小来决定，每个函数的使用情形如下

| 方法              | 说明                                       |
| --------------- | ---------------------------------------- |
| read(size)      | 读取size的字节数。size为空时，读取文件所有字节              |
| readline(size)  | 若当前行的值大于size，则读当size值。若小于，则返回当前行。为空则返回整行 |
| readlines(size) | 把读取到的值放在列表里存储并返回列表值。size并不是单纯的字节数，匹配到的是只要是大于某一行起始值的都会读出整行 |
| write()         | 直接在后续写入                                  |
| writelines()    | 完成一次写入后，换行，但是换行符号需要自己输入                  |



##### 文件的方法
文件的相关方法，都在Python的io模块之中，主要负责文件读写以及文件的状态

| 函数             | 说明                                       |
| -------------- | ---------------------------------------- |
| f.flush()      | 把缓冲区中的数据刷到硬盘，当你往文件里写数据时，python会先把你写的内容写到缓冲区，等缓冲区满了再统一自动写入硬盘，因此减少了对硬盘的操作次数，毕竟硬盘的速度比内存慢得多 |
| f.tell()       | 显示程序光标所在该文件中的当前的位置，位置是以字节来算的             |
| f.seek()       | 跳到指定位置，f.seek(0) 是返回文件开始，位置是以字节来算的       |
| f.truncate()   | f.truncate(10) 从文件开头截取10个字符，超出的都删除       |
| f.xreadlines() | 以迭代的形式循环文件，在处理大文件时效率极高，只记录文件开头和结尾，每循环一次，只读一行，因此不需要将整个文件都一次性加载到内存，而如果用readlines()，则需要将整个文件都加载到内存，处理大文件不合适 |
| f.next()       | 获取下一行数据，不存在，则报错                          |



##### 文件的属性

| 属性             | 说明                                      |
| -------------- | --------------------------------------- |
| file.closed    | 返回True如果文件已经关闭，否则返回False                |
| file.mode      | 返回被打开文件的访问模式                            |
| file.name      | 返回文件的名称                                 |
| file.softspace | 如果用print输出后，必须跟一个空格符，则返回False ，否则返回True |



#### os模块&shutil模块
os包主要作用是对于工作目录，路径，目录等的管理，配合shutil包可以完成绝大多数对于目录和文件的操作，shutil是一个复制或者打包文件或者文件夹的工具集，主要是复制和打包的功能，os模块提供更多的路径操作，sys模块提供的则是与python解释器

##### 操作系统的中文件

| 方法                                       | 说明                               |
| ---------------------------------------- | -------------------------------- |
| os.rename( current_file_name, new_file_name) | 文件重命名                            |
| os.remove( file_name )                   | 删除文件                             |
| os.mkdir( "test")                        | 创建一个目录test                       |
| os.chdir( "newdir" )                     | 切换目录到newdir                      |
| os.getcwd()                              | 获取当前目录的路径                        |
| os.rmdir( "dirname" )                    | 删除目录，在删除目录前，它的所有内容应该先被清除         |
| shutil.copyfile("hello.py","hello_123.py") | oldfile和newfile都只能是文件            |
| shutil.copytree("d:\\file1","d:\\g22")   | olddir和newdir都只能是目录，且newdir必须不存在 |
| shutil.move("d:\\g22","d:\\ee1")         | 将源文件（夹)之中的的文件（夹)移动到目的目录之中        |



#### 综合应用

```python
#基本的python io操作

#python io包
#文件操作
#读取
path='d:\\poem.txt'
ff=open(path,'r')#打开文件
for x in ff:#这样也是一种读文件的方式
    print(x)
ff.close()#需要手动关闭
print('-----')

with open(path,'r') as p:#使用with,无需自己关闭文件了
    for x in p:
        print(x)

#read(size): 读取size的字节数。size为空时，读取文件所有字节。 
#readline(size):若当前行的值大于size，则读当size值。若小于，则返回当前行。为空则返回整行。 
#readlines(size):把读取到的值放在列表里存储并返回列表值。size并不是单纯的字节数，匹配到的是只要是大于某一行起始值的都会读出整行。 
#迭代器：文件本身可以看做一个迭代器，循环操作。像for x in p: print(x)这样循环遍历就可以全部读出了。
with open(path, 'r') as f1:
    fr1=f1.read()#一次性完全读取到内存之中
    print(fr1)

with open('d:\\poem.txt', 'r') as f1:
    fr4=f1.readlines()#按照行读出来，保存到列表里面，如果设了值，则表示读多少行，如果没有值，则读取所有行
    for line in fr4:
        print(line)
    print('===')

with open('d:\\poem.txt', 'r') as f1:
    frt=f1.readline(116)#按列读，保存到列表里面，如果设了值，则表示读取本行的多大的数值，
    print(frt)          #如果数值大于本行的大小，也只是返回本行，如果没值，则也返回本行

#写入
#write()，直接在后续写入
#writelines()，完成一次写入后，换行
with open('d:\\hello.txt','w') as ww:
    ww.write('123')

with open('d:\\hello.txt','a') as ww:
    ww.write('werwerwerew')
    ww.writelines("你好，加油吧，少年！")#虽然是str,但仍然包装成list,进行加入
    prt=['123','mtk','何须风月凑哀愁']
    ww.writelines(prt)#使用list列表方式写入，但不会自动加入分隔符号，如果要换行，需要自己加入'\n'
    nnn=['黄鹤楼送孟浩然\n','烟花三月下扬州。\n','孤帆远影碧空尽，\n','唯见长江天际流。']
    ww.writelines(nnn)

#键盘输入
ss=input("请输入点什么：\n")
print("ss="+ss)

#StringIO和BytesIO
#其中的方法和t默认模式差不多
from io import StringIO#StringIO处理的是str
f11 = StringIO('Hello!\nHi!\nGoodbye!')
while True:
    s = f11.readline()
    if s == '':
        break
    print(s.strip())

from io import BytesIO#BytesIO处理的是byte
f22 = BytesIO()
f22.write('中文'.encode('utf-8'))
print(f22.getvalue())



#操作文件和目录
#python os包
#os包主要作用是对于工作目录，路径，目录等的管理，配合shutil包可以完成绝大多数对于目录和文件的操作
import os
print(os.getcwd())#得到当前工作目录，即当前Python脚本工作的目录路径
os.listdir()#返回指定目录下的所有文件和目录名
os.path.isfile(path)#检验给出的路径是否是一个文件
os.path.isdir(path)#检验给出的路径是否是一个目录
os.path.isabs(path)#判断是否是绝对路径：
os.path.exists(path)#检验给出的路径是否真地存
os.path.split(path)#返回一个路径的目录名和文件名
os.path.splitext(path)#分离扩展名
os.path.dirname(path)#获取路径名
os.path.basename(path)#获取文件名
os.stat(path)#获取文件属性
os.linesep#给出当前平台使用的行终止符:    Windows使用'\r\n'，Linux使用'\n'而Mac使用'\r'

#创建目录
if not os.path.exists("file1"):
    os.mkdir("file1")
if not os.path.exists("d:\\file1"):
    os.mkdir("d:\\file1")
    os.mkdir("d:\\file1\\123")

#重命名文件/目录
os.rename("d:\\hello.txt","d:\\hello123.txt")
#删除文件
os.remove("d:\\hello2.txt")

#转换目录
os.mkdir("d:\\1w1") #创建一个目录
os.chdir("d:\\1w1") #将当前目录设为 "C:\123", 相当于DOC命令的 CD C:\123
os.getcwd()
os.chdir('D:\\MarkdowNotes\\Jupyter\\jupyter-test\\PythonModuleNotes')



#使用shutil,一个复制或者打包文件或者文件夹的工具集，主要是复制和打包的功能，os提供更多的路径操作
#删除目录
import shutil
os.rmdir("file1")    #只能删除空目录
shutil.rmtree("d:\\file1\\123")    #空目录、有内容的目录都可以删

#复制文件
shutil.copyfile("hello.py","hello_123.py")    #oldfile和newfile都只能是文件
#shutil.copy("d:\\eee\\123","d:\\eee123")        #oldfile只能是文件夹，newfile可以是文件，也可以是目标目录

#复制文件夹
shutil.copytree("d:\\file1","d:\\g22")      #olddir和newdir都只能是目录，且newdir必须不存在

#移动文件/目录
shutil.move("d:\\g22","d:\\ee1")    #将源文件（夹)之中的的文件（夹)移动到目的目录之中
```

ref:

1.[Python3之文本操作](http://www.cnblogs.com/wang-yc/p/6485429.html),  2.[Python3 IO](http://www.cnblogs.com/284628487a/p/5590692.html),  3.[python学习-IO编程](http://www.jianshu.com/p/217e66fd539f?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation),  4.[python之IO操作](http://www.cnblogs.com/whuyt/p/4492380.html),  5.[Python3对文件的操作](http://blog.csdn.net/qq_34787226/article/details/52564162),  6.[Python3文件操作](http://www.yiibai.com/python3/python_files_io.html),  7.[python学习笔记 IO 文件读写](http://www.cnblogs.com/Commence/p/5587995.html),  8.[Python 文件I/O](http://www.runoob.com/python/python-files-io.html)

url:
http://www.cnblogs.com/wang-yc/p/6485429.html
http://blog.csdn.net/qq_34787226/article/details/52564162
http://www.yiibai.com/python3/python_files_io.html
https://www.cnblogs.com/l729414559/p/6831014.html
https://www.cnblogs.com/AaronFan/p/6057257.html
http://www.runoob.com/python/python-files-io.html
http://blog.csdn.net/u010039733/article/details/47858189
http://blog.csdn.net/werm520/article/details/6898473
http://www.jianshu.com/p/217e66fd539f?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
https://www.cnblogs.com/whuyt/p/4492380.html
https://www.cnblogs.com/Commence/p/5587995.html
https://www.cnblogs.com/284628487a/p/5590692.html
http://www.runoob.com/python/python-files-io.html