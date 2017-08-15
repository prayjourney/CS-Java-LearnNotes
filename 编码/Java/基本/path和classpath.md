### Path和ClassPath
- - -
*在编程之中，常常遇见**path**(环境变量)的问题，在Java之中，除此之外还有**==classpath==**的问题，这些都是编程之中的小细节，却对我们准确理解相关的特性有很大的影响，现就将其总结。*
123 123
- - -
1.path的理解
&nbsp;&nbsp;&nbsp;&nbsp;安装了Java之后，当我们直接在Windows命令行之中调用`java -version`，返回的结果通常如下图：
![不是命令](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_path1.png)
但是，我们并不希望出现这样的结果，而是希望出现如下的结果：
![java -version](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_path2.png)
&nbsp;&nbsp;&nbsp;&nbsp;为什么会出现这种情况呢？由图一之中的错误提示可以了解到`'java' 不是内部或者外部命令，也不是可以运行的程序或批处理文件`，由于在Windows之下安装软件都要选择一条路径，比如`C:\Installation\Java\jdk1.8.0_92\bin`,但是当我们进入此目录，却又可以运行`java -version`的命令，这就说明，其实我们执行的"java"、"java -version"在本质上都是执行了一个程序，而这个程序就是文件夹下的"==java.exe=="，这表明，我们如果采用绝对路径定位到相关命令的路径下，那么就是可以执行这个命令的，但是如果每次都是用绝对路径，又显得很麻烦，所以我们要找个解决的方法。
![java -version](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_path3.png)
![命令](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_path5.png)
**解决的方法就是Path环境变量**。
&nbsp;&nbsp;&nbsp;&nbsp;path是路径的意思，path环境变量中存放的值，就是一连串的路径。不同的路径之间，用英文的分号（==**;**==）分隔开。系统执行用户命令时，若用户未给出绝对路径，则在**当前目录**下寻找相应的可执行文件、批处理文件（另外一种可以执行的文件）等。若找不到，再依次在path保存的这些路径中寻找相应的可执行的程序文件。系统就以第一次找到的为准；若搜寻完path保存的所有路径都未找到，则会显示类似于图一的错误信息。
&nbsp;&nbsp;&nbsp;&nbsp;明白了这些，我们就把bin目录的完整路径添加到path中。在命令行窗口下，可使用set命令完成此类的任务。直接运行set，会显示系统当前所有环境变量的值，运行==set /?==，会显示关于此命令的帮助信息。使用set命令设置环境变量值的格式为：set 环境变量名=环境变量值。我们可以使用命令`set path=C:\Installation\Java\jdk1.8.0_92\bin`将java等程序文件所在的目录添加到path环境变量中（Windows下环境变量名不区分大小写，这与UNIX不同）。但是这样会使path的值只有"C:\Installation\Java\jdk1.8.0_92\bin"，它预先设定供其他程序使用的值就都被覆盖了。因此，我们应该把值"C:\Installation\Java\jdk1.8.0_92\bin"追加到path中。为此，我们可以使用如下命令：
`set path=%path%;C:\Installation\Java\jdk1.8.0_92\bin`
&nbsp;&nbsp;&nbsp;&nbsp;把path放在两个百分号之间，指把path原有的值取出。其后的分号表示分隔不同的路径值，之后才是我们要添加的值。注意，请在英文输入法状态下使用此命令。但是这种使用set命令的方式设置的环境变量只对当前命令行窗口有效。一旦关闭此窗口，再次运行另一个命令行窗口时，path环境变量还是原来的值。因此，我们必须在Windows下修改path环境变量。我们可以通过`echo %path%`，`echo %classpath%`
![echo命令](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_path7.png)

2.内部命令、外部命令和批处理命令
&nbsp;&nbsp;&nbsp;&nbsp;我们现在启动一个命令行窗口，按上述的方法把path的值全部清除，然后再运行dir、cd等命令。出乎我们意料的是，它们仍然能够正确执行。这，又是什么原因呢？
&nbsp;&nbsp;&nbsp;&nbsp;我们来看看刚才那些报告错误的信息，它们都提到了“内部命令”和“外部命令”的概念。那么什么是内部命令和外部命令呢？
&nbsp;&nbsp;&nbsp;&nbsp;内部命令和外部命令是DOS（disk operating system，微软早期基于命令行的操作系统）时代的概念，百度百科的解释是：内部命令是随每次启动的COMMAND_COM装入并常驻内存，而外部命令是一条单独的可执行文件。粗略地讲，所谓内部命令就是最核心、使用最多的命令。为了提高响应速度，系统一启动，这些命令就被加载到内存，因此可以迅速、直接地执行；而外部命令由于使用相对较少，就不预先加载到内存，当用户使用时，再到硬盘上（c:\windows\system32）找相应的可执行文件，然后加载到内存执行。像dir、cd等都是内部命令，而诸如attrib、format等都是外部命令。尽管DOS的时代早已成为了历史，但某些操作却必须在命令行模式下完成，对专业人士来说更是如此。因此，Windows产品一直保留着命令行模式这个工具。
&nbsp;&nbsp;&nbsp;&nbsp;另外一个概念就是批处理文件（后缀名为.bat，来源于批量的英语单词batch），它是另外一种可以执行的文件。简单地说，批处理文件包含了很多DOS命令。文件执行时，就一条一条地执行这些命令。不一定顺序执行，像通用的程序设计语言一样，它也有自己的流程控制。批处理文件创建很简单：用任何一个文本编辑器（如Windows的记事本）创建一个文本文件，然后把后缀名改为.bat即可。创建好的批处理文件，你也可以用文本编辑器打开，查看它的"源代码"。

ref:
>[Windows下PATH等环境变量详解](http://www.cnblogs.com/sunada2005/articles/2725277.html),
[关于JAVA项目中CLASSPATH路径详解](http://blog.csdn.net/cheney521/article/details/8672066)