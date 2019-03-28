### 五大开源web服务器
***

统计数据显示，超过80%的web应用程序和网站都是使用的开源web服务器。在本文中，我们将介绍目前市场上最流行的5大开源web服务器，并简要回顾它们的历史，技术特性以及更多相关内容，方便你自己能够更加轻松的部署这些流行的web服务器。

根据维基百科介绍，web服务器是“通过HTTP协议处理web请求的计算机系统”(a computer system that processes requests via HTTP)。这个词可以指代整个系统，也可以指代可接收和管理HTTP请求的的程序。本文中介绍的web服务器指的是为终端用户处理web请求的程序。

#### **Apache HTTP Server**

------

Apache HTTP Server，我们常常称之为httpd，或者更简单的Apache。它诞生于1995年，并在2015年2月20日度过了其20岁的生日。全球超过52%的网站使用了Apache，它是目前最流行的web服务器。

Apache httpd通常运行在Linux上，也可以部署在OS X和Windows之上，它的发布得到Apache许可证 2.0 版的许可。该web服务器自身使用模块化架构，加载其它额外的模块可以作为其额外特性。比如，加载mod_proxy模块可以增加服务器代理/ 网关的功能，加载mod_proxy_balancer模块可以为所有支持的协议提供负载平衡。在v2.4版本里，Apache可通过全新的mod_http2模块支持HTTP/2。

从1996年开始，Apache HTTP Server就已经是最为流行的web服务器了，这与它拥有伟大的文档和软件项目集成支持的特性是分不开的，你可以在Apache基金会的[项目页面](https://httpd.apache.org/)上找到它的更多信息。



#### **NGINX**

------

Igor Sysoev从2002年开始开发NGINX，并在2004年发布了第一个公开版本。NGINX的开发是为了解决C10K（C10K是如何处理1万个并发连接的简写）问题，目前，它是第二流行的开源web服务器，全球有超过30%的网站在使用它。

NGINX依靠异步事件驱动架构来帮助其处理大量的并发会话，由于其对资源的轻量利用和伸缩自如的特性，它成为了广受欢迎的web服务器。

NGINX在类BSD（Berkeley Software Distribution）许可协议的授权下发布的，它不仅可作为web服务器进行部署，也可作为代理服务器或负载平衡器。你可以在[NGINX社区网站](https://nginx.org/en/)找到它的更多信息。



#### **Apache Tomcat**

------

Apache Tomcat是一个可作为web服务器的开源Java servlet容器。Java servlet是可扩展服务器特性的Java程序，虽然servlets可以对任何类型的请求作出响应，但是它还是最常用于Web服务器上的应用实施。这些web servlet在Java上的作用与PHP和ASP.NET等其它动态web技术类似。Tomcat的代码库是由Sun Microsystems公司在1999年捐赠给Apache软件基金会的，并在2005年成为Apache的顶级项目，目前有不到1%的网站在使用它。

Apache Tomcat是在Apache许可证 2.0 版的授权下进行发布的，通常用于运行Java应用程序。此外，它能够通过Coyote的扩展，扮演为本地文件HTTP文档服务的普通服务器的角色。更多详细的信息可以查看[Apache Tomcat项目网站](http://tomcat.apache.org/)。

另外，Apache Tomcat还经常内嵌在其它开源Java应用服务器中，如[JBoss](http://www.jboss.org/products/eap/overview/), [Wildfly](http://wildfly.org/)和[Glassfish](https://glassfish.java.net/)。



#### **Node.js**

------

Node.js是一个用于web服务器等网络应用的服务器端JavaScript环境。由于其较小的市场定位，在所有网站中只有0.2%使用Node.js。Node.js最初是由Ryan Dahl在2009年编写的，现在Node.js项目由Node.js基金会进行管理，并在Linux基金会的合作项目计划下快速发展。

相比起其它流行的web服务器，Node.js的不同之处在于它是一个构建网络应用的跨平台运行环境，拥有可胜任异步I/0的事件驱动构架。这些设计选择能够优化应用程序的数据吞吐量和可伸缩性，支持实时通信和网页游戏。 Node.js 还强调了web开发堆栈上的差异，Node.js清楚地显示作为HTML、 CSS或者JavaScript堆栈的一部分，在这一点上与Apache或者NGINX同时作为多个不同软件堆栈的一部分的理念正好是相反的。

Node.js是在[混合授权协议下](https://raw.githubusercontent.com/nodejs/node/master/LICENSE)发布的，更多信息可以查看[该项目网站](https://nodejs.org/en/)。



#### **Lighttpd**

------

Lighttpd，于2003年3月首次发布，目前全球有大约0.1%的网站在使用它，它是在BSD的许可协议下发布的。

Lighttpd以其低内存占用，低CPU负载和处理速度的优化而独立于世，它使用事件驱动架构，对大量并行连接进行优化，支持FastCGI, SCGI, Auth,Output-compression, URL-rewriting等多种功能。Lighttpd主要用于Catalyst和Ruby on Rails的web框架。通过[项目主页](http://www.lighttpd.net/)，你可以找到它的更多信息。



**小贴士**

------

如果你正在寻找一个流行的web服务器，我强烈建议你下载 LAMP（Linux, Apache, MySQL, PHP）或者LEMP（Linux, NGINX, MySQL, PHP）配套堆栈。此外，还可以根据根据你自己的不同喜好，更换搭配多种这样的配套堆栈。这种配套堆栈通常都提供了一键安装支持或者Linux上的软件包管理器的安装支持。



ref:

1.[最流行的5大开源web服务器](http://blog.csdn.net/leansmall/article/details/72614565),   2.[试试54款开源服务器软件 （比较知名的软件大集合）](http://blog.csdn.net/leansmall/article/details/72614488)