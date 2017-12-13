### Python中xlsx文件的操作

***

**放弃xls而转型xlsx**。xlwt、wlrd只能读写xls文件，而不能操作xlsx文件。xlsx文件的读写使用**openpyxl**即可。这是一个非常简单的库，功能全面强大，使用openpyxl来操作xlsx格式的excel文档，至于以前的xls格式，暂时不去考虑，openpyxl是python官方推荐的excel处理包，还有xlwings也是一个流行的包，功能较为强大，可以处理VBA，Xlsxwriter样式丰富，但是只能创建，不能修改文档，总体而言，openpyxl是最为综合和全面的一个包



##### 基本概念

在openpyxl中，主要用到三个概念：**Workbooks，Sheets，Cells**。Workbook就是一个excel工作表；Sheet是工作表中的一张表页；Cell就是简单的一个格。openpyxl就是围绕着这三个概念进行的，不管读写都是“三板斧”：**1.打开Workbook，2.定位Sheet，3.操作Cell**。下面分读和写分别介绍几个常见的方法



##### 读文件

现有文件如下

![readsheet](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_readsheet.jpg)

首先用
```python
from openpyxl import load_workbook
```

引入库
```python
wb = load_workbook("template.xlsx")
```

打开一个xlsx文件
```python
print(wb.sheetnames)    # ['Sheet1', 'Sheet2', 'Sheet3']
```

可以看看打开的excel表里面有哪些sheet页
```python
sheet = wb.get_sheet_by_name("Sheet3")
```

读取到指定的Sheet页，想要的内容都在这里。比如
```python
print(sheet["C"])
# (<Cell Sheet3.C1>, <Cell Sheet3.C2>, <Cell Sheet3.C3>, <Cell Sheet3.C4>, <Cell Sheet3.C5>, <Cell Sheet3.C6>, <Cell Sheet3.C7>, <Cell Sheet3.C8>, <Cell Sheet3.C9>, <Cell Sheet3.C10>)      <-第C列
print(sheet["4"])
# (<Cell Sheet3.A4>, <Cell Sheet3.B4>, <Cell Sheet3.C4>, <Cell Sheet3.D4>, <Cell Sheet3.E4>)     <-第4行
print(sheet["C4"].value)    # c4     <-第C4格的值
print(sheet.max_row)        # 10     <-最大行数
print(sheet.max_column)     # 5      <-最大列数
for i in sheet["C"]:
    print(i.value, end=" ")
# c1 c2 c3 c4 c5 c6 c7 c8 c9 c10     <-C列中的所有值
```



##### 写文件

首先用
```python
from openpyxl import Workbook
wb = Workbook()
```

创建一个工作表，然后使用如下代码激活默认创建的一个sheet，创建一个Workbook，默认有一个sheet
```python
sheet = wb.active
```

找到活动的sheet页。空的excel表默认的sheet页就叫Sheet，如果想改名字，可以直接给title属性赋值
```python
sheet.title = "New Shit"
```

这个属性是可读可写的。当然，这个只针对当前活动页，别的页的话，可以用create_sheet和remove_sheet进行添加和删除。往sheet页里面写内容就比较简单了，跟上面读一样

```python
sheet['C3'] = 'Hello world!'
for i in range(10):
  sheet["A%d" % (i+1)].value = i + 1
```

我们还可以进行花式操作，比如写写公式
```python
sheet["E1"].value = "=SUM(A:A)"
```

最后记得保存
```python
wb.save('保存一个新的excel.xlsx')
```

显示效果如下

![writesheet](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_writesheet.jpg)



