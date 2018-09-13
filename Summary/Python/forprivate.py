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
