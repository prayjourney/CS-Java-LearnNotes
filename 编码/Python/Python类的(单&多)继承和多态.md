### Python类的(单&多)继承和多态

***

##### 类的定义方式
定义方式如下
```python
# -*- coding: utf-8 -*-
class People():
    classname='Class People'  #  静态变量
    def __init__(self,name,gender):
        self.name=name  #  成员变量
        self.gender=gender
        self.__name=name  #  私有变量
        self.__gender=gender

    def setname(self,name):  #  成员方法
        self.name=name

    def printinfo(self):
        print("name:"+name+",gender:"+gender)

    def __getname(self,name):  #  私有方法
        return self.name

    @staticmethod
    def description():  #  静态方法
        print('This is a People class')

    @classmethod
    def classinfo(cls):  # 类方法
        print("类方法可以访问类变量" + cls.classname)
        print("类方法无法访问成员变量")  # 类方法无法访问成员变量

```


##### 单继承
单继承最简单直接的形式是，**在python类的括号后面，只有一个类**，默认的所有的类，
都继承于object，在python3之中，创建类可以不必写出来，一般情况下都是默认写成
`class a():`的形式，而非`class a(object):`

```python
class Person():
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

class Student(Person):
    def __init__(self, name, gender, score):
        super(Student, self).__init__(name, gender)  # 方式1，使用super函数来初始化此类
        # Person.__init__(self, name, gender)        # 方式2，使用父类来初始化此类
        self.score = score
        # 一定要用super(Student, self).__init__(name, gender)
        # 去初始化父类，否则，继承自Person的Student将没有name和gender属性
        # 函数super(Student, self)将返回当前类继承的父类，即Person ，
        # 然后调用__init__()方法，注意self参数已在super()中传入，
        # 在__init__()中将隐式传递，不需要写出（也不能写）。
        # 如果直接使用父类去初始化，则在后面的init方法中，要加入self参数

    def setscore(self, score):  #  子类自定义的方法
        self.score = score

    def printinfo(self):
        print(self.name + ", " + self.gender + ", " + str(self.score))

```



##### 多继承
多继承最简单直接的形式是，**在python类的括号后面，有多个类**，
多继承之中需要注意**MRO**的问题，在初始化的过程之中，**使用的是第一个父类的参数，来初始化**，
**这样就相当于丢失了其他父类的成员变量，而继承了其中的方法**，总的来说是一种折中的方式，
多继承之中**“类的祖先类的查找顺序是广度优先”**,如果子类继承的两个类或者多个类之间也有继承关系，
由于多继承的时候，子类对象的初始化和位置有关系，简单的来说，就是按照第一个参数位置处的类，
去初始化子类。如果是按照==A(子类，父类)==的方式是**可以**的，但是如果按照A(父类，子类)方式就会产生MRO问题，
**因为其无法完成对方法的准确定位**。但为什么第一种继承方式可以呢？因为Student 类是Person 类的子类，
子类具有更高的具体性，往往可以覆盖父类的方法和属性，所以第一种继承方式不会出现问题
这就说明了当一个类继承的多个类时候，如果被继承的类之间有继承关系的话，
一定要按照从“具体”--->“抽象”的方式继承，也就是“子类”--->“父类”的方式继承，否则会有MRO错误
并且，多继承使用的使用，往往是不同关系的类之间的组合，而非有类似关系的类之间的组合
```python
# -*- coding: utf-8 -*-
class Person():
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender

class Student(Person):
    def __init__(self, name, gender, score):
        super(Student, self).__init__(name, gender)  # 重点，使用super函数来初始化此类
        self.score = score
        # 一定要用super(Student, self).__init__(name, gender)
        # 去初始化父类，否则，继承自Person的Student将没有name和gender属性
        # 函数super(Student, self)将返回当前类继承的父类，即Person ，
        # 然后调用__init__()方法，注意self参数已在super()中传入，
        # 在__init__()中将隐式传递，不需要写出（也不能写）。

    def setscore(self, score):
        self.score = score

    def printinfo(self):
        print(self.name + ", " + self.gender + ", " + str(self.score))

class Interest():
    def __init__(self, interest):
        self.interest = interest

    def setinterest(self, interest):
        self.interest = interest

    def printinterest(self):
        print(self.interest)

# 爱学习的学生
class StudentTypeA(Student, Interest):
    def __init__(self, name, gender, score, rank, interest):
        super(StudentTypeA, self).__init__(name, gender, score)
        self.rank = rank
        self.interest = interest

    def setrank(self, rank):
        self.rank = rank

    def printinfo(self):
        print(self.name + ", " + self.gender + ", " + str(self.score) +
              ", " + str(self.rank) + ", " + self.interest)


# 爱玩耍的学生
class StudentTypeB(Interest, Student):
    def __init__(self, name, gender, score, rank, interest):
        super(StudentTypeB, self).__init__(interest)
        self.name = name
        self.gender = gender
        self.score = score
        self.rank = rank

    def setname(self, name):
        self.name = name

    def setgender(self, gender):
        self.gender = gender

    def setscore(self, score):
        self.score = score

    def setrank(self, rank):
        self.rank = rank

    def printinfo(self):
        print(self.name + ", " + self.gender + ", " + str(self.score) +
              ", " + str(self.rank) + ", " + self.interest)

    def printinterest(self):
        print("子类对象的interest是:"+self.interest)
```



