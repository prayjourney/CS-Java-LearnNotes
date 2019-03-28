### SQL触发器
***

**触发器**（TRIGGER）是MySQL的数据库对象之一，从5.0.2版本开始支持。该对象与编程语言中的函数非常类似，都需要声明、执行等。但是触发器的执行不是由程序调用，也不是由手工启动，而是由事件来触发、激活从而实现执行。有点类似DOM中的事件。

那么为什么要使用数据库对象触发器呢？在具体开发项目时，经常会遇到如下实例：
- 在学生表中拥有字段学生姓名，字段学生总数，每当添加一条学生信息时，学生的总数就必须同时更改。
- 在学生表中还会有学生姓名的缩写，学生住址等字段，添加学生信息时，往往需要检查电话、邮箱等格式、否正确。

上面的例子使用触发器完成时具有这样的特点，需要在表发生改变时，自动进行一些处理。MySQL在**触发DELETE/UPDATE/INSERT语句时就会自动执行所设置的操作**，其他SQL语句则不会激活触发器。



##### 创建触发器
使用帮助命令查看具体的语法：
```sql
    CREATE
        [DEFINER = { user | CURRENT_USER }]
        TRIGGER trigger_name
        trigger_time trigger_event
        ON tbl_name FOR EACH ROW
        trigger_body
```
语法中
**trigger_name**：触发器的名称，不能与已经存在的触发器重复；
**trigger_time**：{ BEFORE | AFTER }，表示在事件之前或之后触发；
**trigger_event**：{ INSERT |UPDATE | DELETE }，触发该触发器的具体事件；
**tbl_name**：该触发器作用在tbl_name上；



##### 创建简单触发器
==创建简单触发器==，*准备学生表和学生数目统计表*
```sql
CREATE TABLE student_info (
  stu_no INT(11) NOT NULL AUTO_INCREMENT,
  stu_name VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (stu_no)
);
CREATE TABLE student_count (
  student_count INT(11) DEFAULT 0
);
INSERT INTO student_count VALUES(0);
```
创建简单触发器，在向学生表INSERT数据时，学生数增加，DELETE学生时，学生数减少
```sql
CREATE TRIGGER trigger_student_count_insert
AFTER INSERT
ON student_info FOR EACH ROW
UPDATE student_count SET student_count=student_count+1;
CREATE TRIGGER trigger_student_count_delete
AFTER DELETE
ON student_info FOR EACH ROW
UPDATE student_count SET student_count=student_count-1;
```
INSERT、DELETE数据，查看触发器是否正常工作
```sql
mysql> INSERT INTO student_info VALUES(NULL,'张明'),(NULL,'李明'),(NULL,'王明');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM student_info;
+--------+----------+
| stu_no | stu_name |
+--------+----------+
|      1 | 张明     |
|      2 | 李明     |
|      3 | 王明     |
+--------+----------+
3 rows in set (0.00 sec)

mysql> SELECT * FROM student_count;
+---------------+
| student_count |
+---------------+
|             3 |
+---------------+
1 row in set (0.00 sec)

mysql> DELETE FROM student_info WHERE stu_name IN('张明','李明');
Query OK, 2 rows affected (0.00 sec)

mysql> SELECT * FROM student_info;
+--------+----------+
| stu_no | stu_name |
+--------+----------+
|      3 | 王明     |
+--------+----------+
1 row in set (0.00 sec)

mysql> SELECT * FROM student_count;
+---------------+
| student_count |
+---------------+
|             1 |
+---------------+
1 row in set (0.00 sec)
```
可以看到无论是INSERT还是DELETE学生，学生数目都是跟随着变化的。

#####创建包含多条执行语句的触发器

