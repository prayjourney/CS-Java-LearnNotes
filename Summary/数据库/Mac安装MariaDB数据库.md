# Mac安装MariaDB数据库
***
Mac上的开发者，你可以在macos上通过Homebrew来简单的获取安装最新稳定版本的MariaDB,接下来我们将一步步的来指导安装MariaDB数据库，如果你的Mac中已经安装好了Homebrew的话，则直接开始安装。

#####  安装Homebrew
安装Homebrew的命令：
```sql
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

#####  检查Homebrew
```sql
brew doctor
```



#####  更新Homebrew
如果通过上面的命令检查到Homebrew不是最新的版本，可以通过如下命令来把Homebrew更新到最新：
```sql
brew update
```



#####  确认MariaDB的版本
在Homebrew仓库中确认MariaDB的版本：
```sql
brew info mariadb
```



#####  安装MariaDB
通过如下命令来下载安装MariaDB：
```sql
brew install mariadb
```



#####  运行数据库安装程序
```sql
mysql_install_db
```



#####  运行MariaDB
经过了上面的若干命令，已经安装好了MariaDB数据库，但是MariaDB数据库服务并没有启动，你可以通过这个命令来启动MariaDB数据库服务：
```sql
mysql.server start
```



#####  安全的完成安装
通过上面的启动MariaDB数据库服务，你已经可以连接MariaDB的数据库了，但是还不够安全，通过如下步骤可以完成更全面的设置，如：重设root用户的密码、移除匿名用户、移除默认的test数据库等等
```sql
mysql_secure_installation
```
具体的执行和设置如下：
```sql
Bens-MacBook-Pro:10.1.16 ben$ mysql_secure_installation

NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none):
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

Set root password? [Y/n]
New password:
Re-enter new password:
Password updated successfully!
Reloading privilege tables..
 ... Success!


By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n]
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n]
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n]
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n]
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```



#####  连接MariaDB数据
命令行连接MariaDB数据库的命令：
```sql
mysql -u root -p
```



#####  验证MariaDB版本
```sql
MariaDB [(none)]> select @@version; 
+-----------------+
| @@version  |
+-----------------+
| 10.1.14-MariaDB |
+-----------------+
1 row in set (0.00 sec)
```



#####  MariaDB基础命令
下面是MariaDB的一些基础使用命令：
```sql
-- 显示数据库列表
show databases;
 
-- 切换到名为mysql的数据库，显示该库中的数据表
use mysql; 
show tables;
 
-- 显示数据表table的结构
desc table;
 
-- 建数据库A与删数据库A
create database `database_A`; 
drop database `database_A`;
 
-- 建表：
use database_A; 
create table table_A(字段列表); 
drop table table_A;
 
-- 显示表中的记录：
select * from table_A;
 
-- 清空表中记录：
delete from table_A;
```

ref:
1.[Mac中MariaDB数据库的安装步骤](https://www.jb51.net/article/93202.htm),   2.[使用Homebrew在Mac OS X上安装MariaDB 10.1.16](https://mariadb.com/resources/blog/installing-mariadb-10-1-16-on-mac-os-x-with-homebrew/),   3.[Mac安装MariaDB数据库](https://blog.csdn.net/fighting_no1/article/details/83721189)



