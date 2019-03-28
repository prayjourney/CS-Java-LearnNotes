### SQL索引

***
##### 创建索引
索引的**创建**可以在**CREATE TABLE语句中进行**，也可以**单独用CREATE INDEX**或**ALTER TABLE**来++给表增加索引++。以下命令语句分别展示了如何创建==主键索引==（PRIMARY KEY），联合索引（UNIQUE）和==普通索引==（INDEX）的方法。

```sql
mysql>ALTER TABLE 表名 ADD INDEX 索引名 列名;
mysql>ALTER TABLE 表名 ADD UNIQUE 索引名 列名;
mysql>ALTER TABLE 表名 ADD PRIMARY KEY 索引名 列名;
mysql>CREATE INDEX 索引名 ON 表名 列名;
mysql>CREATE UNIQUE INDEX 索引名 ON 表名 列名;-- 联合唯一索引
```

```sql
例如：
mysql>ALTER TABLE `article` ADD INDEX `id`; -- 给article表增加id索引
或者：
mysql>ALTER TABLE `article` ADD INDEX (`id`,`order_id`);  -- 给article表增加id索引，order_id索引
```


##### 重建索引
**重建索引在常规的数据库维护操作中经常使用**。在数据库运行了较长时间后，索引都有损坏的可能，这时就需要重建。对数据重建索引可以起到提高检索效率。

```sql
mysql> REPAIR TABLE 表名 QUICK;
```



##### 查询数据表索引
MySQL++查询表索引命令++的有两种命令形式：

```sql
mysql> SHOW INDEX FROM 表名;
or：
mysql> SHOW keys FROM 表名;

mysql> SHOW INDEX FROM uc_member;
+--------+---------+----------+----------+---------+-------+----------+-------+------+------+----------+--------+
|Table|Non_unique|Key_name|Seq_in_index|Column_name|Collation|Cardinality|Sub_part|Packed|Null|Index_type |Comment|
| uc_member |  0 | PRIMARY             |1 | member_id       | A |     1099 |     NULL | NULL   |   | BTREE      |         |
| uc_member |  1 | idx_nickname_passwd |1 | member_nickname | A |      549 |     NULL | NULL   |   | BTREE      |         |
| uc_member |  1 | idx_nickname_passwd |2 | member_password | A |     1099 |     NULL | NULL   |   | BTREE      |         |
| uc_member |  1 | member_mobile       |1 | member_mobile   | A |     1099 |     NULL | NULL   |   | BTREE      |         |
+--------+---------+----------+----------+---------+-------+----------+-------+------+------+----------+--------+
4 rows in set (0.00 sec)
```
表头解释：

| column | column |
|--------|--------|
|**Non_unique**|如果索引不能包括重复词，则为0。如果可以，则为1|
|**Key_name**|索引的名称|
|Seq_in_index |索引中的列序列号，从1开始|
|Column_name |列名称|
|Collation |列以什么方式存储在索引中。在MySQL中，有值‘A'（升序）或NULL（无分类）|
|Cardinality |索引中唯一值的数目的估计值通过运行ANALYZE TABLE或myisamchk -a可以更新。基数根据被存储为整数的统计数据来计数，所以即使对于小型表，该值也没有必要是精确的。基数越大，当进行联合时，MySQL使用该索引的机 会就越大|
|Sub_part |如果列只是被部分地编入索引，则为被编入索引的字符的数目。如果整列被编入索引，则为NULL|
|Packed |指示关键字如何被压缩。如果没有被压缩，则为NULL|
|Null |如果列含有NULL，则含有YES。如果没有，则该列含有NO|
|**Index_type** |用过的索引方法（BTREE, FULLTEXT, HASH, RTREE）|



##### 删除索引
**删除索引可以使用ALTER TABLE或DROP INDEX语句来实现**，**DROP INDEX可以在ALTER TABLE内部作为一条语句处理**，其格式如下：

```sql
mysql>DROP index 索引名 ON 表名 列名;
mysql>ALTER TABLE 表名 DROP INDEX 索引名 列名;
mysql>ALTER TABLE 表名 DROP UNIQUE 索引名 列名;
mysql>ALTER TABLE 表名 DROP PRIMARY KEY 索引名 列名;
```

在上面前三条语句中，都删除了table_name中的索引index_name。
而在最后一条语句中，只在删除PRIMARY KEY索引中使用，因为一个表只可能有一个PRIMARY KEY索引，因此也可不指定索引名。
如果没有创建PRIMARY KEY索引，但表具有一个或多个UNIQUE索引，则MySQL将删除第一个UNIQUE索引。
*如果从表中删除某列，则索引会受影响。对于多列组合的索引，如果删除其中的某列，则该列也会从索引中删除*。
如果删除组成索引的所有列，则整个索引将被删除。



