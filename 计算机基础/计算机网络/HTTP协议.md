###HTTP协议
######简介
![HTTP协议设计思路](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_webserver.png)
HTTP 是基于**TCP/IP**协议的应用层协议。它不涉及数据包（packet）传输，**主要规定了客户端和服务器之间的通信格式，默认使用80端口**，**Http协议是无状态的**，++同一个客户端的这次请求和上次请求是没有对应关系，对Http服务器来说，它并不知道这两个请求来自同一个客户端。为了解决这个问题，Web程序引入了Cookie机制来维护状态++。
######发展历史
1. HTTP/0.9
最早版本是1991年发布的0.9版。该版本极其简单，只有一个命令GET，
```html
GET /index.html
```
上面命令表示，==TCP==连接（connection）建立后，客户端向服务器请求（request）网页index.html。0.9版本中规定，服务器只能回应HTML格式的字符串，不能回应别的格式，**服务器发送完毕，就关闭TCP连接**。
```html
<html>
  <body>Hello World</body>
</html>
```
2. HTTP/1.0
1996年5月，HTTP/1.0 版本发布，内容大大增加。**任何格式的内容都可以发送**。这使得互联网不仅可以传输文字，还能传输图像、视频、二进制文件。其次，除了GET命令，还**引入了POST命令和HEAD命令**，丰富了浏览器与服务器的互动手段。再次，**HTTP请求和回应的格式也变了**。++除了数据部分，每次通信都必须包括头信息（HTTP header），用来描述一些元数据++。其他的新增功能还包括**状态码（status code）**、**多字符集支持**、**多部分发送（multi-part type）**、**权限（authorization）**、**缓存（cache）**、**内容编码（content encoding）**等。
2.1 请求格式
```html
GET / HTTP/1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5)
Accept: */*
```
第一行是请求命令，必须在尾部添加协议版本（HTTP/1.0）。后面就是多行头信息，描述客户端的情况。
2.2 回应格式
```html
HTTP/1.0 200 OK
Content-Type: text/plain
Content-Length: 137582
Expires: Thu, 05 Dec 1997 16:00:00 GMT
Last-Modified: Wed, 5 August 1996 15:55:28 GMT
Server: Apache 0.84
<!--此行没有数据，但必须存在！-->
<html>
  <body>Hello World</body>
</html>
```
回应的格式是"==头信息== + **一个空行（\r\n）** + ==数据=="。其中，第一行是"协议版本 + 状态码（status code） + 状态描述"。
2.3Content-Type 字段
关于字符的编码，1.0版规定，头信息必须是 ASCII 码，后面的数据可以是任何格式。因此，**服务器回应的时候，必须告诉客户端，数据是什么格式**，这就是**Content-Type**字段的作用。
下面是一些常见的Content-Type字段的值。
```html
text/plain
text/html
text/css
image/jpeg
image/png
image/svg+xml
audio/mp4
video/mp4
application/javascript
application/pdf
application/zip
application/atom+xml
```
这些数据类型总称为**MIME type**，每个值包括一级类型和二级类型，之间用斜杠分隔。除了预定义的类型，厂商也可以自定义类型。MIME type还可以在尾部使用分号，添加参数，如下表示**数据为是网页，编码为UTF-8**。
```html
Content-Type: text/html; charset=utf-8
```
客户端请求的时候，可以使用**Accept字段声明自己可以接受哪些数据格式**。
Accept: */*
上面代码中，客户端声明自己可以接受任何格式的数据。
**MIME type**
>MIME(**Multipurpose Internet Mail Extensions**)多用途互联网邮件扩展类型。是设定某种扩展名的文件用一种应用程序来打开的方式类型，当该扩展名文件被访问的时候，浏览器会自动使用指定应用程序来打开。多用于指定一些客户端自定义的文件名，以及一些媒体文件打开方式

 2.4Content-Encoding 字段
 由于发送的数据可以是任何格式，因此可以把数据压缩后再发送。**Content-Encoding字段说明数据的压缩方法**。
```html
Content-Encoding: gzip
Content-Encoding: compress
Content-Encoding: deflate
```
客户端在请求时，用**Accept-Encoding字段说明自己可以接受哪些压缩方法**。
```
Accept-Encoding: gzip, deflate
```
2.5 缺点
**HTTP/1.0 版的主要缺点是，每个TCP连接只能发送一个请求。发送数据完毕，连接就关闭，如果还要请求其他资源，就必须再新建一个连接**。因为需要客户端和服务器三次握手,所以TCP连接的新建成本很高，所以，HTTP1.0版本的性能比较差。解决方式是**用一个非标准的Connection字段**，这个字段要求服务器不要关闭TCP连接，以便其他请求复用。服务器同样回应这个字段
```html
Connection: keep-alive
```

3. HTTP/1.1
1997年1月，HTTP/1.1 版本发布，进一步完善了 HTTP 协议，一直用到了20年后的今天，直到现在还是最流行的版本。

 3.1持久连接
最大变化就是引入了**持久连接（persistent connection）**，==即TCP连接默认不关闭，可以被多个请求复用，不用声明Connection: keep-alive==。客户端和服务器发现对方一段时间没有活动，就可以主动关闭连接。不过，规范的做法是，客户端在最后一个请求时，发送`Connection: close`，明确要求服务器关闭TCP连接。**对于同一个域名，大多数浏览器允许同时建立6个持久连接**。
```html
Connection: close
```

 3.2 管道机制
引入了**管道机制（pipelining）**，++即在同一个TCP连接里面，客户端可以同时发送多个请求++。这样就进一步改进了HTTP协议的效率。*例如，客户端需要请求两个资源。以前的做法是，在同一个TCP连接里面，先发送A请求，然后等待服务器做出回应，收到后再发出B请求。管道机制则是允许浏览器同时发出A请求和B请求，但是服务器还是按照顺序，先回应A请求，完成后再回应B请求*。

 3.3 Content-Length 字段
一个TCP连接现在可以传送多个回应，势必就要有一种机制，**区分数据包是属于哪一个TCP连接回应的**。这就是**Content-length**字段的作用，**声明本次回应的数据长度**，如下本次回应的长度是3495个字节
```html
Content-Length: 3495
```

 3.4 分块传输编码
*使用Content-Length字段的前提条件是，服务器发送回应之前，必须知道回应的数据长度*。**对于一些很耗时的动态操作来说**，这意味着，服务器要等到所有操作完成，才能发送数据，显然这样的效率不高。更好的处理方法是，产生一块数据，就发送一块，==采用"流模式"（stream）取代"缓存模式"（buffer）==。1.1版规定==可以不使用Content-Length字段==，而使用**"分块传输编码"（chunked transfer encoding）**。只要请求或回应的头信息有Transfer-Encoding字段，就表明回应将由数量未定的数据块组成。
```html
Transfer-Encoding: chunked
```
每个非空的数据块之前，会有一个16进制的数值，表示这个块的长度。**最后是一个大小为0的块**，就表示本次回应的数据发送完了。下面是一个例子。
```html
HTTP/1.1 200 OK
Content-Type: text/plain
Transfer-Encoding: chunked
25
This is the data in the first chunk
1C
and this is the second one
3
con
8
sequence
0
```

 3.5 其他功能
1.1版还新增了许多动词方法：**PUT**、**PATCH**、**HEAD**、 **OPTIONS**、**DELETE**。另外，==客户端请求的头信息新增了**Host**字段，**用来指定服务器的域名**==。有了Host字段，就可以将请求发往同一台服务器上的不同网站，为虚拟主机的兴起打下了基础。
```html
Host: www.example.com
```

 3.6 缺点
虽然1.1版允许复用TCP连接，但是**同一个TCP连接里面，所有的数据通信是按次序进行的。服务器只有处理完一个回应，才会进行下一个回应**。要是前面的回应特别慢，后面就会有许多请求排队等着。这称为"**队头堵塞**"（Head-of-line blocking）。为了避免这个问题，只有两种方法：一是减少请求数，二是同时多开持久连接。这导致了很多的网页优化技巧，比如合并脚本和样式表、将图片嵌入CSS代码、域名分片（domain sharding）等等。

4. HTTP/2
 4.1 SPDY协议
2009年，谷歌公开了自行研发的SPDY==协议，主要**解决HTTP/1.1效率不高的问题**。这个协议在Chrome浏览器上证明可行以后，就被当作 HTTP/2 的基础，主要特性都在 HTTP/2 之中得到继承。

 4.2 HTTP/2
2015年，HTTP/2 发布。它不叫 HTTP/2.0，是因为标准委员会不打算再发布子版本了，下一个新版本将是 HTTP/3。
  1. 二进制协议
HTTP/1.1 版的头信息肯定是文本（ASCII编码），数据体可以是文本，也可以是二进制。**HTTP/2 则是一个彻底的二进制协议，头信息和数据体都是二进制，并且统称为"帧"（frame）：头信息帧和数据帧**。二进制协议的一个好处是，可以定义额外的帧。HTTP/2 定义了近十种帧，为将来的高级应用打好了基础，**并且二进制的解析更方便**。
 2. 多工
HTTP/2 复用TCP连接，在一个连接里，客户端和浏览器都可以同时发送多个请求或回应，而且不用按照顺序一一对应，这样就**避免了"队头堵塞"**。举例来说，在一个TCP连接里面，服务器同时收到了A请求和B请求，于是先回应A请求，结果发现处理过程非常耗时，于是就发送A请求已经处理好的部分，接着回应B请求，完成后，再发送A请求剩下的部分。**这样双向的、实时的通信，就叫做多工（Multiplexing）**。
 3. 数据流
++因为 HTTP/2 的数据包是不按顺序发送的，同一个连接里面连续的数据包，可能属于不同的回应++。因此，必须要对数据包做标记，指出它属于哪个回应。**HTTP/2将每个请求或回应的所有数据包，称为一个数据流（stream）。每个数据流都有一个独一无二的编号**。数据包发送的时候，都必须标记数据流ID，用来区分它属于哪个数据流。另外还规定，**客户端发出的数据流，ID一律为奇数，服务器发出的，ID为偶数**。数据流发送到一半的时候，客户端和服务器都可以发送信号（RST_STREAM帧），取消这个数据流。*1.1版取消数据流的唯一方法，就是关闭TCP连接*。即**HTTP/2 可以取消某一次请求，同时保证TCP连接还打开着，可以被其他请求使用**。**客户端还可以指定数据流的优先级**。优先级越高，服务器就会越早回应。
 4. 头信息压缩
**HTTP 协议不带有状态，每次请求都必须附上所有信息**。所以，请求的很多字段都是重复的，比如Cookie和User Agent，相同的内容，每次请求都必须附带，会浪费带宽影响速度。**HTTP/2引入了头信息压缩机制（header compression）**。1.头信息使用gzip或compress压缩后再发送；2.客户端和服务器同时维护一张头信息表，所有字段都会存入这个表，生成一个索引号，以后就不发送同样字段了，只发送索引号，这样就提高速度了。
 5. 服务器推送
**HTTP/2 允许服务器未经请求，主动向客户端发送资源，这叫做服务器推送（server push）**。
常见场景是客户端请求一个网页，这个网页里面包含很多静态资源。正常情况下，客户端必须收到网页后，解析HTML源码，发现有静态资源，再发出静态资源请求。其实，服务器可以预期到客户端请求网页后，很可能会再请求静态资源，所以就主动把这些静态资源随着网页一起发给客户端了。

######关于URL
1. URL的组成
以`http://www.aspxfans.com:8080/news/index.asp?boardID=5&ID=24618&page=1#name`为例，可以看出，一个完整的URL包括以下几部分：
    - **协议部分**：该URL的协议部分为“==http:==”，这代表网页使用的是http协议。本例中使用的是http协议。在=="http"后面的“//”为分隔符==
    - **域名部分**：该URL的域名部分为“==*www.aspxfans.com*==”。一个URL中，也可以使用IP地址作为域名使用
    - **端口部分**：跟在域名后面的是==端口==，*域名和端口之间使用“:”作为分隔符*。++端口不是一个URL必须的部分，如果省略端口部分，将采用默认端口++
    - **虚拟目录部分**：==从域名后的第一个“/”开始到最后一个“/”为止==，是*虚拟目录部分*。虚拟目录也不是一个URL必须的部分。本例中的虚拟目录是“/news/”
    - **文件名部分**：==从域名后的最后一个“/”开始到“？”为止==，是*文件名部分*，如果没有“?”,则是从域名后的最后一个“/”开始到“#”为止，是文件部分，如果没有“？”和“#”，那么从域名后的最后一个“/”开始到结束，都是文件名部分。本例中的文件名是“index.asp”。文件名部分也不是一个URL必须的部分，如果省略该部分，则使用默认的文件名
    - **锚部分**：==从“#”开始到最后，都是锚部分==。本例中的锚部分是“name”。锚部分也不是一个URL必须的部分
    - **参数部分**：==从“？”开始到“#”为止之间的部分为参数部分，又称搜索部分、查询部分==。本例中的参数部分为“boardID=5&ID=24618&page=1”。参数可以允许有多个参数，参数与参数之间用“&”作为分隔符。

2. URI, URN 与 URL 的区别
- **URI，是uniform resource identifier，统一资源标识符，用来唯一的标识一个资源**，Web上可用的每种资源如HTML文档、图像、视频片段、程序等都是一个来URI来定位的，URI一般由三部组成：
 - 访问资源的命名机制
 - 存放资源的主机名
 - 资源自身的名称，由路径表示，着重强调于资源。
- **URL是uniform resource locator，统一资源定位器，它是一种具体的URI，即URL可以用来标识一个资源，而且还指明了如何locate这个资源**，URL是Internet上用来描述信息资源的字符串，主要用在各种WWW客户程序和服务器程序上，特别是著名的Mosaic。采用URL可以用一种统一的格式来描述各种信息资源，包括文件、服务器的地址和目录等。URL一般由三部组成：
 - 协议(或称为服务方式)
 - 存有该资源的主机IP地址(有时也包括端口号)
 - 主机资源的具体地址。如目录和文件名等
- **URN，uniform resource name，统一资源命名，是通过名字来标识资源，比如mailto:java-net@java.sun.com**，URI是以一种抽象的，高层次概念定义统一资源标识，而URL和URN则是具体的资源标识的方式。URL和URN都是一种URI。笼统地说，每个 URL 都是 URI，但不一定每个 URI 都是 URL。这是因为 URI 还包括一个子类，即统一资源名称 (URN)，它命名资源但不指定如何定位资源。上面的 mailto、news 和 isbn URI 都是 URN 的示例。

>在Java的URI中，一个URI实例可以代表绝对的，也可以是相对的，只要它符合URI的语法规则。而URL类则不仅符合语义，还包含了定位该资源的信息，因此它不能是相对的。
在Java类库中，URI类不包含任何访问资源的方法，它唯一的作用就是解析。相反的是，URL类可以打开一个到达资源的流。

######HTTP工作原理
HTTP协议定义Web客户端如何从Web服务器请求Web页面，以及服务器如何把Web页面传送给客户端。**HTTP协议采用了请求/响应模型**。客户端向服务器发送一个请求报文，请求报文包含请求的方法、URL、协议版本、请求头部和请求数据。服务器以一个状态行作为响应，响应的内容包括协议的版本、成功或者错误代码、服务器信息、响应头部和响应数据。以下是 HTTP 请求/响应的步骤：

1. **客户端连接到Web服务器**
一个HTTP客户端，通常是浏览器，与Web服务器的HTTP端口（默认为80）建立一个TCP套接字连接。
```html
http://www.baidu.cn。
```
2. **发送HTTP请求**
通过TCP套接字，客户端向Web服务器**发送一个文本的请求报文**，一个请求报文由请求行、请求头部、空行和请求数据4部分组成。
3. **服务器接受请求并返回HTTP响应**
Web服务器解析请求，定位请求资源。**服务器将资源复本写到TCP套接字，由客户端读取**。一个响应由状态行、响应头部、空行和响应数据4部分组成。
4. **释放连接TCP连接**
若connection 模式为close，则服务器主动关闭TCP连接，客户端被动关闭连接，释放TCP连接;若connection 模式为keepalive，则该连接会保持一段时间，在该时间内可以继续接收请求;
5. **客户端浏览器解析HTML内容**
**客户端浏览器首先解析状态行，查看表明请求是否成功的状态代码**。然后解析每一个响应头，响应头告知以下为若干字节的HTML文档和文档的字符集。客户端浏览器读取响应数据HTML，根据HTML的语法对其进行格式化，并在浏览器窗口中显示。
例如：在浏览器地址栏键入URL，按下回车之后会经历以下流程：
```text
1、浏览器向 DNS 服务器请求解析该 URL 中的域名所对应的 IP 地址;
2、解析出 IP 地址后，根据该 IP 地址和默认端口 80，和服务器建立TCP连接;
3、浏览器发出读取文件(URL 中域名后面部分对应的文件)的HTTP 请求，该请求报文作为 TCP 三次握手的第三个报文的数据发送给服务器;
4、服务器对浏览器请求作出响应，并把对应的 html 文本发送给浏览器;
5、释放 TCP连接;
6、浏览器将该 html 文本并显示内容
```

######HTTP请求
请求行以一个方法符号开头，以空格分开，后面跟着请求的URI和协议的版本
![请求](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e8%af%b7%e6%b1%82.png)
- Get请求
Get请求例子，使用Fiddler抓取的request：
```html
GET /562f25980001b1b106000338.jpg HTTP/1.1
Host    img.mukewang.com
User-Agent    Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36
Accept    image/webp,image/*,*/*;q=0.8
Referer    http://www.imooc.com/
Accept-Encoding    gzip, deflate, sdch
Accept-Language    zh-CN,zh;q=0.8
<!--表示空行-->
<!--表示空行-->
```
1.**请求行**，用来说明请求类型,要访问的资源以及所使用的HTTP版本.
GET说明请求类型为GET,[/562f25980001b1b106000338.jpg]为要访问的资源，该行的最后一部分说明使用的是HTTP1.1版本。
2.**请求头部**，紧接着请求行（即第一行）之后的部分，用来说明服务器要使用的附加信息
从第二行起为请求头部，HOST将指出请求的目的地.User-Agent,服务器端和客户端脚本都能访问它,它是浏览器类型检测逻辑的重要基础.该信息由你的浏览器来定义,并且在每个请求中自动发送等等
3.**空行**，请求头部后面的空行是必须的
即使第四部分的请求数据为空，也必须有空行。
4.**请求数据**也叫主体，可以添加任意的其他数据。这个例子的请求数据为空。
![get请求](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_get.png)

- POST请求例子，使用Fiddler抓取的request：
```html
POST / HTTP1.1
Host:www.wrox.com
User-Agent:Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 2.0.50727; .NET CLR 3.0.04506.648; .NET CLR 3.5.21022)
Content-Type:application/x-www-form-urlencoded
Content-Length:40
Connection: Keep-Alive
<!--表示空行-->
name=Professional%20Ajax&publisher=Wiley
```
1.**请求行**，第1行说明了是post请求，以及http1.1版本
2.**请求头部**，第2行至第6行
3.**空行**，第7行的空行
4.**请求数据**，第8行

######HTTP响应
**HTTP响应也由四个部分组成，分别是：状态行、消息报头、空行和响应正文**。
![响应](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_%e5%93%8d%e5%ba%94.png)
    ```html
    HTTP/1.1 200 OK
    Date: Fri, 22 May 2009 06:07:21 GMT
    Content-Type: text/html; charset=UTF-8

    <html>
          <head></head>
          <body>
                <!--body goes here-->
          </body>
    </html>
    ```
1.**状态行**，（HTTP/1.1）表明HTTP版本为1.1版本，状态码为200，状态消息为（ok）
2.**第二行和第三行为消息报头**，Date:生成响应的日期和时间；Content-Type:指定了MIME类型的HTML(text/html),编码类型是UTF8
3.**空行**，消息报头后面的空行是必须的
4.**响应正文**，服务器返回给客户端的文本信息。空行后面的html部分为响应正文。
![response](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_respone.png)

######HTTP请求方法

HTTP1.0定义了三种请求方法： **GET**, **POST** 和 **HEAD**方法。
HTTP1.1新增了五种请求方法：**OPTIONS**, **PUT**, **DELETE**, **TRACE** 和 **CONNECT** 方法。

| 方法 | 作用 |
|--------|--------|
| **GET** |     请求指定的页面信息，并返回实体主体     |
|  HEAD   |    类似于get请求，只不过返回的响应中没有具体的内容，用于获取报头     |
| **POST**|     **向指定资源提交数据进行处理请求（例如提交表单或者上传文件）**。==数据被包含在请求体中==。++POST请求可能会导致新的资源的建立和/或已有资源的修改++     |
| **PUT** |     从客户端向服务器传送的数据取代指定的文档的内容|
| DELETE  |      请求服务器删除指定的页面     |
| CONNECT |    HTTP/1.1协议中预留给能够将连接改为管道方式的代理服务器|
| OPTIONS |     允许客户端查看服务器的性能     |
|  TRACE  |     回显服务器收到的请求，主要用于测试或诊断     |

######Get和Post区别
1. 完全介绍
GET请求
```html
GET /books/?sex=man&name=Professional HTTP/1.1
Host: www.wrox.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6)
Gecko/20050225 Firefox/1.0.1
Connection: Keep-Alive
<!--注意最后一行是空行-->
```
POST请求
```html
POST / HTTP/1.1
Host: www.wrox.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.6)
Gecko/20050225 Firefox/1.0.1
Content-Type: application/x-www-form-urlencoded
Content-Length: 40
Connection: Keep-Alive
<!--注意最后一行是空行-->
name=Professional%20Ajax&publisher=Wiley
<!--注意最后一行是空行-->
```

 1. 传输数据方式
**GET提交，请求的数据会附在URL之后（就是把数据放置在HTTP协议头中），以?分割URL和传输数据，多个参数用&连接**；例如：login.action?name=hyddd&password=idontknow&verify=%E4%BD%A0 %E5%A5%BD。如果数据是英文字母/数字，原样发送，如果是空格，转换为+，**如果是中文/其他字符，则直接把字符串用BASE64加密**，得出如： **%E4%BD%A0%E5%A5%BD，其中％XX中的XX为该符号以16进制表示的ASCII**。==POST提交：把提交的数据放置在是HTTP包的包体中==。**GET提交的数据会在地址栏中显示出来，而POST提交，地址栏不会改变**
 2. 传输数据的大小：
**HTTP协议没有对传输的数据大小进行限制，HTTP协议规范也没有对URL长度进行限制**。而在实际开发中存在的限制主要有：**GET:特定浏览器和服务器对URL长度有限制**，例如 IE对URL长度的限制是2083字节(2K+35)。对于其他浏览器，如Netscape、FireFox等，理论上没有长度限制，其限制取决于操作系统的支持。因此**GET提交时，传输数据就会受到URL长度的限制**。**POST:由于不是通过URL传值，理论上数据不受限**。++但实际各个WEB服务器会规定对post提交数据大小进行限制，Apache、IIS6都有各自的配置++。
 3. 安全性
**POST的安全性要比GET的安全性高**。++通过GET提交数据，用户名和密码将明文出现在URL上++，因为(1)登录页面有可能被浏览器缓存；(2)其他人查看浏览器的历史纪录，那么别人就可以拿到你的账号和密码了，除此之外，使用GET提交数据还可能会造成`Cross-site request forgery攻击
 4. Http get,post,soap协议都是在http上运行的
    - get：请求参数是作为一个key/value对的序列（查询字符串）附加到URL上的
