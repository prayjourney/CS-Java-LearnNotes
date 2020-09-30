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
