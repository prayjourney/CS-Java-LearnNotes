### Java Web中的一些术语

***

##### 1. JavaBean

**javaBean是一种Java语言写成的可重用组件**。为写成JavaBean，**类必须是具体和公共的，并且具有无参数的构造器**。JavaBean通过提供符合一致性设计模式的公共方法将内部域暴露成员属性。更多的是一种规范，**即包含一组set和get方法的 java 对象**。javaBean可以使应用程序更加面向对象，可以把数据封装起来，把应用的业务逻辑和显示逻辑分离开，降低了开发的复杂程度和维护成本


##### 2. EJB

即EnterpriseBean，**也就是Enterprise JavaBean(EJB)**。EJB是JavaEE的一部分，定义了一个用于开发基于组件的企业多重应用程序标准。它被称为Java企业Bean，是Java的核心代码，分别是会话Bean(Session Bean)、实体Bean(Entity Bean)、和消息驱动Bean(MessageDriven Bean)


##### 3. POJO

POJO就是**Plain Ordinary Java Object**，也就是简单的Java对象，实际就是普通JavaBeans，是为了避免和EJB混淆所创造的简称。其中有一些属性及其getter、setter方法的类，**但是没有业务逻辑**，有时可以作为VO（value-object）或DTO（Data Transfer Object）来使用。**不允许有业务方法，也不能携带connection之类的方法**。

与JavaBean相比，JavaBean则复杂很多，JavaBean是可复用的组件，对JavaBean并没有严格的规范，理论上讲，任何一个Java类都可以是一个Bean。但通常情况下，由于JavaBean是被容器创建的，所以JavaBean应具有一个无参的构造器。另外，*通常JavaBean还要实现Serializable接口用于实现Bean的持久性*。一般在web应用程序中建立一个数据库的映射对象时，我们只能称他为POJO。用来强调它是一个普通的对象，而不是一个特殊的对象，其主要用来指代哪些没有遵从特定的java对象模型、约定或框架（如EJB）的java对象。理想的讲，一个POJO是一个不受任何限制的java对象


##### 4. Entity

**实体bean，一般是用于ORM对象关系映射，一个实体映射成一张表，一般无业务逻辑代码**。负责将数据库中的表记录映射为内存中的Entity对象，事实上，创建一个EntityBean对象相当于创建一条记录，删除一个EntityBean对象会同时从数据库中删除对应记录，修改一个Entity Bean时，容器会自动将Entity Bean的状态和数据库同步


##### 5. DTO

数据传输对象（Data Transfer Object）。是一种设计模式之间传输数据的软件应用系统。数据传输目标往往是数据访问对象从数据库中检索数据


##### 6. Model

Model是模型，存放实体类，就是对应的数据库表的实体类


##### 7. Dao
Dao主要做数据库的交互工作，使用了Hibernate连接数据库、操作数据库(增删改查)


##### 8. Service
Service业务逻辑层，**主要处理相应的业务逻辑**，引用对应的Dao数据库操作


##### ~~9. Action<已废弃>~~
~~Action是一个控制器，引用对应的Service层，在这里结合Struts的配置文件，跳转到指定的页面，当然也能接受页面传递的请求数据，也可以做些计算处理~~



##### 10. model与entity（实体类）的区别

**model的字段>entity的字段，并且model的字段属性可以与entity不一致，model是用于前端页面数据展示的，而entity则是与数据库进行交互做存储用途**。

> 举个例子：
>
> 比如在存储时间的类型时，数据库中存的是datetime类型，entity获取时的类型是Date() 类型，date型的数据在前端展示的时候必须进行类型转换(转为String类型)，在前端的进行类型转换则十分的麻烦，转换成功了代码也显得十分的臃肿。
>
> 所以将entity类型转换后，存储到对应的model中，在后台做类型转换，然后将model传到前端显示时，前端的就十分的干净。同时也可以添加字段，作为数据中转。






ref:1.[bean、javabean、entity、dto、ejb、pojo都是些什么鬼](http://blog.csdn.net/alabadazi/article/details/50075759),   2.[javaBean（mvc设计模型中的model）](http://blog.csdn.net/motian06/article/details/17714973),   3.[java 后台开发中model与entity（实体类）的区别](http://blog.csdn.net/u012188107/article/details/51397442),   4.[Java Web中的Action、Dao、Service、Model学习笔记-----阿冬专栏](http://blog.csdn.net/zhangdong305/article/details/48048003)