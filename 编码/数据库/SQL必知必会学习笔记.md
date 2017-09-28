###SQL必会必知笔记
***
####chapter1 基本概念
**数据库**:保存有组织的数据的==容器==(通常是一个文件或者一组文件)
**表**:++某种特定类型数据的结构化清单++
**模式**:++描述表的信息就叫做模式++，就是关于数据库表的布局以及特性的信息
**列**:表中的一个**字段**
**行**:表中的一个**记录**
**主键**:++唯一标识表中每行的这个列（或这几列）称为主键++，通常定义在表的一列上，但并不是必需这么做，也可以一起使用多个列作为主键。在使用多列作为主键时，上述条件必须应用到所有列，所有列值的组合必须是唯一的（但单个列的值可以不唯一）
**SQL**:标准SQL由ANSI标准委员会管理，从而称为**ANSI SQL**。所有主要的DBMS，即使有自己的扩展，也都支持ANSI SQL。各个实现有自己的名称，如PL/SQL、Transact-SQL等，具体使用某种数据库时候需要查阅其文档

###chapter2 检索数据
**检索单个列**:使用select语句，结束语句使用**';'**，++空格会被忽略++，**SQL语句不区分大小写**，*将SQL语句写成多行易于阅读，*
>```sql
	SELECT prod_name
    FROM Products;
 ```

**检索多列**:select语句后面需要有**多个字段**，此时的**SQL语句一般返回原始的、无格式的数据**，因为没有经过排序
>```sql
	SELECT prod_id, prod_name, prod_price
    FROM Products;
 ```

**检索所有列**:select语句后面是星号(\*)，**最好别使用\*通配符**，这会降低效率，*但是使用通配符可以检测到不知道的列*
>```sql
	SELECT *
    FROM Products;
 ```

**检索结果去重**:使用**DISTINCT**关键字，它指示数据库只返回不同的值，*~~DISTINCT关键字作用于所有的列，不仅仅是跟在其后的那一列~~*
>```sql
    SELECT DISTINCT vend_id
    FROM Products;
 ```

**限制结果**:使用SELECT时，可以使用**TOP**关键字来限制最多返回多少行，如TOP 5表示返回前5行，在MySQL里面这一功能使用***LIMIT***关键字来实现
>```sql
    --标准SQL
    SELECT TOP 5 prod_name
    FROM Products;
	-- MySQL中
    SELECT prod_name
    FROM Products
    LIMIT 5;
    -- 为了得到后面的5行数据，需要指定从哪儿开始以及检索的行数
    SELECT prod_name
    FROM Products
    LIMIT 5 OFFSET 5;
```

**注释**:有三种注释方式，如下
>```sql
    --标准SQL
    SELECT TOP 5 prod_name
    FROM Products;
	#MySQL中
    SELECT prod_name
    FROM Products
    LIMIT 5;
    /*为了得到后面的5行数据，需要指定从哪儿开始以及检索的行数
    SELECT prod_name
    FROM Products
    LIMIT 5 OFFSET 5;*/
```