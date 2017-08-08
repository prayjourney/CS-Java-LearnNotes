### Python基本语法
- - -

1.基本的数据结构和函数的定义
- 具体的内容在如下的代码之中,在注释之中有一般用法的说明，其中**# -\*- coding=utf-8 -\*-**，是==编码==注释，需要放在第一行列，这样的话就中文就不会显示乱码，另外在Python之中，单行注释使用**\#**,多行的注释也是使用**\#**，文档注释使用=='''==或者=="""==,可以使用__doc__()方法来提取。
- 三种基本的数据结构，*元组，列表，字典*

|         名称     |       定义     | 使用其中的元素|特点 |
|-----------------|---------------|-------------|--------|
| 元组(tuple)      | t=(1,2,"rrr") |    t[1]   | *不可修改*|
| 列表(list)       | **l**=[1,2,"rrr"] | l[0]| **可以修改**|
| 字典(dictionary) |  d={"name":"123","age":24} ,d={}| d[name]|**可以修改，键值对**|
| 集合(set)|s=set(),s=set(**l**) |*一般是循环* |++其中的值不能重复++ |

2.函数的定义和注意事项
函数使用==def==定义，如下定义了函数abc()，无参数，函数可以返回返回值，使用return，在Python之中，返回的类型，函数的返回值类型，不需要标注，直接返回即可，另外还可以返回元组，字典，集合等高级的数据结构，函数的参数也不需要指出其参数的类型，直接传输即可，也可以以元组，字典等为参数用以传递。
```python
def abc():
	pass
def fun1(str1,str2):
	return str1+str2  #返回值

s=(1,2,3,4,1,"18","eee")
def printfun(p):
    print(p)

printfun(s) #元组作为参数

```

3.函数的参数种类
  - 普通参数：参数分为**形参**和**实参**，形参在函数的声明中体现，实参在函数的调用之中体现，定义的时候是形参，使用的时候是实参。
  ```python
     #声明函数：形参
     def printstr(str1,str2):
         print(str1+","+str2)

     #函数调用:实参
     printstr("hello","python")
  ```
  - 默认参数：我们定义的函数之中，参数可以有很多，我们可以对其中的一些参数赋一个默认值，这样我们调用的时候可以不对这个参数赋值，也可以赋值，来替换默认值。
  ```python
     #函数定义，num3=100，num3为默认参数
     def count(num1,num2,num3=100):
         allcount=num1+num2+num3
         print("allcount="allcount)

     #函数调用，使用默认值，赋新值
     count(1,50)#使用默认值，输出151
     count(1,400,20)#赋新值，输出421
  ```
  - 位置参数：当我们的函数中有很多参数时候，尤其是各个参数的含义有比较大的差异的时候，位置更为重要，所以，位置的顺序很重要，因此把其叫做*位置参数*。
  ```python
     #位置实参，其位置顺序很重要
     def yourinfo(name,age,address):
        print("your name is: "+name+", age is: "+
               age+" ,address is: "+address)

     yourinfo("Lucy",24,"上海")
     yourinfo("张三",22,"重庆")
     yourinfo(22,"海燕","杭州") #Error
  ```
  - 关键字参数：关键字参数，在传递给函数时是**名---值**对，直接在调用时将名称和值关联了起来，*这样就可以防止位置参数中的混淆的问题了*。
    ```python
     #位置实参，其位置顺序很重要
     def profile(name,age,city):
        print("your name is: "+name+", age is: "+
               age+" ,address is: "+address)

     profile(name="Lucy",age=24,city="上海")
     profile(name="张三",age=22,city="重庆")
  ```
  - 任意多的参数：当我们的函数要处理的参数很多时候，我们可以定义任意多参数的函数，这样也算是一种实现*"多态"*的方式，也很方便，Python对参数的数量在理论上是没有限制的。
  ```python
     #任意多的参数
     def animal(*name):
         '''将animal name 打印 '''
         print(name)

     animal("tiger")
     animal("tiger","pander","horse","pig","dog","cat")
  ```
  > 需要说明的是，在有任意多的参数的函数之中，不管有1个，2个或者是n个，所有的参数都将被封装在一个元组(tuple)之中，此处打印形成("tiger")和("tiger","pander","horse","pig","dog","cat")的样式，而非单个的animal name.

  - 任意多的参数和位置参数：位置参数其实就是普通的参数，对应的位置很重要，而任意多的参数，都将被封装在一个元组之中，这时，*重要的是位置参数和任意多参数的顺序*，**位置参数在前，任意多的参数在其后**。
  ```python
     def make_pizza1(size,*other):
         print("making a"+str(size)+
               "inch pizza with follow things:"+other)

     def make_pizza2(cooker,size,*other):
         print("I need"+ cooker + "make a"+str(size)+
               "inch pizza with follow things:"+other)

     make_pizza1(6,onion,tomato,peper)
     make_pizza2("Shilly",6,onion,tomato,peper)

  ```
  >位置参数在前，任意参数在后，其包装形式也是不同的

  - 任意多的关键字参数：任意数量的关键字实参，也是使用**名---值**对来表示的，其在理论上可以有任意多的数量也可以与==位置参数==、==任意数量的参数==一同使用，其顺序是<font color="red">1.位置参数，2，任意数量参数，3任意数量关键字参数</font>，在函数的定义中，使用"\**"来表示，其值封装在++字典++之中。
  ```python
         #定义
         def province_and_city1(**name):
             city={}
	         for key,value in ss.items():
		        abc[key]=value

             return city

         def province_and_city2(*country,**name):
             print(county)
             city={}
	         for key,value in ss.items():
		        abc[key]=value

             return city

         def province_and_city3(star,*country,**name):
             print(star)
             city={}
	         for key,value in ss.items():
		        abc[key]=value

             return city

             #调用
             province_and_city1(重庆="重庆",浙江="杭州"，
                                上海="上海",四川="成都")
             province_and_city2("美国","中国","日本"，
                        加利福尼亚="旧金山",本州="东京",
                        重庆="重庆",浙江="杭州"，
                        上海="上海",四川="成都")
             province_and_city3("地球","美国","中国","日本"，
                        加利福尼亚="旧金山",本州="东京",
                        重庆="重庆",浙江="杭州"，
                        上海="上海",四川="成都")
  ```
    >需要注意任意数量的关键字的赋值方法，其key不需要使用""所包围，赋值使用"=".

