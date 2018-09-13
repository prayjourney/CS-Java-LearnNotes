###Python pdb模块

***

#####pdb
**pdb** 是 python 自带的一个包，为 python 程序提供了一种交互的源代码调试功能，主要特性包括设置断点、单步调试、进入函数调试、查看当前代码、查看栈片段、动态改变变量的值等。



#####pdb常用的模式
一般有两种pdb的调试模式，一种是硬编码的，直接在脚本里面设置断点，使用`pdb.set_trace()`，这种模式之下，可以在命令行之中，对于一个脚本直接进行运行调试

![pdb_debug](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_pdb_debuger.jpg)

第二种是写好一个脚本后，使用run命令，来调用某一个方法，然后进行调试，使用`pdb.run('hello2.add()')`

![pdb_debuger2](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_pdb_debuger2.jpg)



#####pdb 常用命令

| **命令**             | **解释**        |
| ------------------ | ------------- |
| **break 或 b 设置断点** | 设置断点          |
| **continue 或 c**   | 继续执行程序        |
| **list 或 l**       | 查看当前行的代码段     |
| **step 或 s**       | 进入函数          |
| **return 或 r**     | 执行代码直到从当前函数返回 |
| **exit 或 q**       | 中止并退出         |
| **next 或 n**       | 执行下一行         |
| **pp**             | 打印变量的值        |
| **help**           | 帮助            |



##### pdb 常用函数

| 函数签名                                     | 作用                                       |
| ---------------------------------------- | ---------------------------------------- |
| pdb.run(statement, globals=None, locals=None) | 运行语句,statement接收的是一个str类型的方法，如“模块名.方法"此种类型，返回结果 |
| pdb.set_trace()                          | 设置断点，通常在硬编码之中使用，运行到此处时，开始调用栈帧            |
| pdb.pm()                                 | 调试结束后，进入调试信息的回溯                          |
| pdb.runeval(expression, globals=None, locals=None) | 评估表达式，表达式是一个str对象或者code对象，返回运行的结果，和run函数类似 |
| pdb.runcall(function, *args, /*/*kwds)   | 调用函数(函数或者方法对象，而非str)，并且给予参数，返回函数调用的结果    |
| pdb.post_mortem(traceback=None)          | 给出调试完成后的回溯对象，如果没有回溯，将返回一个正在处理的           |



ref:

1.[python 调试 pdb](http://blog.csdn.net/kevin_darkelf/article/details/50585970), 2.[零基础学习PDB命令行调试Python代码](http://python.jobbole.com/81184/), 3.[用PDB库调试Python程序](http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html), 4.[Python 代码调试技巧](https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/)