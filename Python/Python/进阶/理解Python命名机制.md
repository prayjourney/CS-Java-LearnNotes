### 理解Python命名机制

***

##### 引子

我热情地邀请大家猜测下面这段程序的输出
```python
class A():
    def __init__(self):
        self.__private()
        self.public()

    def __private(self):
        print('A.__private()')

    def public(self):
        print('A.public()')


class B(A):
    def __private(self):
        print('B.__private()')

    def public(self):
        print('B.public()')

b = B()
```



##### 初探

正确的答案如下
```python
A.__private()
B.public()
```

如果您已经猜对了，那么可以不看我这篇博文了。如果你没有猜对或者心里有所疑问，那我的这篇博文正是为您所准备的。一切由为什么会输出`A.__private()`开始。但要讲清楚为什么，我们就有必要了解一下Python的命名机制。

据 Python manual，变量名（标识符）是Python的一种原子元素。当变量名被绑定到一个对象的时候，变量名就指代这个对象，就像人类社会一样，不是吗？当变量名出现在代码块中，那它就是本地变量；当变量名出现在模块中，它就是全局变量。模块相信大家都有很好的理解，但代码块可能让人费解些。在这里解释一下：代码块就是可作为可执行单元的一段Python程序文本；模块、函数体和类定义都是代码块。不仅如此，每一个交互脚本命令也是一个代码块；一个脚本文件也是一个代码块；一个命令行脚本也是一个代码块。

接下来谈谈变量的可见性，我们引入一个范围的概念。范围就是变量名在代码块的可见性。如果一个代码块里定义本地变量，那范围就包括这个代码块。如果变量定义在一个功能代码块里，那范围就扩展到这个功能块里的任一代码块，除非其中定义了同名的另一变量。但定义在类中的变量的范围被限定在类代码块，而不会扩展到方法代码块中



##### 迷踪

据上节的理论，我们可以把代码分为三个代码块：类A的定义、类B的定义和变量b的定义。根据类定义，我们知道代码给类A定义了三个成员变量（Python的函数也是对象，所以成员方法称为成员变量也行得通）。类B定义了两个成员变量。这可以通过以下代码验证

```python
>>> print('\n'.join(dir(A)))
_A__private
__class__
__delattr__
__dict__
__dir__
__doc__
__eq__
__format__
__ge__
__getattribute__
__gt__
__hash__
__init__
__le__
__lt__
__module__
__ne__
__new__
__reduce__
__reduce_ex__
__repr__
__setattr__
__sizeof__
__str__
__subclasshook__
__weakref__
public

>>> print('\n'.join(dir(B)))
_A__private
_B__private
__class__
__delattr__
__dict__
__dir__
__doc__
__eq__
__format__
__ge__
__getattribute__
__gt__
__hash__
__init__
__le__
__lt__
__module__
__ne__
__new__
__reduce__
__reduce_ex__
__repr__
__setattr__
__sizeof__
__str__
__subclasshook__
__weakref__
public
```
咦，为什么类A有个名为`_A__private`的 Attribute 呢？而且`__private`消失了！这就要谈谈Python的私有变量轧压了。



##### 探究

懂Python的朋友都知道，*Python把以两个或以上下划线字符开头且没有以两个或以上下划线结尾的变量当作私有变量*。**私有变量会在代码生成之前被转换为长格式（变为公有）。转换机制是这样的：在变量前端插入类名，再在前端加入一个下划线字符。这就是所谓的私有变量轧压（Private name mangling）**。如类A里的`__private`标识符将被转换为`_A__private`，这就是上一节出现`_A__private`和`__private`消失的原因。而且，类在初始化的时候，子类会首先调用自己的`__init__()`函数，如果子类没有显式实现自己的`__init__()`函数，那么子类会调用父类的`__init__()`函数来初始化子类的对象，如果子类定义了自己的`__init__()`函数，其将覆盖父类的`__init__()`函数

**注意**
1.轧压会使标识符变长，当超过255的时候，Python会切断，要注意因此引起的命名冲突
2.类名全部以下划线命名的时候，Python就不再执行轧压。如

