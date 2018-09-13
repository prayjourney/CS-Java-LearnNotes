### 前端UI框架和前端JS框架

***

##### 前端UI框架

**Bootstrap**

首先说 Bootstrap，估计你也猜到会先说或者一定会有这个( 呵呵了 )，这是说明它的强大之处，拥有框架一壁江山的势气。自己刚入道的时候本着代码任何一个字母都得自己敲出来挡我者废的决心，来让自己成长。结果受到周围各 种基友的引诱开始了 Bootstrap 旅程。本人虽然是个设计+前端的万里有一的人才，但是老天只让我会用 PS 和各种设计工具却不给我跟设计妹子一样的审美，所以这也是我最初选择 Bootstrap 的原因之一，它让我做出来的东西好歹能在妹子面前装个逼，不过时间长了难免觉得 Bootstrap 美的让人烦躁， 但好在它的每个版本都会有很大的改变，不会让人觉得自己做的网站会跟很多网站撞脸。Bootstrap 的用法及其简单( 这也可能就是 Bootstrap 作者阅攻城士无数，了解他们痛的结果 )，以至于是个小前端都可以快速上手，几乎没什么学习成本。

官网：<http://getbootstrap.com/>

Github：<https://github.com/twbs/bootstrap/>

作者：Mark Otto 和Jacob Thornton Star：93,112

总结：Bootstrap 最大的优势就是它非常流行，流行就代表你有问题就有很多人帮你解决问题，就代表装逼它就是利器，还有就是界面比较和谐，容易上手，关注它的童鞋应该发现最 新 V4 版也开始支持 FlexBox 布局，这是非常好的升级体验。 劣势是 class 命名不够语义化，并且各种缩写，以至于我离了文档就是个菜，最近开始整混合 APP，选框架的时候首选就是它，但之前搞 PC 一直没注意，后来搞混合右键属性看它的时候，瞬间一阵凉风袭来，Bootstrap 好小，小到我只好选择别的框架。

AUI

第三个是最近刚起来的AUI，虽然作者声称是专为APICloud开发者设计的一套UI框架，但实际它还是解决了很多移动前端开发的普遍问题，是主 要面向混合开发的 CSS 框架。看起来作者比较猖狂，各种高级 CSS3 遍地使用，这让我也不得不去查查这些个 CSS3 的兼容性。不负众望果然选的都是兼容不错的属性，哈哈了一顿激动从前辈手上大胆认识了几个好东西，并且框架还提供了聊天界面、计数列表等组件，解决了很多 复杂的让我骂娘的布局，现在可以直接拿走就用。

Github：<https://github.com/liulangnan/aui>

官网：<http://www.auicss.com/>

作者：流浪男 Star：92

总结：这个框架对我来说有个优点就是纯 CSS 框架，自己以前也就用过 Pure，自己有点 JS 能力，如果不是复杂的效果，找个纯 CSS 框架自己随便改改就可以，而现在 CSS3 也已经能够做到动画，效率、质量、高效全兼顾，所以还是选择了这种 CSS 框架。有一点觉得不满的是这框架的文档真的好那什么，说好的高大上呢。

**Amaze UI**

第二个介绍的是妹子UI，最初使用它是因为本尊遇到了一个爱纠结细节设计士，有一次她跟我的字体较上真了，结果一句顶万句的 BOOS 夸了她，我只好根据她的想法去解决，结果最后找到了Amaze UI 框架( 我不介意你叫我懒淫 )，按照官方的话说就是 "基于社区开源项目构建的一个跨屏前端框架，以移动优先，从小屏到大屏，最终实现所有屏幕适配，适应移动互联潮流" 。但其实我就是看中它能解决国内浏览器存在的跨屏适配和兼容性问题。

官网：<http://amazeui.org/>

Github：<https://github.com/amazeui/amazeui>

所属公司：云适配 Star：6710

总结：Amaze UI 总的来说就是加入更多符合中国市场特性的元素，框架对跨屏、适配都做了的比较好的处理并且准备一了一系列的常用的网页组 件，为减少搞兼容、适配各种敲键盘的加班狗们的工作时间做了不小的贡献。，框架还对中文排版优化，兼容中国本土主流浏览器、轻量化，不仅适用于桌面端，还 更更适合移动端、包含一些封装好的Widgets。不过自也就我感觉 Amaze UI 文档是否有点太那什么了，比如 “人们不会在乎jQuery的那 点流量。”，说实的在这真没啥，不过我从来不会说出来( 哈哈 )，代码和设计上感觉没太多突出的点。

