### python 变量命名规范

***

##### 命名规则

**模块名**:   小写字母，单词之间用_分割
example:   `ad_status.py`, `sys`

**包名**:    小写字母，单词之间用_分割，和模块名一样

example:   `pyqt5`

**类名**:   单词首字母大写

example:   `MyDlg`, `ConfigUtil`

**全局变量名**:   也就是**类变量**，在Java中相当于static变量，大写字母，单词之间用_分割
example:   `NUMBER`, `COLOR_WRITE`

**普通变量**:   小写字母，单词之间用_分割
example:   `this_is_a_var`

**实例变量**:   以_（1个下划线）开头，其他和普通变量一样
example:   `_price`, `_instance_var`

**私有实例变量**:   *外部访问会报错*，以__开头（2个下划线），其他和普通变量一样
example:   `__private_var`

**专有变量**:   \__开头，__结尾，一般为python的自有变量，不要以这种方式命名
example:   `__doc__`, `__class__`

**普通函数**:  和普通变量一样，小写字母，单词之间用_分割
example:   `get_name()`, `count_number()`, `ad_stat()`

**私有函数**:   *外部访问会报错*，以\__开头（2个下划线），其他和普通函数一样
example:   `__get_name()`

**特列函数**:   \__开头，__结尾，一般为python的自有变量，不要以这种方式命名

example:   `__init__()`, `__import__()`



#####注意

- _单下划线开头:   弱“内部使用”标识，如:   `from M import *`，将不导入所有以下划线开头的对象，包括包、模块、成员，相当于protected

- 单下划线结尾_:   只是为了避免与python关键字的命名冲突

- \_\_双下划线开头:   模块内的成员，表示私有成员，外部无法直接调用

- 包和模块:   模块应该使用尽可能短的、全小写命名，可以在模块命名时使用下划线以增强可读性。同样包的命名也应该是这样的，虽然其并不鼓励下划线

- 类:   几乎毫无例外的，类名都使用首字母大写开头(Pascal命名风格)的规范。使用_单下划线开头的类名为内部使用，上面说的from M import *默认不被告导入的情况

- 异常:   因为异常也是一个类，所以遵守类的命名规则。此外，如果异常实际上指代一个错误的话，应该使用“Error”做后缀

以上这些主要是考虑模块名是与文件夹相对应的，因此需要考虑文件系统的一些命名规则的，比如Unix系统对大小写敏感，而过长的文件名会影响其在Windows/Mac/Dos等系统中的正常使用。



##### 对于私有变量

