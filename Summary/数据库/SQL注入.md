### SQL注入
* * *
##### SQL注入
所谓SQL注入，就是通过**把SQL命令插入到Web表单递交**或**输入域名或页面请求的查询字符串**，*最终达到欺骗服务器执行恶意的SQL命令*。
通过一下的例子更形象的了解SQL注入：
有一个Login画面，在这个Login画面上有两个文本框分别用来输入用户名和密码，当用户点了登录按钮的时候，会对输入的用户名和密码进行验证。验证的SQL语句如下：

```sql
select * from student where username='输入的用户名' and password='输入的密码'  ```
++如果能够检索到数据，说明验证通过，否则验证不通过++。
如果用户在用户名文本框中输入 **' or '1' = '1' or '1' = '1**，则验证的SQL语句变成：
```sql
select * from student where username='' or '1' = '1' or '1' = '1' and password=''
```
如果用户在密码文本框中输入 **1' or '1' = '1**，则验证的SQL语句变成：
```sql
select * from student where username='' and password='1' or '1'='1'
```
以上两个SQL语句的where条件永远是成立的，所以验证永远是有效的。

如果在用户名文本框中输入  **tom' ; drop table student**\-\- ，则SQL语句变成：
```sql
select * from student where username='tom' ; drop table student--' and password=''
```
这样就变成的两条SQL语句，*执行完查询操作*，接着**直接把student表给删除了**（双连接符表示注释）



##### 防止SQL注入
- **永远不要信任用户的输入**。对用户的输入进行校验，可以通过**正则表达式**，或限制长度；++对单引号和双"-"进行转换等++。
- **永远不要使用动态拼装sql**，可以使用参数化的sql或者直接使用存储过程进行数据查询存取
- **永远不要使用管理员权限的数据库连接**，为每个应用使用单独的权限有限的数据库连接
- 不要把机密信息直接存放，加密或者hash掉密码和敏感的信息
- **应用的异常信息应该给出尽可能少的提示**，最好使用自定义的错误信息对原始错误信息进行包装采用一些工具或网络平台检测是否存在SQL注入


ref:
1.[Web的脆弱性：各种注入、攻击](http://blog.csdn.net/tianjf0514/article/details/8394086), 2.[sql注入实例分析](http://www.cnblogs.com/leftshine/p/SQLInjection.html), 3.[记一次SQL注入实战](http://blog.jobbole.com/105586/), 4.[SQL注入全过程](http://www.cnblogs.com/tester-l/p/6045466.html), 5.[网络攻击技术开篇——SQL Injection](http://www.cnblogs.com/rush/archive/2011/12/31/2309203.html),  6.[防止ＳＱＬ注入的五种方法](http://www.cnblogs.com/baizhanshi/p/6002898.html), 7.[你真的会SQL注入攻击吗？（上）](https://zhuanlan.zhihu.com/p/22397455), 8.[你真的会SQL注入攻击吗？（下）](https://zhuanlan.zhihu.com/p/22397620)， 9.[10个SQL注入工具](http://blog.jobbole.com/17763/), 10.[如何批量找SQL注入](https://zhuanlan.zhihu.com/p/27383405)