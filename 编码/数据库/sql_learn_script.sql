/*url:http://www.cnblogs.com/xiohao/p/3857669.html*/

/*题目：*/

#1、 查询Student表中的所有记录的Sname、Ssex和Class列。
#select  sname,ssex,class from student;

#2、 查询教师所有的单位即不重复的Depart列。
#select distinct(depart) from teacher;

#3、 查询Student表的所有记录。
#select *from student;

#4、 查询Score表中成绩在60到80之间的所有记录。
#select * from score where degree>60 and degree<80;
#select * from score where degree between 60 and 80;

#5、 查询Score表中成绩为85，86或88的记录。
#  (x)  select * from score where degree =85 and degree =86 and degree=87;
#select * from score where degree in (85,86,88);

#6、 查询Student表中“95031”班或性别为“女”的同学记录。
#select *from student where class='95031' or ssex='女';

#7、 以Class降序查询Student表的所有记录。
#select *from student order by class desc;

#8、 以Cno升序、Degree降序查询Score表的所有记录。
#select * from score order by cno asc,degree desc;

#9、 查询“95031”班的学生人数。
#select count(*) from student where class='95031';

#10、查询Score表中的最高分的学生学号和课程号。
#select sno,cno from score where degree in(select max(degree) from score);
#select sno,cno from score where degree=(select max(degree) from score);


#11、查询‘3-105’号课程的平均分。
#select  Avg(degree) from score where cno='3-105'; 

#12、查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
#select  

#13、查询最低分大于70，最高分小于90的Sno列。

#  (x)  select s.sno from student as s where  s.sno in(select degree from  score where  degree>70 and degree <90)

#14、查询所有学生的Sname、Cno和Degree列。
#  (x)  select  sname,cno,degree from student as a ,score as b where a.sno=b.sno;
#select s1.sno,c1.cno,c1.degree from student as s1 left join score as c1 on s1.sno=c1.sno;

#15、查询所有学生的Sno、Cname和Degree列。

#16、查询所有学生的Sname、Cname和Degree列。

#17、查询“95033”班所选课程的平均分。

#18、假设使用如下命令建立了一个grade表： create table grade(low   number(3,0),upp   number(3),rank   char(1)); insert into grade values(90,100,’A’); insert into grade values(80,89,’B’); insert into grade values(70,79,’C’); insert into grade values(60,69,’D’); insert into grade values(0,59,’E’); commit; 现查询所有同学的Sno、Cno和rank列。

#19、查询选修“3-105”课程的成绩高于“109”号同学成绩的所有同学的记录。

#20、查询score中选学一门以上课程的同学中分数为非最高分成绩的记录。

#21、查询成绩高于学号为“109”、课程号为“3-105”的成绩的所有记录。

#22、查询和学号为108的同学同年出生的所有学生的Sno、Sname和Sbirthday列。

#23、查询“张旭“教师任课的学生成绩。

#24、查询选修某课程的同学人数多于5人的教师姓名。

#25、查询95033班和95031班全体学生的记录。

#26、查询存在有85分以上成绩的课程Cno.

#27、查询出“计算机系“教师所教课程的成绩表。

#28、查询“计算机系”与“电子工程系“不同职称的教师的Tname和Prof。

#29、查询选修编号为“3-105“课程且成绩至少高于选修编号为“3-245”的同学的Cno、Sno和Degree,并按Degree从高到低次序排序。

#30、查询选修编号为“3-105”且成绩高于选修编号为“3-245”课程的同学的Cno、Sno和Degree.

#31、查询所有教师和同学的name、sex和birthday.

#32、查询所有“女”教师和“女”同学的name、sex和birthday.

#33、查询成绩比该课程平均成绩低的同学的成绩表。

#34、查询所有任课教师的Tname和Depart.

#35  查询所有未讲课的教师的Tname和Depart.

#36、查询至少有2名男生的班号。

#37、查询Student表中不姓“王”的同学记录。

#38、查询Student表中每个学生的姓名和年龄。

#39、查询Student表中最大和最小的Sbirthday日期值。

#40、以班号和年龄从大到小的顺序查询Student表中的全部记录。

#41、查询“男”教师及其所上的课程。

#42、查询最高分同学的Sno、Cno和Degree列。

#43、查询和“李军”同性别的所有同学的Sname.

#44、查询和“李军”同性别并同班的同学Sname.

#45、查询所有选修“计算机导论”课程的“男”同学的成绩表

#46、列出部门中工资高于本部门平均工资的的员工数和对应的部门编号，并按部门号进行降序排序。