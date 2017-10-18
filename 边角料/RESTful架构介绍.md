# RESTful架构介绍

#####API

在说RESTful API之前，先说说啥是API，此处的API和我们在Java之中使用的API是同一个概念，都简称接口。随着现在移动互联网的火爆，手机APP发展迅猛。几乎任何一个网站或者应用都会出一款iOS或者Android APP，那么现在问题来了。假如QQ空间，如果我想获取一个用户发的说说列表，那么会有如下问题：

> QQ空间网站里面需要这个功能。
>
> Andoid APP里面也需要这个功能
>
> iOS APP里面也需要这个功能

那么按照传统的开发网站的结构，就要写3套获取用户说说列表的功能。也就是需要在3个地方都写连接mysql，查询mysql，可想而知是非常浪费时间和经历的，而且安全性能很差，所以**API**就诞生了，API就是为了解决这种情况而诞生，**由一个地方统一提供API接口，哪个平台想使用就直接调用这个API接口来获取信息就可以了**。

比如：获取QQ空间用户发的说说列表：

> QQ Zone Web: <https://api.qzone.com/user/getUserFeedList?from=web> 
> QQ Zone Android: <https://api.qzone.com/user/getUserFeedList?from=android> 
> QQ Zone iOS: <https://api.qzone.com/user/getUserFeedList?from=ios>



#####REST&RESTful

REST: **表述性状态传递**（**Representational State Transfer**，简称**REST**）是Roy Fielding博士在2000年他的博士论文中提出来的一种**软件架构风格**。*它是一种针对网络应用的设计和开发方式*，++可以降低开发的复杂性，提高系统的可伸缩性++,设计风格而**不是标准**，只是提供了一组设计原则和约束条件。基于这个风格设计的软件可以更简洁，更有层次，更易于实现缓存等机制，*实现了REST风格的API就是RESTful的API*。REST首次出现在 2000 年 Roy Fielding 的博士论文中，Fielding是 HTTP 规范的主要编写者之一。在目前主流的三种Web服务交互方案中，REST相比于SOAP（Simple Object Access protocol，简单对象访问协议）以及XML-RPC更加简单明了，无论是对URL的处理还是对Payload的编码，**REST都倾向于用更加简单轻量的方法设计和实现**。++值得注意的是REST并没有一个明确的标准，而更像是一种设计的风格++。



#####理解RESTful架构

"互联网软件"采用客户端/服务器模式，建立在分布式体系上，通过互联网通信，具有高延时（high latency）、高并发等特点。

网站开发，完全可以采用软件开发的模式。但是传统上，软件和网络是两个不同的领域，很少有交集；软件开发主要针对单机环境，网络则主要研究系统之间的通信。互联网的兴起，使得这两个领域开始融合，**现在我们必须考虑，如何开发在互联网环境中使用的软件。**