```python
>> class ____():
       def __init__(self):
              self.__method()
       def __method(self):
              print('____.__method()')

>>> print('\n'.join(dir(____)))
__class__
__delattr__
__dict__
__dir__
__doc__
__eq__
__format__
__ge__
__getattribute__
__gt__
__hash__
__init__
__le__
__lt__
__method   # 没被轧压
__module__
__ne__
__new__
__reduce__
__reduce_ex__
__repr__
__setattr__
__sizeof__
__str__
__subclasshook__
__weakref__

>>> obj = ____()
____.__method()
>>> obj.__method()  # 可以外部调用
____.__method()
```
现在我们回过头来看看为什么会输出“A.__private()”吧！



##### 真相

相信现在聪明的读者已经猜到答案了吧？如果你还没有想到，我给你个提示：真相跟C语言里的宏预处理差不多。因为类A定义了一个私有成员函数（变量），所以在代码生成之前先执行私有变量轧压（注意到上一节标红的那行字没有？）。轧压之后，类A的代码就变成如下情形了

```python
# 私有变量轧压之前
class A():
    def __init__(self):
        self.__private()
        self.public()

    def __private(self):
        print('A.__private()')

    def public(self):
        print('A.public()')

# 私有变量轧压之后
class A():
       def __init__(self):
              self._A__private()          # 这行变了
              self.public()

       def _A__private(self):             # 这行也变了
              print ('A.__private()')

       def public(self):
              print ('A.public()')
```

是不是有点像C语言里的宏展开啊？因为在类B定义的时候没有覆盖`__init__`方法，所以调用的仍然是`A.__init__`，即执行了`self._A__private()`，自然输出`A.__private()`了。下面的两段代码可以增加说服力，增进理解

```python
class C(A):
    def __init__(self):  # 重写__init__，不再调用self._A__private
        self.__private()  # 这里绑定的是_C_private
        self.public()

    def __private(self):
        print('C.__private()')

    def public(self):
        print('C.public()')
>>> c = C()
C.__private()
C.public()
```

```python
class D():
    def __init__(self):
        self._D__private()  # 调用一个没有定义的函数，Python会把它给我的 ^_^～
        self.public()

    def __private(self):
        print('D.__private()')

    def public(self):
        print('D.public()')

>>> d = D()
D.__private()
D.public()
```

##### 总结

1.Python把以两个或以上下划线字符开头且没有以两个或以上下划线结尾的变量当作私有变量。
私有变量会在代码生成之前被转换为长格式（变为公有）。转换机制是这样的：在变量前端插入类名，再在前端加入一个下划线字符。这就是所谓的私有变量轧压（Private name mangling）

2.类在初始化的时候，子类会首先调用自己的`__init__()`函数，如果子类没有显式实现自己的`__init__()`函数，那么子类会调用父类的`__init__()`函数来初始化子类的对象，如果子类定义了自己的`__init__()`函数，其将覆盖父类的`__init__()`函数



##### 总的代码

```python
# -*- coding:utf-8-*-
"""
Python把以两个或以上下划线字符开头且没有以两个或以上下划线结尾的变量当作私有变量。
私有变量会在代码生成之前被转换为长格式（变为公有）。
转换机制是这样的：在变量前端插入类名，再在前端加入一个下划线字符。这就是所谓的私有变量轧压（Private name mangling）
"""
"""
类在初始化的时候，子类会首先调用自己的__init__()函数，
如果子类没有显式实现自己的__init__()函数，那么子类会调用父类的__init__()函数来初始化子类的对象，
如果子类定义了自己的__init__()函数，其将覆盖父类的__init__()
"""

class A():
    def __init__(self):
        self.__private()
        self.public()

    def __private(self):
        print('A.__private()')

    def public(self):
        print('A.public()')


class B(A):
    def __private(self):
        print('B.__private()')

    def public(self):
        print('B.public()')


class C(A):
    def __init__(self):  # 重写__init__，不再调用self._A__private
        self.__private()  # 这里绑定的是_C_private
        self.public()

    def __private(self):
        print('C.__private()')

    def public(self):
        print('C.public()')


class D():
    def __init__(self):
        self._D__private()  # 调用一个没有定义的函数，Python会把它给我的 ^_^～
        self.public()

    def __private(self):
        print('D.__private()')

    def public(self):
        print('D.public()')


b = B()
c = C()
d = D()
# A.__private()
# B.public()
# C.__private()
# C.public()
# D.__private()
# D.public()
```



ref:

1.[理解Python命名机制](http://blog.csdn.net/gzlaiyonghao/article/details/1734990)