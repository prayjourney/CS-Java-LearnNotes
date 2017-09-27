###1.了解
-- 略



###2.检索
#select
# select * from student;
-- select sno,sname from student;
-- select * from student;

#插入
-- insert into student(sno,sname,ssex,sbirthday,class) values(110,"李时珍","男",'1533-06-24 00:00:00',95054);
-- insert into student(sno,sname,ssex,sbirthday,class) values(112,"李时珍","男",'1995-06-24 00:00:00',95023);
-- insert into student(sno,sname,ssex,sbirthday,class) values(118,"李时珍","男",'2005-12-09 00:00:00',95012);

#检索多个字段
# select distinct sname from student;
# select sname from student;
# select distinct sno,sname from student;

#结果限制
#limit关键字
-- Mysql之中没有Top关键字
# select TOP 5 sno,sname,ssex from student;
#Mysql之中可以用limit关键字来代替
-- select  sname,sno,ssex from student limit 5;

#注释
-- 从第3行其返回6个数据, offset表示从何处开始
#select * from student limit 6 offset 3;



###3.排序
#order by
#order by后面可以有多个字段，依次进行排序
#select * from student order by class,sno;

#order by支持按列排序
#select  sno,sname,ssex from student order by 3,1;

#order by是最后一个子句，desc的作用范围是其前面的一条，如果有多条，则需要每条后面都要说明course
/*select * from student order by sno desc,class;
select * from student order by sname desc,class asc;
select * from student order by sname desc,class desc;*/



###4.where子句过滤(行数据)
#select * from score where sno>103 order by sno desc,degree desc;
#select * from  student as s  where s.sbirthday>'1974-06-03'  and s.sbirthday <'1977-09-01 00:00:00'

#测试空值
#select * from student where sbirthday is Null;

#and
#select * from teacher where tsex='女' and depart ='计算机系';

#or
#select * from teacher where tsex='女' or depart ='助教';

#and 和or的组合，and优先级更高,导致有sno<107的数据进入
-- select * from score where sno>107 or degree>80 and cno='3-105';
#and 和or的组合，and优先级更高,用小括号消除歧义
-- select * from score where (sno>107 or degree>80) and cno='3-105';



###5.where子句高级使用
#in
#select * from  student where  sname in('李时珍','陆君','王丽') order by sbirthday desc;
/*select * from  student where  sname in(
    select sname from student where sname !='李时珍');#此处子查询只能有一条返回的数据
    */

#not
-- not 可以否定任何条件，相当于取反，其位于条件之前
-- select * from score where not degree>80; 



###6.通配符
#like
-- select * from student where  sname like '王%';
-- select * from student where  sname like '%王%';
# select * from student where  class like %95; #通配符之能对文本类型的字段使用，无法对非文本类型字段使用

#'_','%'
#select * from student where sname like '王_';
#select * from student where sname like '_王_';
#select * from student where sname like '[王李]%';#[]在mysql之中好像不起作用？



###7.拼接，计算
#拼接
-- mysql不支持这种，支持的是concat函数
-- select sname +'|'+ ssex +'|'+ from student;
-- select sname,ssex,concat( sname, '-' , ssex) as info from student;
#select concat( sname, '-' , ssex) as info from student;
#select GROUP_CONCAT(sname,ssex)from student;
#select concat(sname,'-', ssex) as info from student; #中间的-是一个连接符
#select *from student where sno>104;

#执行算数计算
#select sno, sname, ssex,class, sno+sno as 2sno from student  where  sno>109;
#select now();
#select trim('abc');



###8.使用函数
-- select upper(sname), ssex from student ;
-- select length(sname), ssex from student ;
-- select sname,sbirthday from student where Year(sbirthday)>1978;
-- select sin(sno) as sinsno from student where dayofmonth(sbirthday)=14;
-- select PI();
-- select curdate();
-- select now();
-- select dayofmonth(now());
-- select dayofmonth(sbirthday) from student;
-- select * from student as s where DayofMonth(s.sbirthday)>13;



###9.聚合函数sum avg count max min 返回一个值,对于Null值忽略，是不是不能用于where子句？
-- select concat(sum(degree),'---',avg(degree),'---',count(sno)) as allinof,sno from score;
-- select concat(sum(degree),'---',avg(degree),'---',count(sno)) as allinof,sno from score where degree>avg(degree);#invalid use group function
-- select sno, avg(degree) as avg_degree from  score where sno>101 order by sno desc ;

