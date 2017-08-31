### Wireshark 与 Fiddler
***
### Wireshark

##### Wireshark介绍

[wireshark](http://www.wireshark.org/)是非常流行的网络封包分析软件，功能十分强大。可以截取各种网络封包，显示网络封包的详细信息。使用wireshark前必须了解网络协议[^1]，**为了安全考虑，wireshark只能查看封包，而不能修改封包的内容，或者发送封包**。

##### Wireshark的用途
  1. 网络管理员会使用wireshark来**检查网络问题**
  2. 软件测试工程师使用wireshark抓包，**来分析自己测试的软件**
  3. **从事socket编程的工程师会用wireshark来调试**

##### Wireshark VS Fiddler
Fiddler是在windows上运行的程序，**专门用来捕获HTTP，HTTPS的**。wireshark能获取HTTP，也能获取HTTPS，++但是不能解密HTTPS++，所以wireshark看不懂HTTPS中的内容。++总结，如果是处理HTTP,HTTPS 还是用Fiddler, 其他协议比如TCP,UDP 就用Wireshark++。

##### Wireshark使用介绍
  1. 开始界面
  ![开始界面](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_wireshark.png)
  2. 选择网卡
  ![选择网卡](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e9%80%89%e6%8b%a9%e7%bd%91%e5%8d%a1.png)
  3. 开始捕获
  ![开始捕获](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_wireshark%20%e6%93%8d%e4%bd%9c.png)

##### Wireshark 窗口介绍
  1. 窗口介绍
  ![窗口介绍](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_wireshark%e7%95%8c%e9%9d%a2.png)
  2. 窗口介绍
	- Display Filter(显示过滤器)，  用于过滤
	- Packet List Pane(封包列表)， 显示捕获到的封包， 有源地址和目标地址，端口号。 颜色不同，代表
	- Packet Details Pane(封包详细信息), 显示封包中的字段
	- Dissector Pane(16进制数据)
	- Miscellanous(地址栏，杂项)

##### Wireshark 过滤
1. 显示过滤
   使用过滤是非常重要的， 初学者使用wireshark时，将会得到大量的冗余信息，在几千甚至几万条记录中，以至于很难找到自己需要的部分。搞得晕头转向。**过滤器会帮助我们在大量的数据中迅速找到我们需要的信息。**

  一般情况下，我们会将所有的数据都抓取下来，但是会找我们需要的数据，这时候就需要使用显示过滤。
过滤器有两种，
  一种是**显示过滤器**，就是主界面上那个，用来在捕获的记录中找到所需要的记录。
  ![显示过滤](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e6%98%be%e7%a4%ba%e8%bf%87%e6%bb%a4.png)
  一种是**捕获过滤器**，用来过滤捕获的封包，以免捕获太多的记录。 在Capture -> Capture Filters 中设置。
  ![捕获过滤](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e6%8d%95%e8%8e%b7%e8%bf%87%e6%bb%a4.png)

2. 保存过滤
  在Filter栏上，填好Filter的表达式后，点击Save按钮， 取个名字。比如"Filter 102",
  ![Filter1](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_Filter1.png)
  Filter栏上就多了个"Filter 102" 的按钮，可以直接应用于显示之中。
  ![Filter2](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/t_Filter2.png)

3. 过滤表达式的规则
 1. **协议过滤**
 比如TCP，只显示TCP协议。
 2. **IP 过滤**
 比如 ip.src ==192.168.1.102 显示源地址为192.168.1.102，
 ip.dst==192.168.1.102, 目标地址为192.168.1.102
 3. **端口过滤**
 tcp.port ==80,  端口为80的
 tcp.srcport == 80,  只显示TCP协议的愿端口为80的。
 4. **Http模式过滤**
 http.request.method=="GET",   只显示HTTP GET方法的。
 5. **逻辑运算符为 AND/ OR**
 6. **常用的过滤表达式**
 | 过滤表达式 | 用途 |
 |--------|--------|
 |    http    |   只查看HTTP协议的记录     |
 |ip.src\==192.168.1.102 or ip.dst==192.168.1.102	| 源地址或者目标地址是192.168.1.102|


##### 封包列表
1. 封包列表(Packet List Pane)
  ++封包列表的面板中显示，编号，时间戳，源地址，目标地址，协议，长度，以及封包信息++。你可以看到不同的协议用了不同的颜色显示，也可以修改这些显示颜色的规则，视图 ->着色规则。
  ![封包列表](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e5%b0%81%e5%8c%85%e5%88%97%e8%a1%a8.png)
2. 封包列表详细信息(Packet Details Pane)
  **这个面板是我们最重要的，各行信息分别为**
  | TCP/IP层 | 信息 |
  |--------|--------|
  |  **Frame**       |  物理层的数据帧概况  |
  |  **Ethernet II** |  数据链路层以太网帧头部信息  |
  |  **Internet Protocol Version 4**   |  互联网层IP包头部信息  |
  |  **Transmission Control Protocol** |  传输层T的数据段头部信息，此处是TCP  |
  |  **Hypertext Transfer Protocol**   |  应用层的信息，此处是HTTP协议       |
  ++下面是在界面中对应的显示++
  ![5层模型](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_5%e5%b1%82%e6%a8%a1%e5%9e%8b.png)
3. wireshark与对应的OSI七层模型
  ![OSI七层模型](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_OSI%e4%b8%83%e5%b1%82%e6%a8%a1%e5%9e%8b.png)

##### 实例分析TCP三次握手过程
1. TCP包的具体内容
  从下图可以看到wireshark捕获到的TCP包中的每个字段。
  ![TCP包的具体内容](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_TCP%e5%8c%85%e5%85%b7%e4%bd%93%e5%ad%97%e6%ae%b5.png)
2. TCP三次握手过程
  ![TCP三次握手过程](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_n16.png)
3. 实例分析
打开wireshark, 打开浏览器输入[百度](http://www.baidu.com)，使用帐号密码登录，在wireshark中输入tcp过滤，这样做的目的是为了得到与浏览器打开网站相关的数据包，将得到如下图
  ![三次握手](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e4%b8%89%e6%ac%a1%e6%8f%a1%e6%89%8b%e8%bf%87%e7%a8%8b.png)
  图中可以看到wireshark截获到了三次握手的三个数据包。第四个包才是HTTP的， 这说明HTTP的确是使用TCP建立连接的，在下图之中标出来了。
  第一次握手数据包，**客户端发送一个TCP，标志位为SYN，序列号为0， 代表客户端请求建立连接**。 如下图
  ![第一次握手](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e7%ac%ac%e4%b8%80%e6%ac%a1%e6%8f%a1%e6%89%8b.png)
  第二次握手的数据包，**服务器发回确认包, 标志位为 SYN,ACK. 将确认序号(Acknowledgement Number)设置为客户的I S N加1，即0+1=1**, 如下图
  ![第二次握手](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e7%ac%ac%e4%ba%8c%e6%ac%a1%e6%8f%a1%e6%89%8b.png)
  第三次握手的数据包，**客户端再次发送确认包(ACK) SYN标志位为0,ACK标志位为1.并且把服务器发来ACK的序号字段+1,放在确定字段中发送给对方.并且在数据段放写ISN的+1**, 如下图:
  ![第三次握手](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e7%ac%ac%e4%b8%89%e6%ac%a1%e6%8f%a1%e6%89%8b.png)
  经过以上三步就TCP三次握手，建立了连接。
***
###  Fiddler


ref:[Wireshark抓包工具使用教程以及常用抓包规则](http://fangxin.blog.51cto.com/1125131/735178/),[通信协议——Http、TCP、UDP](http://www.cnblogs.com/xhwy/archive/2012/03/03/2378293.html),[Wireshark基本介绍和学习TCP三次握手](http://www.cnblogs.com/TankXiao/archive/2012/10/10/2711777.html),[网络抓包工具 wireshark 入门教程](http://www.cnblogs.com/52php/p/6262956.html),[wireshark怎么抓包、wireshark抓包详细图文教程](http://blog.csdn.net/holandstone/article/details/47026213),[协议的分用以及wireshark对协议的识别](http://www.cnblogs.com/Leo_wl/p/3308958.html)

[^1]:[网络基础知识](ttps://github.com/prayjourney/SummaryOfProgramming/blob/master/%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%9F%BA%E7%A1%80/%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%BD%91%E7%BB%9C/%E7%BD%91%E7%BB%9C%E5%9F%BA%E7%A1%80%E7%9F%A5%E8%AF%86.md)