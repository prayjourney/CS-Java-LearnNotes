### JNDI是什么

***
JNDI是 Java 命名与目录接口（Java Naming and Directory Interface），在J2EE规范中是重要的规范之一，不少专家认为，没有透彻理解JNDI的意义和作用，就没有真正掌握J2EE特别是EJB的知识。那么，JNDI到底起什么作用？要了解JNDI的作用，我们可以从“如果不用JNDI我们怎样做？用了JNDI后我们又将怎样做？”这个问题来探讨。



##### 没有JNDI的做法 

程序员开发时，知道要开发访问MySQL数据库的应用，于是将一个对 MySQL JDBC 驱动程序类的引用进行了编码，并通过使用适当的 JDBC URL 连接到数据库。就像以下代码这样：

```java
Connection conn=null;
try {
  Class.forName("com.mysql.jdbc.Driver",
                true, Thread.currentThread().getContextClassLoader());
  conn=DriverManager.getConnection("jdbc:mysql://MyDBServer?user=qingfeng&password=mingyue");
  /* 使用conn并进行SQL操作 */
  ......
  conn.close();
} 
catch(Exception e) {
  e.printStackTrace();
} 
finally {
  if(conn!=null) {
    try {
      conn.close();
    } catch(SQLException e) {}
  }
}
```

这是传统的做法，也是以前非Java程序员（如Delphi、VB等）常见的做法。这种做法一般在小规模的开发过程中不会产生问题，只要程序员熟悉Java语言、了解JDBC技术和MySQL，可以很快开发出相应的应用程序。

**没有JNDI的做法存在的问题**：

- 数据库服务器名称MyDBServer，用户名和口令都可能需要改变，由此引发JDBC URL需要修改；
- 数据库可能改用别的产品，如改用DB2或者Oracle，引发JDBC驱动程序包和类名需要修改；
- 随着实际使用终端的增加，原配置的连接池参数可能需要调整；

- ......

**解决办法**：

程序员应该不需要关心“具体的数据库后台是什么？JDBC驱动程序是什么？JDBC URL格式是什么？访问数据库的用户名和口令是什么？”等等这些问题，程序员编写的程序应该没有对 JDBC 驱动程序的引用，没有服务器名称，没有用户名称或口令 —— 甚至没有数据库池或连接管理。而是把这些问题交给J2EE容器来配置和管理，程序员只需要对这些配置和管理进行引用即可。

由此，就有了JNDI。



##### 用了JNDI之后的做法

首先，在在J2EE容器中配置JNDI参数，定义一个数据源，也就是JDBC引用参数，给这个数据源设置一个名称；然后，在程序中，通过数据源名称引用数据源从而访问后台数据库。具体操作如下（以JBoss为例）：

1.**配置数据源**
在JBoss的 D:/jboss420GA/docs/examples/jca 文件夹下面，有很多不同数据库引用的数据源定义模板。将其中的 mysql-ds.xml 文件Copy到你使用的服务器下，如 D:/jboss420GA/server/default/deploy。修改 mysql-ds.xml 文件的内容，使之能通过JDBC正确访问你的MySQL数据库，如下：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<datasources>
<local-tx-datasource>
    <jndi-name>

MySqlDS</jndi-name>
    <connection-url>

jdbc:mysql://localhost:3306/lw</connection-url>
    <driver-class>

com.mysql.jdbc.Driver</driver-class>
    <user-name>

root</user-name>
    <password>

rootpassword</password>
<exception-sorter-class-name>org.jboss.resource.adapter.jdbc.vendor.MySQLExceptionSorter</exception-sorter-class-name>
    <metadata>
       <type-mapping>

mySQL</type-mapping>
    </metadata>