查询字符串的长度受到web浏览器和web服务器的限制（如IE最多支持2048个字符），不适合传输大型数据集同时，它很不安全
    - post：请求参数是在http标题的一个不同部分（名为entity body）传输的，这一部分用来传输表单信息，因此必须将Content-type设置为:application/x-www-form- urlencoded。post设计用来支持web窗体上的用户字段，其参数也是作为key/value对传输。
但是：它不支持复杂数据类型，因为post没有定义传输数据结构的语义和规则。
    - soap：是http post的一个专用版本，遵循一种特殊的xml消息格式，Content-type设置为: text/xml 任何数据都可以xml化。Http协议定义了很多与服务器交互的方法，最基本的有4种，分别是GET,POST,PUT,DELETE. 一个URL地址用于描述一个网络上的资源，而HTTP中的GET, POST, PUT, DELETE就对应着对这个资源的查，改，增，删4个操作。我们最常见的就是GET和POST了。**GET一般用于获取/查询资源信息**，而**POST一般用于更新资源信息**

2. **简便介绍**
    1.**GET提交的数据会放在URL之后**，以?分割URL和传输数据，参数之间以&相连，如EditPosts.aspx?name=test1&id=123456. POST方法是把提交的数据放在HTTP包的Body中.
    2.**GET提交的数据大小有限制（因为浏览器对URL的长度有限制），而POST方法提交的数据没有限制**.
    3.GET方式需要使用**Request.QueryString**来取得变量的值，而POST方式通过**Request.Form**来获取变量的值。
    4.**GET方式提交数据，会带来安全问题，比如一个登录页面，通过GET方式提交数据时，用户名和密码将出现在URL上，如果页面可以被缓存或者其他人可以访问这台机器，就可以从历史记录获得该用户的账号和密码**

