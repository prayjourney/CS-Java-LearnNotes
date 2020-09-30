#学生
insert into student (sno,sname,ssex,sbirthday,class) values (108 ,'曾华' ,'男' ,'1977-09-01',95033);

insert into student (sno,sname,ssex,sbirthday,class) values (105 ,'匡明' ,'男' ,'1975-10-02',95031);

insert into student (sno,sname,ssex,sbirthday,class) values (107 ,'王丽' ,'女' ,'1976-01-23',95033); 

insert into student (sno,sname,ssex,sbirthday,class) values (101 ,'李军' ,'男' ,'1976-02-20',95033); 

insert into student (sno,sname,ssex,sbirthday,class) values (109 ,'王芳' ,'女' ,'1975-02-10',95031); 

insert into student (sno,sname,ssex,sbirthday,class) values (103 ,'陆君' ,'男' ,'1974-06-03',95031); 

insert into student (sno,sname,ssex,sbirthday,class) values (111, '王欢', '男', '2013-03-26 09:59:53', 95062);

insert into student (sno,sname,ssex,sbirthday,class) values (112, '王子文', '女', '2012-12-13 09:59:53', 95052);

insert into student (sno,sname,ssex,sbirthday,class) values (110, '王海', '男', '2013-09-13 09:59:53', 95072);

insert into student (sno,sname,ssex,sbirthday,class) values (122, 'Jhon', '男', '1994-02-25 00:00:00', 95042);

insert into student (sno,sname,ssex,sbirthday,class) values (123, 'May', '女', '1995-09-10 00:00:00', 95042);

insert into student (sno,sname,ssex,sbirthday,class) values (121, '李王圣', '男', '1995-02-10 00:00:00', 95042);


#课程
insert into course(cno,cname,tno)values ('3-105' ,'计算机导论',825);

insert into course(cno,cname,tno)values ('3-245' ,'操作系统' ,804);

insert into course(cno,cname,tno)values ('6-166' ,'数字电路' ,856);

insert into course(cno,cname,tno)values ('9-888' ,'高等数学' ,100);

insert into course(cno,cname,tno)values ('2-336', 'Java课程设计', 825);

insert into course(cno,cname,tno)values ('5-238', '计算机体系结构', 831);

insert into course(cno,cname,tno)values	('5-339', 'Python高级应用', 831);

insert into course(cno,cname,tno)values ('5-234', 'Python入门', 831);



#成绩
insert into score(sno,cno,degree)values (103,'3-245',86.0);

insert into score(sno,cno,degree)values (105,'3-245',75.7);

insert into score(sno,cno,degree)values (109,'3-245',68.8);

insert into score(sno,cno,degree)values (103,'3-105',92.9);

insert into score(sno,cno,degree)values (105,'3-105',88.5);

insert into score(sno,cno,degree)values (109,'3-105',76.0);

insert into score(sno,cno,degree)values (101,'3-105',64.1);

insert into score(sno,cno,degree)values (107,'3-105',91.9);

insert into score(sno,cno,degree)values (108,'3-105',78.4);

insert into score(sno,cno,degree)values (101,'6-166',85.6);

insert into score(sno,cno,degree)values (107,'6-106',79.6);

insert into score(sno,cno,degree)values (108,'6-166',81.8); 

insert into score(sno,cno,degree)values	(103, '6-166', 81.0);

insert into score(sno,cno,degree)values (105, '6-166', 79.0);



#教师
insert into teacher(tno,tname,tsex,tbirthday,prof,depart) values (804,'李诚','男','1958-12-02','副教授','计算机系');

insert into teacher(tno,tname,tsex,tbirthday,prof,depart) values (856,'张旭','男','1969-03-12','讲师','电子工程系');

insert into teacher(tno,tname,tsex,tbirthday,prof,depart) values (825,'王萍','女','1972-05-05','助教','计算机系');

insert into teacher(tno,tname,tsex,tbirthday,prof,depart) values (831,'刘冰','女','1977-08-14','助教','电子工程系');

