### SQL必会必知笔记

***
#### chapter1 基本概念
**数据库**:保存有组织的数据的==容器==(通常是一个文件或者一组文件)
**表**:++某种特定类型数据的结构化清单++
**模式**:++描述表的信息就叫做模式++，就是关于数据库表的布局以及特性的信息
**列**:表中的一个**字段**
**行**:表中的一个**记录**
**主键**:++唯一标识表中每行的这个列（或这几列）称为主键++，通常定义在表的一列上，但并不是必需这么做，也可以一起使用多个列作为主键。在使用多列作为主键时，上述条件必须应用到所有列，所有列值的组合必须是唯一的（但单个列的值可以不唯一）
**SQL**:标准SQL由ANSI标准委员会管理，从而称为**ANSI SQL**。所有主要的DBMS，即使有自己的扩展，也都支持ANSI SQL。各个实现有自己的名称，如PL/SQL、Transact-SQL等，具体使用某种数据库时候需要查阅其文档



#### chapter2 检索数据
**检索单个列**:使用select语句，结束语句使用**';'**，++空格会被忽略++，**SQL语句不区分大小写**，*将SQL语句写成多行易于阅读，*

>```sql
>SELECT prod_name
>    FROM Products;
>```
 ```

**检索多列**:select语句后面需要有**多个字段**，此时的**SQL语句一般返回原始的、无格式的数据**，因为没有经过排序
>```sql
	SELECT prod_id, prod_name, prod_price
    FROM Products;
 ```

**检索所有列**:select语句后面是星号(\*)，**最好别使用\*通配符**，这会降低效率，*但是使用通配符可以检测到不知道的列*
>```sql
>SELECT *
>    FROM Products;
>```
 ```

**检索结果去重**:使用**DISTINCT**关键字，它指示数据库只返回不同的值，*~~DISTINCT关键字作用于所有的列，不仅仅是跟在其后的那一列~~*
>```sql
    SELECT DISTINCT vend_id
    FROM Products;
 ```

**限制结果**:使用SELECT时，可以使用**TOP**关键字来限制最多返回多少行，如TOP 5表示返回前5行，在MySQL里面这一功能使用***LIMIT***关键字来实现
>```sql
>    --标准SQL
>    SELECT TOP 5 prod_name
>    FROM Products;
>-- MySQL中
>    SELECT prod_name
>    FROM Products
>    LIMIT 5;
>    -- 为了得到后面的5行数据，需要指定从哪儿开始以及检索的行数
>    SELECT prod_name
>    FROM Products
>    LIMIT 5 OFFSET 5;
>```
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



#### chapter3 排序检索数据
**排序**:关键字是**order by**，检索出的数据并不是随机显示的。*不排序时数据一般将以它在底层表中出现的顺序显示*，这有可能是数据最初添加到表中的顺序。但是，如果数据随后进行过更新或删除，那么这个顺序将会受到DBMS重用回收存储空间的方式的影响。因此，如果不明确控制的话，则最终的结果不能（也不应该）依赖该排序顺序。==明确地排序用SELECT语句检索出的数据==，**可使用oreder by子句**。oreder by子句取一个或多个列的名字，据此对输出进行排序。
**子句**:*SQL语句由子句构成，有些子句是必需的，有些则是可选的*。一个子句通常由一个关键字加上所提供的数据组成。
**oreder by子句的位置**:在指定一条oreder by子句时，**应该保证它是select语句中最后一条子句**。通常，++oreder by子句中使用的列将是为显示而选择的列++。**但是，实际上并不一定要这样，用非检索的列排序数据是完全合法的**，并且可以使用**多个顺序排列**，按照从左到右的顺序排序，同时使用非检索列来排序也是可以的。
```sql
    select prod_id, prod_price, prod_name
    from Products
    order by prod_price, prod_name, prod_detail;
    #order by列出了多列，然后按照顺序排序，而prod_detail是非检索数据
```
**排序方向**:默认是升序ASC，降序是DESC(不区分大小写)，但是一个排序是只对一个列起作用，**如果想在多个列上进行降序排序，必须对每一列指定DESC关键字**



#### chapter4 过滤数据
**过滤数据**:数据根据where子句中指定的搜索条件进行过滤。where子句在表名（from子句）之后给出
**何时使用引号**:一般而言，除了数值之外，都需要用**''**将值包含起来，对于**日期来说，更是需要用引号包含起来**。
**检查的形式**:可以检查单值，使用等号，可以检查范围，使用大于(等于)，小于(等于)，不等于，另外还可以检查空值，NULL(no value)**它与字段包含0、空字符串或仅仅包含空格不同**，另外，**对于Null值的检查不能简单使用"="，而要使用IS NULL**



#### chapter5 高级数据过滤
**高级之处**:*子查询*，*嵌套查询*，*联合查询*等
**操作符号**:or和and，需要知道的是**and**操作符的优先级要高于**or**操作符号
**IN操作符**:**IN操作符用来指定条件范围**，*范围中的每个条件都可以进行匹配*。IN取一组由逗号分隔、括在圆括号中的合法值。
>IN操作符的优点为
1.在有很多合法选项时，IN操作符的语法更清楚，更直观。
2.**在与其他AND和OR操作符组合使用IN时，求值顺序更容易管理**。
3.**IN操作符一般比一组OR操作符执行得更快**。
4.IN的最大优点是可以包含其他SELECT语句，能够更动态地建立WHERE子句。**IN，WHERE子句中用来指定要匹配值的清单的关键字，功能与OR相当**。

