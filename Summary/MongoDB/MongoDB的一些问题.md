### MongoDB的一些问题
1. MongoDB的中的文档和word, excel相同不?
  A:文档是MongoDB中数据的基本单元, 是MongoDB的核心概念, 很类似关系数据库中的行(记录),但是不是word, excel这种, 和我们平常说的文档不是同一个概念. **这儿所说的文档, 其实可以理解成非SQL, JSON为基础这种含义**.
2. 什么是水平扩展, 什么是垂直扩展?
  A:水平扩展是采用分布式的思维, 去扩展出来更多的节点, 垂直扩展是对一台服务器进行扩展, 比如扩容, 扩大内存,增加CPU, 采用这样的方式去扩容, 就叫垂直扩容.
3. MongoDB的基本情况是什么样子的呢？
  A:MongoDB由数据库,集合和文档组成, 这三个是其中的最重要的概念, 其中数据库就是数据库, 和传统的RDBMS的概念基本上是一致的,就是一个数据库, 其中的集合相当于RDBMS的数据库表, 一个集合相当于是一个table, 一个文档相当于是一个集合之中的一条数据. **创建数据库, 使用的是`use 表名[abc]`,上面就创建了一个名为abc的数据库, 如果已经存在, 那就直接使用, 不存在的话就会创建, 固化下来是在第一次插入数据的时候**. 对于集合, 也可以采用这种方式来创建, 有显式和隐式的, 先说**显式创建集合的方法**, 展示如下:

  ```shell
  # 创建固定集合(Capped Collection), 普通集合能够自动增长以容纳更多的doc, 但是固	   定集合有最大的size,
  # 容纳的doc不能超过限制(max选项). 语法如下:
  db.createCollection("log", { capped : true, size : 5242880, max : 5000 } )
  ```
  **隐式创建集合的方式**如下:
  ```shell
  # 先使用数据库abc, 然后再去插入一个文档到集合foo之中, 那么久创建好了集合foo
  use abc
  db.foo.insert({_id:1,name:"test"})  
  ```

ref:
1.[MongoDB文档、集合、数据库的概念](https://www.cnblogs.com/wenxudong/articles/6232000.html),   2.[MongoDB简介](https://www.cnblogs.com/qingtianyu2015/p/5944203.html),   3.[mongodb简单介绍和使用](https://www.jianshu.com/p/9759bf67c7cd),   4.[MongoDB 创建 Database 和 Collection](https://www.cnblogs.com/ljhdo/p/5475017.html),   5.[MongoDB创建集合](https://www.yiibai.com/mongodb/mongodb_create_collection.html),   6.[MongoDb 命令查询所有数据库和表](https://www.cnblogs.com/my-blogs-for-everone/articles/9749842.html),   7.[mongodb简单介绍和使用](https://www.jianshu.com/p/9759bf67c7cd),   8.[MongoDB的介绍和使用场景（1）](https://www.cnblogs.com/yxlblogs/p/3681089.html)