/*select sno, avg(distinct(degree)) as avg_degree from  score where sno>avg(sno);
select sno, avg(distinct(degree)) as avg_degree from  score where sno>(select avg(sno) from score);
*/



###10.分组
-- select sno,count(*) as nu from score group by sno order by sno desc;
-- having和where在语法上是相同的，但是作用上是不一样，而“类似的”，having过滤分组数据，where过滤行数据。
-- select ssex,count(*) as nu from student group by ssex having count(*)>3;
-- select ssex,count(*) as nu from student where sno>104 group by ssex having count(*)>3;#where group by having 可以同时使用
-- select sno,ssex,count(*) as nu from student where sno>104 group by ssex having count(*)>2 order by sno asc;#排序不能只依靠group by,还是要用order by
-- select tbname,count(tbname) as book,press from textbook where price>30 group by press having count(*)>2;
-- select  tbname,tbno,author,count(author) as a from textbook group by author having count(author)>1;
-- select  tbname,press,count(press) as a from textbook group by author having count(press)>1 order by a desc;



###11.子查询
#刘冰老师所教课程的出版社与书名
/*
select tno from teacher where tname='刘冰';
select cno from course where tno='831';
select press, tbname from textbook where cno ='5-238';
select press, tbname from textbook where cno in(
    select cno from course where tno in(
        select tno from teacher where tname='刘冰'));
*/

#所有老师所教课程的出版社与书名，输出press, tbname
/*select press, tbname from textbook where cno in(
    select cno from course where tno in(
        select tno from teacher));
*/

#所有老师所教课程的出版社与书名，输出tname，press, tbname
-- select tname,press,tbname from 
-- select cno from course where tno in(
-- select tno from teacher);

/*
select tname,tno,tbname,press
from teacher,textbook
where textbook.cno in
(select course.cno from course where course.tno=teacher.tno);*/

###12.联结
/*select cname,tbname,press,price,author 
from course,textbook
where course.cno=textbook.cno order by price desc;
*/

#笛卡尔积(结果是表一行数*表二行数)
/*select tname,tno,tbname,press
from teacher,textbook;*/
#等值联结
/*
select cname,tbname,press
from course,textbook
where course.cno=textbook.cno;
*/

#内联（就是等值联结）
#上面一句和这一句相等同
/*
select cname,tbname,press
from course inner join textbook
on course.cno=textbook.cno;*/

#多个表的内联
/*select tname,cname, tbname,press
from teacher,course,textbook
where teacher.tno=course.tno and course.cno=textbook.cno order by tname;
*/
-- select tbname as bookname,press as pressname,price as bookprice from textbook as tb,course as cs where  tb.cno=cs.cno;

###创建高级连接
#自连接
-- select * from course where  cname=(select cname from course where cname='计算机导论');
-- 等价于select * from course where cname='计算机导论';
-- #当cname处的=，子查询的返回结果大于1条的时候，会报错，下面的语句是错误的，下下面的是正确的
-- select * from course where  cname=(select cname from course where length(cname)>4);
-- select * from course where  cname in (select cname from course where length(cname)>4);
#使用自连接（自连接代替子查询，效率也很高）
-- select c1.cno,c1.cname,c1.tno from course as c1,course as c2 where c1.cno=c2.cno and c1.cname=c2.cname;

#自然连接（保持每个列只出现一次）
-- 自然联结要求你只能选择那些唯一的列，一般通过对一个表使用通配符（SELECT *）。
-- select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc,student as st where  sc.sno=st.sno;

#外连接（包含了在表中没有关联的行）
-- 关联时候，无where，一律换成on
-- inner join:select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc inner join student as st on  sc.sno=st.sno;
-- left outer join:select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc left outer join student as st on  sc.sno=st.sno;
-- right outer join:select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc right outer join student as st on  sc.sno=st.sno;
-- full outer join（MySQL无full outer join）：select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc full outer join student as st on  sc.sno=st.sno;

#使用聚合函数的连接
#聚合函数返回的结果是一个结果，所以其结果是一个数字，此时，如果所要展示的列之中，必须是条件之中所过滤后的列
-- select sc.*,st.sno as stno, st.sname as stsname ,st.ssex as stssex from score as sc right outer join student as st on  sc.sno=st.sno group by sc.degree asc,sc.sno desc;
-- select sc.*,st.sno as stno, st.sname as stsname ,count(st.sno) as numbers, st.ssex as stssex from score as sc right outer join student as st on  sc.sno=st.sno group by sc.degree asc,sc.sno desc;
-- select  sc.sno as num, sc.degree as deg, sc.cno, count(sc.sno) as snonum from score as sc where deg>75;#列之中的别名不传递
-- select  sc.sno as num, sc.degree as deg, sc.cno, count(sc.cno) as snonum from score as sc where degree>75 group by sc.cno;



