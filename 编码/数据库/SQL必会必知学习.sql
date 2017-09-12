# select * from student;
-- select sno,sname from student;
-- select * from student;

-- insert into student(sno,sname,ssex,sbirthday,class) values(110,"李时珍","男",'1533-06-24 00:00:00',95054);
-- insert into student(sno,sname,ssex,sbirthday,class) values(112,"李时珍","男",'1995-06-24 00:00:00',95023);
-- insert into student(sno,sname,ssex,sbirthday,class) values(118,"李时珍","男",'2005-12-09 00:00:00',95012);

# select distinct sname from student;
# select sname from student;
# select distinct sno,sname from student;

-- Mysql之中没有Top关键字
# select TOP 5 sno,sname,ssex from student;
-- Mysql之中可以用limit关键字来代替
-- select  sname,sno,ssex from student limit 5;
-- 从第3行其返回6个数据, offset表示从何处开始
#select * from student limit 6 offset 3;

