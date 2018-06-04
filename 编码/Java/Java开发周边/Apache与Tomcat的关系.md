### Apache与Tomcat的关系以及Nginx简介
***
#### 关系概述

**Apache是一个web服务器环境程序，启用它可以作为web服务器使用**，*不过只支持静态网页*，*动态网页如(asp，php，cgi，jsp)等就不行*。如果要在Apache环境下运行jsp的话，就需要一个解释器来执行jsp网页，而这个jsp解释器就是Tomcat， 为什么还要JDK呢？因为jsp需要连接数据库的话，就要jdk来提供连接数据库的驱程，所以要运行jsp的web服务器平台就需要Apache+Tomcat+JDK。整合带来的的好处有如下：
1.如果客户端请求的是静态页面，则只需要Apache服务器响应请求
2.如果客户端请求动态页面，则是Tomcat服务器响应请求
3.因为jsp是服务器端解释代码的，这样整合就可以减少Tomcat的服务



#### 详细描述

经常在用Apache和Tomcat等这些服务器，可是总感觉还是不清楚他们之间有什么关系，在用Tomcat的时候总出现Apache，总感到迷惑，到底谁是主谁是次，因此特意在网上查询了一些这方面的资料，总结了一下： **Apache支持静态页，比如html，Tomcat支持动态的，比如servlet等**， 一般使用Apache+Tomcat的话，Apache只是作为一个转发，对jsp的处理是由Tomcat来处理的。 *Apache可以支持php\cgi\perl，但是要使用java的话，你需要Tomcat在Apache后台支撑，将java请求由Apache转发给Tomcat处理*。Apache是web服务器，Tomcat是应用（java）服务器，它只是一个servlet(jsp也翻译成servlet)容器，可以认为是Apache的扩展，但是可以独立于Apache运行。  

#####比较点

###### 相同点：   

1.两者都是Apache组织开发的，2.两者都有HTTP服务的功能，3.两者都是免费的  

######不同点： 

1.提供的服务不同

**Apache是专门用了提供HTTP服务的**，以及相关配置的（例如虚拟主机、URL转发等等） ,**Tomcat是Apache组织在符合J2EE的JSP、Servlet标准下开发的一个JSP服务器**     

2.支持的页面类型不同

Apache是一个web服务器环境程序，启用他可以作为web服务器使用，**不过只支持静态网页，比如html**，*动态网页如(asp，php，cgi，jsp)等就不行* ，如果要在Apache环境下运行jsp的话，就需要一个解释器来执行jsp网页，而这个jsp解释器就是Tomcat，为什么还要JDK呢？因为jsp需要连接数据库的话，就要jdk来提供连接数据库的驱程，所以要运行jsp的web服务器平台就需要Apache+Tomcat+JDK，整合的好处是：*如果客户端请求的是静态页面，则只需要Apache服务器响应请求 如果客户端请求动态页面，则是Tomcat服务器响应请求，因为jsp是服务器端解释代码的，这样整合就可以减少Tomcat的服务开销*     

3.侧重点不同

**Apache侧重于http server **,**Tomcat侧重于servlet引擎**，如果以standalone方式运行，功能上与Apache等效 ， 支持JSP，但对静态网页不太理想

Apache是web服务器，Tomcat是应用（java）服务器，它只是一个servlet(jsp也翻译成servlet)容器，可以认为是Apache的扩展，但是可以独立于Apache运行。  换句话说，Apache是一辆卡车，上面可以装一些东西如html等。但是不能装水，要装水必须要有容器（桶），而这个桶也可以不放在卡车上。



#### 他山之石

