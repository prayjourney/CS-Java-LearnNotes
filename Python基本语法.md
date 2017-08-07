### Python基本语法
- - -

1.基本的数据结构和函数的定义
- 具体的内容在如下的代码之中,在注释之中有一般用法的说明，其中**# -\*- coding=utf-8 -\*-**，是==编码==注释，需要放在第一行列，这样的话就中文就不会显示乱码，另外在Python之中，单行注释使用**\#**,多行的注释也是使用**\#**，文档注释使用=='''==或者=="""==,可以使用__doc__()方法来提取。
- 三种基本的数据结构，*元组，列表，字典*


|         名称     |       定义     | 使用其中的元素|特点 |
|------------------|---------------|-------------|--------|
| 元组(tuple)      | t=(1,2,"rrr") |    t[1]   | *不可修改*|
| 列表(list)       | **l**=[1,2,"rrr"] | l[0]|  **可以修改**|
| 字典(dictionary) |  d={"name":"123","age":24} ,d={}| d[name]|**可以修改，键值对**|
| 集合(set)|s=set(),s=set(**l**) |*一般是循环* |++其中的值不能重复++ |

  
- 函数的参数种类
  普通参数：普如def function1(p1,p2,p3)之中的p1,p2,p3
    默认参数：
  位置参数：
  任意多的参数：
  任意多的关键字参数：

==hanshu.py==

```python
# -*- coding=utf-8 -*-

# 函数中使用tuple，其值不可变
def  a0():
    s1=(1,2,3,4)
    s2=('1','33','yy','uy','y','m')
    print(s1,end="\t")
    for x in s2:
        print(x+", ",end="\t")

    print("")

    
# 在函数中使用list
def a():
    cookbook = ['chicken', 'apple', 'hotpot', 'orange', 'tea']
    for x in cookbook:
        print("we're eating " + x)

    print("hello")


def b():
    cookbook = ['chicken', 'apple', 'hotpot', 'orange', 'tea']
    cookbook2 = []
    cookbook2.append(cookbook[0])
    cookbook2.append('juice')
    cookbook2.append(cookbook[3])
    cookbook2.append('melon')
    cookbook2.append('tea')
    for x in cookbook2:
        print("we're eating " + x)


def c():
    q = [1, 2, 3, "", "abc", "ABC", "Abc"]
    q.append('r') #添加
    q.insert(2,6) #插入
    if ("abc" in q and q[4] != q[5]):
        if (q[5].lower() != q[6].lower()):
            print("not okay")
        else:
            print("okay")
    else:
        print("12")


# if else elif 语句的使用
def d(age):
    if (age < 4):
        print("免费")
    elif (age >= 4 and age < 18):
        print("5美元")
    else:
        print("10美元")


# 在函数中使用字典
def e():
    abc = {"it1": 123, "it2": 234, "color": "red", "food1": "apple"}
    print(abc)
    abc['gg'] = 'gg'
    print(abc)
    del abc["it2"]
    print(abc)
    print("\t我要开始循环了！")

    # 遍历abc
    for k, v in abc.items():
        print("key:" + k)
        print("value:" + str(v))

    for v in abc.values():
        print(v)

    names = ['jhon', 'jason', 'zhangsan']
    favorite = {"jhon": "java", "zhanghai": "css", "jason": "python", "lee": "C++"}
    for name in favorite.keys():
        if name in names:
            print("Hi," + name, "! I saw your favorite language: " +
                  favorite[name].title() + "!")

    s = favorite.values()
    print(s)  # dict values类型
    print(list(s))  # 转化成list类型


def f():
    # 列表中存放字典
    shanghai = {"name": "sjhanghai", "renkou": "2kw", "mianji": 1.06}
    hangzhou = {"name": "hangzhou", "renkou": "1kw", "mianji": 3.26}
    suzhou = {"name": "suzhou", "renkou": "0.8kw", "mianji": 0.89}
    city = [shanghai, hangzhou, suzhou]
    print(city)

    # 字典中存放列表
    s1 = [1, 2, 3, 4, 5, 6]
    s2 = ["apple", "orange", "purple"]
    s3 = ["red", "green", "pink"]
    dic = {"k1": s1, "k2": s2, "k3": s3}
    for keys in dic.keys():
        for keys in dic.keys():
            for m in dic[keys]:
                print(m)

            print("the key is: " + keys)

    # 字典中存放字典
    d1 = {"name": "jhon", "age": 23}
    d2 = {"lan": "java", "pop": 1}
    d3 = {"city": "hangzhou", "area": "25000km^2"}
    adic = {"people": d1, "language": d2, "city": d3}
    print(adic)
    for bigkey in adic.keys():
        for key, value in adic[bigkey].items():
            print("key is: " + str(key) + ", values is: " + str(value) + "\n", end='')

        print("123 ", end='')


# 函数中的参数，默认参数，位置参数
def people(name, age, address="hangzhou"):
    print("people's infomaition:" + name + "," + age, +"," + address)


# 任意数目的实参调用，多余的参数使用元组tuple包装
def abc(name, age=24, *info):
    print(name, age, info)


# 任意数目的关键字实参，形成键值对，多余的参数使用字典包装，一个星号在前，两个星号在后
def efg(name, *info, **other):
    print(name, info, other)

# 对于字典的操作
def aboutdict():
    a={"name":"zhangsan","age":24}
    b={"f1":"apple","f2":"orange"}
    c={"cityname":"hangzhou","area":"3600km^2"}
    adict={"people":a,"fruit":b,"city":c}
    print(adict)
    for x in adict.keys():
        print("the big key is: "+x)
        for y,z in adict[x].items():
            print("the key is: "+str(y)+", the value is: "+str(z)+"\t", end="")


if __name__ == "__main__":
    a0()
    a()
    b()
    c()
    d(4)
    e()
    f()
    abc("zhanghai", 20, "123", "hha", "mg")
    abc("lee", "123", "hha", "mg")
    efg('li', "男", 24, address="杭州", pets="jvmdog", home="suzhou")
    efg('MIL', "java", "男", 14, address="Hongkong", pets="lfox", home="HK")
    aboutdict()

```