Frozen UI

有段时间看到 QQ 瞬间高大上了，后来四处打听，原来 QQ 客服端也用了 混合开发，其中QQ会员前端用的是 Frozen UI，并且这套框架开源，欣喜若狂耐不住心里的寂寞直接上手试了一遍，初体验感觉基础样式效果简单色调清爽，有个比较活跃的社区所以组件什么的也比较丰 富。

Github：<https://github.com/frozenui/frozenui>

官网：<http://frozenui.github.io/>

作者： QQVIP FD Team Star：1,067

总结：如果拿 Frozen UI 配合一些如 APICloud 用来做混合 APP 感觉就太酷了，或者原生的火鸡们拿去嵌套在应用中做前端开发，这个框架对 android 2.3 +、ios 4.0 + 做了兼容，或者拿来做 Web App 也是极好的选择，劣势的话从 UI 层面就可以看到了，谁让它是出生在QQ会员前端的呢。

WeUIi

第四个是WeUI和同 FrozenUI都属于 差不多的 WeUi了，也是一个比较专一的框架，WeUI应该说比FrozenUI前者更专一，话 说连个官网都不搞，所有答疑都在 gitHub Issues 解决了，这个框架极其简单，体积当然就不用说了，模块也就 7 个左右，不过体量虽然小做 的却不错，口碑看 star 就够了，框架从 16/1/23 发版至今 github star 超过 7K,不过也不排除用户没地方发泄所以都跑 到 git 上来，哈哈。

Github：<https://github.com/weui/weui>

DEMO：<http://weui.github.io/weui/>

Star：7,129

总结：看完微信设计团队设计的这套 DEMO，二话不说如果要做微信公众，这个二话不说必然是首选了。框架不好的地方简而言之就是框架本身应该就没考虑过让用户用到非微信的场景之下。

SUI

“SUI 是一套基于bootstrap开发的前端组件库，同时它她也是一套设计规范。通过SUI，可以非常方便的设计和实现精美的页面”。 果然 还是直接引用官方给的枯燥无味广告要节省自己的脑细胞( 囧… )，当然了就像广告说的，如果你之前用过 Bootstrap， 那么可以轻松转 向 SUI，这可能就是淘宝给前端屌丝们的福利了。。 

Github：<https://github.com/sdc-alibaba/sui>

官网：<http://sui.taobao.org/sui/docs/index.html>

Star：120

AUI

第六个是最近刚起来的最近刚起来的 AUI，虽然作者声称是专为APICloud开发者设计的一套UI框架，但实际它还是解决了很多移动前端开发的 普遍问题，是它主要面向混合开发的 CSS 框架。，所以看起来作者比较猖狂，各种高级 CSS3 遍地使用，这也使得我不得不去查查这些 个 CSS3 的兼容性。不负众望果然选的都是兼容不错的属性，哈哈了一顿激动从前辈手上大胆认识了几个好东西，并且框架还提供了聊天界面、计数列表等组 件，解决了很多复杂的让我骂娘的布局，现在可以直接拿走就用。

Github：<https://github.com/liulangnan/aui>

官网：<http://www.auicss.com/>

作者：流浪男 Star：92

总结：这个框架对我来说有个优点就是纯 CSS 框架，自己以前也就用过 Pure，自己有点 js 能力，如果不是复杂的效果自己找个 纯 CSS 框架自己随便改改就能达到效果，而现在 CSS3 也已经能够做到各种动画，效率、质量、高效各种一顿考虑所以还是选择了这种 CSS 框 架。而一直觉得不满的是这框架的文档真的好那什么，说好的高大上呢。

MUI

曾经一直使用 Android 系统的我，后来见到 IOS，果断移情别恋了，不知道为什么苹果每次调整系统我都特别喜欢，后来一段时间因为缺设计 我专门模仿 IOS 系统做 UI，但始终不能够做到很好，无意间就发现了 MUI 这个框架，这个框架给我的吸引之处就是它的 UI 是以 IOS 为 主体设计的，当然它也补充了android特有UI样式。并且MUI官方声称用来开发深入以后发现拿它做 APP 还能够提高用户使用流畅度，然后便试着 更深入的了解和使用一段时间。