##### 索引、主键、唯一索引、联合索引梳理

- 索引概念：**索引就好比一本书的目录，它会让你更快的找到内容**，++显然目录（索引）并不是越多越好++，假如这本书1000页，有500也是目录，它当然效率低，**目录是要占纸张的,而索引是要占磁盘空间的**。

- **Mysql索引主要有两种结构：hash和B+树**：
**hash**:hsah索引在mysql比较少用,他以把数据的索引以hash形式组织起来,因此当查找某一条记录的时候,**速度非常快**.当时因为是hash结构,每个键只对应一个值,而且是散列的方式分布.所以他并不支持范围查找和排序等功能.
**B+树**:b+tree是mysql使用最频繁的一个索引数据结构,数据结构以平衡树的形式来组织,因为是树型结构,所以更适合用来处理排序,范围查找等功能.相对hash索引,**B+树在查找单条记录的速度虽然比不上hash索引**,==但是因为更适合排序等操作==,所以他更受用户的欢迎.毕竟不可能只对数据库进行单条记录的操作.

- Mysql常见索引有：**主键索引**、**唯一索引**、**普通索引**、**全文索引**、**组合索引**
**PRIMARY KEY(主键索引)**：`ALTER TABLE 表名 ADD PRIMARY KEY 列名`
**UNIQUE(唯一索引)**：     `ALTER TABLE 表名 ADD UNIQUE 列名`
**INDEX(普通索引)**：      `ALTER TABLE 表名 ADD INDEX 索引名 列名`
**FULLTEXT(全文索引)**:    `ALTER TABLE 表名 ADD FULLTEXT 列名 --仅仅在MyIsam引擎下`
**组合索引**：             `ALTER TABLE 表名 ADD INDEX 索引名 (列名1,列名2, 列名3)`

- Mysql各种索引区别：
**普通索引**：最基本的索引，**没有任何限制**，MyIASM中默认的**BTREE类型的索引**，也是我们大多数情况下用到的索引
```sql
	–- 直接创建索引
	CREATE INDEX index_name ON table(column_name)
	–- 修改表结构的方式添加索引
	ALTER TABLE table_name ADD INDEX index_name ON (column_name)
	–- 创建表的时候同时创建索引
	CREATE TABLE `table` (
	`id` int(11) NOT NULL AUTO_INCREMENT ,
	`title` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
	`time` int(10) NULL DEFAULT NULL ,
	PRIMARY KEY (`id`),
	INDEX index_name (title(length))
	)
	–- 删除索引
	DROP INDEX index_name ON table
```
**唯一索引**：与"普通索引"类似，不同的就是：**索引列的值必须唯一**，++但允许有空值++，如果是组合索引，则列值的组合必须唯一，创建方法和普通索引类似
```sql
	–- 创建唯一索引
	CREATE UNIQUE INDEX indexName ON table(column_name)
	–- 修改表结构
	ALTER TABLE table_name ADD UNIQUE indexName ON (column_name)
	–- 创建表的时候直接指定
	CREATE TABLE `table` (
	`id` int(11) NOT NULL AUTO_INCREMENT ,
	`title` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
	`time` int(10) NULL DEFAULT NULL ,
	PRIMARY KEY (`id`),
	UNIQUE indexName (title(length))
	);
```
**主键索引**：它 是一种==特殊的唯一索引==，**不允许有空值**。
**全文索引**：仅可**用于MyISAM 表**，++针对较大的数据，生成全文索引很耗时好空间++。MySQL从3.23.23版开始支持全文索引和全文检索，**FULLTEXT索引仅可用于 MyISAM 表**；他们可以从CHAR、VARCHAR或TEXT列中作为CREATE TABLE语句的一部分被创建，或是随后使用ALTER TABLE 或CREATE INDEX被添加。但是对于较大的数据集，将你的资料输入一个没有FULLTEXT索引的表中，然后创建索引，其速度比把资料输入现有FULLTEXT索引的速度更为快。**不过切记对于大容量的数据表，生成全文索引是一个非常消耗时间非常消耗硬盘空间的做法**。
```sql
	–- 创建表的适合添加全文索引
	CREATE TABLE `table` (
	`id` int(11) NOT NULL AUTO_INCREMENT ,
	`title` char(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL ,
	`content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL ,
	`time` int(10) NULL DEFAULT NULL ,
	PRIMARY KEY (`id`),
	FULLTEXT (content)
	);
	–- 修改表结构添加全文索引
	ALTER TABLE article ADD FULLTEXT index_content(content)
	–-直接创建索引
	CREATE FULLTEXT INDEX index_content ON article(content)
