###  Token Cookie Session
***
**HTTP协议被称为无状态的协议, 访问前面网页的HTTP请求, 访问后面页面的HTTP请求是互不相干的, 独立的cookie就像一个容器. 可以存token可以存session id, 或者两者都不存.**



##### Cookie
cookie 是一个非常具体的东西, 指的就是浏览器里面能永久存储的一种数据, 仅仅是浏览器实现的一种数据存储功能. 
**cookie由服务器生成, 发送给浏览器**, 浏览器把cookie以key-value形式保存到某个目录下的文本文件内, **下一次请求同一网站时会把该cookie发送给服务器**. 由于cookie是存在客户端上的, 所以浏览器加入了一些限制确保cookie不会被恶意使用, 同时不会占据太多磁盘空间, 所以每个域的cookie数量是有限的.



##### Session

session 从字面上讲, 就是会话. 这个就类似于你和一个人交, 你怎么知道当前和你交谈的是张三而不是李四呢? 对方肯定有某种特征(长相等)表明他就是张三. 
session 也是类似的道, 服务器要知道当前发请求给自己的是谁. 为了做这种区, **服务器就要给每个客户端分配不同的“身份标识, 然后客户端每次向服务器发请求的时, 都带上这个“身份标识, 服务器就知道这个请求来自于谁了**. 至于客户端怎么保存这个“身份标识, 可以有很多种方, 对于浏览器客户, 大家都默认采用 cookie 的方式. 
服务器使用session把用户的信息临时保存在了服务器, 用户离开网站后session会被销毁. 这种用户信息存储方式相对cookie来说更安全, 可是session有一个缺陷: **如果web服务器做了负载均, 那么下一个操作请求到了另一台服务器的时候session会丢失**. 



##### Token
**Token的引入**: Token是在客户端频繁向服务端请求数据, 服务端频繁的去数据库查询用户名和密码并进行对比, 判断用户名和密码正确与否, 并作出相应提示, 在这样的背景下, Token便应运而生. 
**Token的定义**: Token是服务端生成的一串字符串, 以作客户端进行请求的一个令牌, 当第一次登录后, 服务器生成一个Token便将此Token返回给客户端, 以后客户端只需带上这个Token前来请求数据即可, 无需再次带上用户名和密码. 最简单的token组成:uid(用户唯一的身份标识), time(当前时间的时间戳), sign(签名, 由token的前几位+盐以哈希算法压缩成一定长的十六进制字符串, 可以防止恶意第三方拼接token请求服务器).
**使用Token的目的**: Token的目的是为了减轻服务器的压力, 减少频繁的查询数据库, 使服务器更加健壮.**token是无状态的, token字符串里就保存了所有的用户信息**. **token可以抵抗CSRF(跨域攻击)，cookie+session不行**. **token在客户端一般存放于localStorage, cookie, 或sessionStorage中. 在服务器一般存于数据库中**.



ref：
1.[cookie和session和token的概念](https://blog.csdn.net/qq_37615098/article/details/83552170),   2.[HTTP cookies 详解](http://bubkoo.com/2014/04/21/http-cookies-explained/),   3.[彻底弄懂session，cookie，token](https://segmentfault.com/a/1190000017831088),   4.[Token ，Cookie和Session的区别](https://www.cnblogs.com/JamesWang1993/p/8593494.html),   5.[彻底理解cookie，session，token](https://www.cnblogs.com/moyand/p/9047978.html)