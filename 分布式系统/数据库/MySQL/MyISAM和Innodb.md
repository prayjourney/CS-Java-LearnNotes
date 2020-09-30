### MyISAM和Innodb
***
##### 重要区别
两种类型最主要的差别就是Innodb 支持__事务处理__与__外键__和__行级锁__。



##### 简易区别

MyISAM和Innodb的最大区别是：**两种类型最主要的差别就是Innodb 支持事务处理与外键和行级锁**，**读操作多用MyISAM，写操作多用InnoDB**
InnoDB和MyISAM是MySQL中最常用的两个表类型，这两个表类型各有优劣，视具体应用而定。基本的差别为：**MyISAM类型不支持事务处理等高级处理，而InnoDB类型支持事务处理**。*MyISAM类型的表强调的是性能，其执行数度比InnoDB类型更快，但是不提供事务支持*，而**InnoDB提供事务支持以及外部键等高级数据库功能**。
  以下是一些细节和具体实现的差别：
　1.++InnoDB不支持FULLTEXT类型的索引++
　2.++InnoDB中不保存表的具体行数++，也就是说，执行select count(\*) from table时，InnoDB要扫描一遍整个表来计算有多少行，但是MyISAM只要简单的读出保存好的行数即可。注意的是，当count(*)语句包含 where条件时，两种表的操作是一样的。
　3.**对于AUTO_INCREMENT类型的字段，InnoDB中必须包含只有该字段的索引**，但是在MyISAM表中，可以和其他字段一起建立联合索引。
　4.*DELETE FROM table时，InnoDB不会重新建立表，而是一行一行的删除*。
　5.*LOAD TABLE FROM MASTER操作对InnoDB是不起作用的，解决方法是首先把InnoDB表改成MyISAM表，导入数据后再改成InnoDB表，但是对于使用的额外的InnoDB特性(例如外键)的表不适用。
　++另外，InnoDB表的行锁也不是绝对的，假如在执行一个SQL语句时MySQL不能确定要扫描的范围，InnoDB表同样会锁全表，例如update table set num=1 where name like “%aaa%”++



##### 详细区别

1.**MySQL默认采用的是MyISAM**
2.**MyISAM不支持事务，而InnoDB支持**。==InnoDB的AUTOCOMMIT默认是打开的，即每条SQL语句会默认被封装成一个事务==，自动提交，这样会影响速度，*所以最好是把多条SQL语句显示放在begin和commit之间，组成一个事务去提交*。
3.**InnoDB支持数据行锁定，MyISAM不支持行锁定，只支持锁定整个表**。即MyISAM同一个表上的读锁和写锁是互斥的，MyISAM并发读写时如果等待队列中既有读请求又有写请求，默认写请求的优先级高，即使读请求先到，所以MyISAM不适合于有大量查询和修改并存的情况，那样查询进程会长时间阻塞。因为MyISAM是锁表，所以某项读操作比较耗时会使其他写进程饿死。
4.**InnoDB支持外键，MyISAM不支持**。
5.**InnoDB的主键范围更大，最大是MyISAM的2倍**。
6.**InnoDB不支持全文索引，而MyISAM支持**。全文索引是指对char、varchar和text中的每个词（停用词除外）建立倒排序索引。MyISAM的全文索引其实没啥用，因为它不支持中文分词，必须由使用者分词后加入空格再写到数据表里，而且少于4个汉字的词会和停用词一样被忽略掉。
7.**MyISAM支持GIS数据，InnoDB不支持**。即MyISAM支持以下空间数据对象：Point, Line, Polygon, Surface等。
8.没有where的count(\*)使用MyISAM要比InnoDB快得多。因为MyISAM内置了一个计数器，count(\*)时它直接从计数器中读，而InnoDB必须扫描全表。所以在InnoDB上执行count(\*)时一般要伴随where，且where中要包含主键以外的索引列。为什么这里特别强调“主键以外”？因为**InnoDB中primary index是和raw data存放在一起的**，而*secondary index则是单独存放，然后有个指针指向primary key*。所以只是count(\*)的话使用secondary index扫描更快，而primary key则主要在扫描索引同时要返回raw data时的作用较大。

|MyISAM |InnoDB| -- |
|---|---|---|
|构成上的区别：| 每个MyISAM在磁盘上存储成三个文件。第一个文件的名字以表的名字开始，扩展名指出文件类型。.frm文件存储表定义。数据文件的扩展名为.MYD (MYData)。索引文件的扩展名是.MYI (MYIndex)。|基于磁盘的资源是InnoDB表空间数据文件和它的日志文件，InnoDB 表的大小只受限于操作系统文件的大小，一般为 2GB|
|事务处理上方面:| MyISAM类型的表强调的是性能，其执行数度比InnoDB类型更快，但是不提供事务支持| InnoDB提供事务支持事务，外部键等高级数据库功能|
|SELECT   UPDATE,INSERT，Delete操作|	  如果执行大量的SELECT，MyISAM是更好的选择|  	  1.如果你的数据执行大量的INSERT或UPDATE，出于性能方面的考虑，应该使用InnoDB表/n2.DELETE   FROM table时，InnoDB不会重新建立表，而是一行一行的删除。/n  3.LOAD   TABLE FROM MASTER操作对InnoDB是不起作用的，解决方法是首先把InnoDB表改成MyISAM表，导入数据后再改成InnoDB表，但是对于使用的额外的InnoDB特性（例如外键）的表不适用|
|对AUTO_INCREMENT的操作|  每表一个AUTO_INCREMEN列的内部处理 MyISAM为INSERT和UPDATE操作自动更新这一列。这使得AUTO_INCREMENT列更快（至少10%）。在序列顶的值被删除之后就不能再利用。(当AUTO_INCREMENT列被定义为多列索引的最后一列，可以出现重使用从序列顶部删除的值的情况）。AUTO_INCREMENT 值可用ALTER TABLE或myisamch来重置，对于AUTO_INCREMENT类型的字段，InnoDB中必须包含只有该字段的索引，但是在MyISAM表中，可以和其他字段一起建立联合索引，更好和更快的auto_increment处理|如果你为一个表指定AUTO_INCREMENT列，在数据词典里的InnoDB表句柄包含一个名为自动增长计数器的计数器，它被用在为该列赋新值。自动增长计数器仅被存储在主内存中，而不是存在磁盘上，关于该计算器的算法实现，请参考，**AUTO_INCREMENT列在InnoDB**里如何工作|
|表的具体行数|select count(*) from table,MyISAM只要简单的读出保存好的行数，注意的是，当count(*)语句包含   where条件时，两种表的操作是一样的| 	  InnoDB 中不保存表的具体行数，也就是说，执行select count(*) from table时，InnoDB要扫描一遍整个表来计算有多少行|
|锁| 表锁|	  提供行锁(locking on row level)，提供与 Oracle 类型一致的不加锁读取(non-locking read in SELECTs)，另外，InnoDB表的行锁也不是绝对的，如果在执行一个SQL语句时MySQL不能确定要扫描的范围，InnoDB表同样会锁全表，例如update table set num=1 where name like “%aaa%”|



ref:
1.[MyISAM和InnoDB的区别](http://www.cnblogs.com/lyl2016/p/5797519.html), 2.[MySQL存储引擎－－MyISAM与InnoDB区别](http://blog.csdn.net/xifeijian/article/details/20316775)