```sql
   SELECT prod_name, prod_price
   FROM Products
   WHERE vend_id IN ( 'DLL01', 'BRS01' )
   ORDER BY prod_name;
```

**NOT操作符**:NOT操作符有且只有一个功能，即**否定其后所跟的任何条件**。因为NOT从不单独使用（它总是与其他操作符一起使用），所以它的语法与其他操作符有所不同。**NOT关键字可以用在要过滤的列前，而不仅是在其后**。
```sql
   SELECT prod_name
   FROM Products
   WHERE NOT vend_id = 'DLL01'
   ORDER BY prod_name;
```



#### chapter6 用通配符进行过滤
**LIKE操作符**:匹配操作符
**通配符**:用来匹配值的一部分的特殊字符，**通配符搜索只能用于文本字段（串），非文本数据类型字段不能使用通配符搜索**。
**常用通配符**:**%**，在搜索串中，%表示任何字符出现任意次数，**\_**下划线的用途与%一样，但它只匹配单个字符，而不是多个字符，**[]**方括号通配符用来指定一个字符集，它必须匹配指定位置（通配符的位置）的一个字符
**通配符的技巧**:，SQL的通配符很有用，但这种功能是有代价的，即**通配符搜索一般比前面讨论的其他搜索要耗费更长的处理时间**，=*不要过度使用通配符*=。如果其他操作符能达到相同的目的，应该使用其他操作符。*在确实需要使用通配符时，也**尽量不要把它们用在搜索模式的开始处***。*把通配符置于开始处，搜索起来是最慢的*。仔细注意通配符的位置。如果放错地方，可能不会返回想要的数据



#### chapter7 创建计算字段
**字段**:基本上与列（column）的意思相同，经常互换使用，不过数据库列一般称为列，而术语字段通常与计算字段一起使用
**拼接字段**:将值联结到一起（将一个值附加到另一个值）构成单个值，此操作符可用加号（**+**）或两个竖杠（**||**）表示。在MySQL和MariaDB中，必须使用特殊的函数，**在mysql 使用concat函数**，Oracle、PostgreSQL、SQLite使用||
**去除空格**:使用**trim()**系列的函数
**别名**:使用**as**，as可以给**列**起别名，也可以给**表**起别名
```sql
    select a.id as ID ,a.name as Name, b.price as Price
    from student as a, book as b
    where  a.id=b.studentID;
```
**执行算术计算**:可以在表之中的**列**中进行运算
```sql
    SELECT prod_id,quantity,item_price,quantity*item_price AS expanded_price
    FROM OrderItems
    WHERE order_num = 20008;
```



#### chapter8 使用数据处理函数
**函数**:一般是在数据上执行的，为数据的转换和处理提供了方便，用于处理**文本字符串**（如删除或填充值，转换值为大写或小写）的文本函数。用于在数值数据上进行**算术操作**（如返回绝对值，进行代数运算）的数值函数。用于处理**日期和时间值**并从这些值中提取特定成分（如返回两个日期之差，检查日期有效性）的日期和时间函数



#### chapter9 汇总数据
**聚集函数**:（aggregate function） 对某些行运行的函数，**计算并返回一个值**。

|函 数| 说 明|
|-----|-----|
|AVG()| 返回某列的平均值|
|**COUNT()**| 返回某列的行数|
|MAX()| 返回某列的最大值|
|MIN()| 返回某列的最小值|
|**SUM()**| 返回某列值之和|
**聚集不同值**对所有行执行计算，指定ALL参数或不指定参数（因为ALL是默认行为），如果不指定DISTINCT，则假定为ALL，**DISTINCT不能用于COUNT(\*)**，如果指定列名，则DISTINCT只能用于COUNT()。DISTINCT不能用于COUNT(\*)。类似地，DISTINCT必须使用列名，不能用于计算或表达式。



#### chapter10 分组数据
**数据分组**:分组可以将数据分为多个逻辑组，对每个组进行聚集计算
**创建分组**:分组是使用SELECT语句的**GROUP BY**子句建立的
```sql
    SELECT vend_id, COUNT(*) AS num_prods
    FROM Products
    GROUP BY vend_id
```
>1.GROUP BY子句可以包含任意数目的列，因而可以对分组进行嵌套，更细致地进行数据分组。
2.如果在GROUP BY子句中嵌套了分组，数据将在最后指定的分组上进行汇总。换句话说，在建立分组时，指定的所有列都一起计算（所以不能从个别的列取回数据）。
3.GROUP BY子句中列出的每一列都必须是检索列或有效的表达式（但不能是聚集函数）。如果在SELECT中使用表达式，则必须在GROUP BY子句中指定相同的表达式。不能使用别名。
4.大多数SQL实现不允许GROUP BY列带有长度可变的数据类型（如文本或备注型字段）。
5.除聚集计算语句外，SELECT语句中的每一列都必须在GROUP BY子句中给出。
6.如果分组列中包含具有NULL值的行，则NULL将作为一个分组返回。如果列中有多行NULL值，它们将分为一组。**GROUP BY子句必须出现在WHERE子句之后，ORDER BY子句之前**。

