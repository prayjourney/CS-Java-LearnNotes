### Python基本语法
- - -
接上[Python基本语法(1)](https://github.com/prayjourney/SummaryOfProgramming/blob/master/Python%E5%9F%BA%E6%9C%AC%E8%AF%AD%E6%B3%95(1).md)
- - -
8.IO操作
&nbsp;&nbsp;&nbsp;&nbsp;Python之中IO操作相比与Java之中的IO操作，确实是非常简单和方便的，所有的操作只用一个简单的关键字==open==，就可以完成。在Python的操作手册之中我们可以看到如下的定义，
`open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None)`
其中的操作手册对于其中的参数的解释如下：
>Open file and return a corresponding file object. If the file cannot be opened, an OSError is raised.

>file is either a string or bytes object giving the pathname (absolute or relative to the current working directory) of the file to be opened or an integer file descriptor of the file to be wrapped. (If a file descriptor is given, it is closed when the returned I/O object is closed, unless closefd is set to False.)

>mode is an optional string that specifies the mode in which the file is opened. It defaults to 'r' which means open for reading in text mode. Other common values are 'w' for writing (truncating the file if it already exists), 'x' for exclusive creation and 'a' for appending (which on some Unix systems, means that all writes append to the end of the file regardless of the current seek position). In text mode, if encoding is not specified the encoding used is platform dependent: locale.getpreferredencoding(False) is called to get the current locale encoding. (For reading and writing raw bytes use binary mode and leave encoding unspecified.) The available modes are:

>'r' open for reading (default)
'w' open for writing, truncating the file first
'x' open for exclusive creation, failing if the file already exists
'a' open for writing, appending to the end of the file if it exists
'b' binary mode
't' text mode (default)
'+' open a disk file for updating (reading and writing)
'U' universal newlines mode (deprecated)

>The default mode is 'r' (open for reading text, synonym of 'rt'). For binary read-write access, the mode 'w+b' opens and truncates the file to 0 bytes. 'r+b' opens the file without truncation.

以上主要表达了如下的含义：**open函数返回的是一个对应的File对象，如果此对象无法打开，就会分抛出OSError的异常，File的路径可以是string类型或者bytes类型表示的路径，模式是打开文件所指定的类型，其中r是默认的类型，是只读的模式**。'r'的同义词是'rt'，对于二进制文件的读写，需要使用模式'w+b'，但是其有截断，'r+b'打开文件没有截断，其余的模式含义见下面的表格。

| 字符 | 含义 |  默认与否  |
|-----|--------|---------|
| 'r' |  打开阅读 |   是   |
| 'w' | 打开写，并截断文件 | - - |
| 'x' | 打开独占文件，如果存在则失败 | - - |
| 'a' | 打开写，如果文件存在在在其末尾添加'文本' | - - |
| 'b' | 二进制模式 | - - |
| 't' | 文本模式   |  是  |
| '+' | 打开文件，读写更新 | - - |
| 'U' | 已经废弃   | - - |
常用的处理方式是`with open('pi_digits.txt') as file_object:`，关键字with 在不再需要访问文件后将其关闭，这样我们不用去太过于关注文件是否关闭的问题。

&nbsp;&nbsp;&nbsp;&nbsp;操作的实例
```python
	# -*- coding:utf-8 -*-
    with open("abc.txt"") as fobj:
        lines=fobj.readlines()

    for line in lines:
        if 'jj' in line:
            print("===========")
        else:
            print(line.rstrip())

    with open("abc.txt",'w') as wobj:
        wobj.write("I am write test!")
        #'w'会清空之前的文字，'a'是追加模式，不清空之前的，
        #'r'是默认的读，读写两个则是'r+'
        #写入文件时，如果不存在，则会自动创建
```

9.单元测试
&nbsp;&nbsp;&nbsp;&nbsp;和Java之中的单元测试一样，都是为了验证程序最小模块的功能是否满足，在Python之中单元测试的模块*unittest*提供了类似于*junit*的功能，与其不同的是，Python之中的用于测试的类，都需要继承++unittest.TestCase++，而测试的运行，都是通过**unittest.main()**方法来实现，所有要测试的方法，在测试的时候必须要以"test\_xxx"的方式出现，也就是说，在测试类之中，所有的方法都需要以*test*开头，另外，还是这个很重要的概念，**测试是验证程序提供的功能是否正确，而不不能发现程序的逻辑错误**，在Python之中，测试的运行方式，也是**断言**。
&nbsp;&nbsp;&nbsp;&nbsp;Python之中，函数和类同等重要，所以单元测试分为对于函数的测试和对于类的测试，但其实并没有什么区别，都要创建*测试类*。下面列举Python单元测之中的++断言方法++以及常用的方法。

| 方法 | 用途 |
|-----------------------|-------------------------|
|  assertEqual(a, b)    | 核实a == b               |
|  assertNotEqual(a, b) | 核实a != b               |
|  assertTrue(x)        | 核实x 为True             |
|  assertFalse(x)       |核实x 为False             |
|  assertIn(item,list ) |核实 item 在 list 中      |
|  assertNotIn(item,list )| 核实 item 不在 list 中  |
|  **setUp()** | **创建一些对象和一些资源，供测试方法使用** |

&nbsp;&nbsp;&nbsp;&nbsp;下面是一些单元测试的例子
- 测试方法
==getname.py==
  ```python
     def getname(first,last):
         first_name=first
         last_name=last
         fullname=first+" "+last
         return fullname
  ```
==TestGetname.py ==
    ```python
       import unittest
       import sys

       sys.path.append(".")#将当前路径加入path
       import getname as gt123#导入getname模块

       class TestGetname(unittest.TestCase):#测试类，继承了unittest.TestCase
           '''测试getname方法'''
           def test_getname(self):#方法以test开头
               testname=gt123.getname("123","abc")#调用gt123模块的getname方法
               self.assertEqual(testname, "123 abc") #断言方法

       unittest.main()#运行测试
    ```
- 测试类
==person.py==
    ```python
    class persons():
    def __init__(self,name,age,gender):
        self.name=name #属性
        self.age=age
        self.gender=gender

    def getname(self):
        return self.name #返回值

    def getage(self):
        return self.age

    def getgender(self):
        return self.gender

    def setname(self,name):
        self.name=name

    def speak(self,words):
        print("hello,"+words)
        return words
    ```
==TestPerson.py ==
    ```python
    import unittest
    import sys
    from person import persons

    sys.path.append(".")

    class TestPerson(unittest.TestCase):
        '''测试person类'''
        def test__init__(self):
            p1=persons(name="xxx",age=24,gender="man")#person对象
            self.assertEqual("xxx",p1.getname())
            self.assertEqual(24,p1.getage())
            self.assertEqual("man",p1.getgender())

        def test_getage(self):
            p1=persons("xxx",24,"man")
            self.assertEqual(24,p1.getage())

        def test_setname(self):
            p1=persons("xxx",24,"man")
            p1.setname("ABC")
            self.assertEqual("ABC",p1.getname())

        def test_speak(self):
            p1=persons("xxx",24,"man")
            words=p1.speak("python")
            self.assertEqual(words,"python")

        if __name__=="__main__":
            unittest.main()

    ```
==TestPersonSetUp.py ==
    ```python
    import unittest
    import sys
    from person import persons

    sys.path.append(".")

    #use saetUp()
    class TestPerson(unittest.TestCase):
        '''使用setUp()方法创建需要的对象和资源，可以方便测试'''
        def setUp(self):
            self.p1=persons(name="x1",age=24,gender="man")#是其中的变量了
            self.p2=persons(name="x2",age=25,gender="woman")
            self.p3=persons(name="x3",age=26,gender="man")

        def test_setname(self):
            self.assertEqual("x2",self.p2.getname())

        def test_speak(self):
            words=self.p3.speak("python")
            self.assertEqual("python",words)

    if __name__=="__main__":
        unittest.main()
    ```
10.Lambda表达式
&nbsp;&nbsp;&nbsp;&nbsp;**lambda是一个表达式而不是一个语句**。它能够出现在python语法不允许def出现的地方。作为表达式，**lambda返回一个值（即一个新的函数）**。lambda用来编写简单的函数，而def用来处理更强大的任务。lambda表达式的定义为`lambda argument1,argument2,...argumentN:expression using arguments`。在下面的例子中，`func`和`f`的作用完全相同，lambda表达式返回的是一个函数，给其赋值调用之后，就会出现相应的结果。
```python
   def func(x,y,z):#1
       return x+y+z

   f=lambda x,y,z:x+y+z#
```
**默认参数也可以在lambda表达式中使用**，如下：
```python
   x=(lambda a="fee",b="file123",c="hello":a+b+c)
   x("qwe")
```
其运行结果如下：
![lambda默认值](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_lambda.png)
lambda表达式通常来写跳转表（包含行为的列表或者字典），**lambda针对*小段的内联代码，而且专注于在使用`def`定义时繁琐的情况下**，++**lambda表达式之中通常是*短小精悍的*==逻辑代码==**++，在实践之中，最好别嵌套lambda表达式。
```python
	#lambda表达式写跳转表
    L = [(lambda x: x**2),
        (lambda x: x**3),
        (lambda x: x**4)]
    print(L[0](2),L[1](2),L[2](2))

    D = {'f1':(lambda: 2+3),
        'f2':(lambda: 2*3),
        'f3':(lambda: 2**3)}
    print(D['f1'](),D['f2'](),D['f3']())
```
![运行情况](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_111.png)
```python
	#python交互模式下lambda表达式嵌套的情况
    >>> action=lambda x:(lambda y:x+y)
    >>> act=action(99)
    >>> act
    <function <lambda>.<locals>.<lambda> at 0x00000000040EF0D0>#说明了返回的是函数
    >>> act(3)
```
![lambda嵌套](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_222.png)
11.标准库学习
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*0.[learn_python_module.ipynb](https://github.com/prayjourney/PythonModuleNotes/blob/master/learn_python_module.ipynb)*
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*1.[Python pdb模块.md](https://github.com/prayjourney/SummaryOfProgramming/blob/master/%E7%BC%96%E7%A0%81/Python/Python%20pdb%E6%A8%A1%E5%9D%97.md)*
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*2.[Python模块之pickle和json.md](https://github.com/prayjourney/SummaryOfProgramming/blob/master/%E7%BC%96%E7%A0%81/Python/Python%E6%A8%A1%E5%9D%97%E4%B9%8Bpickle%E5%92%8Cjson.md)*
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*3.[Python io, os, shutil.md](https://github.com/prayjourney/SummaryOfProgramming/blob/master/%E7%BC%96%E7%A0%81/Python/Python%20io%2C%20os%2C%20shutil.md)*
12.注意（待续）
&nbsp;&nbsp;在Python之中，字符的处理对于编码有要求，Python默认的字符集对于中文的支持不太好，所以我们需要在__*每个py文件的第一句，写上如下代码:*__
```python
# -*- coding: utf-8 -*-
```

ref:
>1.[Python自带的操作手册怎么学习？](https://segmentfault.com/q/1010000010640464)
2.[Python学习笔记（十二）：lambda表达式与函数式编程](http://blog.csdn.net/mathboylinlin/article/details/9413551)