![img](http://image.beekka.com/blog/201109/bg2011091202.jpg)

RESTful架构，就是目前最流行的一种互联网软件架构。它结构清晰、符合标准、易于理解、扩展方便，所以正得到越来越多网站的采用。

但是，到底什么是RESTful架构，并不是一个容易说清楚的问题。下面简单介绍一下RESTful架构。

**起源**

REST这个词，是Fielding在其博士论文中提出的，他也是HTTP协议（1.0版和1.1版）的主要设计者、Apache服务器软件的作者之一、Apache基金会的第一任主席。他的这篇论文一经发表，就引起了关注，并且立即对互联网开发产生了深远的影响。

他这样介绍论文的写作目的：

> "本文研究计算机科学两大前沿----软件和网络----的交叉点。长期以来，软件研究主要关注软件设计的分类、设计方法的演化，很少客观地评估不同的设计选择对系统行为的影响。而相反地，网络研究主要关注系统之间通信行为的细节、如何改进特定通信机制的表现，常常忽视了一个事实，那就是改变应用程序的互动风格比改变互动协议，对整体表现有更大的影响。**我这篇文章的写作目的，就是想在符合架构原理的前提下，理解和评估以网络为基础的应用软件的架构设计，得到一个功能强、性能好、适宜通信的架构。**"
>
> (This dissertation explores a junction on the frontiers of two research disciplines in computer science: software and networking. Software research has long been concerned with the categorization of software designs and the development of design methodologies, but has rarely been able to objectively evaluate the impact of various design choices on system behavior. Networking research, in contrast, is focused on the details of generic communication behavior between systems and improving the performance of particular communication techniques, often ignoring the fact that changing the interaction style of an application can have more impact on performance than the communication protocols used for that interaction. My work is motivated by the desire to understand and evaluate the architectural design of network-based application software through principled use of architectural constraints, thereby obtaining the functional, performance, and social properties desired of an architecture. )

**名称**

Fielding将他对互联网软件的架构原则，定名为REST，即Representational State Transfer的缩写。这个词组的翻译是**"表现层状态转化"**。如果一个架构符合REST原则，就称它为RESTful架构。

**要理解RESTful架构，最好的方法就是去理解Representational State Transfer这个词组到底是什么意思，它的每一个词代表了什么涵义。**如果你把这个名称搞懂了，也就不难体会REST是一种什么样的设计。

**资源(Resources)**

REST的名称"表现层状态转化"中，省略了主语。"表现层"其实指的是**"资源"**（Resources）的"表现层"。所谓++"资源"，就是网络上的一个实体，或者说是网络上的一个具体信息++。*它可以是一段文本、一张图片、一首歌曲、一种服务，总之就是一个具体的实在*。你可以用一个URI（统一资源定位符）指向它，每种资源对应一个特定的URI。要获取这个资源，访问它的URI就可以，因此URI就成了每一个资源的地址或独一无二的识别符。平常所说的"上网"，就是与互联网上一系列的"资源"互动，调用它的URI。

**表现层（Representation）**

"资源"是一种信息实体，它可以有多种外在表现形式。**我们把"资源"具体呈现出来的形式，叫做它的"表现层"（Representation）。**比如，文本可以用txt格式表现，也可以用HTML格式、XML格式、JSON格式表现，甚至可以采用二进制格式；图片可以用JPG格式表现，也可以用PNG格式表现。**URI只代表资源的实体，不代表它的形式**。严格地说，有些网址最后的".html"后缀名是不必要的，因为这个后缀名表示格式，属于"表现层"范畴，而URI应该只代表"资源"的位置。它的具体表现形式，应该在HTTP请求的头信息中用Accept和Content-Type字段指定，这两个字段才是对"表现层"的描述。

**状态转化（State Transfer）**

*访问一个网站，就代表了客户端和服务器的一个互动过程。在这个过程中，势必涉及到数据和状态的变化*。互联网通信协议HTTP协议，是一个无状态协议。这意味着，所有的状态都保存在服务器端。因此，**如果客户端想要操作服务器，必须通过某种手段，让服务器端发生"状态转化"（State Transfer）。而这种转化是建立在表现层之上的，所以就是"表现层状态转化"。**客户端用到的手段，只能是HTTP协议。具体来说，就是HTTP协议里面，四个表示操作方式的动词：GET、POST、PUT、DELETE。它们分别对应四种基本操作：**GET用来获取资源，POST用来新建资源（也可以用于更新资源），PUT用来更新资源，DELETE用来删除资源。**

**综述**

综合上面的解释，我们总结一下什么是RESTful架构：

　　(1)每一个URI代表一种资源；

　　(2)客户端和服务器之间，传递这种资源的某种表现层；

　　(3)**客户端通过四个HTTP动词，对服务器端资源进行操作，实现"表现层状态转化"**。

**误区**

RESTful架构有一些典型的设计误区。

**最常见的一种设计错误，就是URI包含动词。**因为"资源"表示一种实体，所以应该是名词，URI不应该有动词，动词应该放在HTTP协议中。

举例来说，某个URI是/posts/show/1，其中show是动词，这个URI就设计错了，正确的写法应该是/posts/1，然后用GET方法表示show。如果某些动作是HTTP动词表示不了的，你就应该把动作做成一种资源。比如网上汇款，从账户1向账户2汇款500元，错误的URI是：

> 　　POST /accounts/1/transfer/500/to/2

正确的写法是把动词transfer改成名词transaction，资源不能是动词，但是可以是一种服务：

> 　　POST /transaction HTTP/1.1
> 　　Host: 127.0.0.1
> 　　from=1&to=2&amount=500.00

**另一个设计误区，就是在URI中加入版本号**：

> 　　http://www.example.com/app/1.0/foo
>
> 　　http://www.example.com/app/1.1/foo
>
> 　　http://www.example.com/app/2.0/foo

因为不同的版本，可以理解成同一种资源的不同表现形式，所以应该采用同一个URI。版本号可以在HTTP请求头信息的Accept字段中进行区分（参见[Versioning REST Services](http://www.informit.com/articles/article.aspx?p=1566460)）：

> 　　Accept: vnd.example-com.foo+json; version=1.0
>
> 　　Accept: vnd.example-com.foo+json; version=1.1
>
> 　　Accept: vnd.example-com.foo+json; version=2.0

**其实最重要的点就是将用户的互动和数据库之间的操作，通过比较纯粹的相应的HTTP动作来完成，将资源和网址对应起来，将HTTP的资源的操作和SQL操作对应起来使用名词来标注网址，而非动词**，具体的设计规则，看下面一部分。



#####RESTful API 设计指南

网络应用程序，分为前端和后端两个部分。当前的发展趋势，就是前端设备层出不穷（手机、平板、桌面电脑、其他专用设备......）。因此，必须有一种统一的机制，方便不同的前端设备与后端进行通信。这导致API构架的流行，甚至出现["API First"](http://www.google.com.hk/search?q=API+first)的设计思想。[RESTful API](http://en.wikipedia.org/wiki/Representational_state_transfer)是目前比较成熟的一套互联网应用程序的API设计理论。今天，介绍RESTful API的设计细节，探讨如何设计一套合理、好用的API。我的主要参考了两篇文章([1](http://codeplanet.io/principles-good-restful-api-design/)，[2](https://bourgeois.me/rest/))。

![RESTful API](http://image.beekka.com/blog/2014/bg2014052201.png)

**协议**

API与用户的通信协议，总是使用[HTTPs协议](http://www.ruanyifeng.com/blog/2014/02/ssl_tls.html)。

**域名**

应该尽量将API部署在专用域名之下。

> ```
> https://api.example.com
>
> ```

如果确定API很简单，不会有进一步扩展，可以考虑放在主域名下。

> ```
> https://example.org/api/
>
> ```

**版本（Versioning）**

应该将API的版本号放入URL。

> ```
> https://api.example.com/v1/
>
> ```

另一种做法是，将版本号放在HTTP头信息中，但不如放入URL方便和直观。[Github](https://developer.github.com/v3/media/#request-specific-version)采用这种做法。

**路径（Endpoint）**

路径又称"终点"（endpoint），表示API的具体网址。

在RESTful架构中，每个网址代表一种资源（resource），所以网址中不能有动词，只能有名词，而且所用的名词往往与数据库的表格名对应。一般来说，数据库中的表都是同种记录的"集合"（collection），所以API中的名词也应该使用复数。

举例来说，有一个API提供动物园（zoo）的信息，还包括各种动物和雇员的信息，则它的路径应该设计成下面这样。

> - https://api.example.com/v1/zoos
> - https://api.example.com/v1/animals
> - https://api.example.com/v1/employees

**HTTP动词**

对于资源的具体操作类型，由HTTP动词表示。

常用的HTTP动词有下面五个（括号里是对应的SQL命令）。

> - GET（SELECT）：从服务器取出资源（一项或多项）。
> - POST（CREATE）：在服务器新建一个资源。
> - PUT（UPDATE）：在服务器更新资源（客户端提供改变后的完整资源）。
> - PATCH（UPDATE）：在服务器更新资源（客户端提供改变的属性）。
> - DELETE（DELETE）：从服务器删除资源。

还有两个不常用的HTTP动词。

> - HEAD：获取资源的元数据。
> - OPTIONS：获取信息，关于资源的哪些属性是客户端可以改变的。

下面是一些例子。

> - GET /zoos：列出所有动物园
> - POST /zoos：新建一个动物园
> - GET /zoos/ID：获取某个指定动物园的信息
> - PUT /zoos/ID：更新某个指定动物园的信息（提供该动物园的全部信息）
> - PATCH /zoos/ID：更新某个指定动物园的信息（提供该动物园的部分信息）
> - DELETE /zoos/ID：删除某个动物园
> - GET /zoos/ID/animals：列出某个指定动物园的所有动物
> - DELETE /zoos/ID/animals/ID：删除某个指定动物园的指定动物



**过滤信息（Filtering）**

如果记录数量很多，服务器不可能都将它们返回给用户。API应该提供参数，过滤返回结果。

下面是一些常见的参数。

> - ?limit=10：指定返回记录的数量
> - ?offset=10：指定返回记录的开始位置。
> - ?page=2&per_page=100：指定第几页，以及每页的记录数。
> - ?sortby=name&order=asc：指定返回结果按照哪个属性排序，以及排序顺序。
> - ?animal_type_id=1：指定筛选条件

参数的设计允许存在冗余，即允许API路径和URL参数偶尔有重复。比如，GET /zoo/ID/animals 与 GET /animals?zoo_id=ID 的含义是相同的。



**状态码（Status Codes）**

服务器向用户返回的状态码和提示信息，常见的有以下一些（方括号中是该状态码对应的HTTP动词）。

> - 200 OK - [GET]：服务器成功返回用户请求的数据，该操作是幂等的（Idempotent）。
> - 201 CREATED - [POST/PUT/PATCH]：用户新建或修改数据成功。
> - 202 Accepted - [*]：表示一个请求已经进入后台排队（异步任务）
> - 204 NO CONTENT - [DELETE]：用户删除数据成功。
> - 400 INVALID REQUEST - [POST/PUT/PATCH]：用户发出的请求有错误，服务器没有进行新建或修改数据的操作，该操作是幂等的。
> - 401 Unauthorized - [*]：表示用户没有权限（令牌、用户名、密码错误）。
> - 403 Forbidden - [*] 表示用户得到授权（与401错误相对），但是访问是被禁止的。
> - 404 NOT FOUND - [*]：用户发出的请求针对的是不存在的记录，服务器没有进行操作，该操作是幂等的。
> - 406 Not Acceptable - [GET]：用户请求的格式不可得（比如用户请求JSON格式，但是只有XML格式）。
> - 410 Gone -[GET]：用户请求的资源被永久删除，且不会再得到的。
> - 422 Unprocesable entity - [POST/PUT/PATCH] 当创建一个对象时，发生一个验证错误。
> - 500 INTERNAL SERVER ERROR - [*]：服务器发生错误，用户将无法判断发出的请求是否成功。

状态码的完全列表参见[这里](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html)。



**错误处理（Error handling）**

如果状态码是4xx，就应该向用户返回出错信息。一般来说，返回的信息中将error作为键名，出错信息作为键值即可。

> ```
> {
>     error: "Invalid API key"
> }
>
> ```

**返回结果**

针对不同操作，服务器向用户返回的结果应该符合以下规范。

> - GET /collection：返回资源对象的列表（数组）
> - GET /collection/resource：返回单个资源对象
> - POST /collection：返回新生成的资源对象
> - PUT /collection/resource：返回完整的资源对象
> - PATCH /collection/resource：返回完整的资源对象
> - DELETE /collection/resource：返回一个空文档

**Hypermedia API**

RESTful API最好做到Hypermedia，即返回结果中提供链接，连向其他API方法，使得用户不查文档，也知道下一步应该做什么。

比如，当用户向api.example.com的根目录发出请求，会得到这样一个文档。

> ```
> {"link": {
>   "rel":   "collection https://www.example.com/zoos",
>   "href":  "https://api.example.com/zoos",
>   "title": "List of zoos",
>   "type":  "application/vnd.yourformat+json"
> }}
>
> ```

上面代码表示，文档中有一个link属性，用户读取这个属性就知道下一步该调用什么API了。rel表示这个API与当前网址的关系（collection关系，并给出该collection的网址），href表示API的路径，title表示API的标题，type表示返回类型。

Hypermedia API的设计被称为[HATEOAS](http://en.wikipedia.org/wiki/HATEOAS)。Github的API就是这种设计，访问[api.github.com](https://api.github.com/)会得到一个所有可用API的网址列表。

> ```
> {
>   "current_user_url": "https://api.github.com/user",
>   "authorizations_url": "https://api.github.com/authorizations",
>   // ...
> }
>
> ```

从上面可以看到，如果想获取当前用户的信息，应该去访问[api.github.com/user](https://api.github.com/user)，然后就得到了下面结果。

> ```
> {
>   "message": "Requires authentication",
>   "documentation_url": "https://developer.github.com/v3"
> }
>
> ```

上面代码表示，服务器给出了提示信息，以及文档的网址。

**其他**

（1）API的身份认证应该使用[OAuth 2.0](http://www.ruanyifeng.com/blog/2014/05/oauth_2_0.html)框架。

（2）服务器返回的数据格式，应该尽量使用JSON，避免使用XML。

ref:

1.[REST](https://baike.baidu.com/item/rest/6330506?fr=aladdin), 2.[RESTful](https://baike.baidu.com/item/RESTful/4406165?fr=aladdin), 3.[Restful API 原理以及实现](http://blog.csdn.net/u013474436/article/details/49908961), 4.[怎样用通俗的语言解释REST，以及RESTful?](https://www.zhihu.com/question/28557115), 5.[RESTful API 设计最佳实践](http://www.csdn.net/article/2013-06-13/2815744-RESTful-API), 6.[理解RESTful架构](http://www.ruanyifeng.com/blog/2011/09/restful.html), 7.[RESTful API 设计指南](http://www.ruanyifeng.com/blog/2014/05/restful_api.html), 8.[RESTful API 设计最佳实践](http://blog.jobbole.com/41233/), 9.[举例说明，RESTful 到底有哪些好处?](https://www.zhihu.com/question/20130130), 10.[REST简介](http://www.cnblogs.com/loveis715/p/4669091.html)