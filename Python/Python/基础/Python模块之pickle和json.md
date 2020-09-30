### Pickle&JSON

#### pickle模块
pickle是腌制的意思，也就是**对象的序列化**，将动态的对象，保存在一个可以永久存储的文档之中（二进制或者文本）,这样可以*方便我们在网络之中的传输，便于在文件系统之中的永久保存*。

##### 主要方法
主要的函数有**dump**和**load**方法以及**dumps**和**loads**方法，分别表示将对象腌制成一个序列化的对象，表示从一个序列化对象加载出对象，pickle的操作，一般而言都和IO有关系，而且是二进制模式的IO。主要的方法签名如下

| 方法签名                                     | 作用                                       |
| :--------------------------------------- | :--------------------------------------- |
| *dump(obj, file, protocol=None, \*, fix_imports=True)* | 将一个Python对象序列化到一个符合pickle规范的文件之中，**对象和文件的交互**，在文件系统之中 |
| *dumps(obj, protocol=None,\*, fix_imports=True)* | 将一个Python对象序列化到一个符合pickle规范的对象，**对象和string对象的交互**，在内存文件之中 |
| *load(file, \*, fix_imports=True, encoding='ASCII', errors='strict')* | 将一个符合pickle规范的文件，反序列化成为一个Python对象，**对象和文件的交互**，在文件系统之中 |
| *loads(data, \*, fix_imports=True, encoding='ASCII', errors='strict')* | 将一个符合pickle规范的对象，反序列化成为一个Python对象，**string对象和对象的交互**，在内存之中 |

##### 场景
pickle模块的主要作用是，可以将一些状态保存下来，然后在下一次打开的时候，将其加载出来，保存之前的状态，比如游戏场景，记录退出之前的情况在下次登录时直接加载

##### 扩展
扩展可以继承**Pickler**和**Unpickler**类，来根据需要进行扩展

##### 应用

```python
#pickle模块的主要作用是，可以将一些状态保存下来，然后在下一次打开的时候，将其加载出来，保存之前的状态，比如游戏场景
import pickle
data1 = {'a': [1, 2.0, 3, 4+6j],'b': ('string', u'Unicode string'),'c': None}
print(data1)
#写入
path="d:\\pickle.pkl"
try:
    fi=open(path,'wb')#写入此文档
    pi=pickle.dump(data1,fi)
    print("写入成功！")
except PickleError:
    print("写入失败！")

#读取
fo=open(path,'rb')
dataload=pickle.load(fo)#此处从文档中读取出来
print(dataload,"读取成功！")

#dumps和loads主要是对象和内存的交互，而dump和load主要是对象和文件系统的交互
data2=[1,2,3,4,(1,2,3),"hello",[1,2,'h','p']]
d2=pickle.dumps(data2)
print(d2)
hh=pickle.loads(d2)
print(hh)
if(hh==data2):
    print("hh==data2")

#此处尚未涉及到pickle扩展的情况
```



#### json模块
json(Java Script Object Notation)是一种轻量级**数据交互格式**，相对于XML而言更简单，易于阅读和编写，方便解析和生成，json是JavaScript中的一个子集，*json最广泛的应用是作为AJAX中web服务器和客户端的通讯的数据格式*。python2.6版本开始加入了json模块，python的json模块序列化与反序列化的过程分别是encoding和decoding。encoding: 把一个**python对象**编码转换成**json字符串**，decoding: 把**json格式字符串**编码转换成**python对象**。

##### 主要方法
主要的函数有**dump**和**load**方法以及**dumps**和**loads**方法，分别表示将对象腌制成一个序列化的对象，表示从一个序列化对象加载出对象，json的操作有两种，一种是文件的操作，一种是在内存中操作。主要的方法签名如下

