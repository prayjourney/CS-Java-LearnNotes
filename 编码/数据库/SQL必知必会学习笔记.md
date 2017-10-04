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



###chapter3 排序检索数据
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

###chapter4 过滤数据
**过滤数据**:数据根据where子句中指定的搜索条件进行过滤。where子句在表名（from子句）之后给出
**何时使用引号**:一般而言，除了数值之外，都需要用**''**将值包含起来，对于**日期来说，更是需要用引号包含起来**。
**检查的形式**:可以检查单值，使用等号，可以检查范围，使用大于(等于)，小于(等于)，不等于，另外还可以检查空值，NULL(no value)**它与字段包含0、空字符串或仅仅包含空格不同**，另外，**对于Null值的检查不能简单使用"="，而要使用IS NULL**



###chapter5 高级数据过滤
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



###chapter6 用通配符进行过滤
**LIKE操作符**:匹配操作符
**通配符**:用来匹配值的一部分的特殊字符，**通配符搜索只能用于文本字段（串），非文本数据类型字段不能使用通配符搜索**。
**常用通配符**:**%**，在搜索串中，%表示任何字符出现任意次数，**\_**下划线的用途与%一样，但它只匹配单个字符，而不是多个字符，**[]**方括号通配符用来指定一个字符集，它必须匹配指定位置（通配符的位置）的一个字符
**通配符的技巧**:，SQL的通配符很有用，但这种功能是有代价的，即**通配符搜索一般比前面讨论的其他搜索要耗费更长的处理时间**，=*不要过度使用通配符*=。如果其他操作符能达到相同的目的，应该使用其他操作符。*在确实需要使用通配符时，也**尽量不要把它们用在搜索模式的开始处***。*把通配符置于开始处，搜索起来是最慢的*。仔细注意通配符的位置。如果放错地方，可能不会返回想要的数据



###chapter7 创建计算字段
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



###chapter8 使用数据处理函数
**函数**:一般是在数据上执行的，为数据的转换和处理提供了方便，用于处理**文本字符串**（如删除或填充值，转换值为大写或小写）的文本函数。用于在数值数据上进行**算术操作**（如返回绝对值，进行代数运算）的数值函数。用于处理**日期和时间值**并从这些值中提取特定成分（如返回两个日期之差，检查日期有效性）的日期和时间函数



###chapter9 汇总数据
**聚集函数**:（aggregate function） 对某些行运行的函数，**计算并返回一个值**。

|函 数| 说 明|
|-----|-----|
|AVG()| 返回某列的平均值|
|**COUNT()**| 返回某列的行数|
|MAX()| 返回某列的最大值|
|MIN()| 返回某列的最小值|
|**SUM()**| 返回某列值之和|
**聚集不同值**对所有行执行计算，指定ALL参数或不指定参数（因为ALL是默认行为），如果不指定DISTINCT，则假定为ALL，**DISTINCT不能用于COUNT(\*)**，如果指定列名，则DISTINCT只能用于COUNT()。DISTINCT不能用于COUNT(\*)。类似地，DISTINCT必须使用列名，不能用于计算或表达式。



###chapter10 分组数据
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



###chapter11 使用子查询
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



###chapter12 联结表
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



###chapter13 创建高级联结
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



###chapter14 组合查询
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
**使用Union时排序**:++在用union组合查询时，只能使用一条ORDER BY子句，并且它必须位于最后一条SELECT语句之后++，*某些DBMS还支持另外两种union: **except**(有时称为minus)可用来检索只在第一个表中存在而在第二个表中不存在的行；而**intersect**可用来检索两个表中都存在的行。实际上，这些union很少使用，因为相同的结果可利用联结得到*