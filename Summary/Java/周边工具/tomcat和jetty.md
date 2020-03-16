### tomcat和jetty的比较

***

#### 一些差异

Jetty和Tomcat为目前全球范围内最著名的两款开源的webserver/servlet容器。 由于它们的实现都遵循[Java ](http://lib.csdn.net/base/java)Servlet规范，一个[java ](http://lib.csdn.net/base/java)Web应用部署于两款容器的任意一个皆可。 但选择哪个更优？也许这得看`场景`
Jetty更符合云环境的需求，亦分布式环境的需求。那Jetty与Tomcat比较，有哪**差异**呢？

- **Jetty更轻量级**。这是相对Tomcat而言的
由于Tomcat除了遵循[Java](http://lib.csdn.net/base/java) Servlet规范之外，自身还扩展了大量JEE特性以满足企业级应用的需求，所以**Tomcat是较重量级的，而且配置较Jetty亦复杂许多**。但对于大量普通互联网应用而言，并不需要用到Tomcat其他高级特性，所以在这种情况下，使用Tomcat是很浪费资源的。这种劣势放在分布式环境下，更是明显。换成Jetty，每个应用服务器省下那几兆内存，对于大的分布式环境则是节省大量资源。而且，Jetty的轻量级也使其在处理高并发细粒度请求的场景下显得更快速高效

- **jetty更灵活，体现在其可插拔性和可扩展性**，更易于开发者对Jetty本身进行二次开发，定制一个适合自身需求的Web Server。相比之下，重量级的Tomcat原本便支持过多特性，要对其瘦身的成本远大于丰富Jetty的成本。用自己的理解，即增肥容易减肥难。**然而，当支持大规模企业级应用时，Jetty也许便需要扩展，在这场景下Tomcat便是更优的**

- **总结** 
**Jetty更满足公有云的分布式环境的需求，而Tomcat更符合企业级环境**



#### Jetty和tomcat的比较
##### 相同点：
Tomcat和Jetty都是一种Servlet引擎，他们都支持标准的servlet规范和JavaEE的规范。

##### 不同点：
- [架构](http://lib.csdn.net/base/architecture)比较 
Jetty的架构比Tomcat的更为简单 
Jetty的架构是基于Handler来实现的，主要的扩展功能都可以用Handler来实现，扩展简单
Tomcat的架构是基于容器设计的，进行扩展是需要了解Tomcat的整体设计结构，不易扩展
- 性能比较 
Jetty和Tomcat性能方面差异不大 
**Jetty可以同时处理大量连接而且可以长时间保持连接，适合于web聊天应用等等**
Jetty的架构简单，因此作为服务器，Jetty可以按需加载组件，减少不需要的组件，减少了服务器内存开销，从而提高服务器性能
Jetty默认采用NIO结束在处理I/O请求上更占优势，在处理静态资源时，性能较高
- **少数非常繁忙，Tomcat适合处理少数非常繁忙的链接**，也就是说链接生命周期短的话，Tomcat的总体性能更高。 Tomcat默认采用BIO处理I/O请求，在处理静态资源时，性能较差。
- 其它比较 
*Jetty的应用更加快速，修改简单，对新的Servlet规范的支持较好*
*Tomcat目前应用比较广泛，对JavaEE和Servlet的支持更加全面，很多特性会直接集成进来*



#### 具体一点的了解
Jetty 的架构从前面的分析可知，它的所有组件都是基于 Handler 来实现，当然它也支持 JMX。但是主要的功能扩展都可以用 Handler 来实现。可以说 Jetty 是面向 Handler 的架构，就像 Spring 是面向 Bean 的架构，iBATIS 是面向 statement 一样，而 Tomcat 是以多级容器构建起来的，它们的架构设计必然都有一个“元神”，所有以这个“元神“构建的其它组件都是肉身

从设计模板角度来看 Handler 的设计实际上就是一个责任链模式，接口类 HandlerCollection 可以帮助开发者构建一个链，而另一个接口类 ScopeHandler 可以帮助你控制这个链的访问顺序。另外一个用到的设计模板就是观察者模式，用这个设计模式控制了整个 Jetty 的生命周期，只要继承了 LifeCycle 接口，你的对象就可以交给 Jetty 来统一管理了。所以扩展 Jetty 非常简单，也很容易让人理解，整体架构上的简单也带来了无比的好处，Jetty 可以很容易被扩展和裁剪

相比之下，Tomcat 要臃肿很多，Tomcat 的整体设计上很复杂，前面说了 Tomcat 的核心是它的容器的设计，从 Server 到 Service 再到 engine 等 container 容器。作为一个应用服务器这样设计无口厚非，容器的分层设计也是为了更好的扩展，这是这种扩展的方式是将应用服务器的内部结构暴露给外部使用者，使得如果想扩展 Tomcat，开发人员必须要首先了解 Tomcat 的整体设计结构，然后才能知道如何按照它的规范来做扩展。这样无形就增加了对 Tomcat 的学习成本。不仅仅是容器，实际上 Tomcat 也有基于责任链的设计方式，像串联 Pipeline 的 Vavle 设计也是与 Jetty 的 Handler 类似的方式。要自己实现一个 Vavle 与写一个 Handler 的难度不相上下。表面上看，Tomcat 的功能要比 Jetty 强大，因为 Tomcat 已经帮你做了很多工作了，而 Jetty 只告诉，你能怎么做，如何做，有你去实现

单纯比较 Tomcat 与 Jetty 的性能意义不是很大，只能说在某种使用场景下，它表现的各有差异。因为它们面向的使用场景不尽相同。从架构上来看 Tomcat 在处理少数非常繁忙的连接上更有优势，也就是说连接的生命周期如果短的话，Tomcat 的总体性能更高

而 Jetty 刚好相反，Jetty 可以同时处理大量连接而且可以长时间保持这些连接。例如像一些 web 聊天应用非常适合用 Jetty 做服务器，像淘宝的 web 旺旺就是用 Jetty 作为 Servlet 引擎

另外由于 Jetty 的架构非常简单，作为服务器它可以按需加载组件，这样不需要的组件可以去掉，这样无形可以减少服务器本身的内存开销，处理一次请求也是可以减少产生的临时对象，这样性能也会提高。另外 Jetty 默认使用的是 NIO 技术在处理 I/O 请求上更占优势，Tomcat 默认使用的是 BIO，在处理静态资源时，Tomcat 的性能不如 Jetty



ref:

1.[Jetty与Tomcat的区别 转](http://www.cnblogs.com/gym333/p/5127941.html),   2.[tomcat与jetty的区别](http://www.cnblogs.com/fengli9998/p/7247559.html),   3.[jetty与tomcat区别](http://blog.csdn.net/u014209975/article/details/52598428)