######HTTP状态码
1. 常见状态码
当浏览者访问一个网页时，浏览者的浏览器会向网页所在服务器发出请求。当浏览器接收并显示网页前，**此网页所在的服务器会返回一个包含HTTP状态码的信息头（server header）用以响应浏览器的请求**。下面是常见的HTTP状态码:**
**200** - 请求**成功**
**301** - 资源（网页等）被永久**转移**到其它URL
**404** - 请求的资源（网页等）**不存在**
**500** - 内部**服务器错误**
| 状态码 | 含义 |
|--------|--------|
|200|	OK //客户端请求成功|
|400|	Bad Request //客户端请求有语法错误，不能被服务器所理解|
|401|	Unauthorized //请求未经授权，这个状态代码必须和WWW-Authenticate报头域一起使用|
|403|	Forbidden //服务器收到请求，但是拒绝提供服务|
|404|	Not Found //请求资源不存在，eg：输入了错误的URL|
|500|	Internal Server Error //服务器发生不可预期的错误|
|503|	Server Unavailable //服务器当前不能处理客户端的请求，一段时间后可能恢复正常|

2. 状态码分类
| 分类 | 分类描述 |
|--------|--------|
|  1\*\*    |  **信息**，服务器收到请求，需要请求者继续执行操作      |
|  2\*\*    |  **成功**，操作被成功接收并处理      |
|  3\*\*    |  **重定向**，需要进一步的操作以完成请求      |
|  4\*\*    |  **客户端错误**，请求包含语法错误或无法完成请求      |
|  5\*\*    |  **服务器错误**，服务器在处理请求的过程中发生了错误      |

