### Python import的问题

***

##### python文件的组成

1.模块(module)
模块是文件的最小组织形式，就是说，每个python的函数，类，所构成的一个文档，就是一个模块(module)，可以作为module的文件类型有`.py`, `.pyo`, `.pyc`, `.pyd`, `.so` , `.dll`等

2.包(package)
通常包总是一个目录，可以使用import导入包，或者from xx import x来导入包中的部分模块。包目录下为首的一个文件便是 `__init__.py`。然后是一些模块文件和子目录，假如子目录中也有` __init__.py` 那么它就是这个包的子包了， `__init__.py`是一个包的标志，如果没有此 `__init__.py`文件，那么它就仅仅是一个文件夹，而非一个包，对于 `__init__.py`的要求很宽松，其中的内容为空也可以，但是更多的情况下，在这个文件之中包含的是一些初始化的定义



##### 模块的搜索路径
导入的模块，其路径都放在了模块的搜索路径之中，而**模块的搜索路径都放在了sys.path列表中**，如果缺省的sys.path中没有含有自己的模块或包的路径，可以动态的加入`sys.path.apend`即可。下面是sys.path在Windows平台下的添加规则

> 1.sys.path第一个路径往往是主模块所在的目录。在交互环境下添加一个空项，它对应当前目录，在交互式的情况下，我们得到的第一个目录是' '，这个就是表示当前目录

> 2.如果python path环境变量存在，sys.path会加载此变量指定的目录

> 3.我们尝试找到python home，如果设置了python home环境变量，我们认为这就是python home，否则，我们使用python.exe所在目录找到lib/os.py去推断python home。如果我们确实找到了python home，则相关的子目录(Lib、plat-win、lib-tk等)将以python home为基础加入到sys.path，并导入（执行）lib/site.py，将site-specific目录及其下的包加入。如果我们没有找到python home，则把注册表Software/Python/PythonCore/3.5/PythonPath的项加入sys.path（HKLM和 HKCU合并后加入），但相关的子目录不会自动添加的

> 4.如果我们没有找到python home，并且没有python path环境变量，并且不能在注册表中找到python home，那么缺省相对路径将加入（如：./Lib;./plat-win等）

也就是说
当在安装好的主目录中运行python.exe时，首先推断pythonhome，如果找到了pythonhome，注册表中的pythonpath将被忽略；否则将注册表的pythonpath加入，**如果PYTHONPATH环境变量存在，sys.path肯定会加载此变量指定的目录。**如果python.exe在另外的一个目录下（不同的目录，比如通过COM嵌入到其他程序），pythonhome将不推断，此时注册表的pythonpath将被使用。如果python.exe不能发现他的主目录(pythonhome)，并且注册表也没有pythonpath，则将加入缺省的相对目录



##### 模块的导入

1.在同一个目录或者sys.path
当一个模块要使用另一个包或者模块之中的功能，就需要导入另一个模块或者包，如果此两个模块或者包所在的目录为**同一目录**，或者都**在sys.path中**，_则可以直接导入_

2.不在同一个目录或者sys.path
当一个模块要使用另一个包或者模块之中的功能，就需要导入另一个模块或者包，如果此两个模块或者包所在的目录**不是同一目录**，或者**不在sys.path中**，*则需要将模块的搜索路径添加到sys.path之中*，然后才可以导入

3.导入包/模块
例如，`a.py`要导入`b.py`
**同一目录**: `import b `
**不同目录**: 首先需要使用`sys.path.append`方法将`b.py`所在目录加入到搜索路径下。然后进行import即可，例如 

```python
import sys
sys.path.append('c:\xxxx\b.py') # 这个例子针对 windows 用户来说的
```
大多数情况，上面的代码工作的很好。但是如果你没有发现上面代码有什么问题的话，可要注意了，上面的代码有时会找不到模块或者包(`ImportError: No module named xxxxxx`)，这是因为*sys模块是使用c语言编写的，因此字符串支持 '\n', '\r', '\t'等来表示特殊字符*。所以上面代码最好写成如下格式
```python
sys.path.append('c:\xxx\b.py') 
# 或者sys.path.append('c:/xxxx/b.py') 

```
这样可以避免因为错误的组成转义字符，而造成无效的搜索目录（sys.path）设置



##### 两种不同的导入方式

首先，需要说明的是import可以导入*模块(子模块)*，*类*，*方法*三种，常用的两种导入方式如下，我们所定义的模块的结构如下
```python
FC/
  __init__.py
  Libr/
    __init__.py
    one.py
    two.py
    ....
  Model/
    __init__.py
    one.py
    ....
```