###组合查询
#UNION（多个where子句，就可转化成UNION的形式）
/*UNION中两个select语句所查之列，必须数据相同
select s.sno, s.sname, s.sex from student as s where sno>110
Union
select t.tbname, t.press, t.price  from textbook as t where price>36;
*/
#union all不去除重复，union默认去除重复
/*
select s.sno as sn from score as s where s.sno>60
union all
select st.sno as stn from student as st where st.sno>80
order by  sn; 
*/



###Insert
-- insert into  teacher values('326','张学友','M','1968-07-22 18:36:54','歌手','音乐学院');
-- insert into  teacher (tno,tname,tsex,tbirthday,prof,depart) values('325','Bie','M','1992-09-12 18:36:54','歌手','音乐学院');
-- insert into book values(110,'繁星春水','巴金','国家出版社',15.9);
-- insert into book(bid,bname,author,press,price) values(109,'京华春梦','梁羽生','成人出版社',92.8);
-- insert into book(bid,bname,price) values(111,'Cava编程思想',192.8);
#Insert Select检索插入语句(要保证两个表的结构相同)
#Insert Select(Error)
-- insert into teacher values(select t1.tno,t1.tname,t1.tsex,t1.tbirthday,t1.prof,t1.depart from  teacher as t1 where t1.tno='326' union select  *from  teacher as t2 where t2.tno='100');
#Insert Select(Okay)(可以用where过滤，更可以一次性插入多条语句)
-- insert  into book(bid,bname,author,press,price) select * from booktemp where bid<106;# insert select;

##Insert Select和Select  Into的区别
-- Insert select:导出数据
-- Select   into:导入数据(select * into custcopy from customer)
-- insert into book select * from booktemp where bid<106;
-- (mysql不支持)select  * into  booktemp from  book;
-- create table booktable1  as select * from booktemp;
-- create table booktable2  as select * from booktemp where price >60;
-- create table booktable3  as select * from booktemp group by press having count(*)>=2
-- create table booktable4  as select * from booktemp;#(为了删除数据库)
/*INSERT INTO `aboutstudent`.`booktable3` (`bid`, `bname`, `press`, `price`) VALUES ('102', '红楼春梦', 'XXX出版社', '399.5');
INSERT INTO `aboutstudent`.`booktable3` (`bid`, `bname`, `press`, `price`) VALUES ('103', '红楼轶梦', 'XXX出版社', '69.50');
INSERT INTO `aboutstudent`.`booktable3` (`bid`, `bname`, `press`, `price`) VALUES ('104', '红楼轶梦', 'XXX出版社', '69.50');*/



###Update and Delete
#update
-- 有where(某一行),无where(全表)
-- update booktable3 set bname='红楼春梦' where bid=102; 
-- update booktable3 set bname='红楼遗梦', press='国色天香出版社' where bid=103; 
-- update booktable3 set bname='红楼遗梦', press=null where bid=104;#相当于删除某列的值

#delete(删除的是表之中的数据)
-- 有where(某一行),无where(全表)
-- delete from booktable4 where bid=101;
-- delete from booktable4;



###create and manipulate database
#create(选择某种缩进，最好是四个空格，主键，注释，默认值，默认值好于null)
/*
#注意在定义语句里面和外面，有：有“=”和无“=”的区别#
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

#alter table(更新表的定义，主要是字段)
#alter table要和数据备份（包括模式与数据）联系起来，修改表的操作有一定的风险性
/*create table foralter as select * from booktemp; 准备工作*/
-- alter table foralter add presstime date default current_date();
-- alter table foralter add testinfo varchar(20) default "test";
-- alter table foralter drop testinfo;

#drop table(删除表)
-- drop table foralter;

#Rename(重命名表)
-- rename table foralter to foralter1;



###View视图
#view(主要目的是为了SQL的重用)
-- (error)create view v1;#创建view
-- create view bookview as select * from book where price >50;#不能丢了AS,后面要有检索填充的数据
-- drop view v1;
/*select p.pfname, p.pmname, s.sno,s.sname, sc.cno,sc.degree from parent as p,student as s,score as sc where p.sno=s.sno and s.sno=sc.sno;*/
-- 简化SQL，重用SQL
-- create view par_stu_scopar_stu_sco as select p.pfname, p.pmname, s.sno,s.sname, sc.cno,sc.degree from parent as p,student as s,score as sc where p.sno=s.sno and s.sno=sc.sno;
-- select * from bookview where bid>103;#view的查询
-- 格式化数据
-- create view bookcontactview as select concat(bid,'-',bname,'-',author,'-',press,'-',price) as bookinfo from book where price>40;



