### HTTP中GET，POST和PUT的区别

HTTP中定义了以下几种请求方法:
1、GET；2、POST；3、PUT；4、DELETE; 5、HEAD；6、TRACE；7、OPTIONS；



#### 各个方法介绍：
1、**GET方法**：对这个资源的**查询操作**。
2、**DELETE方法**：对这个资源的删操作。但要注意：客户端无法保证删除操作一定会被执行，因为HTTP规范允许服务器在不通知客户端的情况下撤销请求。
3、**HEAD方法**：与GET方法的行为很类似，但服务器在响应中只返回实体的主体部分。这就允许客户端在未获取实际资源的情况下，对资源的首部进行检查，使用HEAD，我们可以更高效的完成以下工作：
- 在不获取资源的情况下，了解资源的一些信息，比如资源类型；
- 通过查看响应中的状态码，可以确定资源是否存在；
- 通过查看首部，测试资源是否被修改；
4、**TRACE方法**：会在目的服务器端发起一个“回环”诊断，我们都知道，客户端在发起一个请求时，这个请求可能要穿过防火墙、代理、网关、或者其它的一些应用程序。这中间的每个节点都可能会修改原始的HTTP请求，TRACE方法允许客户端在最终将请求发送服务器时，它变成了什么样子。由于有一个“回环”诊断，在请求最终到达服务器时，服务器会弹回一条TRACE响应，并在响应主体中携带它收到的原始请求报文的最终模样。这样客户端就可以查看HTTP请求报文在发送的途中，是否被修改过了。
5、**OPTIONS方法**：用于获取当前URL所支持的方法。若请求成功，则它会在HTTP头中包含一个名为“Allow”的头，值是所支持的方法，如“GET, POST”。



#### 方发之间的区别：
##### PUT和POST
PUT和POST都有更改指定URI的语义。但PUT被定义为idempotent的方法[<font color = "deeppink">幂等</font>] ，POST则不是idempotent的方法[<font color = "lightblue">不是幂等</font>] 。
> 如果一个方法重复执行多次，产生的效果是一样的，那就是idempotent的。

也就是说：
- PUT请求[<font color = "deeppink">幂等</font>]：如果两个请求相同，后一个请求会把第一个请求覆盖掉。~~（所以PUT用来改资源）【感觉这儿有点问题】~~
- POST请求[<font color = "lightblue">不是幂等</font>]：后一个请求不会把第一个请求覆盖掉。~~（所以POST用来增资源）【感觉这儿有点问题】~~

##### GET和POST
1、GET参数通过URL传递，POST放在Request body中。
2、GET请求会被浏览器主动cache，而POST不会，除非手动设置。
3、GET请求参数会被完整保留在浏览器历史记录里，而POST中的参数不会被保留。
4、Get 请求中有非 ASCII 字符，会在请求之前进行转码，POST不用，因为POST在Request body中，通过 MIME，也就可以传输非 ASCII 字符。
5、 一般我们在浏览器输入一个网址访问网站都是GET请求
6、HTTP的底层是TCP/IP。HTTP只是个行为准则，而TCP才是GET和POST怎么实现的基本。GET/POST都是TCP链接。GET和POST能做的事情是一样一样的。但是请求的数据量太大对浏览器和服务器都是很大负担。所以业界有了不成文规定，（大多数）浏览器通常都会限制url长度在2K个字节，而（大多数）服务器最多处理64K大小的url。
7、GET产生一个TCP数据包；POST产生两个TCP数据包。对于GET方式的请求，浏览器会把http header和data一并发送出去，服务器响应200（返回数据）；而对于POST，浏览器先发送header，服务器响应100 continue，浏览器再发送data，服务器响应200 ok（返回数据）。
8、在网络环境好的情况下，发一次包的时间和发两次包的时间差别基本可以无视。而在网络环境差的情况下，两次包的TCP在验证数据包完整性上，有非常大的优点。但并不是所有浏览器都会在POST中发送两次包，Firefox就只发送一次。

 

参考：
http://www.cnblogs.com/logsharing/p/8448446.html, http://www.cnblogs.com/shanyou/archive/2011/10/17/2215930.html, http://www.jellythink.com/archives/806, https://blog.csdn.net/qq_36183935/java/article/details/80570062, https://www.cnblogs.com/fundebug/p/http_post_vs_put.html