*在trigger_body中可以执行多条SQL语句*，此时的trigger_body需要使用**BEGIN和END**作为开始和结束的标志：
```sql
CREATE
    [DEFINER = { user | CURRENT_USER }]
    TRIGGER trigger_name
    trigger_time trigger_event
    ON tbl_name FOR EACH ROW
    BEGIN
        trigger_statement
    END;
```
==创建包含多条执行语句的触发器==，依然沿用上面的例子中的表，对student_count表做如下变更：增加student_class字段表示具体年级的学生数，其中0表示全年级，1代表1年级……；同样学生表中也增加该字段。清空两个表中的所有数据。
```sql
DELIMITER $$
CREATE TRIGGER trigger_student_count_insert
AFTER INSERT
ON student_info FOR EACH ROW
BEGIN
UPDATE student_count SET student_count=student_count+1 WHERE student_class=0;
UPDATE student_count SET student_count=student_count+1 WHERE student_class= NEW.student_class;
END
$$
DELIMITER ;
```
- 删除上例中的两个触发器，初始化student_count表中数据，插入三条数据(0,0),(1,0),(2,0)表示全年级、一年级、二年级的初始人数都是0；
- 创建触发器，在INSERT时首先增加学生总人数，然后判断新增的学生是几年级的，再增加对应年级的学生总数：
- 创建触发器，在DELETE时首先减少学生总人数，然后判断删除的学生是几年级的，再减少对应年级的学生总数：
```sql
CREATE TRIGGER trigger_student_count_delete
AFTER DELETE
ON student_info FOR EACH ROW
BEGIN
UPDATE student_count SET student_count=student_count-1 WHERE student_class=0;
UPDATE student_count SET student_count=student_count-1 WHERE student_class= OLD.student_class;
END
$$
DELIMITER ;
```
- 向学生表中分别插入多条不同年级的学生信息，查看触发器是否起作用：
```sql
mysql> INSERT INTO student_info VALUES(NULL,'AAA',1),(NULL,'BBB',1),(NULL,'CCC',2),(NULL,'DDD',2),(NULL,'ABB',1),(NULL,'ACC',1);
Query OK, 6 rows affected (0.02 sec)
Records: 6  Duplicates: 0  Warnings: 0
mysql> SELECT * FROM student_info;
+--------+----------+---------------+
| stu_no | stu_name | student_class |
+--------+----------+---------------+
|      4 | AAA      |             1 |
|      5 | BBB      |             1 |
|      6 | CCC      |             2 |
|      7 | DDD      |             2 |
|      8 | ABB      |             1 |
|      9 | ACC      |             1 |
+--------+----------+---------------+
6 rows in set (0.00 sec)
mysql> SELECT * FROM student_count;
+---------------+---------------+
| student_count | student_class |
+---------------+---------------+
|             6 |             0 |
|             4 |             1 |
|             2 |             2 |
+---------------+---------------+
3 rows in set (0.00 sec)
```
可以看到，总共插入了6条数据，学生总数是6，1年级4个，2年级2个，trigger正确执行。
- 从学生表中分别删除多条不同年级的学生信息，查看触发器是否起作用：从学生表中将姓名以A开头的学生信息删除，学生信息删除的同时，数量表也跟随变化。
```sql
mysql> DELETE FROM student_info WHERE stu_name LIKE 'A%';
Query OK, 3 rows affected (0.02 sec)
mysql> SELECT * FROM student_info;
+--------+----------+---------------+
| stu_no | stu_name | student_class |
+--------+----------+---------------+
|      5 | BBB      |             1 |
|      6 | CCC      |             2 |
|      7 | DDD      |             2 |
+--------+----------+---------------+
3 rows in set (0.00 sec)
mysql> SELECT * FROM student_count;
+---------------+---------------+
| student_count | student_class |
+---------------+---------------+
|             3 |             0 |
|             1 |             1 |
|             2 |             2 |
+---------------+---------------+
3 rows in set (0.00 sec)
```