###存储过程
#略



###事务管理
#MySQL事务管理
/*
begin;
insert into booktable2(bid,bname,author,press,price)values(220,"东京爱情故事",'小田正和','文艺出版社',93.2);
insert into booktable2(bid,bname,author,press,price)values(221,"西西里美丽传说",'雅马哈','文艺出版社',117.2);
insert into booktable2(bid,bname,author,press,price)values(222,"孽海花",'曾朴','商务出版社',36.8);
delete  from booktable2 where bid=106; 
commit;
*/

#MySQl事务回滚
/*
begin;
insert into booktable2 (bid,bname,author,press,price)values(223,'西北往事','玛尔莎','西安大学出版社',36.9);
delete  from booktable2 where bid=222;
rollback;
select * from booktable2 where bid =222;
select * from booktable2 where bid =223;
*/

#MySQL创建保留点
/*
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
rollback to spoint2;#只能这样在里面弄吗？
commit;
select * from booktable2 where bid=223 or bname='乱世佳人' or bid>230 and bid<236;
*/


###游标



###高级特性
#约束:管理如何插入或处理数据库数据的规则

##主键
/*
create table product (
    pdtid int  primary key auto_increment comment '产品id',
	 pdtname varchar(20) default '产品X' comment '产品名称',
	 pdtprice int  not null comment '产品价格',
	 pdtdescribe text comment '产品说明'
	 )default charset='utf8' comment='产品信息表'
*/

#外键：必须是其他表的主键，一张表之中可以有多个外键
#机器自动生成的定义
/*
CREATE TABLE `order` (
	`oid` INT(11) NOT NULL COMMENT '订单ID',
	`oname` VARCHAR(50) NULL DEFAULT NULL COMMENT '订单名',
	`pno` VARCHAR(50) NOT NULL DEFAULT '0' COMMENT '商品数量',
	`odescribe` TINYTEXT NULL COMMENT '订单描述',
	`otime` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
	`pid` INT(11) NOT NULL COMMENT '商品ID',
	PRIMARY KEY (`oid`),
	INDEX `pid` (`pid`),
	CONSTRAINT `pid` FOREIGN KEY (`pid`) REFERENCES `product` (`pdtid`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8_general_ci' ENGINE=InnoDB;
*/

#这个定义OKAY，是一个简易的定义
/*create table foreigntable1(
    tid int,
    tname varchar(50),
    primary key(tid)
    )engine=InnoDB ;
*/
/*create table foreigntable2(
    tid2 int,
    t2name varchar(50),
	 tidid int,
	 primary key(tid2),
	 FOREIGN KEY(tidid) REFERENCES t1 (tid)
	 )engine=InnoDB;    
*/
#比较实际复杂一点的外键定义

/*create table orderinfo (
    oid int comment '订单ID',
    oname varchar(50)  not null default '订单名：' comment '订单名',
    pid int not null comment '订单商品的商品ID',
    pno int default 0 comment '订单上屏数量',
    odetail tinytext null comment '订单详情',
    otime timestamp default current_timestamp comment '订单时间',
    primary key(oid),
    foreign  key (pid) references product(pdtid) on update cascade on delete cascade
    )engine=Innodb default charset='utf8' comment='订单详情';
*/

/*
insert into product(pdtid,pdtname,pdtprice,pdtdescribe) values
    (100,'健力宝',3.5,'健力宝'),
    (101,'可口可乐',3.5,'可口可乐'),
    (102,'王老吉',5,'王老吉'),
    (103,'海飞丝',23.5,'海飞丝')
*/

