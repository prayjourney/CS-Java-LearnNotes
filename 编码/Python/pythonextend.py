# -------------------------------------------------------------------------------
# -*- coding: utf-8 -*-
# 
# __title__ = 'pythonextend'
# __purpose__ =
# __author__ = 'prayjourney'
# __mtime__ = '2017/12/5'
# __copyright__='(c) renjiaxin.jesse 2017'
# __licence__ = 'prayjourney 2017'
# 
#                 ┏ ┓   ┏ ┓
#              ┏━━┛ ┻━━━┛ ┻━━┓
#              ┃    #
#              ┃   ┳┛  ┗*━   ┃    蹉跎错，消磨过，最是光阴化浮沫。
#              ┃      ┻      ┃
#              ┗━━┓       ┏━━┛
#                 ┃         ┗━━━━━━━━━━┓
#                 ┃  神兽保佑           ┣━┓
#                 ┃  永无BUG！         ┏┛
#                 ┗┓━┓ ┏━━━━━━━━━┳━┓━┓┛
#                  ┃━┫━┫         ┃━┫━┫
#                  ┗━┻━┛         ┗━┻━┛
#
# ---------------------------------------------------------------
class Person():
    def __init__(self, name, gender):
        self.name = name
        self.gender = gender


# 单继承
class Student(Person):
    def __init__(self, name, gender, score):
        super(Student, self).__init__(name, gender)  # 重点
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


# MRO问题
class ChineseStudent(Student, Person):
    def __int__(self, name, gender, score, speciality):
        super(ChineseStudent, self).__init__(name, gender, score)
        self.speciality = speciality

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


if __name__ == "__main__":
    p = Person('zhansan', '男')
    print(p.name + ", " + p.gender)
    s = Student('Lee', '女', 89)
    s.printinfo()
    chs = ChineseStudent('赵中英', '男', '85')
    chs.printinfo()
    sta = StudentTypeA("ww", "女", 89, 3, '羽毛球')
    stb = StudentTypeB("ww", "男", 67, 31, '篮球')
    # 多继承按照第一个参数位置的类来初始化对象，不按照后面的，
    # 这样损失了后面类之中的属性，但是获得了该类的方法
    sta.printinterest()  # 获得了该类的方法
    sta.printinfo()
    stb.printinfo()  # 子类的方法覆盖了父类的方法


    #  http://blog.csdn.net/goodluckac/article/details/53100957
    #  http://blog.csdn.net/chenxiao_ji/article/details/50311597
    #  https://www.cnblogs.com/yudy/archive/2013/06/10/3130521.html
    #  http://blog.csdn.net/new_abc/article/details/47904595
