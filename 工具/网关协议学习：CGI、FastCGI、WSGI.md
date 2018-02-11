### 网关协议学习：CGI、FastCGI、WSGI

***

**CGI**

**CGI即通用网关接口(Common Gateway Interface)**，*是外部应用程序（CGI程序）与Web服务器之间的接口标准，是在CGI程序和Web服务器之间传递信息的规程*。__CGI规范允许Web服务器执行外部程序__，并将它们的输出发送给Web浏览器，CGI将Web的一组简单的静态超媒体文档变成一个完整的新的交互式媒体。通俗的讲CGI就像是一座桥，把网页和WEB服务器中的执行程序连接起来，它把HTML接收的指令传递给服务器的执行程序，再把服务器执行程序的结果返还给HTML页。CGI 的跨平台性能极佳，几乎可以在任何操作系统上实现。

CGI方式在遇到连接请求（用户请求）先要创建cgi的子进程，激活一个CGI进程，然后处理请求，处理完后结束这个子进程。这就是fork-and-execute模式。所以用cgi方式的服务器有多少连接请求就会有多少cgi子进程，子进程反复加载是cgi性能低下的主要原因。当用户请求数量非常多时，会大量挤占系统的资源如内存，CPU时间等，造成效能低下。

CGI脚本工作流程：

1. 浏览器通过HTML表单或超链接请求指向一个CGI应用程序的URL。
2. 服务器收发到请求。
3. 服务器执行所指定的CGI应用程序。
4. CGI应用程序执行所需要的操作，通常是基于浏览者输入的内容。
5. CGI应用程序把结果格式化为网络服务器和浏览器能够理解的文档（通常是HTML网页）。
6. 网络服务器把结果返回到浏览器中。



**FastCGI**

FastCGI是一个可伸缩地、高速地在HTTP server和动态脚本语言间通信的接口。多数流行的HTTP server都支持FastCGI，包括Apache、Nginx和lighttpd等，同时，FastCGI也被许多脚本语言所支持，其中就有PHP。

FastCGI是从CGI发展改进而来的。传统CGI接口方式的主要缺点是性能很差，因为每次HTTP服务器遇到动态程序时都需要重新启动脚本解析器来执行解析，然后结果被返回给HTTP服务器。这在处理高并发访问时，几乎是不可用的。FastCGI像是一个常驻(long-live)型的CGI，它可以一直执行着，只要激活后，不会每次都要花费时间去fork一次(这是CGI最为人诟病的fork-and-execute 模式)。CGI 就是所谓的短生存期应用程序，FastCGI 就是所谓的长生存期应用程序。由于 FastCGI 程序并不需要不断的产生新进程，可以大大降低服务器的压力并且产生较高的应用效率。它的速度效率最少要比CGI 技术提高 5 倍以上。它还支持分布式的运算, 即 FastCGI 程序可以在网站服务器以外的主机上执行并且接受来自其它网站服务器来的请求。

FastCGI是语言无关的、可伸缩架构的CGI开放扩展，其主要行为是将CGI解释器进程保持在内存中并因此获得较高的性能。众所周知，CGI解释器的反复加载是CGI性能低下的主要原因，如果CGI解释器保持在内存中并接受FastCGI进程管理器调度，则可以提供良好的性能、伸缩性、Fail-Over特性等等。FastCGI接口方式采用C/S结构，可以将HTTP服务器和脚本解析服务器分开，同时在脚本解析服务器上启动一个或者多个脚本解析守护进程。当HTTP服务器每次遇到动态程序时，可以将其直接交付给FastCGI进程来执行，然后将得到的结果返回给浏览器。这种方式可以让HTTP服务器专一地处理静态请求或者将动态脚本服务器的结果返回给客户端，这在很大程度上提高了整个应用系统的性能。

*FastCGI的工作流程*

1. Web Server启动时载入FastCGI进程管理器（PHP-CGI或者PHP-FPM或者spawn-cgi)
2. FastCGI进程管理器自身初始化，启动多个CGI解释器进程(可见多个php-cgi)并等待来自Web Server的连接。
3. 当客户端请求到达Web Server时，FastCGI进程管理器选择并连接到一个CGI解释器。Web server将CGI环境变量和标准输入发送到FastCGI子进程php-cgi。
4. FastCGI子进程完成处理后将标准输出和错误信息从同一连接返回Web Server。当FastCGI子进程关闭连接时，请求便告处理完成。FastCGI子进程接着等待并处理来自FastCGI进程管理器(运行在Web Server中)的下一个连接。 在CGI模式中，php-cgi在此便退出。