-  _xx 以单下划线开头的表示的是protected类型的变量。即**保护类型只能允许其本身与子类进行访问**。若内部变量标示，如:  当使用`from M import *`时，不会将以一个下划线开头的对象引入
-  \_\_xx 双下划线的表示的是**私有类型**的变量。只能允许这个类本身进行访问了，*连子类也不可以用于命名一个类属性（类变量）*，**调用时名字被改变(类`FooBar`内部，调用`__boo`时，使用: `_FooBar.__boo`，如`self._FooBar.__boo`**，这是因为~~私有变量会在代码生成之前被转换为长格式（**变为公有**）。转换机制是这样的：在变量前端插入类名，再在前端加入一个下划线字符~~，如`_FooBar.__boo`
-  \_\_xx\_\_定义的是**特列方法**。用户控制的命名空间内的变量或是属性，如`__init__ `,` __import__`或是`__file__`，只有当文档有说明时使用，不要自己定义这类变量。*就是说这些是python内部定义的变量名*

在这里强调说一下私有变量，python默认的成员函数和成员变量都是公开的，没有像其他类似语言的public，private等关键字修饰。但是可以在变量前面加上两个下划线`__`,这样的话函数或变量就变成私有的。这是python的`私有变量轧压(private name mangling)`(这个翻译好拗口)。它的**情况就是当变量被标记为私有后,在变量的前端插入类名,再类名前添加一个下划线`_`,即形成了`_ClassName__变量名`**。



##### 例子

下面是一个对于两种类型的私有变量使用的demo

```python
# -*- coding: utf-8 -*-
"""
用来测试Python之中的私有和公有方法和变量的特性
由如下的测试可以得知
_xxx:单下划线的方法，变量等，可以被子类访问，它相当于是protected类型
__xxx:双下划线的方法，变量等，不可以可以被子类访问，而且不可以在类定义之外访问，它相当于是private类型的
"""


class PrivateAndPublic():
    _name = "zuiguangyin"  # 弱内部使用，protected
    _age = 24  # 弱内部使用，protected
    __address = "重庆"  # 私有变量，private
    __nickname = "最光阴"  # 私有变量，private

    def __init__(self, dream):
        self.dream = dream

    # 私有方法
    def _set(self, name, age, address, nickname):
        self._name = name
        self._age = age
        self.__address = address
        self.__nickname = nickname

    def _get(self):
        self.__get()  # 只能在内部调用

    def __get(self):
        print("private method:  " + self._name + "," + str(
            self._age) + "," + self.__address + "," + self.__nickname + ",")

    def print1(self):
        print(self._name + "," + str(self._age) + "," + self.__address + "," + self.__nickname + ",")

    def print2(self):
        print(self.dream)


class PrivateAndPublicChild(PrivateAndPublic):
    def __init__(self, dream, timeline):
        super().__init__(dream)
        self.timeline = timeline

    def print2(self):
        print(self.dream + ", " + self.timeline)


if __name__ == "__main__":
    # 父类
    print("======" + "父类")
    private_and_public = PrivateAndPublic("have a good life")
    print(private_and_public.dream)  # 访问成员变量
    private_and_public.print1()  # 访问成员方法
    private_and_public._set("张三", 25, "广州", "狗蛋")  # 访问私有方法
    private_and_public._get()
    # private_and_public.__get()   # 无法直接调用
    private_and_public.print1()
    private_and_public.print2()
    # 子类
    print("======" + "子类")
    private_and_public_child = PrivateAndPublicChild("become a  great man", "10")
    private_and_public_child.print1()  # 这是父类的效果
    private_and_public_child.print2()  # 访问重写的后的方法
    PrivateAndPublic.print1(private_and_public_child)  # 调用父类方法
    private_and_public_child._get()
    # private_and_public_child.__get()  # 无法直接调用
    print(private_and_public_child.timeline)
    print(private_and_public_child._name)
    # print(private_and_public_child.__nickname)  # 无法直接调用
```



##### 不同名字带来的问题

父类的方法没有被子类的方法覆盖，此时可能会引起一些问题，就如同上面的demo一样，下面的也引起了一些问题，只不过是由于名字问题而带来的

The name scrambling is used to ensure that subclasses don't accidentally override the private methods and attributes of their superclasses. It's not designed to prevent deliberate access from outside.

For example:

```python
>>> class Foo():
...     def __init__(self):
...         self.__baz = 42
...     def foo(self):
...         print(self.__baz)
...
>>> class Bar(Foo):
...     def __init__(self):
...         super(Bar, self).__init__()
...         self.__baz = 21
...     def bar(self):
...         print(self.__baz)
...
>>> x = Bar()
>>> x.foo()
42
>>> x.bar()
21
>>> print x.__dict__
{'_Bar__baz': 21, '_Foo__baz': 42}

```
Of course, it breaks down if two different classes have the same name.

ref：

1.[Py第九问 python 变量命名规范](http://blog.csdn.net/olfisher/article/details/52815183),   2.[Python命名规则](http://blog.csdn.net/buhappy/article/details/50960861),   3.[python 中变量的命名规范](http://www.cnblogs.com/Maker-Liu/p/5528213.html),   4.[Python 中特殊变量/方法命名规则说明(特别是私有变量)及使用实例](http://www.cnblogs.com/king-sun/p/4361998.html),   5.[理解Python命名机制](http://blog.csdn.net/gzlaiyonghao/article/details/1734990),   6.[Classes](https://docs.python.org/3/tutorial/classes.html#tut-private),   7.[Why are Python's 'private' methods not actually private?](https://stackoverflow.com/questions/70528/why-are-pythons-private-methods-not-actually-private)