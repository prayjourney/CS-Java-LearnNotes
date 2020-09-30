# -*- coding: utf-8 -*-
"""
测试了关于 rowcount的问题
rowcount返回的始终是cur所处的位置，而非是整个数据的总数量
另外对于函数的返回的类型的定义，这个只有类型的说明，没有具体的含义
比如，list的函数，所返回的都是list的类型（至少在pycharm中可以看到如此），
而不是返回的一个String,int,list这种类型，这个问题需要考虑一下
“Python函数之中返回的类型值的问题”
"""
import os
import sqlite3

if not os.path.exists("sqlitetest.db"):
    con = sqlite3.connect("sqlitetest.db")
    rr = con.cursor()
    rr.execute("create table people_tb(id integer primary key,pid integer," +
               "name varchar(10), age integer, info text NULL)")
    con.commit()
    rr.close()
    con.close()
else:
    pass

    mycon = sqlite3.connect("sqlitetest.db")
    cur = mycon.cursor()
    # 查询数据
    obj1 = cur.execute("SELECT * FROM people_tb")
    if obj1.rowcount >= 0:
        print(obj1.rowcount)
    else:
        print(obj1.rowcount)
        cur.execute("DELETE  FROM people_tb")
        mycon.commit()
        # 插入数据
        cur.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(1,1,'张三',62,'河北石家庄人')")
        cur.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(2,2,'李四',12,'吉林铁岭人')")
        cur.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(3,3,'Jhon Sm',32,'美国纽约人')")
        cur.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(4,4,'Maimaiti',28,'新疆喀什人')")
        cur.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(5,5,'Rain',26,'韩国大邱人')")
        mycon.commit()

    obj2 = cur.execute("SELECT * FROM people_tb")
    l = cur.fetchall()
    print(len(l))
    print(obj2.rowcount)  # 如此返回的总是-1，要使用以上的方式来获取总的行数
    cur.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(?,?,?,?,?)", (6, 6, 'hi', 18, "hello world"))
    mycon.commit()
    obj2 = cur.execute("SELECT * FROM people_tb")
    print(obj2.fetchone())
    # 使用占位符，一次插入多个数据
    insertsql = "INSERT INTO people_tb(id,pid,name,age,info) VALUES(?,?,?,?,?)"
    infos = [(12, 12, 'Shi Jimodora', 23, "日本东京人"), (7, 7, '张海涛', 26, '甘肃天水人'), \
             (9, 9, '李雅文', 22, '台湾桃园人')]
    obj3 = cur.executemany(insertsql, infos)
    mycon.commit()
    print(obj3.fetchall())  # 必须使用Select * from 才能获取得到所有的，这样获取不到，因为是插入
