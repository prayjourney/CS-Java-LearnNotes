###Python中__repr__和__str__区别
***
#####官方解释是
str是给普通用户看的，repr是给编译器/程序员看的

> The str() function is meant to return representations of values which are fairly human-readable, while repr() is meant to generate representations which can be read by the interpreter (or will force a SyntaxError if there is not equivalent syntax).



#####例子
```python
class Test(object):
    def __init__(self, value='hello, world!'):
        self.data = value

>>> t = Test()
>>> t
<__main__.Test at 0x7fa91c307190>
>>> print t
<__main__.Test object at 0x7fa91c307190>

# 看到了么？上面打印类对象并不是很友好，显示的是对象的内存地址
# 下面我们重构下该类的__repr__以及__str__，看看它们俩有啥区别

# 重构__repr__
class TestRepr(Test):
    def __repr__(self):
        return 'TestRepr(%s)' % self.data

>>> tr = TestRepr()
>>> tr
TestRepr(hello, world!)
>>> print tr
TestRepr(hello, world!)

# 重构__repr__方法后，不管直接输出对象还是通过print打印的信息都按我们__repr__方法中定义的格式进行显示了

# 重构__str__
calss TestStr(Test):
    def __str__(self):
        return '[Value: %s]' % self.data

>>> ts = TestStr()
>>> ts
<__main__.TestStr at 0x7fa91c314e50>
>>> print ts
[Value: hello, world!]

# 可以发现，直接输出对象ts时并没有按我们__str__方法中定义的格式进行输出，而用print输出的信息却改变了1234567891011121314151617181920212223242526272829303132333435363738
```



#####总结
__repr__和__str__这两个方法都是用于显示的，__str__是面向用户的，而__repr__面向编译器/程序员。
- 打印操作会首先尝试__str__和str内置函数(print运行的内部等价形式)，它通常应该返回一个友好的显示。
- __repr__用于所有其他的环境中：用于交互模式下提示回应以及repr函数，如果没有使用__str__，会使用print和str。它通常应该返回一个编码字符串，可以用来重新创建对象，或者给开发者详细的显示。

当我们想所有环境下都统一显示的话，可以重构__repr__方法；当我们想在不同环境下支持不同的显示，例如终端用户显示使用__str__，而程序员在开发期间则使用底层的__repr__来显示，实际上__str__只是覆盖了__repr__以得到更友好的用户显示。



ref:
1.[Pythonrepr和str区别](http://blog.csdn.net/luckytanggu/article/details/53649156)