```
**组合索引**：++为了更多的提高mysql效率可建立组合索引++，**遵循”最左前缀“原则**，平时用的SQL查询语句一般都有比较多的限制条件，所以**为了进一步榨取MySQL的效率，就要考虑建立组合索引**。例如上表中针对title和time建立一个组合索引：`ALTER TABLE article ADD INDEX index_titme_time (title,time)`，建立这样的组合索引，其实是相当于分别建立了下面两组组合索引：
```sql
–title,time
–title
```
为什么没有time这样的组合索引呢？这是因为MySQL组合索引“**最左前缀**”的结果。**简单的理解就是只从最左面的开始组合**。并不是只要包含这两列的查询都会用到该组合索引，如下面的几个SQL所示：
```sql
	–-使用到上面的索引
	SELECT * FROM article WHREE title='测试' AND time=1234567890;
	SELECT * FROM article WHREE utitle='测试';
	–-不使用上面的索引
	SELECT * FROM article WHREE time=1234567890;
```
- 索引的实质
**索引是一种特殊的文件(InnoDB数据表上的索引是表空间的一个组成部分)，它们包含着对数据表里所有记录的引用==指针==**。普通索引(由关键字KEY或INDEX定义的索引)的**唯一任务是加快对数据的访问速度**。
++普通索引允许被索引的数据列包含重复的值++。如果能确定某个数据列将只包含彼此各不相同的值，在为这个数据列创建索引的时候就应该用关键字UNIQUE把它定义为一个唯一索引。也就是说，唯一索引可以保证数据记录的唯一性。
**主键**，**是一种特殊的唯一索引，在一张表中只能定义一个主键索引**，主键用于唯一标识一条记录，使用关键字 PRIMARY KEY 来创建。
*索引可以覆盖多个数据列*，如像**INDEX(columnA, columnB)索引，这就是联合索引**。
**主键分为复合主键和联合主键**，++复合主键就是指表的主键由一个以上的字段组成++。
例如：
```sql
create table test(
    name varchar(19),
    id number,
    value varchar(10),
    primary key (id,name)
   )engine=innodb default charset='utf8'