**过滤分组**:GROUP BY分组数据外，SQL还允许过滤分组，**但是where语句无法创建分组**，where不能完成任务，为**where过滤指定的是行而不是分组**。事实上，**where没有分组的概念这个功能需要使用having子句**，使用having时应该结合group by子句，而where子句用于标准的行级过滤。
**Having和Where**:++1.having子句可以代替where子句的功能++; **2.having过滤分组，where过滤行**; 3.having语句与where语句可能同时使用; **4.having分组后过滤，where分组前过滤**; 5.HAVING子句配合GROUP BY子句，而WHERE子句用于标准的行级过滤; 6.where，group by， having 可以同时使用
```sql
    SELECT cust_id, COUNT(*) AS orders
    FROM Orders
    GROUP BY cust_id
    HAVING COUNT(*) >= 2;
```
**分组和排序**:一般在使用GROUP BY子句时，应该也给出ORDER BY子句。这是保证数据正确排序的唯一方法。**千万不要仅依赖GROUP BY排序数据**。如下例子
```sql
    SELECT order_num, COUNT(*) AS items
    FROM OrderItems
    GROUP BY order_num
    HAVING COUNT(*) >= 3
    ORDER BY items, order_num;
```

###SELECT子句顺序
|子 句 |说 明 |是否必须使用|
|-----|------|----------|
|SELECT| 要返回的列或表达式| 是 |
|FROM  |从中检索数据的表   |仅在从表选择数据时使用|
|WHERE |**行级过滤**| 否 |
|GROUP BY |++分组说明++ |仅在按组计算聚集时使用|
|HAVING   |**组级过滤**     | 否 |
|ORDER BY |输出排序顺序 | 否  |



#### chapter11 使用子查询
**子查询作用**:为主查询提供**过滤**后的数据，**一条select语句返回的结果用于另一条select语句的where子句**，就是子查询。
**子查询的执行顺序**:在select语句中，**子查询总是从内向外处理**
**子查询的限制**:++子查询的Select语句，**只能查找出单个列值**，试图返回多个列，将会发生错误++
**使用子查询**:计算字段中使用子查询，是子查询常用的场景之一，当select语句中有多个表的时候，需要使用表名完全限定字段名，**子查询常用于where子句的in操作符，exists中**，以及用来填充计算列。
```sql
select cust_name, cust_state,
    (SELECT COUNT(*)
    FROM Orders
    WHERE Orders.cust_id = Customers.cust_id) AS orders
    FROM Customers
ORDER BY cust_name;
```
```sql
-- 使用表名完全限定
where Orders.cust_id = Customers.cust_id
```



#### chapter12 联结表
**联结**:联结是利用sql的select能执行的最重要的操作，相同的数据出现多次造成的冗余对于数据库的效能有很大的影响
**创建联结**:指定要连接的**所有表**，以及**关联它们的方式**即可，例子如下
```sql
select vend_name, prod_name, prod_price
from Vendors, Products
where Vendors.vend_id = Products.vend_id;
```
++这里最大的差别是**Select语句所指定的两列不在同一张表之中**，*prod_name*和*prod_price*在一个表中，而*vend_name*在另一个表中++；**From子句表示查询的来源有两张表**，分别是***Vendors***和***Products***。它们就是这条select语句联结的两个表的名字。这两个表用where子句正确地联结，**where子句指示DBMS将Vendors表中的vend_id与Products表中的vend_id匹配起来**，这就是联结的条件
**Where子句的重要性**:在数据库表的定义中没有指示DBMS如何对表进行联结的内容。必须自己做这件事情。**在联结两个表时，实际要做的是将第一个表中的每一行与第二个表中的每一行配对**，而这个条件的动作，是要在Where子句之中实现
**笛卡儿积**:笛卡儿积(cartesian product)**由没有联结条件**的表关系返回的结果为*笛卡儿积*。++检索出的行的数目将是第一个表中的行数乘以第二个表中的行数++，**笛卡儿积有时也称叉联结(cross join)**，假设A表有10行，B表有6行，则A表与B表进行笛卡尔联结，一共有60个结果
```sql
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products;
```
**内联结**:基于两个表之间的**相等测试的联结称为等值联结**(equijoin)，也称为**内联结**(inner join)，此语句中的SELECT部分没有改变，++但from子句不同++。这里，两个表之间的关系是以inner join指定的部分from子句。在使用这种语法时，联结条件用特定的on子句而不是where子句给出。传递给on的实际条件与传递给where的相同。
```sql
SELECT vend_name, prod_name, prod_price
FROM Vendors INNER JOIN Products
ON Vendors.vend_id = Products.vend_id;
```
**联结多个表**:SQL不限制一条SELECT语句中可以联结的表的数目，多个表的联结主要是在where子句之中，设定联结多个条件。**使用联结时候，需要考虑数据库的性能**，不要联结不必要的表。联结的表越多，性能下降越厉害。
**联结和子查询**:子查询并不总是执行复杂SELECT操作的最有效方法，有时候联结和子查询可以转换，下面两个就是等价抓换的例子。
```sql
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));
```
```sql
SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
      AND OrderItems.order_num = Orders.order_num
      AND prod_id = 'RGAN01';
```



