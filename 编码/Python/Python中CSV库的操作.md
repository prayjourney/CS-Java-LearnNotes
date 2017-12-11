###Python中CSV文件的操作

***

##### CSV文件

CSV是Comma-Separated Values的缩写，CSV文件格式是一种通用的电子表格和数据库导入导出格，是用文本文件形式储存的表格数据，比如如下的表格：

![tablecontent](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_tablecontent.jpg)

就可以存储为csv文件，文件内容是：

```excel
No.,Name,Age,Score
1,mayi,18,99
2,jack,21,89
3,tom,25,95
4,rain,19,80
```



##### CSV方法对象介绍
CSV模块之中常用的方法对象，介绍如下

| 方法             | 对象                                | 作用                      | 备注                |
| -------------- | --------------------------------- | ----------------------- | ----------------- |
| csv.reader()   | -                                 | 获得csv模块的**普通**读对象       | csv模块的方法          |
| csv.writer()   | -                                 | 获得csv模块的**普通**写对象       | csv模块的方法          |
| *writerow(f)*  | -                                 | 所获得的普通写对象的方法，一次写入**一**行 | -                 |
| *writerows(f)* | -                                 | 所获得的普通写对象的方法，一次写入**多**行 | -                 |
| -              | csv.DictReader(self, f)           | 获得csv模块的**字典读**方法       | csv模块的DictReader类 |
| -              | csv.DictWriter(self,f fieldnames) | 获得csv模块的**字典写**方法       | csv模块的DictWriter类 |
| -              | *writeheade(self)*                | 所获得的字典对象的方法，一次写入**多**行  | -                 |
| -              | *writerow(self, rowdict)*         | 所获得的字典对象的方法，一次写入**一**行  | -                 |
| -              | *writerows(self, rowdicts)*       | 所获得的字典对象的方法，一次写入**多**行  | -                 |



##### CSV文件的操作
**读**: 分为普通的读和字典读

普通读
```python
# 读取
# 注意从csv读出的都是str类型
with open("mm.csv", "r") as rr:
    rer = csv.reader(rr)
    # 整体读取
    # for x in rer:
    #     print(x)

    # 整体读取，打印某一行，某一行的某一个
    column = [row for row in rer]
    print(column[2])
    print(column[2][2])
    # column = []
    # i = -1
    # for row in rer:
    #     i = i + 1
    #     print(row, i)
    #     if i == 2:
    #         column = row[1]  # 读取第2行第2列
    # print("===")
    # print(column)
```

字典读
```python
# 字典读
with open('dic.csv', 'r') as dcir:
    dr = csv.DictReader(dcir)
    # column1 = [row for row in dr]  #读取所有的行
    column2 = [row['Name'] for row in dr]  # 读取所有行的'Name'列
    # print(column1)
    print(column2)
```


**写**: 分为普通的写和字典写

普通写
```python
# 写入
with open("mm.csv", 'w') as ww:
    wtr = csv.writer(ww)
    fff = ('123', 'rth', '123er')
    hello = ("12312312312", 'gdsf')
    wtr.writerows(fff)  # 每个位置占有一个格子，比如1，2，3
    wtr.writerow(hello)  # 每个逗号前面的数据占有一个格子，比如12312312312，gdsf
```

字典写
```python
# 字典写
with open("dic.csv", "w") as dw:
    header = ['No.', 'Name', 'Age', 'Score']
    dww = csv.DictWriter(dw, header)  # 此处需要加入头

    # 一个字典
    row = {'No.': '5', 'Age': '18', 'Score': '99', 'Name': '张三'}
    # 一个字典组
    rows = [{'No.': '1', 'Age': '18', 'Score': '99', 'Name': 'mayi'},
            {'No.': '2', 'Age': '21', 'Score': '89', 'Name': 'jack'},
            {'No.': '3', 'Age': '25', 'Score': '95', 'Name': 'tom'},
            {'No.': '4', 'Age': '19', 'Score': '80', 'Name': 'rain'}]
    dww.writeheader()  # 写入头
    dww.writerow(row)  # 写一个字典
    dww.writerows(rows)  # 写一个字典组
```



ref:
1.[Python CSV操作](http://blog.csdn.net/hitwangpeng/article/details/68489123),   2.[Python CSV模块简介](http://www.cnblogs.com/nisen/p/6155492.html)