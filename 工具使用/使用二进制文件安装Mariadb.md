### 使用二进制文件安装Mariadb

***

##### 环境
LinuxMint 19

##### 安装步骤和可能遇到的问题
[Linux安装mariadb二进制版本](https://www.cnblogs.com/freeweb/p/6088206.html),   [可能会遇到的问题](https://help.directadmin.com/item.php?id=368)

##### 启动服务
服务可以加入自启动, 这样不用自己再去每次都启动, 其中需要使用到`chkonfig`指令, 有许多自启动服务的方式, 可以参见[Linux中设置服务自启动的三种方式](https://www.cnblogs.com/nerxious/archive/2013/01/18/2866548.html), 并且首先, 我们需要手动启动mysql服务, 添加mysql到系统服务目录, 使用如下指令`cp support-files/mysql.server /etc/init.d/mysqld`, 然后可以查看mysql服务运行状态 : `systemctl status mysqld.service`

##### 修改用户密码
root用户的密码可以修改也可以不修改, 最好修改, 如下是linux之中修改mysql的root密码的方法, [Linux 下修改mysql的root密码](http://blog.bihe0832.com/mysql-modify-root.html)

##### 启用数据库
服务启动之后使用`mysql -u用户 -p` 例如：`mysql -uzgy -p` 后面输入密码就行了, 这是对于普通用户, 如果对于root用户, 可以免密登录, root免密码登陆` mysql -uroot  `即可登陆 .

##### 服务的开停启动
**开启**mariadb(mysql)服务: **service mysql start**
**停止**mariadb(mysql)服务: **service mysql stop**
**重启**mariadb(mysql)服务: **service mysql restart**

##### 注意的点

回顾整个安装的过程, 其实关键点在于**配置**, 也就是在` /etc/my.cnf `之中的配置, 我们需要在 mariadb安装目录下的support-files文件夹之中选择一个配置模板, 一般我们个人选择my-medium.cnf 或者my-large.cnf 即可,将其复制到`/etc/my.cnf`之中, 然后在`/etc/my.cnf`之中添加`basedir = /usr/local/mariadb`, 也就是数据库的安装目录, 完成后保存.
[![mysqlinstall1.png](../images/mysqlinstall1.png)]()
初次安装, 要**创建mysql用户和组, 并给当前目录赋予权限**:
```bash
groupadd mysql
useradd -r -g mysql -s /sbin/nologin mysql
chown -R mysql .
chgrp -R mysql .
```
然后执行**初始化安装** : ` ./scripts/mysql_install_db --user=mysql `, 然后调整权限 :
```bash
chown -R root .
chown -R mysql data/
```
启动脚本 : `bin/mysqld_safe --user=mysql & `
添加mysql到系统服务目录： `cp support-files/mysql.server /etc/init.d/mysqld `
如果是之前安装过mysql，那么现在就已经启动了，第一次安装需要手动启动服务： `/etc/init.d/mysqld start `
[![mysqlinstall2.png](../images/mysqlinstall2.png)]()
[![mysqlinstall3.png](../images/mysqlinstall3.png)]()