#### chapter13 创建高级联结
**使用表别名**:**表别名只在查询执行中使用**。与列别名不一样，表别名不返回到客户端，关键字为**AS**
```sql
SELECT cust_name, cust_contact
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
AND OI.order_num = O.order_num
AND prod_id = 'RGAN01';
```
**自联结**:使用表别名的一个主要原因是能在一条SELECT语句中不止一次引用相同的表，当查询条件之中只有一个值的时候，可以使用等号，下面是自连接的例子，以下是两种功能相同的查询操作，第一种使用的是子查询，第二种使用的是自联结，**自联结通常作为外部语句，用来替代从相同表中检索数据的使用子查询语句，但是自联结的效率高于子查询**，重点是某个属性，对自身表的操作(也是一种特殊的自然联结，只是两张表都是它自己)
```sql
SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (SELECT cust_name
                   FROM Customers
                   WHERE cust_contact = 'Jim Jones');
```
```sql
SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name = c2.cust_name
      AND c2.cust_contact = 'Jim Jones';
```
**自然联结**:无论何时对表进行联结，应该至少有一列不止出现在一个表中（被联结的列）。**标准的联结（内联结）返回所有数据**，相同的列甚至多次出现。自**然联结排除多次出现，使每一列只返回一次**。自然联结要求你只能选择那些唯一的列，一般通过对一个表使用通配符（SELECT *），而对其他表的列使用明确的子集来完成，==++自然连接是在广义笛卡尔积R×S中选出同名属性上符合相等条件元组，再进行投影，去掉重复的同名属性，组成新的关系。即自然连接是在两张表中寻找那些数据类型和列名都相同的字段，然后自动地将他们连接起来，并返回所有符合条件按的结果++==，重点是都相同，对两张表操作
```sql
SELECT C.*, O.order_num, O.order_date, OI.prod_id, OI.quantity, OI.item_price
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
      AND OI.order_num = O.order_num
      AND prod_id = 'RGAN01';
```
**外联结**:**外连接返回到查询结果集合中的不仅包含符合连接条件的行，而且还包括左表(左外连接或左连接))、右表(右外连接或右连接)或两个边接表(全外连接)中的所有数据行**。SELECT语句使用了关键字**OUTER JOIN**来指定联结类型（而不是在WHERE子句中指定）。但是，与内联结关联两个表中的行不同的是，**外联结还包括没有关联行的行**。在使用OUTER JOIN语法时，**必须使用RIGHT或LEFT关键字指定包括其所有行的表**（RIGHT指出的是OUTER JOIN右边的表，而LEFT指出的是OUTER JOIN左边的表）
```sql
SELECT Customers.cust_id, Orders.order_num
FROM Customers LEFT OUTER JOIN Orders
ON Customers.cust_id = Orders.cust_id;
```
需要说明的是**Access、MariaDB、MySQL、Open Office Base或SQLite不支持FULL OUTER JOIN语法**。*left join*(左联接)等价于(left outer join)  返回包括左表中的所有记录和右表中联结字段相等的记录；***right join*(右联接)等价于(right outer join）返回包括右表中的所有记录和左表中联结字段相等的记录**；*full join*(全连接)等价于(full outer join)查询结果等于左外连接和右外连接的和
**联结种类**:联结包括笛卡尔联结，**内联结(等值联结)**，**外联结**，**自然联结**
**联结使用实践**:1.注意所使用的联结类型。一般我们使用内联结，但使用外联结也有效。2.应该总是提供联结条件，否则会得出笛卡儿积。3.在一个联结中可以包含多个表，甚至可以对每个联结采用不同的联结类型。虽然这样做是合法的，一般也很有用，但应该在一起测试它们前分别测试每个联结。这会使故障排除更为简单。
**使用带聚集函数的联结**：聚合函数返回的结果是一个**数字**，所以此时，如果所要展示到列之中，必须是条件之中所过滤后得到的列，可以起别名，这样容易辨识，另外，如果group by时候往往需要对应的聚合函数的结果来分组
```sql
SELECT Customers.cust_id,
COUNT(Orders.order_num) AS num_ord
FROM Customers INNER JOIN Orders
ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;
```



#### chapter14 组合查询
**组合查询**:利用**UNION**操作符将多条SELECT语句**组合**成一个结果集。这些组合查询通常称为并(union)或复合查询(compound query)
```sql
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';
```
**Union使用**:**使用union很简单，所要做的只是给出每条SELECT语句，在各条语句之间放上关键字union**
**Union使用规则**:**union必须由两条或两条以上的SELECT语句组成，语句之间用关键字union分隔**(因此，如果组合四条SELECT语句，将要使用三个union关键字)**union中的每个查询必须包含相同的列、表达式或聚集函数**(不过，各个列不需要以相同的次序列出)**列数据类型必须兼容：类型不必完全相同**
**组合查询使用场景**:1.在一个查询中从不同的表返回结构数据；2.对一个表执行多个查询，按一个查询返回数据。任何具有多个WHERE子句的SELECT语句都可以作为一个组合查询
**去除重复**:union从查询结果集中**自动去除了重复的行**，想要保留重复的行，可以使用**union all**，DBMS不取消重复的行。
**使用Union时排序**:++在用union组合查询时，只能使用一条ORDER BY子句，并且它必须位于最后一条SELECT语句之后++，*某些DBMS还支持另外两种union: **except**(有时称为minus)可用来检索只在第一个表中存在而在第二个表中不存在的行；而**intersect**可用来检索两个表中都存在的行。实际上，这些union很少使用，因为相同的结果可利用联结得到*、



#### chapter15 插入数据
**数据插入**:插入分为完整的行和部分数据,但是都需要使用**insert**关键字，insert后的into通常是可选的，但是最好不要省略。*其含义是将一些字段插入到某个表之中的一些字段之中*，第一个例子是完整版本，第二个例子是默认对所有的字段都提供数据，在第一个例子之中可以只插入部分数据。一个原则是**不要使用没有明确给出列的INSERT语句。给出列能使SQL代码继续发挥作用，即使表结构发生了变化**。
```sql
INSERT INTO Customers
(cust_id,cust_name,cust_address,cust_city,cust_state,
cust_zip,cust_country,cust_contact,cust_email)
VALUES('1000000006','Toy Land','123 Any Street','New York',
'NY','11111','USA',NULL,NULL);
```
```sql
INSERT INTO Customers
VALUES('1000000006','Toy Land','123 Any Street','New York',
'NY','11111','USA',NULL,NULL);
```
**插入检索出的数据**:使用的语法是**Insert Select**，由一条Insert语句和一条Select语句组成，需要注意的是，**select出来的数据必须和insert插入的字段相一致**,其后可以使用where语句过滤，普通情况下如果要增加多行数据，则需要执行多条语句，但是**在Insert Select语句之中，可以一次性插入多条记录**。
```sql
INSERT INTO Customers(cust_id,cust_contact,cust_email,
cust_name,cust_address,cust_city,cust_state,
cust_zip,cust_country)
	SELECT cust_id,cust_contact,cust_email,
		cust_name,cust_address,cust_city,cust_state,
		cust_zip,cust_country
	FROM CustNew;
```
**从一个表复制到另一个表**:**Select Into将数据复制到一个新表**，Select Into和Insert Select的区别是，select into将数据从一个表复制到另一个新表，而insert select是导出数据。使用select into想要全部信息，则可以用"\*,如果只想要复制部分的列，可以明确给出列名，而不是使用/*通配符.
```sql
SELECT *
INTO CustCopy
FROM Customers;

SELECT ID,Name,Email
INTO CustCopy
FROM Customers;
```



#### chapter16 更新和删除数据
**更新数据**:更新表中的数据分为，**更新表中特定的行**，**更新表中的所有行**，*要删除某个列的值，可设置它为NULL(假如表定义允许NULL值)*
```sql
UPDATE Customers
SET cust_contact = 'Sam Roberts',
    cust_email = 'sam@toyland.com'
WHERE cust_id = '1000000006';
```
**删除数据**:从表中删除数据有删除一行和删除所有的行这两种，使用的关键字是**Delete From**，删除语句的使用要小心，另外也需要有足够的权限，Delete后面的From是可选的，但是最好别省略。
```sql
ELETE FROM Customers
WHERE cust_id = '1000000006';
```
**更新和删除的指导原则**:
- 除非确实打算更新和删除每一行，否则绝对不要使用不带WHERE子句的UPDATE或DELETE语句
- **保证每个表都有主键**，尽可能像WHERE子句那样使用它（可以指定各主键、多个值或值的范围）
- 在UPDATE或DELETE语句使用WHERE子句前，应该先用SELECT进行测试，保证它过滤的是正确的记录，以防编写的WHERE子句不正确
- 使用强制实施引用完整性的数据库，这样DBMS将不允许删除其数据与其他表相关联的行
- 有的DBMS允许数据库管理员施加约束，防止执行不带WHERE子句的UPDATE或DELETE语句。如果所采用的DBMS支持这个特性，应该使用它



#### chapter17 创建和操纵表
**创建表**：创建表使用Create Table关键字，表名紧跟Create Table关键字，定义体之中是表中的字段。*sql语句最好以某种格式缩进*
```sql
create table if not exists parent(
    pid int auto_increment not null comment'ID',
    pfname varchar(25)  not null default 'XXX的爸爸' comment '学生爸爸名字',
    pmname varchar(25)  not null default 'XXX的妈妈' comment '学生妈妈名字',
    sno    varchar(3)   not null comment '学生学号',
    pftel  varchar(11)  not null comment '学生爸爸电话',
    pmtel  varchar(11)  not null comment '学生妈妈电话',
    primary key(pid)
 )default charset=utf8 AUTO_INCREMENT=100 comment='学生父母的信息';
-- 有主键，自增信息，以及自增开始处的定义方式
*/
```
**默认值**：SQL允许指定默认值，在插入行时如果不给出值，DBMS将自动采用默认值，另外，最好不要使用NULL值，让所有的字段都有默认值，是一个比较好的方法，而且，不要混淆Null和空字符串，二者是不一样的。
**更新表**：更新表定义，可以使用**ALTER TABLE**语句，以下是使用ALTER
TABLE时需要考虑的事情。
- 理想情况下，不要在表中包含数据时对其进行更新。应该在表的设计过程中充分考虑未来可能的需求，避免今后对表的结构做大改动。
- 所有的DBMS都允许给现有的表增加列，不过对所增加列的数据类型（以及NULL和DEFAULT的使用）有所限制。
- 许多DBMS不允许删除或更改表中的列。
- 多数DBMS允许重新命名表中的列。
- 许多DBMS限制对已经填有数据的列进行更改，对未填有数据的列几乎没有限制。

```sql
-- 添加一列
ALTER TABLE Vendors
ADD vend_phone CHAR(20);
-- 删除一列
ALTER TABLE Vendors
DROP COLUMN vend_phone;
```
**复杂表结构**:对于复杂的表结构更改一般需要手动删除过程，它涉及以下步骤：
- 用新的列布局创建一个新表；
- 使用**INSERT SELECT**语句（关于这条语句的详细介绍，请参阅第15课）从旧表复制数据到新表。有必要的话，可以使用转换函数和计算字
段；
- 检验包含所需数据的新表；
- 重命名旧表（如果确定，可以删除它）；
- 用旧表原来的名字重命名新表；
- 根据需要，重新创建触发器、存储过程、索引和外键。

**删除表**:删除表（删除整个表而不是其内容）非常简单，使用DROP TABLE语句即可

**重命名表**:每个DBMS对表重命名的支持有所不同
```sql
-- MySQL修改表名
RENAME TABLE 表名 TO 新表名； -- 这里面的TO不可以省略
```



#### chapter18 使用视图
**视图**:视图是虚拟的表，视图的数据来源于表之中，*视图只包含使用时动态检索数据的查询*。通俗的说，**视图不包含“原始数据”，包含查询数据，这些查询数据来自于一个SQL语句的执行结果**。
**为何使用视图**:粗略而言有如下原因，但是也要注意，*视图的数据源自于查询，查询会导致效率下降*
- 重用SQL语句
- 简化复杂的SQL操作。在编写查询后，可以方便地重用它而不必知道其基本查询细节
- 使用表的一部分而不是整个表
- 保护数据。可以授予用户访问表的特定部分的权限，而不是整个表的访问权限
- 更改数据格式和表示。视图可返回与底层表的表示和格式不同的数据

**视图的规则和限制**:粗略而言有如下限制
- 与表一样，视图必须唯一命名（不能给视图取与别的视图或表相同的名字）
- 创建视图，必须具有足够的访问权限。这些权限通常由数据库管理人员授予
- 视图可以嵌套，即可以利用从其他视图中检索数据的查询来构造视图。所允许的嵌套层数在不同的DBMS中有所不同（嵌套视图可能会严重降低查询的性能，因此在产品环境中使用之前，应该对其进行全面测试）
- 许多DBMS禁止在视图查询中使用ORDER BY子句

**创建视图**:创建视图使用**Create View**关键字，删除视图使用**Drop View viewname**，在创建的时候，**AS关键字不能丢了**
```sql
CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
AND OrderItems.order_num = Orders.order_num;
-- 当创建了视图之后，可以对其进行查询
SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';
```
**视图的过滤作用**:结合Where子句，可以过滤一些不想要的数据
```sql
CREATE VIEW CustomerEMailList AS
SELECT cust_id, cust_name, cust_email
FROM Customers
WHERE cust_email IS NOT NULL;
-- email为空的数据被过滤掉了
```
**小结**:视图为虚拟的表。它们包含的不是数据而是根据需要检索数据的查询。视图提供了一种封装SELECT语句的层次，可用来简化数据处理，重新格式化或保护基础数据




#### chapter19 使用存储过程
**存储过程**:存储过程就是为以后使用而保存的一条或多条SQL语句。可将其视为批文件，但是其作用不止于此，不同的数据库的语法不同。存储过程有如下优点，1.**通过把处理封装在一个易用的单元中，可以简化复杂的操作（如前面例子所述）**。2.**由于不要求反复建立一系列处理步骤，因而保证了数据的一致性**。MySQL从MySQL5开始支持存储过程，如下提供一个Oracle存储过程的例子
```sql
CREATE PROCEDURE MailingListCount (
ListCount OUT INTEGER
) IS
v_rows INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_rows
    FROM Customers
    WHERE NOT cust_email IS NULL;
    ListCount := v_rows;
END;
```



#### chapter20 事务处理
**事务处理**:事务处理(transaction processing)，通过确保成批的SQL操作要么完全执行，要么完全不执行，来维护数据库的完整性，**保证了数据操作的原子性**，事务处理用来**管理INSERT、UPDATE和DELETE语句**，不能回退SELECT语句(回退SELECT语句也没有必要)，也不能回退CREATE或DROP操作。事务处理中可以使用这些语句，但进行回退时，这些操作也不撤销

**相关术语**:事务处理中的相关术语
- **事务**（transaction）指一组SQL语句
- **回退**（rollback）指撤销指定SQL语句的过程
- **提交**（commit）指将未存储的SQL语句结果写入数据库表
- **保留点**（savepoint）指事务处理中设置的临时占位符（placeholder），可以对它发布回退（与回退整个事务处理不同）

**控制事务处理**:不同的数据库的实现不太一样
SQL Server之中
```sql
BEGIN TRANSACTION
...
COMMIT TRANSACTION
```
在MariaDB和MySQL，相同的功能如下代码实现
```sql
START TRANSACTION
...
-- 其中的...表示省略的SQL操作语句
```
SQL的**ROLLBACK**命令用来回退（撤销）SQL语句
```sql
DELETE FROM Orders;
ROLLBACK;
```
在事务处理块中，提交不会隐式进行。不同DBMS的做法有所不同。进行明确的提交，使用**COMMIT**语句。
```sql
begin;  # 开始事务
insert into runoob_transaction_test value(5);
insert into runoob_transaction_test value(6);
commit; # 提交事务
```
```sql
begin;    # 开始事务
insert into runoob_transaction_test values(7);
rollback;  # 回滚
select * from runoob_transaction_test;
```
**使用保留点**:使用简单的ROLLBACK和COMMIT语句，就可以写入或撤销整个事务。但是，只对简单的事务才能这样做，复杂的事务可能需要部分提交或回退，**要支持回退部分事务，必须在事务处理块中的合适位置放置占位符**。这样，如果需要回退，可以回退到某个占位符。在SQL中，这些占位符称为**保留点**。在MariaDB、MySQL和Oracle中创建占位符，可使用**SAVEPOINT**语句，可以在SQL代码中设置任意多的保留点，越多越好。为什么呢？因为保留点越多，你就越能灵活地进行回退
```sql
SAVEPOINT delete1;
```
```sql
begin ;
insert into booktable2(bid,bname,author,press,price)values(230,'长安乱','韩寒','天神出版社',22.8);
insert into booktable2(bid,bname,author,press,price)values(231,'乱世佳人','lucy','朗文版社',232.7);
insert into booktable2(bid,bname,author,press,price)values(232,'汤姆叔叔的小屋','马克','纽约大学出版社',72.8);
delete from booktable2 where bid=223;
savepoint spoint1;
insert into booktable2(bid,bname,author,press,price)values(233,'轰动武林','霹雳','霹雳出版社',122.3);
delete from booktable2 where bid=224;
savepoint spoint2;
insert into booktable2(bid,bname,author,press,price)values(234,'轰定干戈','霹雳','霹雳出版社',112.6);
insert into booktable2(bid,bname,author,press,price)values(235,'轰掣天下','霹雳','霹雳出版社',152.7);
insert into booktable2(bid,bname,author,press,price)values(236,'轰霆剑海录','霹雳','霹雳出版社',142.8);
delete from booktable2 where bid=225;
savepoint spoint3;
rollback to spoint1;#只能这样在里面弄吗？
commit;
select * from booktable2 where bid=223 or bname='乱世佳人';
```



#### chapter21 游标
**创建游标**:SQL检索操作返回一组称为结果集的行，这组返回的行都是与SQL语句相匹配的行（零行或多行）。使用**DECLARE语句**创建游标
```sql
DECLARE CustCursor CURSOR
FOR
SELECT * FROM Customers
WHERE cust_email IS NULL
```
**使用游标**:使用OPEN CURSOR语句打开游标，用FETCH语句访问游标数据，使用CLOSE CustCursor来关闭游标
```sql
OPEN CURSOR CustCursor
```
```sql
DECLARE TYPE CustCursor IS REF CURSOR
RETURN Customers%ROWTYPE;
DECLARE CustRecord Customers%ROWTYPE
BEGIN
OPEN CustCursor;
LOOP
FETCH CustCursor INTO CustRecord;
EXIT WHEN CustCursor%NOTFOUND;
...
END LOOP;
CLOSE CustCursor;
END;
```



#### chapter22 高级SQL特性
**约束**:**管理如何插入或处理数据库数据的规则**，利用键来建立从一个表到另一个表的引用(由此产生了术语引用完整性(referential integrity))
**主键**:**主键是一种特殊的约束**，用来保证一列（或一组列）中的值是唯一的，**而且永不改动**。换句话说，表中的一列（或多个列）的值唯一标识表中的每一行。这方便了直接或交互地处理表中的行。没有主键，要安全地UPDATE或DELETE特定行而不影响其他行会非常困难。
```sql
CREATE TABLE Vendors(
vend_id CHAR(10) NOT NULL PRIMARY KEY,
vend_name CHAR(50) NOT NULL,
vend_address CHAR(50) NULL,
vend_city CHAR(50) NULL,
vend_state CHAR(5) NULL,
vend_zip CHAR(10) NULL,
vend_country CHAR(50) NULL
);
```
```sql
-- 给表的vend_id列定义添加关键字PRIMARY KEY，使其成为主键
ALTER TABLE Vendors
ADD CONSTRAINT PRIMARY KEY (vend_id);
```
**外键**:**外键是表中的一列，其值必须列在另一表的主键中**。外键是保证引用完整性的极其重要部分。在定义外键后，DBMS不允许删除在另一个表中具有关联行的行,由于需要一系列的删除，因而利用**外键可以防止意外删除数据**
```sql
create table orderinfo (
    oid int comment '订单ID',
    oname varchar(50)  not null default '订单名：' comment '订单名',
    pid int not null comment '订单商品的商品ID',
    pno int default 0 comment '订单上屏数量',
    odetail tinytext null comment '订单详情',
    otime timestamp default current_timestamp comment '订单时间',
    primary key(oid),
    foreign  key (pid) references product(pdtid) on update cascade on delete cascade
    )engine=Innodb default charset='utf8' comment='订单详情';
```
```sql
ALTER TABLE Orders
ADD CONSTRAINT
FOREIGN KEY (cust_id) REFERENCES Customers (cust_id)
```
**唯一约束**:**唯一约束用来保证一列（或一组列）中的数据是唯一的**。它们类似于主键
- 表可包含多个唯一约束，但每个表只允许一个主键
- 唯一约束列可包含NULL值
- 唯一约束列可修改或更新
- 唯一约束列的值可重复使用
- 与主键不一样，唯一约束不能用来定义外键

```sql
create table check_unique(
        id int auto_increment comment 'id',
        name varchar(20) not null comment '姓名',
        age int not null comment '年龄' ,
        unique (name),#定义了unique约束
        check(age>15),
        primary key(id)
        )engine=Innodb default charset='utf8' comment='检查check和唯一unique' auto_increment=10 ;
```
**检查约束**:用来保证一列（或一组列）中的数据满足一组指定的条件,检查约束的常见用途有以下几点
- 检查最小或最大值。例如，防止0个物品的订单（即使0是合法的数）
- 指定范围。例如，保证发货日期大于等于今天的日期，但不超过今天起一年后的日期
- 只允许特定的值。例如，在性别字段中只允许M或F

```sql
CREATE TABLE OrderItems(
order_num INTEGER NOT NULL,
order_item INTEGER NOT NULL,
prod_id CHAR(10) NOT NULL,
quantity INTEGER NOT NULL CHECK (quantity > 0),
item_price MONEY NOT NULL
);
```
```sql
-- 添加检查约束，在Mysql之中，检查约束形同虚设
ADD CONSTRAINT CHECK (gender LIKE '[MF]')
```

**索引**:索引用来排序数据以加快搜索和排序操作的速度，不要忘了创建时候的**ON**关键字，在开始创建索引前，应该记住以下内容
- 索引改善检索操作的性能，**但降低了数据插入、修改和删除的性能**。在执行这些操作时，DBMS必须动态地更新索引。
- 索引数据可能要占用大量的存储空间
- 并非所有数据都适合做索引。取值不多的数据（如州）不如具有更多可能值的数据（如姓或名），能通过索引得到那么多的好处
- 索引用于数据过滤和数据排序。如果你经常以某种特定的顺序排序数据，则该数据可能适合做索引
- 可以在索引中定义多个列（例如，州加上城市）。这样的索引仅在以州加城市的顺序排序时有用。如果想按城市排序，则这种索引没有用处

```sql
##索引index,
#创建索引的目的是为了加快查询，过多的索引会占据大量空间，所以也会导致查询速度下降很严重；
#索引是一种特殊的文件(InnoDB数据表上的索引是表空间的一个组成部分)，它们包含着对数据表里所有记录的引用指针。
#索引分为聚簇索引和非聚簇索引两种，聚簇索引是按照数据存放的物理位置为顺序的，而非聚簇索引就不一样了；聚簇索引能提高多行检索的速度，而非聚簇索引对于单行的检索很快。
#索引按照种类可以分为1.普通索引，2.唯一索引，3.全文索引（仅可用于 MyISAM 表），4.单列索引、多列索引，5. 组合索引（最左前缀）
/*
create table tb_index(
        id int auto_increment,
        name varchar(20) not null comment'姓名',
        age int not null comment'年龄',
        height float not null comment'身高',
        birthday date not null comment'生日',
        home varchar(50) default 'X省X市X区' comment'故乡',
        hobby varchar(100) null comment'喜好',
        primary key(id),
        index cmonindex(age),#普通索引
        unique index uqindex(height)#唯一索引
        )engine=Innodb default charset='utf8' comment='个人信息的索引表';
show index from tb_index;
*/
#创建组合索引
-- create index combindex on tb_index (home,hobby);
-- create index tempindex on tb_index(birthday);
#删除索引
-- drop index tempindex on tb_index;uniquetableuniquetableuniquetable
/*
insert into tb_index values
       (1,'zhangsan',22,173,'1992-09-08','承德','唱歌'),
       (2,'lisi',24,163,'1991-09-08','铁岭','街舞'),
       (3,'wangerxiao',20,179,'1997-02-03','石家庄','摇滚'),
       (4,'marry',34,176,'1982-09-08','杭州','游泳'),
       (5,'kuang hai',24,181,'1992-09-08','重庆','吃火锅'),
       (6,'wawenhui',27,169,'1990-09-08','德令哈','啪啪啪')
*/
-- select * from tb_index where id=6;
```

**触发器**:**触发器是特殊的存储过程**，它在特定的数据库活动发生时自动执行。*触发器可以与特定表上的INSERT、UPDATE和DELETE操作（或组合）相关联*。与存储过程不一样（存储过程只是简单的存储SQL语句），**触发器与单个的表相关联**，
**用途**:触发器有如下的一些常见用途
- 保证数据一致。例如，在INSERT或UPDATE操作中将所有州名转换为大写
- 基于某个表的变动在其他表上执行活动。例如，每当更新或删除一行时将审计跟踪记录写入某个日志表
- 进行额外的验证并根据需要回退数据。例如，保证某个顾客的可用资金不超限定，如果已经超出，则阻塞插入
- 计算计算列的值或更新时间戳

**比较**:和约束相比，一般来说，**约束的处理比触发器快，因此在可能的时候，应该尽量使用约束**
```sql
-- drop trigger tginsert; --删除触发器

-- 创建触发器，不要忘了ON关键字

CREATE TRIGGER trigger_student_count_insert
AFTER INSERT
ON tg_student_info FOR EACH ROW
UPDATE tg_student_count SET student_count=student_count+1;

CREATE TRIGGER trigger_student_count_delete
AFTER DELETE
ON tg_student_info FOR EACH ROW
UPDATE tg_student_count SET student_count=student_count-1;

-- INSERT INTO tg_student_info VALUES(NULL,'张明'),(NULL,'李明'),(NULL,'王明');#触发触发器
```

** 数据库安全**:安全性使用SQL的**GRANT**和**REVOKE**语句来管理，不过，大多数DBMS提供了交互式的管理实用程序，这些实用程序在内部使用GRANT和REVOKE语句。一般说来，需要保护的操作有如下一些
- 对数据库管理功能（创建表、更改或删除已存在的表等）的访问
- 对特定数据库或表的访问
- 访问的类型（只读、对特定列的访问等）
- 仅通过视图或存储过程对表进行访问
- 创建多层次的安全措施，从而允许多种基于登录的访问和控制
- 限制管理用户账号的能力