官网：<http://dev.dcloud.net.cn/mui/>

Github：<https://github.com/dcloudio/mui>

Star：2,450

总结：就像之前说的这个框架是以两大系统为参照来封装UI组件，框架自身还有一个较为活跃的社区，不太好的地方这也是我特别关注的一点，关于开发应 用的流畅度，我当然知道这是 H5 目前的劣势，但是看到官网给的描述，还是抱着期待的心理试试看能否提升，然而它其实还是需要是借助 Webview来 提升，而不是框架本身。

Semantic UI

倒数第三个是 Semantic UI，接触这个框架还是因为 Bootstrap，Semantic UI 刚上线 github 就受到大量开发者的关注，以至于很多人拿它俩对比各种挑刺各种夸，是好是坏不能单凭别人三句四句就抬起手指开始赞，用了以后感觉 UI 上跟 Bootstrap 没太多的区别，不过代码命名规范上却相差甚大，本人认为 Semantic UI 是不是就想做的不一样，它的命名全是采用复合的方式，类名特别的离散，用的时候你得很小心自己扩展或者新增的 class 命名与它的类名冲突。

官网：<http://www.semantic-ui.cn/>

Github：<https://github.com/semantic-org/semantic-ui/>

Foundation

Foundation 算是框架界的元老啦，都说框架去的早，而这个框架一直到现在依然这么的热门，如果你比较介意 Bootstrap 开发撞脸的尴尬事情，那么你可以考虑使用 Foundation 。即使你使用预定义的 UI 元素, 也不会与其他网站太像，就像官方说的给开发者更灵活的框架体验。

官网：<http://foundation.zurb.com/>

Github：<https://github.com/zurb/foundation-sites>

Star：22,736

UiKit

UIkit是YOOtheme团队开发的，在许多WordPress主题中都有应用(也就是如果你是个 WordPress 爱好者，那么这个框架应该比较适合深究)，并且框架能够通过GUI编辑器和手动编辑，所以它提供了一个灵活、强大的自定义机制。框架借助LESS、 jQuery、normalize.css及FontAwesome开源项目的独有特点，整合成了这么一款轻量级、模块化的前端框架。
官网：<http://www.getuikit.com/>
Github：<https://github.com/uikit/uikit>
作者：YOOtheme Star：6,372

**Pure**

终于最后一个了，我和你一样好开森 (～￣▽￣)～)，这个框架是我在做管理系统时接触的，选择使用也是因为框架小巧，并且是纯 CSS，没有太多的牵扯，好用来与其他框架快速结合使用。

官网：<http://purecss.io/>

Github：<https://github.com/yahoo/pure/>

Star：13,592



##### 前端JS框架

Zepto.js

- 地址：http://www.css88.com/doc/zeptojs/
- 描述：Zepto是一个轻量级的针对现代高级浏览器的JavaScript库， 它与jquery有着类似的api。 如果你会用jquery，那么你也会用zepto。关于Zepto认知我也是通过与一位腾讯朋友聊天的时候知道的，只作了些基础的了解。

SUI Mobile