```
==上面的id和name字段组合起来就是你test表的复合主键 （若其一为单索引字段时，左边的id才会有索引）==，它的出现是因为你的*name字段可能会出现重名*，+所以要加上ID字段这样就可以保证你记录的唯一性+，一般情况下，**主键的字段长度和字段数目要越少越好**。==联合主键==，顾名思义就是**多个主键联合形成一个主键组合，体现在联合**。主键原则上是唯一的，别被唯一值所困扰。**索引可以极大的提高数据的查询速度**，==但是会降低插入、删除、更新表的速度==，*因为在执行这些写操作时，还要操作索引文件*。
主键A跟主键B组成联合主键，主键A跟主键B的数据可以完全相同(困扰吧，没关系)，联合就在于主键A跟主键B形成的联合主键是唯一的。下例主键A数据是1，主键B数据也是1，联合主键其实是11，这个11是唯一值，绝对不充许再出现11这个唯一值。(这就是多对多关系)
|主键A数据 |主键B数据|
|---------|--------|
|1　　　　|　　1|
|2　　　　|　　2|
|3　　　　|　　3|
主键A与主键B的联合主键值最多也就是
==11，12，13，21，22，23，31，32，33==



##### MySQL索引的优化
上面都在说使用索引的好处，但过多的使用索引将会造成滥用。因此索引也会有它的**缺点**：++虽然索引大大提高了查询速度，==同时却会降低更新表的速度==++，如对表进行INSERT、UPDATE和DELETE。**因为更新表时，MySQL不仅要保存数据，还要保存一下索引文件**。建立索引会占用磁盘空间的索引文件。一般情况这个问题不太严重，*但如果你在一个大表上创建了多种组合索引，索引文件的会膨胀很快*。索引只是提高效率的一个因素，如果你的MySQL有大数据量的表，就需要花时间研究建立最优秀的索引，或优化查询语句。下面是一些总结以及收藏的MySQL索引的注意事项和优化方法。
- **何时使用聚集索引或非聚集索引**？
|动作描述|	使用聚集索引|	使用非聚集索引|
|--------|--------|--------|
|列经常被分组排序|	使用|	使用|
|返回某范围内的数据|	使用|	不使用|
|一个或极少不同值|	不使用|	不使用|
|小数目的不同值|	使用|	不使用|
|大数目的不同值|	不使用|	使用|
|频繁更新的列|	不使用|	使用|
|外键列|	使用|	使用|
|主键列|	使用|	使用|
|频繁修改索引列|	不使用|	使用|
事实上，我们可以通过前面聚集索引和非聚集索引的定义的例子来理解上表。如：++返回某范围内的数据一项。比如您的某个表有一个时间列，恰好您把聚合索引建立在了该列，这时您查询2004年1月1日至2004年10月1日之间的全部数据时，这个速度就将是很快的++，因为您的这本字典正文是按日期进行排序的，**聚类索引只需要找到要检索的所有数据中的开头和结尾数据即可**；而不像非聚集索引，必须先查到目录中查到每一项数据对应的页码，然后再根据页码查到具体内容。其实这个具体用法我还不是很理解，只能等待后期的项目开发中慢慢学学了。

- **索引不会包含有NULL值的列**
**只要列中包含有NULL值都将不会被包含在索引中，复合索引中只要有一列含有NULL值，那么这一列对于此复合索引就是无效的**。++所以我们在数据库设计时不要让字段的默认值为NULL++。

- **使用短索引**
对串列进行索引，如果可能应该指定一个前缀长度。例如，如果有一个CHAR(255)的列，如果在前10个或20个字符内，多数值是惟一的，那么就不要对整个列进行索引。**短索引不仅可以提高查询速度而且可以节省磁盘空间和I/O操作**。

- 索引列排序
**MySQL查询只使用一个索引**，++因此如果where子句中已经使用了索引的话，那么order by中的列是不会使用索引的++。==因此数据库默认排序可以符合要求的情况下不要使用排序操作==；*尽量不要包含多个列的排序，如果需要最好给这些列创建复合索引*。

- like语句操作
**一般情况下不鼓励使用like操作**，==如果非使用不可，如何使用也是一个问题。like “%aaa%” 不会使用索引而like “aaa%”可以使用索引==。

- **不要在列上进行运算**
+例如：select * from users where YEAR(adddate)<2007，将在每个行上进行运算，这将导致索引失效而进行全表扫描，因此我们可以改成：select * from users where adddate<’2007-01-01′。关于这一点可以围观：一个单引号引发的MYSQL性能损失+。
**最后总结一下，MySQL只对一下操作符才使用索引：<,<=,=,>,>=,between,in,以及某些时候的like(不以通配符%或_开头的情形)。而理论上每张表里面最多可创建16个索引，不过除非是数据量真的很多，否则过多的使用索引也不是那么好玩的**。



##### 一个小例子
```sql
##索引index,
#创建索引的目的是为了加快查询，过多的索引会占据大量空间，所以也会导致查询速度下降很严重；
#索引是一种特殊的文件(InnoDB数据表上的索引是表空间的一个组成部分)，它们包含着对数据表里所有记录的引用指针。
#索引分为聚簇索引和非聚簇索引两种，聚簇索引是按照数据存放的物理位置为顺序的，而非聚簇索引就不一样了；聚簇索引能提高多行检索的速度，而非聚簇索引对于单行的检索很快。
#索引按照种类可以分为1.普通索引，2.唯一索引，3.全文索引（仅可用于 MyISAM 表），4.单列索引、多列索引，5. 组合索引（最左前缀）

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

#查看表中的index
show index from tb_index;
#创建组合索引
create index combindex on tb_index (home,hobby);
create index tempindex on tb_index(birthday);
#删除索引
drop index tempindex on tb_index;

insert into tb_index values
       (1,'zhangsan',22,173,'1992-09-08','承德','唱歌'),
       (2,'lisi',24,163,'1991-09-08','铁岭','街舞'),
       (3,'wangerxiao',20,179,'1997-02-03','石家庄','摇滚'),
       (4,'marry',34,176,'1982-09-08','杭州','游泳'),
       (5,'kuang hai',24,181,'1992-09-08','重庆','吃火锅'),
       (6,'wawenhui',27,169,'1990-09-08','德令哈','啪啪啪')

#查询操作
select * from tb_index where id=6;
```
ref：
1.[mysql操作命令梳理（1）-索引](http://www.cnblogs.com/kevingrace/p/5835474.html), 2.[mysql索引总结----mysql 索引类型以及创建](http://www.cnblogs.com/lihuiyong/p/5623191.html), 3.[mysql之index(索引)](http://www.cnblogs.com/alazalazalaz/p/4083696.html)