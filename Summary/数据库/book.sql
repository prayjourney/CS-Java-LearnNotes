create table book(
    bid int  primary key  comment '书本id' ,
    bname varchar(50) not null comment '书本名称' ,
    author varchar(20) not null comment '作者' default '佚名',
    press varchar(50) not null comment  '出版社' default  '长江出版社',
    price decimal(10,2) not null comment '价格'
)comment='书本' default charset=utf8 auto_increment=100 ;