在上面的示例中，使用了三个新的关键字：DELIMITER、NEW、OLD，这三个关键字在官网上“[触发器语法](http://dev.mysql.com/doc/refman/5.6/en/trigger-syntax.html)”一节中都有介绍，整理如下：



##### DELIMITER
使用**BEGIN…END**结构，可以定义一个执行多句SQL的触发器。在BEGIN语句块中，还可以使用其它的语法，例如条件语句和循环语句。在MySQL中，分号”;”标志着SQL语句的结束，**但是在触发器要执行的SQL语句中使用到了”;”作为要执行SQL语句的结束标记**，++*所以你需要重新定义结束标识符*++。**重新定义结束标识符使用DELIMITER关键字，后面跟空格和重新定义的结束标识符**，注意：该语句与其他语句不同的是不需要在语句末尾添加结束标志符，如**DELIMITER**的作用是将现有的结束标识符重新定义为**|**，但是，此时由于习惯或是疏忽在末尾添加了”;”也就是” **DELIMITER;**”那么该语句的作用就变成了将符号**”;”**作为新的结束标志符。



##### NEW和OLD
**NEW在触发器为INSERT事件**类型时有效，表示当前正在插入的数据；同理，**OLD在触发器类型为DELETE事件**类型时有效，表示当前正在删除的数据。如上面的示例中，可以在触发器中使用NEW.student_class取得正在插入的学生信息中年级值，使用OLD.student_class取得正在删除的学生信息中的年级值。



##### 触发器的使用限制
官网“触发器语法和示例” [http://dev.mysql.com/doc/refman/5.6/en/trigger-syntax.html](http://dev.mysql.com/doc/refman/5.6/en/trigger-syntax.html)
- **触发器只能创建在永久表上**，不能对临时表创建触发器；
- ++触发器不能使用CALL语句调用具有返回值或使用了动态SQL的存储过程++（存储过程可以使用OUT或INOUT参数返回给触发器返回值）。
- **触发器中不能使用开启或结束事务的语句段**，比如，开始事务（START TRANSACTION）、提交事务（COMMIT）或是回滚事务（ROLLBACK），*但是回滚到一个保存点*（SAVEPOINT是允许的，因为回滚到保存点不会结束事务）；
- **外键不会激活触发器**；
- 当使用基于行的复制时，从表上的触发器不会因操作主表中的数据而激活。当使用基于语句的复制时，从表上的触发器会被激活。参考 [Section 17.4.1.34,“Replication and Triggers”](http://dev.mysql.com/doc/refman/5.6/en/replication-features-triggers.html)；
- **触发器中不允许返回值**，因此触发器中不能有返回语句，如果要立即停止一个触发器，应该使用LEAVE语句；



##### 触发器中的异常机制
MySQL的触发器是按照**BEFORE触发器**、**行操作**、**AFTER触发器**的顺序执行的，其中任何一步发生错误都不会继续执行剩下的操作。如果是对事务表进行的操作，那么会整个作为一个事务被回滚，但是如果是对非事务表进行的操作，那么已经更新的记录将无法回滚，这也是设计触发器的时候需要注意的问题。



##### 查看触发器
可以通过执行`SHOW TRIGGERS`命令查看触发器，但是因为不能查询指定的触发器，所以每次都返回所有的触发器的信息，使用不方便。但是可以使用查询系统表information_schema.triggers的方式指定查询条件，查看指定的触发器信息。如：
```sql
mysql> USE information_schema;
Database changed
mysql> SELECT  * FROM triggers WHERE trigger_name='trigger_student_count_insert';
```



##### 删除触发器
```sql
DROP TRIGGER trigger_name;
```
ref:
1.[触发器](http://blog.csdn.net/goskalrie/article/details/53020631), 2. [mysql触发器(Trigger)简明总结和使用实例](http://www.jb51.net/article/49207.htm), 3. [MySQL触发器使用详解](http://www.cnblogs.com/duodushu/p/5446384.html), 4. [为了梦想,努力奋斗!] 追求卓越,成功就会在不经意间追上你 mysql之触发器trigger](), 5.[mysql之触发器] 6.[MySQL 触发器简单实例](http://www.cnblogs.com/nicholas_f/archive/2009/09/22/1572050.html)