1.import 语句导入
```python
在外部加载调用时，有以下方式：
#coding:utf-8
#加载方式一
import Fc.Libr.one
print (Fc.Libr.one.a)
```

2.from-import语句导入
```python
在外部加载调用时，有以下方式：
#加载方式二
from Fc.Libr import one   # 导入子包中的模块
print(one.a)
#加载方式三
from Fc.Libr.one import a
print(a)
#加载方式四
from Fc.Libr import *
print(one.a)
注意直接使用第四种方式是不能正确导入Libr下的one子模块的，这就需要在Fc目录下的__init__.py文件中定义好需要加载子模块的名称
Fc/Libr/__init__.py
__all__=['one','two'] #定义加载子模块的名称
```

3.import和from-import的区别

二者简单区别就是from-import导入的直接使用，不需要额外限定，而使用import导入的往往需要额外限定

> 下面是 from *module* import 的基本语法：
>
> > ```python
> > from module1 import Module1
> > ```
> >
> > 它与你所熟知的 import *module* 语法很相似，但是有一个重要的区别：`Module1` 被直接导入到局部名字空间去了，所以它可以直接使用，而不需要加上模块名的限定。你可以导入独立的项或使用 from *module* import * 来导入所有东西，而使用`imoprt module1`只是将这个包导入到了局部空间，如果需要使用`moudle1`之中的类，方法等则需要在这些类方法前面加上`module1`的限定，如同`module1.method1`，`module1.class1`样式
>
> *Dive Into Python*

用一个简单形象的例子解释就是
>`from datetime import datetime  `这行命令相当于，校长说：高三二班的 李伟出来，站在我面前
>
>`import datetime`这行命令相当于，校长说：高三二班，都站在我面前
>
>`from datetime import datetime` 中 调用 `datetime.now()` 成功是因为: 这个命令相当于，校长说:  李伟，现在是几点？ 因为就一个李伟站在他面前，能确定是哪个李伟
>
>`import datetime`   调用` datetime.now()` 失败是因为: 这个命令相当于，校长说: 李伟，现在是几点？ 可是校长面前，站了整个高三二班，没法知道是哪个李伟

*其实，深层次的原因是因为，每一个类，模块，包等都有一些如同`__name__`, `__contains__`, `__eq__`等的参数在起作用，另外就是命名空间的问题，这部分暂时还没有研究，涉及到的基础内容较多，暂时等有空了再去探究*



##### 注意
如果要同时导入多个模块，只需要在模块名之前用逗号进行分隔
```python
import module1,module2,module3.......
form x import moudle1,moudle2,method1,method2
```
而且如果当一个模块的`__init__.py`文件之中有内容，而且为`__all__`的话，则只是导入在`__all__`中含有的模块名，而不是一股脑完全导入



##### 另一篇文档之中的感受

```python
# 此处的openpyxl包是处理excel文件的官方推荐包(xlsx)
关于导入的问题：
1.一般而言，一个包之中，类名是不会重复的，所以，我们可以使用["from 包名 import 类名"]的方式来导入

2.当一个包里面有子包名和类名重复的时候，我们为了做一个明显的区别，可以使用["from 包名.子包名 import 类名"]的方式来导入，更加极端一点，在以上的例子之中我们可以有多个子包名，形成了“包名.子包名.子包名...子包名”的 模式

3.还有一种不标准的方式，就是只是并导入子包名，然后使用子包名来引用其中的方法和类，这种方式一般不太推荐

但是一般而言，我们都是采用第一种["from 包名 import 类名"]的方式来导入，如下的

1.from openpyxl.workbook import Workbook 其实和2.from openpyxl import Workbook等价

当然也和3.from openpyxl import workbook等价,但是在下面的使用之中，就要使用
wb = workbook.Workbook()的方式来引用

而1，2两种方式则只需要使用wb = Workbook()这种模式来引用类之中的方法即可
1中的workbook是子包名，Workbook是类名，3之中的workbook也是子包名

from openpyxl import workbook
from openpyxl.workbook import Workbook
```



ref:

1.[Python Import机制](http://www.cnblogs.com/zhepama/p/4146255.html),   2.[python 的import机制](http://blog.csdn.net/sirodeng/article/details/17095591),   3.[python基础之---import与from...import....](http://blog.csdn.net/sean_abc/article/details/20621417),   4.[python语法31module/package+import\]](http://www.cnblogs.com/itech/archive/2010/06/20/1760345.html),   5.[Python中import的使用](http://www.cnblogs.com/CheeseZH/p/5260608.html),   6.[python中 from . import ×××的那个点是表示当前包吗？](https://www.zhihu.com/question/28688151),   7.[Python的from import和import的区别？](https://www.zhihu.com/question/38857862)