insert into teacher(tno,tname,tsex,tbirthday,prof,depart) values (100, '王大山', '女', '1980-08-14', '助教', '电子工程系');



#教材
insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('039', 'Java入门', '2-336', '科学出版社', '2013-02-20 00:00:00', '波多野结衣', 70.1);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values ('040', 'Java编程思想', '2-336', '科学出版社', '2012-05-20 00:00:00', '小泽圆', 130.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('041', 'Java编程导论', '2-336', '人民邮电出版社', '2008-02-18 00:00:00', '小泽圆', 38.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('042', 'Java从入门到精通', '2-336', '科学出版社', '2014-07-09 00:00:00', '尼古拉斯赵四', 75);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('043', '学习Python', '5-339', '科学出版社', '2013-12-20 00:00:00', '波多野结衣', 102.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('044', 'Python标准库', '5-339', '科学出版社', '2008-09-20 00:00:00', '王大陆', 59.7);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('045', 'fluent python', '5-234', '图文出版社', '2014-07-10 00:00:00', '小泽玛', 73.5);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('046', 'python很简单', '5-234', '长江出版社', '2008-06-17 00:00:00', '波多野结衣', 73.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('046', '高等数学第三版上', '9-888', '同济大学出版社', '2013-02-20 00:00:00', '数学组', 33.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('047', '高等数学第三版下', '9-888', '同济大学出版社', '2013-02-20 00:00:00', '数学组', 27.8);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('048', '高等数学第四版上', '9-888', '同济大学出版社', '2015-02-20 00:00:00', '数学组', 45.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('049', '高等数学第四版下', '9-888', '同济大学出版社', '2015-02-20 00:00:00', '数学组', 32.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('050', '高等数学习题集', '9-888', '同济大学出版社', '2015-02-20 00:00:00', '数学组', 15.8);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('051', '高等数学', '9-888', '科学出版社', '2015-02-20 00:00:00', '科学出版社编委会', 67.7);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('052', '高等数学', '9-888', '伦敦大学出版社', '2013-12-28 00:00:00', '伦敦大学数学学院', 248.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('053', '操作系统第2版', '3-245', '西安电子科技大学出版社', '2013-02-20 00:00:00', '马飞天', 23.3);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('054', '操作系统第3版', '3-245', '西安电子科技大学出版社', '2015-02-20 00:00:00', '马飞天', 33.7);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('055', '操作系统', '3-245', '香港科技大学出版社', '2012-12-20 00:00:00', '肖刚军', 160.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('056', '操作系统', '3-245', '世界出版社', '2013-02-20 00:00:00', 'Jhon', 343.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('057', 'Operation System', '3-245', 'O\'Reilly', '2013-02-20 00:00:00', 'O\'Reilly', 243.8);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('058', '计算机导论', '3-105', '人民邮电出版社', '2006-08-13 00:00:00', '王大陆', 21.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('059', '计算机导论---以python为舟', '3-105', '人民邮电出版社', '2014-08-13 00:00:00', '沙行勉', 34.5);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('060', '计算机导论', '3-105', '南京理工大学出版社', '2012-08-13 00:00:00', '陆机', 29.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('061', '数字电路', '6-166', '人民邮电出版社', '2013-08-13 00:00:00', '王大陆', 21.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('062', '数字电路', '6-166', '南京理工大学出版社', '2014-08-13 00:00:00', '陆机', 33.2);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('063', '计算机体系结构', '5-238', '人民邮电出版社', '2013-08-13 00:00:00', '王大陆', 18.5);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('064', '计算机体系结构', '5-238', '南京理工大学出版社', '2013-02-13 00:00:00', '陆机', 23.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('065', '计算机体系结构', '5-238', '伦敦大学出版社', '2017-08-13 00:00:00', 'Marry', 323.9);

insert into textbook(tbno, tbname, cno, press, presstime, author, price) values	('066', '计算机体系结构', '5-238', '科学出版社', '0200-06-22 00:00:00', '陆机', 30.8);