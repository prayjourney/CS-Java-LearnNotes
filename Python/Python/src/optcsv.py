# -*- coding:utf-8 -*-
import csv
import os

print(os.getcwd())
# 写入
with open("mm.csv", 'w') as ww:
    wtr = csv.writer(ww)
    fff = ('123', 'rth', '123er')
    hello = ("12312312312", 'gdsf')
    wtr.writerows(fff)  # 每个位置占有一个格子，比如1，2，3
    wtr.writerow(hello)  # 每个逗号前面的数据占有一个格子，比如12312312312，gdsf


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


# 字典读
with open('dic.csv', 'r') as dcir:
    dr = csv.DictReader(dcir)
    # column1 = [row for row in dr]  #读取所有的行
    column2 = [row['Name'] for row in dr]  # 读取所有行的'Name'列
    # print(column1)
    print(column2)
