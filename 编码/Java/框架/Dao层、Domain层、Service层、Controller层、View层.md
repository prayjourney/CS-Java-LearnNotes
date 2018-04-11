### Dao层、Domain层、Service层、Controller层、View层
***

##### 1.Dao层: 持久层**主要与数据库进行交互的接口**

DAO层主要是做数据持久层的工作，主要与数据库进行交互。DAO层首先会创建DAO接口，然后会在配置文件中定义该接口的实现类，接着就可以在模块中就可以调用DAO 的接口进行数据业务的而处理，并且不用关注此接口的具体实现类是哪一个类。DAO 层的数据源和数据库连接的参数数都是在配置文件中进行配置的。DAO层所定义的接口里的方法都大同小异，这是由我们在DAO层对数据库访问的操作来决定的，**对数据库的操作，我们基本要用到的就是新增，更新，删除，查询等方法**。因而DAO层里面基本上都应该要涵盖这些方法对应的操作。除此之外，可以定义一些自定义的特殊的对数据库访问的方法。 



##### 2.Entity层/Domain层/Model层: **实体层表示数据库在项目中的类**



##### 3.Service层(biz): **业务层用于控制业务**

Service层主要负责业务模块的逻辑应用设计。和DAO层一样都是先设计接口，再创建要实现的类，然后在配置文件中进行配置其实现的关联。接下来就可以在Service层调用接口进行业务逻辑应用的处理。封装Service层的业务逻辑有利于业务逻辑的独立性和重复利用性。**Service层是建立在DAO层之上的，建立了DAO层后才可以建立Service层，而Service层又是在Controller层之下的，因而Service层应该既调用DAO层的接口，又要提供接口给Controller层的类来进行调用，它刚好处于一个中间层的位置**。每个模型都有一个Service接口，每个接口分别封装各自的业务处理方法。



##### 4.Controller层/Action层: **控制层用于控制业务逻辑**

Controller层负责具体的业务模块流程的控制，Controller层主要调用Service层里面的接口控制具体的业务流程，控制的配置也需要在配置文件中进行，说的最直观的一点，**Controller用来控制跳转的URL**。Controller层和Service层的区别是：**Controller层负责具体的业务模块流程的控制；Service层负责业务模块的逻辑应用设计**



##### 5.View层 此层与控制层结合比较紧密，需要二者结合起来协同工发。View层主要负责前台jsp页面的表示。



#### 总结

在具体的项目中，其流程为：Controller层调用Service层的方法，Service层调用Dao层中的方法，其中调用的参数是使用Entity层进行传递的。

ref:
1.[DAO层，Service层，Controller层、View层](https://blog.csdn.net/zdwzzu2006/article/details/6053006),   2.[DAO层、ENTITY层、SERVICE层、CONTROLLER层个人的理解分析](https://blog.csdn.net/warpar/article/details/67638379)