- 地址：http://m.sui.taobao.org
- 描述：SUI Mobile 是一套基于 [Framework7](http://framework7.taobao.org/) 开发的UI库。它非常轻量、精美，只需要引入我们的CDN文件就可以使用，并且能兼容到 iOS 6.0+ 和 Android 4.0+，非常适合开发跨平台Web App。
- 用途：你也看到了，他是用于无线端的Web App的开发。

**Node.Js**

- 地址：http://www.runoob.com/nodejs/nodejs-tutorial.html (中文网)
- 描述：Node.js 是一个Javascript运行环境(runtime)。实际上它是对Google V8引擎进行了封装。V8引 擎执行Javascript的速度非常快，性能非常好。Node.js对一些特殊用例进行了优化，提供了替代的API，使得V8在非浏览器环境下运行得更 好。

　　Node.js是一个基于Chrome JavaScript运行时建立的平台， 用于方便地搭建响应速度快、易于扩展的网络应用。Node.js 使用[事件驱动](http://baike.baidu.com/view/536048.htm)， 非阻塞[I/O](http://baike.baidu.com/subview/300881/11169495.htm) 模型而得以轻量和高效，非常适合在分布式设备上运行数据密集型的实时应用。

　　简单的说 Node.js 就是运行在服务端的 JavaScript。

　　Node.js 是一个基于Chrome JavaScript 运行时建立的一个平台。

　　Node.js是一个事件驱动I/O服务端JavaScript环境，基于Google的V8引擎，V8引擎执行Javascript的速度非常快，性能非常好。

- 用途：

1. RESTful API
这是NodeJS最理想的应用场景，可以处理数万条连接，本身没有太多的逻辑，只需要请求API，组织数据进行返回即可。它本质上只是从某个数据库中 查找一些值并将它们组成一个响应。由于响应是少量文本，入站请求也是少量的文本，因此流量不高，一台机器甚至也可以处理最繁忙的公司的API需求。

2. 统一Web应用的UI层
目前MVC的架构，在某种意义上来说，Web开发有两个UI层，一个是在浏览器里面我们最终看到的，另一个在server端，负责生成和拼接页面。

不讨论这种架构是好是坏，但是有另外一种实践，面向服务的架构，更好的做前后端的依赖分离。如果所有的关键业务逻辑都封装成REST调用，就意味着在上层 只需要考虑如何用这些REST接口构建具体的应用。那些后端程序员们根本不操心具体数据是如何从一个页面传递到另一个页面的，他们也不用管用户数据更新是 通过Ajax异步获取的还是通过刷新页面。

3. 大量Ajax请求的应用
例如个性化应用，每个用户看到的页面都不一样，缓存失效，需要在页面加载的时候发起Ajax请求，NodeJS能响应大量的并发请求。　　总而言之，NodeJS适合运用在高并发、I/O密集、少量业务逻辑的场景。

angular.Js

- 地址：http://www.runoob.com/angularjs/angularjs-tutorial.html (中文网)
- 描述：AngularJS[1]  诞生于2009年，由Misko Hevery 等人创建，后为Google所收购。是一款优秀的前端JS框架，已经被用于Google的多款产品当中。AngularJS有着诸多特性，最为核心的是：MVVM、模块化、自动化双向数据绑定、语义化标签、依赖注入等等。
- 用途：通过描述我们应该就能很好的明白AngularJS的真实用途了，MVVM，模块化，自动化双向数据绑定等等。除了简单的dom操作外，更能体现Js编程的强大。当然应用应该视场合而定。

JQuery Mobile

- 地址：http://www.w3school.com.cn/jquerymobile/    (中文网)
- 描述：Query Mobile是[jQuery](http://baike.baidu.com/view/1020297.htm) 在 手机上和平板设备上的版本。jQuery Mobile 不仅会给主流移动平台带来jQuery核心库，而且会发布一个完整统一的jQuery移动UI框架。支持全球主流的移动平台。jQuery Mobile开发团队说：能开发这个项目，我们非常兴奋。移动Web太需要一个跨浏览器的框架，让开发人员开发出真正的移动Web网站。
- 用途：jQuery Mobile 是创建移动 web 应用程序的框架。
jQuery Mobile 适用于所有流行的智能手机和平板电脑。
jQuery Mobile 使用 HTML5 和 CSS3 通过尽可能少的脚本对页面进行布局。

requirejs

- 地址：http://www.requirejs.cn/
- 描述：RequireJS的目标是鼓励代码的模块化，它使用了不同于传统<script>标签的脚本加载步骤。可以用它来加速、优化代码，但其主要目的还是为了代码的模块化。它鼓励在使用脚本时以module ID替代URL地址。

RequireJS以一个相对于[baseUrl](http://makingmobile.org/docs/tools/requirejs-api-zh/#config-baseUrl)的地址来加载所有的代码。 页面顶层<script>标签含有一个特殊的属性data-main，require.js使用它来启动脚本加载过程，而baseUrl一般设置到与该属性相一致的目录。

- 用途：模块化动态加载。

**Vue.js**

- 地址：http://cn.vuejs.org/
- 描述：Vue.js 是用于构建交互式的 Web  界面的库。它提供了 [MVVM](http://www.yyyweb.com/) 数据绑定和一个可组合的组件系统，具有简单、灵活的 API。从技术上讲， Vue.js 集中在 [MVVM](http://www.yyyweb.com/) 模式上的视图模型层，并通过双向数据绑定连接视图和模型。实际的 DOM 操作和输出格式被抽象出来成指令和过滤器。相比其它的 MVVM 框架，Vue.js 更容易上手。

backbone.js

- 地址：http://www.css88.com/doc/backbone/
- 描述：[Backbone](http://baike.baidu.com/view/342697.htm) 为复杂Javascript应用程序提供模型(models)、集合(collections)、视图(views)的结构。其中模型用于绑定键值数据和自定义事件；集合附有可枚举函数的丰富API； 视图可以声明事件处理函数，并通过RESTful JSON接口连接到应用程序。

**React**

- 地址：http://reactjs.cn/react/docs/why-react.html
- 描述：React 是一个 Facebook 和 Instagram 用来创建用户界面的 JavaScript 库。很多人认为 React 是 [MVC](http://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller) 中的 V（视图）。我们创造 React 是为了解决一个问题：构建随着时间数据不断变化的大规模应用程序。为了达到这个目标，React 采用下面两个主要的思想。

Ionic

- 地址：http://www.ionic.wang/js_doc-index.html
- 描述：Ionic既是一个CSS框架也是一个Javascript UI库。许多组件需要Javascript才能产生神奇的效果，尽管通常组件不需要编码，通过框架扩展可以很容易地使用，比如我们的Angular Ionic扩展。

  Ionic遵循 视图控制模式，通俗的理解和 Cocoa 触摸框架相似。在视图控制模式中，我们将界面的不同部分分为子视图或包含其他视图的子视图控制器。然后视图控制器“驱动”内部视图来提供交互和UI功能。 一个很好的例子就是标签栏（Tab Bar）视图控制器处理点击标签栏在一系列可视化面板间切换。
  浏览我们的API文档来了解视图控制器和Ionic中可用的Javascript实用工具。

  Ionic 是目前最有潜力的一款 HTML5 手机应用开发框架。通过 SASS 构建应用程序，它 提供了很多 UI 组件来帮助开发者开发强大的应用。 它使用 JavaScript MVVM 框架和 AngularJS 来增强应用。提供数据的双向绑定，使用它成为 Web 和移动开发者的共同选择。



##### 可视化组件

**Echarts**

- 地址：http://echarts.baidu.com/
- 描述：ECharts，一个纯 Javascript 的图表库，可以流畅的运行在 PC 和移动设备上，兼容当前绝大部分浏览器（IE8/9/10/11，Chrome，Firefox，Safari等），底层依赖轻量级的 Canvas 类库[ZRender](https://github.com/ecomfe/zrender)，提供直观，生动，可交互，可高度个性化定制的数据可视化图表。

**tableau(收费)**

- 地址：http://www.yuandingit.com/special/tableau/index.html
- 描述：Tableau 是桌面系统中最简单的商业智能工具软件，Tableau 没有强迫用户编写自定义代码，新的控制台也可完全自定义配置。在控制台上，不仅能够监测信息，而且还提供完整的分析能力。Tableau控制台灵活，具有高度的动态性。

 

##### 前端构建工具

**gulp**

- 地址：http://www.gulpjs.com.cn/
- 描述：
  - 易于使用:  通过代码优于配置的策略，Gulp 让简单的任务简单，复杂的任务可管理。
  - 构建快速:  利用 Node.js 流的威力，你可以快速构建项目并减少频繁的 IO 操作。
  - 插件高质:  Gulp 严格的插件指南确保插件如你期望的那样简洁高质得工作。
  - 易于学习:  通过最少的 API，掌握 Gulp 毫不费力，构建工作尽在掌握：如同一系列流管道。

 

##### 博客搭建 

**技术组合**

HEXO+Github,搭建属于自己的博客。
站点：http://www.jianshu.com/p/465830080ea9
HEXO介绍：Hexo是一个开源的静态博客生成器,用node.js开发,作者是台湾大学生tommy351
准备：git  + node.js + markdown编辑 + gitcafe + 域名



**UI框架是为了展示样式, 而JS框架主要是为了数据的绑定, 动画效果以及交互**.

ref:

1.[前端Js框架汇总](http://www.cnblogs.com/mbailing/articles/Js.html),   2.[10大html5前端框架](http://www.cnblogs.com/huangyin1213/p/5750113.html) 

