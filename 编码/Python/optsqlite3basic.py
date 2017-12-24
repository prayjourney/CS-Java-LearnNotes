# -*- coding: utf-8 -*-
# sqlite3模块的学习和使用
import os
import sqlite3

print(os.getcwd())
print(os.listdir())

if os.path.exists("my_sqlite_test.db"):
    os.remove("my_sqlite_test.db")
else:
    # 打开（不存在时候创建）数据库
    sjk = sqlite3.connect("my_sqlite_test.db")
    # 创建游标
    cu = sjk.cursor()
    # 使用游标对象，操作SQL语句查询数据库，获得查询对象
    # 基本上sqlite3之中一切都是由游标操作的

    # 游标对象有以下的操作：
    # execute()--执行sql语句
    # executemany--执行多条sql语句
    # close()--关闭游标
    # fetchone()--从结果中取一条记录，并将游标指向下一条记录
    # fetchmany()--从结果中取多条记录
    # fetchall()--从结果中取出所有记录
    # scroll()--游标滚动
    # 创建表
    cu.execute("create table people_tb(id integer primary key,pid integer," +
               "name varchar(10) unique, age integer, info text NULL)")
    # 插入数据
    cu.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(1,1,'张三',62,'河北石家庄人')")
    cu.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(2,2,'李四',12,'吉林铁岭人')")
    cu.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(3,3,'Jhon Sm',32,'美国纽约人')")
    cu.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(4,4,'Maimaiti',28,'新疆喀什人')")
    cu.execute("INSERT INTO people_tb(id,pid,name,age,info) VALUES(5,5,'Rain',26,'韩国大邱人')")
    sjk.commit()  # 提交

    ##查询
    cu.execute("SELECT * FROM people_tb")  # 要提取查询到的数据,使用游标的fetch***函数,如:
    print(cu.fetchall())
    print("===========")
    # 修改
    cu.execute("UPDATE people_tb SET name='萨克斯' WHERE id= 2")
    cu.execute("UPDATE people_tb SET age=27 WHERE id= 4")
    sjk.commit()  # 提交

    # 插入,查询
    cu.execute("INSERT INTO people_tb VALUES(6,6,'鸠摩智',52,'西藏拉萨人')")
    cu.execute("INSERT INTO people_tb VALUES(7,7,'郭靖',42,'湖北襄阳人')")
    sjk.commit()

    # 占位符的使用
    sql1 = "insert into people_tb values(?,?,?,?,?)"
    # sql2='insert into people_tb (id,pid,name,age,info) values(%d, %d, %s, %d, %s)'
    cu.execute(sql1, (9, 9, '杨过', 22, '陕西西安人'))
    # cu.execute(sql2,(10,10,'杀马特',22,'四川成都人'))
    # executemany的使用
    li = [(11, 11, '马超22', 24, '甘肃武威人'), (12, 12, '诸葛亮22', 23, '河南南阳人'), (13, 13, '周瑜22', 22, '浙江绍兴人')]
    cu.executemany(sql1, li)
    sjk.commit()
    cu.execute("SELECT * FROM people_tb")  # 要提取查询到的数据,使用游标的fetch***函数,如:
    print(cu.fetchall())
    print("===========")
    de_sql = "delete from people_tb where id=?"
    no = [(6,), (7,), (9,), (10,), (11,), (12,), (13,)]
    cu.executemany(de_sql, no)
    sjk.commit()

    # 删除
    cu.execute("DELETE FROM people_tb WHERE name='鸠摩智1'")
    cu.execute("SELECT * FROM people_tb")  # 要提取查询到的数据,使用游标的fetch***函数,如:
    print(cu.fetchall())