[Apache](http://blog.csdn.net/hdfqq188816190/article/details/67639899) 和 [Tomcat](http://blog.csdn.net/hdfqq188816190/article/details/67639899) 都是web网络服务器，两者既有联系又有区别，在进行HTML、PHP、JSP、Perl等开发过程中，需要准确掌握其各自特点，选择最佳的服务器配置。

**Apache是web服务器（静态解析，如HTML），Tomcat是java应用服务器（动态解析，如JSP）**

**Tomcat只是一个servlet(jsp也翻译成servlet)容器，可以认为是Apache的扩展，但是可以独立于Apache运行**

两者从以下几点可以比较的：*两者都是Apache组织开发的，两者都有HTTP服务的功能，两者都是开源免费的*

###### 联系

1.Apache是普通服务器，本身只支持html即普通网页，可以通过插件支持php，还可以与Tomcat连通(Apache单向连接Tomcat，就是说通过Apache可以访问Tomcat资源，反之不然)。　　

2.Apache只支持静态网页，但像Jsp动态网页就需要Tomcat来处理。

3.Apache和Tomcat整合使用：
如果客户端请求的是静态页面，则只需要Apache服务器响应请求；
如果客户端请求动态页面，则是Tomcat服务器响应请求，将解析的JSP等网页代码解析后回传给Apache服务器，再经Apache返回给浏览器端。
这是因为jsp是服务器端解释代码的，Tomcat只做动态代码解析，Apache回传解析好的静态代码，Apache+Tomcat这样整合就可以减少Tomcat的服务开销。

4.Apache和Tomcat是独立的，在同一台服务器上可以集成。

###### 区别
Apache是有C语言实现的，支持各种特性和模块从而来扩展核心功能；Tomcat是Java编写的，更好的支持Servlet和JSP。

1.Apache是Web服务器，Web服务器传送(serves)页面使浏览器可以浏览，Web服务器专门处理HTTP请求(request)，但是应用程序服务器是通过很多协议来为应用程序提供 (serves)商业逻辑(business logic)。

Tomcat是运行在Apache上的应用服务器，应用程序服务器提供的是客户端应用程序可以调用(call)的方法 (methods)。它只是一个servlet(jsp也翻译成servlet)容器，可以认为是Apache的扩展，但是可以独立于Apache运行。

2.Apache是普通服务器，本身只支持html静态普通网页。不过可以通过插件支持PHP，还可以与Tomcat连通(单向Apache连接Tomcat，就是说通过Apache可以访问Tomcat资源，反之不然)，Tomcat是jsp/servlet容器，同时也支持HTML、JSP、ASP、PHP、CGI等，其中CGI需要一些手动调试，不过很容易的。

3.Apache侧重于http server，Tomcat侧重于servlet引擎，如果以standalone方式运行，功能上Tomcat与Apache等效支持JSP，但对静态网页不太理想。

4.Apache可以运行一年不重启，稳定性非常好，而Tomcat则不见得。

5.首选web服务器是Apache，但Apache解析不了的jsp、servlet才用Tomcat。

6.Apache是很最开始的页面解析服务，Tomcat是后研发出来的，从本质上来说Tomcat的功能完全可以替代Apache，但Apache毕竟是Tomcat的前辈级人物，并且市场上也有不少人还在用Apache，所以Apache还会继续存在，不会被取代，Apache不能解析java的东西，但解析html速度快。


###### 总结
**Apache是一辆车，上面可以装一些东西如html等，但是不能装水，要装水必须要有容器（桶），而这个桶也可以不放在卡车上，那这个桶就是Tomcat**。Apache是一个web服务器环境程序，启用他可以作为web服务器使用不过只支持静态网页，不支持动态网页，如asp、jsp、php、cgi，如果要在Apache环境下运行jsp就需要一个解释器来执行jsp网页，而这个jsp解释器就是Tomcat。那为什么还要JDK呢？因为jsp需要连接数据库的话就要jdk来提供连接数据库的驱程，所以要运行jsp的web服务器平台就需要Apache+Tomcat+JDK。如果客户端请求的是静态页面，则只需要Apache服务器响应请求，如果客户端请求动态页面，则是Tomcat服务器响应请求，因为jsp是服务器端解释代码的，这样整合就可以减少Tomcat的服务开销



#### Nginx简介

Nginx是一款轻量级的Web服务器/[反向代理](https://baike.baidu.com/item/%E5%8F%8D%E5%90%91%E4%BB%A3%E7%90%86)服务器及[电子邮件](https://baike.baidu.com/item/%E7%94%B5%E5%AD%90%E9%82%AE%E4%BB%B6)（IMAP/POP3）代理服务器，并在一个BSD-like 协议下发行。其特点是占有内存少，[并发](https://baike.baidu.com/item/%E5%B9%B6%E5%8F%91)能力强。为什么会出现nginx或者其他相似功能的web服务，一方面是因为http的历史局限型，而最重要的还是C10K问题，高并发访问，历史局限型，说的通俗点就是httpd(apache)老了不太能适应现在的网络环境了，毕竟Apache是95年的东西了，现代的计算机网络已经和当时远远不同了，倒不如说现在还大量使用httpd已经是一个小奇迹了(之所以不说奇迹，就担心较真的人太过在意，还有一个问题C10K，什么意思？The C10k problem is the problem of optimising network sockets to handle a large number of clients at the same time.The name C10k is a numeronym for concurrently handling ten thousand connections。**Apache的致命缺陷就是同时不可以处理一万个请求(建立套接字处理)**。*Nginx以事件驱动的方式编写，所以有非常好的性能，同时也是一个非常高效的反向代理、负载平衡*。其拥有匹配Lighttpd的性能，同时还没有Lighttpd的内存泄漏问题，而且Lighttpd的mod_proxy也有一些问题并且很久没有更新。

**Nginx做为HTTP服务器，有以下几项基本特性**：

- 处理静态文件，索引文件以及自动索引；打开文件描述符缓冲．
- 无缓存的反向代理加速，简单的负载均衡和容错．
- FastCGI，简单的负载均衡和容错．
- 模块化的结构。包括gzipping, byte ranges, chunked responses,以及 SSI-filter等filter。如果由FastCGI或其它代理服务器处理单页中存在的多个SSI，则这项处理可以并行运行，而不需要相互等待。
- 支持SSL 和 TLSSNI

Nginx专为性能优化而开发，性能是其最重要的考量,实现上非常注重效率 。它支持内核Poll模型，能经受高负载的考验,有报告表明能支持高达 50,000个并发连接数

Nginx具有很高的稳定性。其它HTTP服务器，当遇到访问的峰值，或者有人恶意发起慢速连接时，也很可能会导致服务器物理内存耗尽频繁交换，失去响应，只能重启服务器。例如当前apache一旦上到200个以上进程，web响应速度就明显非常缓慢了。而Nginx采取了分阶段资源分配技术，使得它的CPU与内存占用率非常低。nginx官方表示保持10,000个没有活动的连接，它只占2.5M内存，所以类似DOS这样的攻击对nginx来说基本上是毫无用处的。就稳定性而言,nginx比lighthttpd更胜一筹，**Nginx是一个HTTP服务器，可以作为Apache的代替品**

Nginx支持热部署。它的启动特别容易, 并且几乎可以做到7*24不间断运行，即使运行数个月也不需要重新启动。你还能够在不间断服务的情况下，对软件版本进行进行升级

Nginx采用master-slave模型,能够充分利用SMP的优势，且能够减少工作进程在磁盘I/O的阻塞延迟。当采用select()/poll()调用时，还可以限制每个进程的连接数

Nginx代码质量非常高，代码很规范，手法成熟， 模块扩展也很容易。特别值得一提的是强大的Upstream与Filter链。Upstream为诸如reverse proxy,与其他服务器通信模块的编写奠定了很好的基础。而Filter链最酷的部分就是各个filter不必等待前一个filter执行完毕。它可以把前一个filter的输出做为当前filter的输入，这有点像Unix的管线。这意味着，一个模块可以开始压缩从后端服务器发送过来的请求，且可以在模块接收完后端服务器的整个请求之前把压缩流转向客户端



ref:

1.[Apache与Tomcat有什么关系和区别](http://blog.csdn.net/hdfqq188816190/article/details/67639899),   2.[Apache与Tomcat的区别 ，几种常见的web/应用服务器](http://blog.csdn.net/salonzhou/article/details/37651197),   3.[关于Apache/Tomcat/JBOSS/Neginx/lighttpd/Jetty等一些常见服务器的区别比较和理解](http://blog.csdn.net/allenlinrui/article/details/6675998),   4.[Nginx是什么？Nginx介绍及Nginx的优点](https://lnmp.org/nginx.html),   5.[tomcat 与 nginx，apache的区别是什么？](https://www.zhihu.com/question/32212996)