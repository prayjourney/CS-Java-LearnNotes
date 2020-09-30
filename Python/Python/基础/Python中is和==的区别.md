### Python中is和==的区别

***

##### is 和==

`is` is the identity comparison. #比较引用是否相同

`==` is the equality comparison. #比较内容是否相同



##### 详解

Python中对象包含的三个基本要素,分别是：**id**(身份标识)，**type**(数据类型)和**value**(值)。is和==都是对对象进行比较判断作用的，但对对象比较判断的内容并不相同

**==**:   是python*标准操作符*中的比较操作符，**比较判断两个对象的value(值)是否相等**，例如下面两个字符串间的比较

```python
>>> a = 'cheesezh'
>>> b = 'cheesezh'
>>> a == b
True
```

**is**:   也叫做*同一性运算符*，**比较判断的是对象间的唯一身份标识，也就是id是否相同**。通过对下面几个list间的比较，你就会明白is同一性运算符的工作原理

```python
>>> x = y = [4,5,6]
>>> z = [4,5,6]
>>> x == y
True
>>> x == z
True
>>> x is y
True
>>> x is z
False
>>>
>>> print id(x)
3075326572
>>> print id(y)
3075326572
>>> print id(z)
3075328140
```

以上例子中的前三个比较都是True，这什么最后一个是False呢? x、y和z的值是相同的，所以前两个是True没有问题。至于最后一个为什么是False，看看三个对象的id分别是什么就会明白了，因为他们的value相同，但是id不同

下面再来看一个例子，例3中同一类型下的a和b的（a==b）都是为True，而（a is b）则不然

```python
>>> a = 1 #a和b为数值类型
>>> b = 1
>>> a is b
True
>>> id(a)
14318944
>>> id(b)
14318944
>>> a = 'cheesezh' #a和b为字符串类型
>>> b = 'cheesezh'
>>> a is b
True
>>> id(a)
42111872
>>> id(b)
42111872
>>> a = (1,2,3) #a和b为元组类型
>>> b = (1,2,3)
>>> a is b
False
>>> id(a)
15001280
>>> id(b)
14790408
>>> a = [1,2,3] #a和b为list类型
>>> b = [1,2,3]
>>> a is b
False
>>> id(a)
42091624
>>> id(b)
42082016
>>> a = {'cheese':1,'zh':2} #a和b为dict类型
>>> b = {'cheese':1,'zh':2}
>>> a is b
False
>>> id(a)
42101616
>>> id(b)
42098736
>>> a = set([1,2,3])#a和b为set类型
>>> b = set([1,2,3])
>>> a is b
False
>>> id(a)
14819976
>>> id(b)
14822256
```

通过以上的例子可看出，只有数值型和字符串型的情况下，a is b才为True，当a和b是tuple，list，dict或set型时，a is b为False



##### 其他

以前在学Java时，记得判断字符串是否相等要用equals(str)方法，而不能直接用==。**equals**判断的是*值*是否相同，**==**判断的是*引用*是否相同。内容相同的两个字符串其引用可能是不同的。

ref:

1.[Python中is和==的区别](http://www.cnblogs.com/CheeseZH/p/5260560.html),   2.[Python 中的 is 和 ==](http://www.cnblogs.com/restran/archive/2013/04/02/2996686.html)