| 方法签名                                     | 作用                                       |
| :--------------------------------------- | :--------------------------------------- |
| *dump(obj, fp, skipkeys=False, ensure_ascii=True, check_circular=True, allow_nan=True, cls=None, indent=None, separators=None, default=None, sort_keys=False, \*\*kw)* | 将一个**Python对象序列化成一个Json格式的字符串流，并写入文件之中**，**对象和文件的交互**，在文件系统之中 |
| *dumps(obj, skipkeys=False, ensure_ascii=True, check_circular=True, allow_nan=True, cls=None, indent=None, separators=None, default=None, sort_keys=False, \*\*kw)* | 将一个**Python对象序列化成一个Json格式的字符串**，**对象和对象的交互**，在内存之中 |
| *load(fp, cls=None, object_hook=None, parse_float=None, parse_int=None, parse_constant=None, object_pairs_hook=None, \*\*kw)* | 将一个**Json格式的字符串流，反序列化成一个Python对象，从文件之中读取**，对象和文件的交互，在文件系统之中 |
| *loads(s, encoding=None, cls=None, object_hook=None, parse_float=None, parse_int=None, parse_constant=None, object_pairs_hook=None, \*\*kw)* | 将一个**Json格式的字符串，反序列化成一个Python对象，对象和对象的交互**，在内存之中 |

##### 类型对应
Json和Python之中数据类型的对应情况，如下表
Json字符串(流)反序列化成Python对象

|     JSON      | Python |
| :-----------: | :----: |
|    object     |  dict  |
|     array     |  list  |
|    string     |  str   |
| number (int)  |  int   |
| number (real) | float  |
|     true      |  True  |
|     false     | False  |
|     null      |  None  |

Python对象序列化成Json字符串(流)

|   Python    |  JSON  |
| :---------: | :----: |
|    dict     | object |
| list, tuple | array  |
|     str     | string |
| int, float  | number |
|    True     |  true  |
|    False    | false  |
|    None     |  null  |
##### 场景
json一种轻量级*数据交互格式*，在服务器和客户端之间的数据传输是它的一种最广泛而且重要的应用，另外其也是一种序列化的方式(*将对象，存储成为一种可以长期保留的格式，需要时可以随时加载，并且可以复原其当时的状态*)，从这点而言，其和pickle有点相似，但是更多的来说，json是一种通用的数据交互格式，它的重点作用在于数据的传输而非序列化功能

##### 扩展
扩展可以继承**JSONEncoder**和**JSONDecoder**类，来根据需要进行扩展

##### 应用

```python
import json
#所要涉及的对象，数据，要符合json的语法规范，文档也要符合json规范，才能够正确的编码和解析
#python--->json
dic={"month":1,"age":23,"year":2018,"weekday":"sat","national":"Han"}
tu=(51,22,3,4,5,66,2,-99,21)
li=['1gg',2,3,'hi','ff',45]
print(type(dic),type(tu),type(li))#测试类型
print(dic)
print(tu)
print(li)
jdic=json.dumps(dic)#dumps函数
jtu=json.dumps(tu)#对象和对象之间的转换，在内存之中
jli=json.dumps(li)
print(type(jdic),type(jtu),type(jli))#测试类型，但是其实此处都会是str，这个str是JSON形式的str
print(jdic)
print(jtu)
print(jli)
print("--------")
#json--->python
s1=json.loads(jdic)
s2=json.loads(jtu)
s3=json.loads(jli)
print(s1,type(s1),s2,type(s2),s3,type(s3))#好像json更倾向于和python的list一起转化

#对象和文件之间的转换
path="d:\\myjsontest.json"
data={"month":"Jan","age":23,"year":2018,"weekday":['1gg',2,3,'hi','ff',45],"hi":(51,22,3,4,5,66,2,-99,21)}
#使用with可以不用关心close的问题了
with open(path,"w") as ff:
    json.dump(data,ff)

with open(path,"r") as pp:
    sg=json.load(pp)
    print(sg,type(sg))

#此处尚未涉及到json扩展的情况
```



ref:

1.[python数据持久存储：pickle模块的基本使用](http://www.cnblogs.com/pzxbc/archive/2012/03/18/2404715.html), 2.[python pickle模块](http://www.cnblogs.com/cobbliu/archive/2012/09/04/2670178.html), 3.[Python3中的Json与Pickle](http://www.cnblogs.com/hjc4025/p/6511570.html),  4.[Json概述以及python对json的相关操作](http://www.cnblogs.com/coser/archive/2011/12/14/2287739.html),  5.[Python3 JSON 数据解析](http://www.runoob.com/python3/python3-json.html),  6.[用Python3处理JSON](http://blog.csdn.net/u011008379/article/details/48860047),  7.[【Python3.5】读写JSON格式的数据](http://blog.csdn.net/gamer_gyt/article/details/53577477)