4.对于基本数据结构以及函数的使用案例
- ==hanshu.py==
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
                    print("key is: " + str(key) +
                    ", values is: " + str(value) + "\n", end='')

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

5.类的定义，使用与继承
- 类的定义是使用==class==关键字，其中必须有一个，而且仅有一个==\__init\__()方法，创建对象使用
    `
    a=A() or erson1=Person(name,age,gender)
    `
- 类是面向对象的基础，Python定义类的方法如示例中所示，"""所包裹起来的是类的说明文档，每个类必须有一个==__init__(self)==方法，其中的参数最少为一个**self**,表示其本身，类定义时，其后的括号中表示的是==**父类**==,<font color="blue">++每个Python类只能有一个而且必须只有一个\__init\__()方法</font>++，结合Python中的\*，\**任意多个参数与任意多的==关键字==参数方法，就可以实现多态。另外需要注意的是，如果需要使用父类的\__init\__()方法，就需要使用super().\__init____()方法，如果有新的成员变量，在以上句子之后添加，++super()的引用必须放在第一行++，其他的方法如果子类不选择重写，那么也可以直接调用父类的方法。
- 类的使用示例：==dogclass ==

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

6.Python类中的方法与变量
- | 类中的方法 | 方法的表示 |方法的访问|类中的变量|变量的表示|变量的访问|
  |--------|--------|--------|--------|--------|--------|
  |  成员方法 | def(self,a,b)  |  对象   |   ----   |  ----   |  ----   |
  |  类方法  | @classmethod 修饰  |    对象，类   |   ----   |  ----   |  ----   |
  |  静态方法 | @staticmethod 修饰  |    类   |   ----   |  ----   |  ----   |
  |   ----   |  ----   |  ----   | 类变量     |  类的方法之外定义  | 类，对象    |
  |   ----   |  ----   |  ----   | 成员变量     | 类的\__init\__()方法之中定义   |  对象   |
  |   ----   |  ----   |  ----   | 方法局部变量     |  类的方法中定义  |  对象调用的方法   |
- 类的变量的使用示例：
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
		#运行
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

7.异常
8.IO操作
9.单元测试
10.标准库学习指南


ref:
[python类中普通方法，类方法，静态方法](http://blog.csdn.net/y_angpeng/article/details/38168635),
[Python的类方法,静态方法,实例方法,类变量,实例变量,静态变量的总结](http://blog.csdn.net/imba123456789/article/details/54150812),
[ Python中\*args 和\**kwargs的用法](http://blog.csdn.net/chenjinyu_tang/article/details/8136841),
[Python函数的各种参数(含星号参数)](http://bbs.fishc.com/thread-67011-1-1.html)  