*FastCGI 的特点*

1. 打破传统页面处理技术。传统的页面处理技术，程序必须与 Web 服务器或 Application 服务器处于同一台服务器中。这种历史已经早N年被FastCGI技术所打破，FastCGI技术的应用程序可以被安装在服务器群中的任何一台服务器，而通过 TCP/IP 协议与 Web 服务器通讯，这样做既适合开发大型分布式 Web 群，也适合高效数据库控制。
2. 明确的请求模式。CGI 技术没有一个明确的角色，在 FastCGI 程序中，程序被赋予明确的角色（响应器角色、认证器角色、过滤器角色）。



**ISAPI**

ISAPI（Internet Server Application Program Interface）是微软提供的一套面向WEB服务的API接口，它能实现CGI提供的全部功能，并在此基础上进行了扩展，如提供了过滤器应用程序接口。ISAPI应用大多数以DLL动态库的形式使用，可以在被用户请求后执行，在处理完一个用户请求后不会马上消失，而是继续驻留在内存中等待处理别的用户输入。此外,ISAPI的DLL应用程序和WEB服务器处于同一个进程中，效率要显著高于CGI。（由于微软的排他性，只能运行于windows环境)

ISAPI服务器扩展为使用 Internet 服务器的通用网关接口(CGI) 应用程序提供了另一种选择。与 CGI 应用程序不同，ISA 在 HTTP服务器所在的同一地址空间运行，并且可以访问可由 HTTP 服务器使用的所有资源。ISA 的系统开销比 CGI 应用程序低，因为它们不要求创建其他进程，也不执行需要越过进程边界的通信，而这种通信非常耗时。如果内存被其他进程所需要，扩展和筛选器DLL 都可能被卸载。ISAPI 允许在一个 DLL 中有多个命令，这些命令作为 DLL 中CHttpServer对象的成员函数来实现。CGI 要求每个任务有一个单独的名称和一个到单独的可执行文件的 URL 映射。每个新的 CGI 请求启动一个新进程，而每个不同的请求包含在各自的可执行文件中，这些文件根据每个请求加载和卸载，因此系统开销高于 ISA。



**PHP-CGI**

PHP-CGI是PHP自带的FastCGI管理器。PHP-CGI的不足：

1. php-cgi变更php.ini配置后需重启php-cgi才能让新的php-ini生效，不可以平滑重启
2. 直接杀死php-cgi进程php就不能运行了。(PHP-FPM和Spawn-FCGI就没有这个问题,守护进程会平滑从新生成新的子进程。）




**Spawn-FCGI**

Spawn-FCGI是一个通用的FastCGI管理服务器，它是lighttpd中的一部份，很多人都用Lighttpd的Spawn-FCGI进行FastCGI模式下的管理工作，不过有不少缺点。而PHP-FPM的出现多少缓解了一些问题，但PHP-FPM有个缺点就是要重新编译，这对于一些已经运行的环境可能有不小的风险)，在php 5.3.3中可以直接使用PHP-FPM了。Spawn-FCGI的代码很少，全部才630行，用c语言编写，最近一次提交是5年前。代码主页：https://github.com/lighttpd/spawn-fcgi

Spawn-FCGI代码分析如下：

1. spawn-fcgi 首先create socket,bind,listen 3步创建服务器socket,(把这个socket叫做 fcgi_fd)
2. 用dup2，把fcgi_fd 交换给 FCGI_LISTENSOCK_FILENO （FCGI_LISTENSOCK_FILENO数值上等于0，这是fastcgi协议当中指定用来listen的socket id）
3. 执行execl ,replaces the current process image with a new process image. process image 进程在运行空间的代码段

很显然，Spawn-FCGI也是 pre-fork 模型，只是用了上古C语言编写，充满了N多 unix下暗黑编程技巧。

Spawn-FCGI功能很单一：

1. 只管fork进程，子进程挂了，主进程仅仅log记录一次，根本不会重新fork。在2009年一段时间内，我曾经用spawn-fcgi部署php-cgi，当跑一段时间就会全挂掉，只能用crontab定时重启spawn-fcgi
2. 不负责子进程中的网络IO，把socket放到指定位置就完了，接下来的事情由被spawn的程序处理

