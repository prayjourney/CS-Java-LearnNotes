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