#给订单之中插入数据，必须是在商品表之中存在的商品ID
/*insert into orderinfo(oid,oname,pid,pno,odetail) values
      (1000,'订购可口可乐',101,30,'订购可口可乐30箱'),
      (1001,'订购健力宝',100,50,'订购健力宝50箱'),
      (1002,'订购海飞丝',103,18,'订购海飞丝18瓶')
*/
-- delete from product where pdtname='健力宝';#设置为cascade，同时删除了product表和orderinfo之中的数据
-- update product set pdtname='海飞丝活力版',pdtprice=25.6  where pdtname='海飞丝'; #此处也设置了级联，但是没有数据上的影响，因为没有用到相关的数据
-- insert into product values(120,'walkman',1629,'walkman音乐播放器');
-- insert into product(pdtid,pdtname,pdtprice,pdtdescribe)values(121,'macbook pro',11800,'macbook pro 2017款，金属灰，256G');
-- insert into product(pdtid,pdtname,pdtprice,pdtdescribe)values(122,'new balance 376',678,'new balance 376跑鞋');
/*
insert into orderinfo(oid,oname,pid,pno,odetail) values 
       (1020,'new balance 跑鞋',122,30,'30双new balance跑鞋'),
       (1021,'macbook pro',121,5,'5台macbook pro'),
       (1022,'walkman',120,10,'10台walkman');
*/
-- insert into orderinfo(oid,oname,pid,pno,odetail) values  (1050,'new balance 跑鞋',130,30,'30双new balance跑鞋');#报错，因为没有这个商品

##check and  unique 检查约束和唯一约束
/*create table check_unique(
        id int auto_increment comment 'id',
        name varchar(20) not null comment '姓名',
        age int not null comment '年龄' ,
        unique (name),#定义了unique约束
        check(age>15),
        primary key(id)
        )engine=Innodb default charset='utf8' comment='检查check和唯一unique' auto_increment=10 ;
#在定义完了数据库表之后，最下面的一行是需要用=将key和value来连接起来的；
#比如单独放一个auto_increment就会出错,定义auto_increment是在ID处，而最后一行定义的是从那个值开始增长
*/
-- insert into check_unique values(1,'jhon',22);
-- insert into check_unique(name,age) values('mary',26);
-- insert into check_unique(name,age) values('张三',18);
-- insert into check_unique(name,age) values('李四',13);
-- insert into check_unique(name,age) values('李四',18)#违反unique约束，一个表之中可以有多个unique约束
-- alter table check_unique rename to uniquetable;
/*
create table uniquetable(
        id int auto_increment comment 'id',
        name varchar(20) not null comment'姓名',
        age int not null comment'年龄',
        primary key(id),
        unique(name),#定义了unique约束
        check(age>20)#定义了check约束,check在mysql之中就是个摆设，会被忽略
        )engine=innodb auto_increment=checktablechecktable10 default charset='utf8' comment='年龄，姓名，ID表';*/

-- insert into checktable(name,age)  values('jhon',3);
-- insert into checktable(name,age)  values('jhon',3);#违反unique约束
-- alter table checktable rename to tb_check;
-- alter table uniquetable rename to tb_unique;

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

#触发器
/*
create table tb_trigger_goods(
       id int primary key auto_increment comment 'ID',
       name varchar(20) default '商品X' comment '商品X',
       price float not null comment'商品价格',
       nature varchar(100) default '' comment'商品性质 ',
       unique index(name)
       )engine=innodb default charset='utf8' comment='商品表';
       
create table tb_trigger_goodscalist(
       glid int auto_increment,
       glnu int not null comment '商品数量',
       gldatetime datetime  comment'更新时间',
       primary key(glid)
       )engine=innodb default charset='utf8' comment='商品库存表';
*/
-- alter table  tb_trigger_goodscalist drop column gldatetime;#删除一列
#创建触发器
-- drop trigger tginsert; --删除触发器
/*
create trigger tginsert
after insert
on tb_trigger_goods for each row
insert into tb_trigger_goodscalist(glnu,gldatetime) values(glnu+1,now());

create trigger tgdelete
after insert
on tb_trigger_goods for each row
update tb_trigger_goodscalist set glnu=glnu-1;
*/
/*insert into tb_trigger_goods(id,name,price,nature) values(1,'LV'，22.5，'奢侈品');*/
/*
CREATE TABLE tg_student_info (
  stu_no INT(11) NOT NULL AUTO_INCREMENT,
  stu_name VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (stu_no)
);
CREATE TABLE tg_student_count (
  student_count INT(11) DEFAULT 0
);
*/
-- INSERT INTO tg_student_count VALUES(0);
-- 创建触发器
/*
CREATE TRIGGER trigger_student_count_insert
AFTER INSERT
ON tg_student_info FOR EACH ROW
UPDATE tg_student_count SET student_count=student_count+1;

CREATE TRIGGER trigger_student_count_delete
AFTER DELETE
ON tg_student_info FOR EACH ROW
UPDATE tg_student_count SET student_count=student_count-1;
*/
-- INSERT INTO tg_student_info VALUES(NULL,'张明'),(NULL,'李明'),(NULL,'王明');#触发触发器