Spawn-FCGI是一个很早期的程序，瞻仰一下即可。另外有：1996年的一段代码:http://www.fastcgi.com/om_archive/kit/cgi-fcgi/cgi-fcgi.c，和spawn-fcgi一个风格

**PHP-FPM**

PHP-FPM是一个PHP FastCGI管理器，是只用于PHP的,可以在 http://php-fpm.org/download下载得到。PHP-FPM其实是PHP源代码的一个补丁，旨在将FastCGI进程管理整合进PHP包中。必须将它patch到你的PHP源代码中，在编译安装PHP后才可以使用。FPM（FastCGI 进程管理器）用于替换 PHP-CGI 的大部分附加功能，对于高负载网站是非常有用的。它的功能包括：

1. 支持平滑停止/启动的高级进程管理功能；
2. 可以工作于不同的 uid/gid/chroot 环境下，并监听不同的端口和使用不同的 php.ini 配置文件（可取代 safe_mode 的设置）；
3. stdout 和 stderr 日志记录;
4. 在发生意外情况的时候能够重新启动并缓存被破坏的 opcode;
5. 文件上传优化支持;
6. “慢日志” – 记录脚本（不仅记录文件名，还记录 PHP backtrace 信息，可以使用 ptrace或者类似工具读取和分析远程进程的运行数据）运行所导致的异常缓慢;
7. fastcgi_finish_request() – 特殊功能：用于在请求完成和刷新数据后，继续在后台执行耗时的工作（录入视频转换、统计处理等）；
8. 动态／静态子进程产生；
9. 基本 SAPI 运行状态信息（类似Apache的 mod_status）；
10. 基于 php.ini 的配置文件。

**WSGI**

Web服务器网关接口（Python Web Server Gateway Interface，缩写为WSGI）是为Python语言定义的Web服务器和Web应用程序或框架之间的一种简单而通用的接口。自从WSGI被开发出来以后，许多其它语言中也出现了类似接口。WSGI是作为Web服务器与Web应用程序或应用框架之间的一种低级别的接口，以提升可移植Web应用开发的共同点。WSGI是基于现存的CGI标准而设计的。

WSGI区分为两个部份：一为“服务器”或“网关”，另一为“应用程序”或“应用框架”。在处理一个WSGI请求时，服务器会为应用程序提供环境资讯及一个回呼函数（Callback Function）。当应用程序完成处理请求后，透过前述的回呼函数，将结果回传给服务器。所谓的 WSGI 中间件同时实现了API的两方，因此可以在WSGI服务和WSGI应用之间起调解作用：从WSGI服务器的角度来说，中间件扮演应用程序，而从应用程序的角度来说，中间件扮演服务器。“中间件”组件可以执行以下功能：

1. 重写环境变量后，根据目标URL，将请求消息路由到不同的应用对象。
2. 允许在一个进程中同时运行多个应用程序或应用框架。
3. 负载均衡和远程处理，通过在网络上转发请求和响应消息。
4. 进行内容后处理，例如应用XSLT样式表。

以前，如何选择合适的Web应用程序框架成为困扰Python初学者的一个问题，这是因为，一般而言，Web应用框架的选择将限制可用的Web服务器的选择，反之亦然。那时的Python应用程序通常是为CGI，FastCGI，mod_python中的一个而设计，甚至是为特定Web服务器的自定义的API接口而设计的。WSGI没有官方的实现, 因为WSGI更像一个协议。只要遵照这些协议,WSGI应用(Application)都可以在任何服务器(Server)上运行, 反之亦然。WSGI就是Python的CGI包装，相对于Fastcgi是PHP的CGI包装。

WSGI将 web 组件分为三类： web服务器，web中间件,web应用程序， wsgi基本处理模式为 ： WSGI Server -> (WSGI Middleware)* -> WSGI Application 。