3. 状态码列表
| 状态码 | 状态码英文名称 | 描述 |
|--------|--------|--------|
|100     |	Continue  |	 继续。客户端应继续其请求  |
|101     |	Switching Protocols  |	切换协议。服务器根据客户端的请求切换协议。只能切换到更高级的协议，例如，切换到HTTP的新版本协议  |
|**200** |	OK	|  **请求成功**。一般用于GET与POST请求  |
|201     |	Created	 |  已创建。成功请求并创建了新的资源  |
|202	 |  Accepted  |	  已接受。已经接受请求，但未处理完成  |
|203	 |  Non-Authoritative Information  |  非授权信息。请求成功。但返回的meta信息不在原始的服务器，而是一个副本  |
|204	 |  No Content  |  无内容。服务器成功处理，但未返回内容。在未更新网页的情况下，可确保浏览器继续显示当前文档  |
|205	 |  Reset Content  |  重置内容。服务器处理成功，用户终端（例如：浏览器）应重置文档视图。可通过此返回码清除浏览器的表单域  |
|206	 |  Partial Content  |  部分内容。服务器成功处理了部分GET请求  |
|300	 |  Multiple Choices  |  多种选择。请求的资源可包括多个位置，相应可返回一个资源特征与地址的列表用于用户终端（例如：浏览器）选择  |
|**301** | 	Moved Permanently  |  **永久移动**。请求的资源已被永久的移动到新URI，返回信息会包括新的URI，浏览器会自动定向到新URI。今后任何新的请求都应使用新的URI代替  |
|302	 |  Found  |	临时移动。与301类似。但资源只是临时被移动。客户端应继续使用原有URI  |
|303	 |  See Other  |  查看其它地址。与301类似。使用GET和POST请求查看  |
|304	 |  Not Modified  |	 未修改。所请求的资源未修改，服务器返回此状态码时，不会返回任何资源。客户端通常会缓存访问过的资源，通过提供一个头信息指出客户端希望只返回在指定日期之后修改的资源  |
|305	 |  Use Proxy  |  使用代理。所请求的资源必须通过代理访问  |
|306	 |  Unused  |  已经被废弃的HTTP状态码  |
|307	 |  Temporary Redirect  |  临时重定向。与302类似。使用GET请求重定向  |
|**400** |	Bad Request	 |  客户端请求的语法错误，服务器无法理解  |
|401	 |  Unauthorized  |	 请求要求用户的身份认证  |
|402	 |  Payment Required  |  保留，将来使用  |
|**403** |  Forbidden  |  服务器理解请求客户端的请求，但是拒绝执行此请求  |
|**404** |	Not Found  |  ** 服务器无法根据客户端的请求找到资源（网页）** 。通过此代码，网站设计人员可设置"您所请求的资源无法找到"的个性页面  |
|405     |	Method Not Allowed  |  客户端请求中的方法被禁止  |
|406	 |  Not Acceptable  |  服务器无法根据客户端请求的内容特性完成请求  |
|407	 |  Proxy Authentication Required  |  请求要求代理的身份认证，与401类似，但请求者应当使用代理进行授权  |
|408	 |  Request Time-out  |	 服务器等待客户端发送的请求时间过长，超时  |
|409	 |  Conflict  |	服务器完成客户端的PUT请求是可能返回此代码，服务器处理请求时发生了冲突  |
|410	 |  Gone  |	客户端请求的资源已经不存在。410不同于404，如果资源以前有现在被永久删除了可使用410代码，网站设计人员可通过301代码指定资源的新位置  |
|411	 |  Length Required  |	服务器无法处理客户端发送的不带Content-Length的请求信息  |
|412	 |  Precondition Failed  |	客户端请求信息的先决条件错误  |
|413	 |  Request Entity Too Large  |  由于请求的实体过大，服务器无法处理，因此拒绝请求。为防止客户端的连续请求，服务器可能会关闭连接。如果只是服务器暂时无法处理，则会包含一个Retry-After的响应信息  |
|414	 |  Request-URI Too Large  |  请求的URI过长（URI通常为网址），服务器无法处理  |
|415	 |  Unsupported Media Type  |  服务器无法处理请求附带的媒体格式  |
|416	 |  Requested range not satisfiable  |	客户端请求的范围无效  |
|417	 |  Expectation Failed  |	服务器无法满足Expect的请求头信息  |
|**500** |	Internal Server Error  |	** 服务器内部错误** ，无法完成请求  |
|501	 |  Not Implemented	 |  服务器不支持请求的功能，无法完成请求  |
|**502** |  Bad Gateway  |	充当网关或代理的服务器，从远端服务器接收到了一个无效的请求  |
|**503** |  Service Unavailable  |	由于超载或系统维护，服务器暂时的无法处理客户端的请求。延时的长度可包含在服务器的Retry-After头信息中  |
|**504** | 	Gateway Time-out  |  充当网关或代理的服务器，未及时从远端服务器获取请求  |
|505	 |  HTTP Version not supported  |  服务器不支持请求的HTTP协议的版本，无法完成处理  |