</local-tx-datasource>
</datasources>
```

这里，定义了一个名为MySqlDS的数据源，其参数包括JDBC的URL，驱动类名，用户名及密码等。


2.**在程序中引用数据源**

```java
Connection conn=null;
try {
  Context ctx=new InitialContext();
  Object datasourceRef=ctx.lookup("java:MySqlDS"); //引用数据源
  DataSource ds=(Datasource)datasourceRef;
  conn=ds.getConnection();
  /* 使用conn进行数据库SQL操作 */
  ......
  c.close();
} 
catch(Exception e) {
  e.printStackTrace();
} 
finally {
  if(conn!=null) {
    try {
      conn.close();
    } catch(SQLException e) { }
  }
}
```

直接使用JDBC或者通过JNDI引用数据源的编程代码量相差无几，但是现在的程序可以不用关心具体JDBC参数了。在系统部署后，如果数据库的相关参数变更，只需要重新配置 mysql-ds.xml 修改其中的JDBC参数，只要保证数据源的名称不变，那么程序源代码就无需修改。由此可见，**JNDI避免了程序与数据库之间的紧耦合，使应用更加易于配置、易于部署**。



##### JNDI的扩展：

JNDI在满足了数据源配置的要求的基础上，还进一步扩充了作用：**所有与系统外部的资源的引用，都可以通过JNDI定义和引用**。所以，在J2EE规范中，J2EE 中的资源并不局限于 JDBC 数据源。引用的类型有很多，其中包括资源引用（已经讨论过）、环境实体和 EJB 引用。特别是 EJB 引用，它暴露了 JNDI 在 J2EE 中的另外一项关键角色：查找其他应用程序组件。

EJB 的 JNDI 引用非常类似于 JDBC 资源的引用。在服务趋于转换的环境中，这是一种很有效的方法。可以对应用程序架构中所得到的所有组件进行这类配置管理，从 EJB 组件到 JMS 队列和主题，再到简单配置字符串或其他对象，这可以降低随时间的推移服务变更所产生的维护成本，同时还可以简化部署，减少集成工作。 外部资源”。 



##### 命名服务和目录服务

上面的解释中提高了命名服务和目录服务两个概念.先要了解JNDI就必须知道，命名服务和目录服务是做什么用的。
学习新的概念和知识，比较有效的方式是通过和以前所学过的内容进行联系，比较。

关于命名服务，其实我们很多时候都在用它，但是并不知道它是它，比较典型的是域名服务器DNS(Domain Naming Service)，大对人对DNS还是比较了解的，它是将域名映射到IP地址的服务.比如百度的域名[www.baidu.com](http://developer.51cto.com/art/201112/www.baidu.com)所映射的IP地址是<http://202.108.22.5/>，你在浏览器中输入两个内容是到的同一个页面。用命名服务器的原因是因为我们记忆baidu这几个有意义的字母要比记202.108.22.5更容易记忆，但如果站到计算机的角度上，它更喜欢处理这些数字。

从我们生活中找的话还有很多类似的例子，比如说你的身份证号和你的名字可以"理解"成一种命名服务，你的学号和姓名也可以"解释"为一种命名服务。

可以看出命名服务的特点:一个值和另一个值的映射，将我们人类更容易认识的值同计算机更容易认识的值进行一一映射。

到现在应该对命名服务有所理解吧?

至于目录服务，从计算机角度理解为在互联网上有着各种各样的资源和主机，但是这些内容都是散落在互联网中，为了访问这些散落的资源并获得相应的服务，就需要用到目录服务。
![img](../../../images/jndi1.png)

从我们日常生活中去理解目录服务的概念可以从电话簿说起，电话簿本身就是一个比较典型的目录服务，如果你要找到某个人的电话号码，你需要从电话簿里找到这个人的名称，然后再看其电话号码。
![img](../../../images/jndi2.png)

理解了命名服务和目录服务再回过头来看JDNI，它是一个为Java应用程序提供命名服务的应用程序接口，为我们提供了查找和访问各种命名和目录服务的通用统一的接口。通过JNDI统一接口我们可以来访问各种不同类型的服务。如下图所示，我们可以通过JNDI API来访问刚才谈到的DNS。
![img](../../../images/jndi3.png)



##### 总结

J2EE 规范要求所有 J2EE 容器都要提供 JNDI 规范的实现。JNDI 在 J2EE 中的角色就是“交换机” —— J2EE 组件在运行时间接地查找其他组件、资源或服务的通用机制。在多数情况下，提供 JNDI 供应者的容器可以充当有限的数据存储，这样管理员就可以设置应用程序的执行属性，并让其他应用程序引用这些属性（Java 管理扩展（Java Management Extensions，JMX）也可以用作这个目的）。JNDI 在 J2EE 应用程序中的主要角色就是提供间接层，这样组件就可以发现所需要的资源，而不用了解这些间接性。

在 J2EE 中，JNDI 是把 J2EE 应用程序合在一起的粘合剂，JNDI 提供的间接寻址允许跨企业交付可伸缩的、功能强大且很灵活的应用程序。这是 J2EE 的承诺，而且经过一些计划和预先考虑，这个承诺是完全可以实现的。J2EE主要讲解的内容是各个规范，再清楚一些就是各个概念。JNDI，翻译为Java命名和目录结构(JavaNaming And Directory Interface)官方对其解释为JNDI是一组在Java应用中访问命名和目录服务的API(ApplicationProgramming Interface)说明很精炼，但是比较抽象。 




ref:

1.[读完这个我懂了JNDI](https://blog.csdn.net/sunkobe2494/article/details/50824359),   2.[ Java之JNDI详解 ](https://blog.csdn.net/u010430304/article/details/54601302)

 