[![wsgi](http://www.biaodianfu.com/wp-content/uploads/2014/08/wsgi.png)](http://www.biaodianfu.com/wp-content/uploads/2014/08/wsgi.png)

1.WSGI Server/gateway

wsgi server可以理解为一个符合wsgi规范的web server，接收request请求，封装一系列环境变量，按照wsgi规范调用注册的wsgi app，最后将response返回给客户端。文字很难解释清楚wsgi server到底是什么东西，以及做些什么事情，最直观的方式还是看wsgi server的实现代码。以python自带的wsgiref为例，wsgiref是按照wsgi规范实现的一个简单wsgi server。它的代码也不复杂。

[![wsgi-gateway](http://www.biaodianfu.com/wp-content/uploads/2014/08/wsgi-gateway.png)](http://www.biaodianfu.com/wp-content/uploads/2014/08/wsgi-gateway.png)

1. 服务器创建socket，监听端口，等待客户端连接。
2. 当有请求来时，服务器解析客户端信息放到环境变量environ中，并调用绑定的handler来处理请求。
3. handler解析这个http请求，将请求信息例如method，path等放到environ中。
4. wsgi handler再将一些服务器端信息也放到environ中，最后服务器信息，客户端信息，本次请求信息全部都保存到了环境变量environ中。
5. wsgi handler 调用注册的wsgi app，并将environ和回调函数传给wsgi app
6. wsgi app 将reponse header/status/body 回传给wsgi handler
7. 最终handler还是通过socket将response信息塞回给客户端。

2.WSGI Application

wsgi application就是一个普通的callable对象，当有请求到来时，wsgi server会调用这个wsgi app。这个对象接收两个参数，通常为environ,start_response。environ就像前面介绍的，可以理解为环境变量，跟一次请求相关的所有信息都保存在了这个环境变量中，包括服务器信息，客户端信息，请求信息。start_response是一个callback函数，wsgi application通过调用start_response，将response headers/status 返回给wsgi server。此外这个wsgi app会return 一个iterator对象 ，这个iterator就是response body。这么空讲感觉很虚，对着下面这个简单的例子看就明白很多了。

3.WSGI MiddleWare

有些功能可能介于服务器程序和应用程序之间，例如，服务器拿到了客户端请求的URL, 不同的URL需要交由不同的函数处理，这个功能叫做 URL Routing，这个功能就可以放在二者中间实现，这个中间层就是 middleware。middleware对服务器程序和应用是透明的，也就是说，服务器程序以为它就是应用程序，而应用程序以为它就是服务器。这就告诉我们，middleware需要把自己伪装成一个服务器，接受应用程序，调用它，同时middleware还需要把自己伪装成一个应用程序，传给服务器程序。

其实无论是服务器程序，middleware 还是应用程序，都在服务端，为客户端提供服务，之所以把他们抽象成不同层，就是为了控制复杂度，使得每一次都不太复杂，各司其职。

参考资料：

- <http://blog.csdn.net/on_1y/article/details/18803563>
- <http://blog.kenshinx.me/blog/wsgi-research/>
- <http://blog.ez2learn.com/2010/01/27/introduction-to-wsgi/>

**uWSGI**

uWSGI 项目旨在为部署分布式集群的网络应用开发一套完整的解决方案。uWSGI主要面向web及其标准服务，已经成功的应用于多种不同的语言。由于uWSGI的可扩展架构，它能够被无限制的扩展用来支持更多的平台和语言。目前，你可以使用C，C++和Objective-C来编写插件。项目名称中的“WSGI”是为了向同名的Python Web标准表示感谢，因为WSGI为该项目开发了第一个插件。uWSGI是一个Web服务器，它实现了WSGI协议、uwsgi、http等协议。uWSGI，既不用wsgi协议也不用FastCGI协议，而是自创了一个uwsgi的协议，uwsgi协议是一个uWSGI服务器自有的协议，它用于定义传输信息的类型（type of information），每一个uwsgi packet前4byte为传输信息类型描述，它与WSGI相比是两样东西。据说该协议大约是fcgi协议的10倍那么快。

1. uWSGI的主要特点如下：
2. 超快的性能。
3. 低内存占用（实测为apache2的mod_wsgi的一半左右）。
4. 多app管理。
5. 详尽的日志功能（可以用来分析app性能和瓶颈）。
6. 高度可定制（内存大小限制，服务一定次数后重启等）。

其他拓展知识：Java Servlet、Sinatra、Rack


ref:
1.[CGI——万法归宗](https://zhuanlan.zhihu.com/p/25013398),   2.[如何理解 CGI, WSGI？](https://www.zhihu.com/question/19998865),   3.[CGI跟我学](http://www.jdon.com/idea/cgi.htm),   4.[cgi详解](http://blog.csdn.net/linuxheik/article/details/51865292),   5.[网关协议学习：CGI、FastCGI、WSGI](https://www.biaodianfu.com/cgi-fastcgi-wsgi.html),   6.[CGI](https://baike.baidu.com/item/CGI/607810?fr=aladdin),   7.[C++后台实践：古老的CGI与Web开发](http://blog.csdn.net/guodongxiaren/article/details/50569675)