2.类的定义，使用与继承
- 类是面向对象的基础，Python定义类的方法如示例中所示，"""所包裹起来的是类的说明文档，每个类必须有一个==__init__(self)==方法，其中的参数最少为一个**self**,表示其本身，类定义时，其后的括号中表示的是==**父类**==,++每个Python类只能有一个而且必须只有一个\__init\__()方法， ++，结合Python中的\*，\**任意多个参数与任意多的==关键字==参数方法，就可以实现多态。另外需要注意的是，如果需要使用父类的\__init\__()方法，就需要使用super().\__init____()方法，如果有新的成员变量，在以上句子之后添加，++super()的引用必须放在第一行++，其他的方法如果子类不选择重写，那么也可以直接调用父类的方法。

==dogclass ==
```python
class Dog():
    """a class example"""
    def __init__(self,n,a):
        """初始化属性name和age"""
        self.name=n
        self.age=a

    def sit(self):
        print(self.name.title()+" is sitting now!")

    def walk(self):
        print(self.name.title()+" is walking now!")

    #修改属性
    def upage(self,a):
        if a>self.age:
            self.age=a
        else:
            print("不能修改变小！")

    def info(self):
        print("the dog is:"+self.name+", and it's age is:"+str(self.age))

class ShibaDog(Dog):
    '''继承的例子1'''
    def __init__(self,n,a):
        super().__init__(n,a)

    def maimeng(self):
        print("我是一只可爱的柴犬！")

class TianyuanquanDog(Dog):
    '''继承的例子2'''
    #def __init__(self,n,a):
    #    super().__init(n,a)

    def __init__(self,n):
        self.name=n

    def __init__(self,n,a,m):
        self.name=n
        self.age=a
        self.master=m

    def wang(self):
        print("汪汪汪！")

    def masterinfo(self):
        print("my master is:"+self.master)

    mydog=Dog("JVM",12)#创建对象
    mydog.info()
    mydog.sit()
    mydog.walk()
    yourdog=Dog("Lili",18)
    yourdog.info()
    yourdog.name="Lucy"#直接修改属性
    yourdog.upage(6)#使用方法修改属性
    yourdog.info()

    shiba=ShibaDog("Bug",11)
    shiba.maimeng()

    #huang=TianyuanquanDog("小黄",12)
    bai=TianyuanquanDog("小白")
    hei=TianyuanquanDog("小黑",18,"xin")

    #huang.info()
    bai.wang()
    hei.masterinfo()
    hei.info()

```

3.Python类中的方法与变量
- 如下，后续补上

==variable_and_method_inclass1.py==

```python
class CCC():
    auth = "hello"  # 类变量

    def __init__(self):
        self.person = "jzm123"  # 实例变量

    def instance_printauth(self):  # 实例方法
        print("成员方法:" + self.auth)

    @classmethod
    def class_printauth(cls):  # 类方法
        print("类方法:" + cls.auth)

    @staticmethod
    def static_printauth():  # 静态方法
        print("静态方法:" + CCC.auth)

    def use_membervariable(self):
        print("成员变量" + self.person)


if __name__ == "__main__":
    ccc = CCC()
    print("---静态方法，对参数无要求---")
    ccc.static_printauth()
    CCC.static_printauth()
    print("---类方法，第一个参数为类，可由类或者对象调用---")
    ccc.class_printauth()
    CCC.class_printauth()
    print("---成员方法，只能由对象调用---")
    ccc.instance_printauth()
    print("---类变量---")
    print("类变量:CCC.auth=" + CCC.auth)  # 类变量
    print("---实例变量---")
    print("实例变量:ccc.person=" + ccc.person)  # 实例变量
    ccc.person = "xxx"
    ccc.auth = "1222er"
    print("实例变量:ccc.person=" + ccc.person)  # 实例变量
    print("类变量:CCC.auth=" + CCC.auth)  # 类变量
    CCC.auth = "ggg"
    print("类变量:CCC.auth=" + CCC.auth)  # 类变量

    ppp = CCC()
    print("实例变量:ppp.person=" + ppp.person)  # 实例变量
    print("类变量:CCC.auth=" + CCC.auth)  # 类变量

```

==variable_and_method_inclass2.py==

```python
# coding=utf-8
class People():
    sex = "man"  # 类变量

    def __init__(self):
        self.age = 10  # 成员变量

    def work(self):
        city = "Chongqing"  # 方法局部变量，无法被实例访问，只能在函数内使用
        self.salary = 5000  # 不调用work()方法，无法访问salary

    @classmethod
    def classinfo(cls):
        print("类方法可以访问类变量" + cls.sex)  # 类方法可以访问类变量
        print("类方法无法访问成员变量")  # 类方法无法访问成员变量

    @staticmethod
    def staticinfo():
        print("静态方法可以访问类变量" + People.sex)  # 静态方法也可以访问类变量


# 这是在类之外的方法
def speak():
    print("Hello Python world!")  # 普通函数无法访问成员变量


if __name__ == '__main__':
    Lee = People()
    print(People.sex)  # 类可以直接访问类变量
    print(People.sex)  # 实例也可以访问类变量
    print("类无法访问成员变量")
    print(Lee.age)  # 成员变量需要实例化才可访问
    print(Lee.work())  # 成员变量需要实例化才可访问,调用相应的方法，才可以使用具体的局部变变量
    People.classinfo()  # 类方法 和 静态方法都可以访问类变量
    People.staticinfo()
    speak()
```

4.异常


  5.IO操作

6.单元测试


ref:
[python类中普通方法，类方法，静态方法](http://blog.csdn.net/y_angpeng/article/details/38168635),
[Python的类方法,静态方法,实例方法,类变量,实例变量,静态变量的总结](http://blog.csdn.net/imba123456789/article/details/54150812)