##### python继承中特点
1：在继承中基类的构造（__init__()方法）不会被自动调用，它需要在其派生类的构造中亲自专门调用。
   使用super().__init__()或parentClassName.__init__()
2：在调用基类的方法时，需要加上基类的类名前缀，且需要带上self参数变量，如同==类名.方法(子类对象)==
   区别于在类中调用普通函数时并不需要带上self参数
3：Python总是首先查找对应类型的方法，如果它不能在派生类中找到对应的方法，它才开始到基类中逐个查找。
  （先在本类中查找调用的方法，子类中的方法会覆盖父类中的相同签名的方法，找不到才去基类中找）



##### 例子
```python
# -*- coding: utf-8 -*-
"""
关于初始化__init__函数的说明：
方法1:使用super完成初始化
def __init__(self,A,B,C):
    super(子类,self).__init__(A,B)
    self.C = C
说明：def的__init__是子类的初始化方法，其中的A,B,C是初始化对象需要的参数，
      使用super初始化时候，其返回的是一个父类对象，相当于父类对象调用了它自己的初始化函数，
      此处的A,B都是父类的参数，当取得一个父类对象时候，然后再在此个对象的基础上，添加属性C
      完成对子类的初始化

方法2:直接使用父类完成初始化
def __init__(self,A,B,C):
    父类.__init__(A,B)
    self.C = C
说明：def的__init__是子类的初始化方法，其中的A,B,C是初始化对象需要的参数，
      使用父类调用init,返回的是一个父类对象，相当于父类对象调用了它自己的初始化函数，
      此处的A,B都是父类的参数，当取得一个父类对象时候，然后再在此个对象的基础上，添加属性C
      完成对子类的初始化

"""

"""
在python中继承中的一些特点：

1：在继承中基类的构造（__init__()方法）不会被自动调用，它需要在其派生类的构造中亲自专门调用。
   使用super().__init__()或parentClassName.__init__()
2：在调用基类的方法时，需要加上基类的类名前缀，且需要带上self参数变量。
   区别于在类中调用普通函数时并不需要带上self参数
3：Python总是首先查找对应类型的方法，如果它不能在派生类中找到对应的方法，它才开始到基类中逐个查找。
  （先在本类中查找调用的方法，找不到才去基类中找）
"""


class Person():
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender


# 单继承
class Student(Person):
    def __init__(self, name, gender, score):
        super(Student, self).__init__(name, gender)  # 重点，使用super函数来初始化此类
        self.score = score
        # 一定要用super(Student, self).__init__(name, gender)
        # 去初始化父类，否则，继承自Person的Student将没有name和gender属性
        # 函数super(Student, self)将返回当前类继承的父类，即Person ，
        # 然后调用__init__()方法，注意self参数已在super()中传入，
        # 在__init__()中将隐式传递，不需要写出（也不能写）。

    def setscore(self, score):
        self.score = score

    def printinfo(self):
        print(self.name + ", " + self.gender + ", " + str(self.score))


class Teacher(Person):
    def __init__(self, name, gender, salary):
        Person.__init__(self, name, gender)
        self.salary = salary
        # 使用父类直接初始化子类也可以，作用与super函数相同，使用Person对象，在下面新添加salary属性
        # 就完成了对于Teacher对象的初始化

    def getsalary(self):
        return self.salary

    def updatesalary(self,number):
        self.salary=self.salary+number

    def printinfo(self):
        print(self.salary)

class Interest():
    def __init__(self, interest):
        self.interest = interest

    def setinterest(self, interest):
        self.interest = interest

    def printinterest(self):
        print(self.interest)


# 多继承
# MRO问题
class ChineseStudent(Student, Person):
    def __int__(self, name, gender, score, speciality):  # 此处是ChineseStudent类需要初始化的参数
        super(ChineseStudent, self).__init__(name, gender, score)
        self.speciality = speciality
        # super(ChineseStudent, self)返回的是Student,在接下来，使用返回的Student对象，添加speciality属性
        # 就完成了对于ChineseStudent对象的初始化

    def setspeciality(self, speciality):
        self.speciality = speciality


# 如下代码将产生【TypeError: Cannot create a consistent method resolution
# order (MRO) for bases Person, Student】的错误，因为无法识别到底该使用那个类的方法
# 此二类之间也有继承关系，由于继承的时候，和位置有关系，简单的来说，就是按照
# 第一个参数位置处的类，去初始化子类，如果按照此已经注释了的方法，就会导致会乱
# 但为什么上面一个继承就可以呢？因为Student 类是Person 类的子类，
# 子类具有更高的具体性，往往可以覆盖父类的方法和属性，所以上面一个继承方式不会出现问题
# 这就说明了当一个类继承的多个类时候，如果被继承的类之间有继承关系的话，
# 一定要按照从“具体”--->“抽象”的方式继承，也就是“子类”--->“父类”的方式继承，否则会有MRO错误
# 因为“类的祖先类的查找顺序是广度优先”
#
# class AmericanStudent(Person, Student):
#     def __init__(self, name, gender, score, speciality):
#         super(AmericanStudent, self).__init__(name, gender)
#         self.score = score
#         self.speciality = speciality
#
#     def setspeciality(self, speciality):
#         self.speciality = speciality

# 爱学习的学生
class StudentTypeA(Student, Interest):
    def __init__(self, name, gender, score, rank, interest):
        super(StudentTypeA, self).__init__(name, gender, score)
        self.rank = rank
        self.interest = interest

    def setrank(self, rank):
        self.rank = rank

    def printinfo(self):
        print(self.name + ", " + self.gender + ", " + str(self.score) +
              ", " + str(self.rank) + ", " + self.interest)


# 爱玩耍的学生
class StudentTypeB(Interest, Student):
    def __init__(self, name, gender, score, rank, interest):
        super(StudentTypeB, self).__init__(interest)
        self.name = name
        self.gender = gender
        self.score = score
        self.rank = rank

    def setname(self, name):
        self.name = name

    def setgender(self, gender):
        self.gender = gender

    def setscore(self, score):
        self.score = score

    def setrank(self, rank):
        self.rank = rank

    def printinfo(self):
        print(self.name + ", " + self.gender + ", " + str(self.score) +
              ", " + str(self.rank) + ", " + self.interest)

    def printinterest(self):
        print("子类对象的interest是:"+self.interest)


if __name__ == "__main__":
    p = Person('zhansan', '男')
    print(p.name + ", " + p.gender)
    s = Student('Lee', '女', 89)
    s.printinfo()
    t1 = Teacher("马燕", '女', 3000)
    t1.printinfo()
    t2 = Teacher("刘亦菲", '男', 8000)
    t2.updatesalary(900)
    t2.printinfo()
    chs = ChineseStudent('赵中英', '男', '85')
    chs.printinfo()
    sta = StudentTypeA("ww", "女", 89, 3, '羽毛球')
    stb = StudentTypeB("ww", "男", 67, 31, '篮球')
    # 多继承按照第一个参数位置的类来初始化对象，不按照后面的，
    # 这样损失了后面类之中的属性，但是获得了该类的方法
    sta.printinterest()  # 获得了该类的方法
    sta.printinfo()
    stb.printinfo()  # 子类的方法覆盖了父类的方法
    stb.printinterest()  # 调用子类的方法
    Interest.printinterest(stb)  # 调用父类的方法


    # http://blog.csdn.net/goodluckac/article/details/53100957
    # https://www.cnblogs.com/chenlin163/p/7307962.html
    # http://blog.csdn.net/chenxiao_ji/article/details/50311597
    # https://www.cnblogs.com/yudy/archive/2013/06/10/3130521.html
    # http://blog.csdn.net/new_abc/article/details/47904595
    # https://www.cnblogs.com/haoxinyue/archive/2013/01/04/2844758.html
    # https://www.cnblogs.com/z941030/p/4851650.html

```

ref:
1.[python3.x 类和对象](https://www.cnblogs.com/cdinc/p/5860351.html),   2.[Python的3个方法：静态方法(staticmethod),类方法(classmethod)和实例方法](http://www.cnblogs.com/genezhao/p/6920761.html),  3.[Python3 面向对象](http://www.runoob.com/python3/python3-class.html),  4.[python3 入门 (四) 类与继承](http://www.cnblogs.com/z941030/p/4851650.html),  5.[python3--类与继承和组合](http://www.cnblogs.com/chenlin163/p/7307962.html),  6.[Python3 学习笔记 -- 继承](http://www.cnblogs.com/haoxinyue/archive/2013/01/04/python3_Inheritance.html),  7.[python多重继承新算法C3](http://www.cnblogs.com/mingaixin/archive/2013/01/31/2887190.html),  8.[Python类的多重继承问题深入分析](http://www.jb51.net/article/57263.htm),  9.[Python多重继承是否始终是遵循从左到右 深度优先的规则?](https://www.zhihu.com/question/54855335)