##### 例子
```python
# -*- coding:utf-8 -*-
"""
使用openpyxl来操作xlsx格式的excel文档
至于以前的xls格式，暂时不去考虑
openpyxl是python官方推荐的excel处理包
还有xlwings也是一个流行的包，功能较为强大，可以处理VBA
Xlsxwriter样式丰富，但是只能创建，不能修改文档
总体而言，openpyxl是最为综合和全面的一个包
"""

'''
在openpyxl中，主要用到三个概念：Workbooks，Sheets，Cells。
Workbook就是一个excel工作表；Sheet是工作表中的一张表页；Cell就是简单的一个格。
openpyxl就是围绕着这三个概念进行的，
不管读写都是“三板斧”：打开Workbook，定位Sheet，操作Cell。
下面分读和写分别介绍几个常见的方法。
'''

'''
不管是读取还是写入，如果文件是打开的状态，则会报"文件无权限访问"的bug
'''

# 写入
# 关于导入的问题：
# 1.一般而言，一个包之中，类名是不会重复的，所以，我们可以使用["from 包名 import 类名"]的方式来导入
# 2.当一个包里面有子包名和类名重复的时候，我们为了做一个明显的区别，可以使用["from 包名.子包名 import 类名"]的方式来导入
# 更加极端一点，在以上的例子之中我们可以有多个子包名，形成了“包名.子包名.子包名...子包名”的 模式
# 3.还有一种不标准的方式，就是只是并导入子包名，然后使用子包名来引用其中的方法和类，这种方式一般不太推荐
# 但是一般而言，我们都是采用第一种["from 包名 import 类名"]的方式来导入，如下的
# 1.from openpyxl.workbook import Workbook 其实和2.from openpyxl import Workbook等价
# 当然也和3.from openpyxl import workbook等价,但是在下面的使用之中，就要使用wb = workbook.Workbook()的方式来引用
# 而1，2两种方式则只需要使用wb = Workbook()这种模式来引用类之中的方法即可
# 1中的workbook是子包名，Workbook是类名，3之中的workbook也是子包名
# from openpyxl import workbook
# from openpyxl.workbook import Workbook

from openpyxl import Workbook, load_workbook
from openpyxl.drawing.image import Image
from openpyxl.styles import Alignment, Font
# 写入
wb = Workbook()  # 创建一个工作簿，一个工作簿创建好之后，默认就有一个sheet
# wb = workbook.Workbook()
sheet = wb.active  # 激活当前的sheet
sheet.title = "默认创建的sheet"
sheet['C3'] = ' hello     world!'
sheet2 = wb.create_sheet("自己创建的sheet2")
sheet2.sheet_properties.tabColor = "1072BA"  # 设置了sheet的属性
sheet2['A3'].value = 'hello'  # 此处设置为A3正确，但是设置为3A错误，说明是先列后行
for x in range(10):
    sheet["A%d" % (x + 1)].value = x + 1

sheet['E1'].value = "=SUM(A:A)"
for st in wb:  # 打印标题
    print(st.title)

# 插入图片，需要PIL库支持
sheet2['E2'] = 'You should see three logos below'
img = Image('mg.jpg')
sheet2.add_image(img, 'E2')


# 样式设置，字体大小
font = Font(name="小米兰亭", size=20)
sheet2.cell(row=3, column=1).font = font

wb.save("myfrist.xlsx")  # 保存

# 读取
wr = load_workbook("myfrist.xlsx")
print(wr.sheetnames)
print(sheet['C'])
print(sheet[1][2])  # 从1开始，而非从0开始
print(sheet[1][2].value)  # excel是行优先还是列优先？--->先列后行
print(sheet['C3'].value)  # C3 <-第C3格的值
print(sheet.max_row)  # 10   <-最大行数
print(sheet.max_column)  # 5  <-最大列数
# 打印
for i in sheet['A']:
    print(i.value, end="=")

ss = wr.get_sheet_by_name('自己创建的sheet2')
ss['C4'] = "MLGB"
ss.append([1, 2, "hello"])  # 添加三个cell数值,一般要求添加的格式是list,tuple,dict,不能是str
# ss.append({"hi": "你好"})  # 添加一个值
# 遍历多个单元格
for row in ss.iter_rows('A1:D2'):
    for cell in row:
        print(cell)
# 使用sheet中的cell来操作Cell
md1 = ss.cell('A3').value
mdc = ss.cell(row=4, column=3)
md2 = mdc.value
print("====", md1, md2)

wr.save("myfrist.xlsx")

```



ref:

xls格式文档处理(此处未涉及)

1.[python操作Excel的几种方式](http://www.cnblogs.com/lingwang3/p/6416023.html),   2.[python操作Excel读写--使用xlrd](http://www.cnblogs.com/lhj588/archive/2012/01/06/2314181.html),   3.[python操作excel表格(xlrd/xlwt)](http://www.cnblogs.com/zhoujie/p/python18.html)

xlsx格式文档处理(openpyxl)

1.[用python读写excel的强大工具：openpyxl](http://www.cnblogs.com/anpengapple/p/6399304.html),   2.[ openpyxl Simple usage](http://openpyxl.readthedocs.io/en/default/usage.html#fold-columns-outline),   3.[OpenPyXL的使用教程（一）](http://www.jianshu.com/p/642456aa93e2),   4.[Python处理Excel文档之openpyxl](http://www.jianshu.com/p/b1983be87f56),   5.[Python 与 Excel 不得不说的事](https://zhuanlan.zhihu.com/p/22261597),   6.[Python-Excel 模块哪家强？](http://www.jianshu.com/p/be1ed0c5218e)

xlsx格式文档处理(xlwings) 

1.[xlwings Quickstart](http://docs.xlwings.org/en/stable/quickstart.html),   2.[插上翅膀，让Excel飞起来——xlwings（一）](http://www.jianshu.com/p/e21894fc5501),   3.[插上翅膀，让Excel飞起来——xlwings（二）](http://www.jianshu.com/p/b534e0d465f7),   4.[插上翅膀，让Excel飞起来——xlwings（三）](https://www.jianshu.com/p/de7efe591c12),   5.[插上翅膀，让Excel飞起来——xlwings（四）](http://www.jianshu.com/p/7d6f53e3e6e9),   6.[xlwings 让你的 Excel 飞起来](https://zhuanlan.zhihu.com/p/25810634)