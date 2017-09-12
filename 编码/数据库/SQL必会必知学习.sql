# select * from student;
-- select sno,sname from student;
-- select * from student;

-- insert into student(sno,sname,ssex,sbirthday,class) values(110,"李时珍","男",'1533-06-24 00:00:00',95054);
-- insert into student(sno,sname,ssex,sbirthday,class) values(112,"李时珍","男",'1995-06-24 00:00:00',95023);
-- insert into student(sno,sname,ssex,sbirthday,class) values(118,"李时珍","男",'2005-12-09 00:00:00',95012);


-- select
# select distinct sname from student;
# select sname from student;
# select distinct sno,sname from student;

-- limit
-- Mysql之中没有Top关键字
# select TOP 5 sno,sname,ssex from student;
-- Mysql之中可以用limit关键字来代替
-- select  sname,sno,ssex from student limit 5;
-- 从第3行其返回6个数据, offset表示从何处开始
#select * from student limit 6 offset 3;

-- order by
#order by后面可以有多个字段，依次进行排序
#select * from student order by class,sno;
#order by支持按列排序
#select  sno,sname,ssex from student order by 3,1;
#order by是最后一个子句，desc的作用范围是其前面的一条，如果有多条，则需要每条后面都要说明course
/*select * from student order by sno desc,class;
select * from student order by sname desc,class asc;
select * from student order by sname desc,class desc;*/


#where
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

-- in
#select * from  student where  sname in('李时珍','陆君','王丽') order by sbirthday desc;
/*select * from  student where  sname in(
    select sname from student where sname !='李时珍');#此处子查询只能有一条返回的数据
    */
-- not
-- not 可以否定任何条件，相当于取反，其位于条件之前
-- select * from score where not degree>80; 