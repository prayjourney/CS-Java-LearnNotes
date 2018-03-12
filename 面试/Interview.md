##### 1.Http报文结构

**Answer**: 

Http报文分为**请求报文**和**响应报文**，Http响应报文主要由状态行、响应头部、响应正文3部分组成。Http请求报文主要由请求行、请求头部、请求正文3部分组成。请求方法包括GET、HEAD、PUT、POST、TRACE、OPTIONS、DELETE以及扩展方法，协议版本的格式为：HTTP/主版本号.次版本号，常用的有HTTP/1.0和HTTP/1.1协议。

> ref:[HTTP请求、响应报文格式](http://blog.csdn.net/a19881029/article/details/14002273)



##### 2.Hashtable和HashMap的相同点和不同点，以及它们的内部实现

**Answer**: 

**相同点**: 存储方式相同，利用一个内部类，实现的是Map.Entity接口，内部实现不一样，但是都是以节点方式进行存储的。是一种单向链表，链表是基于数组的。

**不同点**: 
  - HashMap可以允许key为null，value为null，HashTable都不允许为null
  - 继承的类不一样，Hashtable<K,V> extends Dictionary<K,V> ，HashMap<K,V> extends AbstractMap<K,V>
  - HashMap没有提供同步机制，是线程不安全的，需要自己在外面写同步代码，HashTable 部分方法上有自己的 synchronize 同步，是线程安全的
  - HashMap中没有contains()方法
  - 它们的数组初始化大小和扩容方式不一样，HashTable中hash数组默认大小是11，增加的方式是 old*2+1。HashMap中hash数组的默认大小是16，而且一定是2的指数

> ref:[HashMap和HashTable的区别](http://www.cnblogs.com/wuqinglong/p/5746473.html)

##### 3.Hibernate的二级缓存

**Answer**: 

