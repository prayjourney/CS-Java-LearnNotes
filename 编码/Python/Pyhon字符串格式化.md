###Python字符串格式化
***
python之中字符串的格式化有两种方法，一种是py2之中常用的**%**，作为字符转换标识的方法，另一种是py3之中常用的**str.format()**方法，下面对此进行演示



#####py2的%方法
py2中对于字符串格式化的方法，来自于c语言，主要关键点有一点，就是**我们要格式化的字符串和字符串后面的给出来的参数，在同一个"str句子之中，其中的关联就是%”**，我们的参数，一般是放在**元组或者字典之中包裹起来**，如果不这样的话就会提示参数过多，这说明**%格式化方式，只接受“1”个参数**



#####py3的format方法
format方法来自于==*builtins.html#str*==，其方法引用如下，主要是通过对于args和kwargs参数的使用，下面函数的意思是，该函数返回一个使用args和kwargs格式化的字符串s，替换的部分是使用大括号{}来定义的
>format(...)
>S.format(*args, **kwargs) -> str
>Return a formatted version of S, using substitutions from args and kwargs.
>The substitutions are identified by braces ('{' and '}').



#####复杂的参数
py2
>复杂格式的参数
1. 格式化标识符 （%）
2. 对齐，默认右对齐，"-" 表示左对齐（-）
3. 最小域宽（10）
4. 精度（4）
5. 格式化类型（f）
- 1、5必须，2、3、4可选

py3
>复杂格式的参数
1. 格式化标识符 （{:}）
2. 占位符，默认为空格（!）
3. 对齐，默认右对齐，"<" 表示左对齐，">"表示右对齐， "^"表示居中
4. 最小域宽（10）
5. 精度（4）
6. 格式化类型（f）
- 1、6必须，2、3、4、5可选
具体的使用，见如下使用小例



#####应用
```python
# -*- coding:utf-8 -*-

# python字符格式化
# 格式化字符串时，Python使用一个字符串作为模板。模板中有格式符，这些格式符为真实值预留位置，并说明真实数值应该呈现的格式。


# python之中，格式化分为两种，一种是python2的%模式，一种是python3的format模式

# py2
# 一般情况下，我们只需要记住%d-->十进制数，%f-->浮点数，%s-->字符串
# 我们要格式化的字符串和要给予的参数，是在同一个字符串之中，其实就是没有逗号隔开
# Python用一个tuple将多个值传递给模板，每个值对应一个格式符

# 普通的格式化，使用位置对应
print("hello ,%s " % "python")
# 下面这句有问题，超过一个参数的时候，就需要使用元组或者字典，将参数包裹起来，这说明，格式化时候，只接受%后面有一个参数
# print("hello ,%s, i am %d" %"python" %18)
print("I am %s,%d years old! hello %s!" % ('pr', 26, 'python'))
print("I'm %s. I'm %d year old" % ('Vamei', 99))

# 格式化字典，使用key-value
print("I'm %(name)s. I'm %(age)d year old" % {'name': 'Vamei', 'age': 99})
print("hello %(aaa)s, 今天是%(day)d,  我用%(lan)s" % {'aaa': 'world!', 'day': 1, "lan": 'python'})

# 复杂格式的参数
# 1. 格式化标识符 （%）
# 2. 对齐，默认右对齐，"-" 表示左对齐（-）
# 3. 最小域宽（10）
# 4. 精度（4）
# 5. 格式化类型（f）
# 1、5必须，2、3、4可选
print("I come from %-30s, area is %20.6f km^2" % ('中国', 9600000))
print("===============")

# py3
# 按照默认位置
ss = "S.format(*args, **kwargs) -> str,\n {} a formatted version of S , using substitutions from {} and kwargs,\n \
       The {} are identified by braces ('左括号' and '右括号')".format("Return", "arg", "substitutions")
print(ss)

# 按照标记位置，一般是从0开始
mystring = "hello {0}, I love {0}, today is  {1}, everything will be {2} !".format("python", "Sat", "okay!")
print(mystring)

# 按照key-value
poem = "{a}依山尽，{b}入海流，欲穷{c}目，更上一层{d}".format(a="白日", b="黄河", c="千里", d="楼层")
print(poem)

# 复杂格式的参数
# 1. 格式化标识符 （{:}）
# 2. 占位符，默认为空格（!）
# 3. 对齐，默认右对齐，"<" 表示左对齐，">"表示右对齐， "^"表示居中
# 4. 最小域宽（10）
# 5. 精度（4）
# 6. 格式化类型（f）
# 1、6必须，2、3、4、5可选
intro = "I come from {0:#>40.4s}, area is {1:#^2.4f} km^2".format('中国', 9600000)
print(intro)
poemdict = "{a:>20.0s}依山尽，{b:10s}入海流，欲穷{c:25s}目，更上{d:#22.6f}层楼".format(a="白日", b="黄河", c="千里", d=1)
print(poemdict)

# 说明
# 整数类型不能有精度
# string类型可以有精度，但是没有作用
# string类型不能格式化成int，但是int类型可以转化为string类型
```