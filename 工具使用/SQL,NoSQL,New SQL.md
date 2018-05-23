###SQL,NoSQL,New SQL
***
##### SQL
结构化查询语言SQL（STRUCTURED QUERY LANGUAGE）是最重要的关系数据库操作语言。目前SQL也是关系型数据库的代称。结构化查询语言包含6各部分：

- 数据查询语言(DQL)  Data Query Language:
也称为“数据检索语句”，用以从表中获得数据，确定数据怎样在应用程序给出。保留字SELECT是DQL（也是所有SQL）用得最多的动词，其他DQL常用的保留字有WHERE，ORDER BY，GROUP BY和HAVING。这些DQL保留字常与其他类型的SQL语句一起使用。

- 数据操作语言(DML)  Data Manipulation Language:
其语句包括动词INSERT, UPDATE, DELETE它们分别用于添加，修改和删除表中的行。也称为动作查询语言。

- 事务处理语言(TPL):
它的语句能确保被DML语句影响的表的所有行及时得以更新。TPL语句包括BEGIN TRANSACTION，COMMIT和ROLLBACK。

- 数据控制语言(DCL):
它的语句通过GRANT或REVOKE获得许可，确定单个用户和用户组对数据库对象的访问。某些RDBMS可用GRANT或REVOKE控制对表单个列的访问。

- 数据定义语言(DDL):
其语句包括动词CREATE和DROP。在数据库中创建新表或删除表（CREAT TABLE 或 DROP TABLE）；为表加入索引等。DDL包括许多与人数据库目录中获得数据有关的保留字。它也是动作查询的一部分。

- 指针控制语言(CCL):
它的语句，像DECLARE CURSOR，FETCH INTO和UPDATE WHERE CURRENT用于对一个或多个表单独行的操作。



##### No SQL
NoSQL是对不同于传统的关系数据库的数据库管理系统的统称。
SQL和No SQL两者存在许多显著的不同点，其中最重要的是NoSQL不使用SQL作为查询语言。其数据存储可以不需要固定的表格模式，也经常会避免使用SQL的JOIN操作，一般有水平可扩展性的特征。*对NoSQL最普遍的解释是“非关联型的”*，强调**Key-Value Stores**和**文档数据库**的优点，而不是单纯的反对RDBMS。NoSQL市场领先企业是MarkLogic，MongoDB和Datastax。基于2015年的人气排名，最受欢迎的NoSQL数据库是**MongoDB**，Apache Cassandra和**Redis**。

###### NoSQL数据库的4大分类
- **键值(Key-Value)存储数据库**
  这一类数据库主要会使用到一个哈希表，这个表中有一个特定的键和一个指针指向特定的数据。Key/value模型对于IT系统来说的优势在于简单、易部署。但是如果DBA只对部分值进行查询或更新的时候，Key/value就显得效率低下了。举例如：Tokyo Cabinet/Tyrant, Redis, Voldemort, Oracle BDB.
- 列存储数据库
  这部分数据库通常是用来应对分布式存储的海量数据。键仍然存在，但是它们的特点是指向了多个列。这些列是由列家族来安排的。如：Cassandra, HBase, Riak.
- **文档型数据库**
  文档型数据库的灵感是来自于Lotus Notes办公软件的，而且它同第一种键值存储相类似。该类型的数据模型是版本化的文档，半结构化的文档以特定的格式存储，比如JSON。文档型数据库可 以看作是键值数据库的升级版，允许之间嵌套键值。而且文档型数据库比键值数据库的查询效率更高。如：CouchDB, MongoDb. 国内也有文档型数据库SequoiaDB，已经开源。
- **图形(Graph)数据库**
  图形结构的数据库同其他行列以及刚性结构的SQL数据库不同，它是使用灵活的图形模型，并且能够扩展到多个服务器上。NoSQL数据库没有标准的查询语言(SQL)，因此进行数据库查询需要制定数据模型。许多NoSQL数据库都有REST式的数据接口或者查询API。如：Neo4J, InfoGrid, Infinite Graph.


![nosql](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/NoSQL.png)

###### 适用情况
NoSQL数据库在以下的这几种情况下比较适用：1、数据模型比较简单；2、需要灵活性更强的IT系统；3、对数据库性能要求较高；4、不需要高度的数据一致性；5、对于给定key，比较容易映射复杂值的环境。



##### New SQL
NewSQL 是对各种新的可扩展/高性能数据库的简称，这类数据库不仅具有NoSQL对海量数据的存储管理能力，还保持了传统数据库支持ACID和SQL等特性。NewSQL是指这样一类新式的关系型数据库管理系统，针对OLTP（读-写）工作负载，追求提供和NoSQL系统相同的扩展性能，且仍然保持ACID和SQL等特性（scalable and ACID and (relational and/or sql -access)）。
现有NewSQL系统厂商包括Clustrix、GenieDB、ScalArc、Schooner、VoltDB、RethinkDB、ScaleDB、Akiban、CodeFutures、ScaleBase、Translattice和NimbusDB，以及 Drizzle、带有 NDB的 MySQL 集群和带有HandlerSocket的MySQL。后者包括Tokutek和JustOne DB。相关的“NewSQL作为一种服务”类别包括亚马逊关系数据库服务，微软SQLAzure，Xeround和FathomDB。



ref:
1.[结构化查询语言](https://baike.baidu.com/item/%E7%BB%93%E6%9E%84%E5%8C%96%E6%9F%A5%E8%AF%A2%E8%AF%AD%E8%A8%80?fromtitle=sql&fromid=86007),   2.[NoSQL](https://zh.wikipedia.org/wiki/NoSQL),   3.[LIST OF NOSQL DATABASES](http://nosql-databases.org/),   4.Understanding NoSQL](https://spring.io/understanding/NoSQL),   5.[NoSQL](https://baike.baidu.com/item/NoSQL),   6.