### Python子类调用父类函数的方法

***

##### 初始化

Python子类调用父类的方法，最常见的就是初始化方法__init__()，python中类的初始化方法是__init__()，因此父类子类的初始化方法都是这个，如果子类不实现这个函数，初始化时调用父类的初始化函数，如果子类实现这个函数，就覆盖了父类的这个函数，既然继承父类，就要在这个函数里显式调用一下父类的\_\_init\_\_()，这跟C++,jAVA不一样，他们是自动调用父类初始化函数的

```python
# -*- coding:utf-8 -*-
class Animal():
    def __init__(self, name):
        self.name = name
 
    def saySomething(self):
        print("I am " + self.name)
 
class Dog(Animal):
    def __init__(self, name):
        super().__init__(name)
 
    def saySomething(self):
        print ("I am "+ self.name + ", and I can bark")
```



##### 子类调用父类函数的方法

- 直接写类名调用： parent_class.parent_attribute(self)
- 用 super(type, obj).method(arg)方法调用：super(child_class, child_object).parent_attribute(arg)   【不需要写self】
- 在类定义中调用本类的父类方法，可以直接 super().parent_method(arg)  【个人推崇这种写法】

demo如下

```python
# -*- coding:utf-8 -*-
# file_name: python_class_inheritance_example.py
class Animal():
    def __init__(self, name):
        self.name = name
 
    def saySomething(self):
        print("I am " + self.name)
 
class Dog(Animal):
    def __init__(self, name):
        super().__init__(name)
 
    def saySomething(self):
        print ("I am "+ self.name + ", and I can bark")
 
    def animal_say_1(self):
        # 子类调用父类的方法
        #  方式1
        super(Dog, self).saySomething()
 
    def animal_say_2(self):
        #  方式2 [推荐]
        super().saySomething()
     
    def animal_say_3(self):
        # 方式3
        Animal.saySomething(self)
 
 
if __name__ == "__main__":
    dog = Dog("Blake")
    dog.saySomething()
    dog.animal_say_1()
    dog.animal_say_2()
    dog.animal_say_3()
    # 子类对象调用被覆盖的父类方法
    super(Dog, dog).saySomething()
 
'''
输出结果如下：
python python_class_inheritance_example.py
I am Blake, and I can bark
I am Blake
I am Blake
I am Blake
I am Blake
'''
```

ref：

1.[Python子类调用父类内属性的方法](http://www.cnblogs.com/labc/articles/4856724.html)