#####一次完整的浏览器请求流程
整个过程如下:
1.**域名解析**：解析域名对应的IP地址
1. 浏览器**搜索浏览器自身的DNS缓存**，如找不到，进行第2步
2. 向**本地配置的首选DNS服务器**发起域名解析请求，如找不到，进行第3步
3. **找到根DNS地址**，**发起请求（请问www.jianshu.com这个域名的IP地址是多少啊？）**，根域发现这是一个顶级域com域的一个域名，于是就告诉运营商的DNS我不知道这个域名的IP地址，但是我知道com域的IP地址，进行第4步
4. **com域服务器**告诉运营商的DNS我不知道www.jianshu.com这个域名的IP地址，但是我知道jianshu.com这个域的DNS地址，进行第5步
5. 运营商的DNS又向www.jianshu.com这个域名的DNS地址（这个一般就是由**域名注册商**提供的，像万网，新网等）发起请求，这个时候运营商的DNS服务器就拿到了www.jianshu.com这个域名对应的IP地址，并返回给Windows系统内核，内核又把结果返回给浏览器，终于浏览器拿到了www.jianshu.com对应的IP地址
![域名解析](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_DNS%e8%af%b7%e6%b1%822.jpg)

2.发起TCP的**3次握手**，建立连接（关闭连接时用4次挥手）
3.建立TCP连接后**发起http请求**
4.服务器**响应http请求**，浏览器得到html代码
5.浏览器**解析html代码**，并请求html代码中的资源（如js、css、图片等）
6.浏览器对页面进行**渲染**呈现给用户
***IP--->MAC***:ARP(地址解析协议)
***MAC--->IP***:RARP(反向地址解析协议)
ref:
1.[HTTP 协议入门](http://www.ruanyifeng.com/blog/2016/08/http.html), 2.[关于HTTP协议，一篇就够了](http://www.cnblogs.com/ranyonsue/p/5984001.html), 3.[详解URL的组成](http://blog.csdn.net/ergouge/article/details/8185219), 4.[HTTP状态码](http://www.runoob.com/http/http-status-codes.html), 5.[HTTP协议详解](http://www.cnblogs.com/TankXiao/archive/2012/02/13/2342672.html), 6.[关于HTTP协议，一篇就够了](http://www.jianshu.com/p/80e25cb1d81a), 7.[深入理解HTTP协议（转）](http://www.blogjava.net/zjusuyong/articles/304788.html), 8.[Journey to HTTP/2](http://kamranahmed.info/blog/2016/08/13/http-in-depth/), 9.[HTTP协议详解](http://blog.csdn.net/sayhello_world/article/details/75018519), 10.[网络请求过程扫盲](http://www.jianshu.com/p/8a40f99da882), 11.[一次完整的浏览器请求流程](http://www.jianshu.com/p/fbe0e9fa45a6), 12.[通信协议——Http、TCP、UDP](http://www.cnblogs.com/xhwy/archive/2012/03/03/2378293.html)