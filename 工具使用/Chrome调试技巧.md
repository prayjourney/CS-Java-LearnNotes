### Chrome调试技巧

***

#### 常用快捷键
- command + option + j(mac): 调出调试工具, F12(win)
- { }: 在Source页面格式化JS或者HTML代码
- 🚫图标: 清空Console的内容



#### 先来认识一下这些按钮
![chromebutton](../images/chromebutton.png)
先来看这张图最上头的一行是一个功能菜单，每一个菜单都有它相应的功能和使用方法，依次从左往右来看
**1.箭头按钮**
用于在页面选择一个元素来审查和查看它的相关信息，当我们在**Elements**这个按钮页面下点击某个Dom元素时，箭头按钮会变成选择状态


**2.设备图标**
点击它可以切换到不同的终端进行开发模式，移动端和pc端的一个切换，可以选择不同的移动终端设备，同时可以选择不同的尺寸比例，chrome浏览器的模拟移动设备和真实的设备相差不大，是非常好的选择可选择的适配
![chromedevice](../images/chromedevice.png)


**3.Elements** 功能标签页：用来查看，修改页面上的元素，包括DOM标签，以及css样式的查看，修改，还有相关盒模型的图形信息，下图我们可以看到当我鼠标选择id 为lg_tar的div元素时，右侧的css样式对应的会展示出此id 的样式信息，此时可以在右侧进行一个修改，修改即可在页面上生效， 灰色的element.style样式同样可以进行添加和书写，唯一的区别是，在这里添加的样式是添加到了该元素内部，实现方式即：该div元素的style属性，这个页面的功能很强大，在我们做了相关的页面后，修改样式是一块很重要的工作，细微的差距都需要调整，但是不可能说做到每修改一点即编译一遍代码，再刷新浏览器查看效果，这样很低效，一次性在浏览器中修改之后，再到代码中进行修改
![chromeelement](../images/chromeelement.png)

- 对应的样式
![chromecssstyle](../images/chromecssstyle.png)

- 盒模型信息
同时，当我们浏览网站看到某些特别炫酷的效果和难做的样式时候，打开这个功能，我们即可看到别人是如何实现的，学会它这知识就是你的了，仔细钻研也会有意想不到的收获


**4.Console控制台**
用于打印和输出相关的命令信息，其实console控制台除了我们熟知的报错，打印console.log信息外，还有很多相关的功能，下面简单介绍几个：
1. 一些对页面数据的指令操作，比如打断点正好执行到获取的数据上，由于数据都是层层嵌套的对象，这个时候查看里面的key/value不是很方便，即可用这个指令开查看，obj的json string 格式的key/value，我们对于数据里面有哪些chrome字段和属性即可一目了然
![chromeconsole](../images/chromeconsole.png)

2. 除了console.log还有其他相关的指令可用chromconsole也有相关的API
![chromeconsoleother](../images/chromeconsoleother.png)


**5.Sources** 资源页面(html+css+js)
这个页面内我们可以找到当然浏览器页面中的js 源文件，方便我们查看和调试，在我还没有走出校园时候，我经常看一些大站的js代码，那时候其实基本都看不懂，但是最起码可以看看人家的代码风格，人家的命名方式，所有的代码都是压缩之后的代码，我们可以点击下面的{}大括号按钮将代码转成可读格式,，Sources Panel 的左侧分别是 Sources 和 Content scripts和Snippets

- 对应的源代码
![chromesource](../images/chromesource.png)

- 格式化后的代码
![chromesourceformate](../images/chromesourceformate.png)

关于打断点调试的内容，下面介绍，先来说一些，其他平时基本没人用但是很有用的小点，比如当我们想不起某个方法的具体使用时候，会打开控制台随意写一些测试代码，或者想测试一下刚刚写的方法是否会出现期待的样子，但是控制台一打回车本想换行但是却执行刚写的半截代码，所以推荐使用**Sources**下面的左侧的Sinppets代码片段按钮，这时候点击创建一个新的片段文件，写完测试代码后把鼠标放在新建文件上run，再结合控制台查看相关信息（**新建了一个名叫：app.js的片段代码，在你的项目环境页面内，该片段可执行项目内的方法**）
![chromewritejs](../images/chromewritejs.png)

- 自己书写的片段
Content scripts 是 Chrome 的一种扩展程序，它是按照扩展的ID来组织的，这些文件也是嵌入在页面中的资源，这类文件可以读写和操作我们的资源，需要调试这些扩展文件，则可以在这个目录下打开相关文件调试，但是几乎我们的项目还没有相关的扩展文件，所以啥也看不到，平时也不需要关心这块ccc 
![chromeselfjs](../images/chromeselfjs.png)


**6.Network** 网络请求标签页(**与前端交互调试，发送请求和接收数据的重点**)
可以看到所有的资源请求，包括网络请求，图片资源，html，css，js文件等请求，可以根据需求筛选请求项，一般多用于网络请求的查看和分析，分析后端接口是否正确传输，获取的数据是否准确，请求头，请求参数的查看

- 所有的资源
以上我选择了All，就会把该页面所有资源文件请求下来，如果只选择XHR 异步请求资源，则我们可以分析相关的请求信息
![chromeallrequestinfo](../images/chromeallrequestinfo.png)

- 请求的相关信息
打开一个Ajax异步请求，可以看到它的请求头信息，是一个POST请求，参数有哪些，还可以预览它的返回的结果数据，这些数据的使用和查看有利于我们很好的和后端工程师们联调数据，也方便我们前端更直观的分析数据
![chromexhr](../images/chromexhr.png)

- 预览请求的数
![chromepreview](../images/chromepreview.png)


**7.Timeline**标签
可以显示JS执行时间、页面元素渲染时间，不做过多介绍


**8.Profiles**标签
可以**查看**CPU执行时间与内存占用，不做过多介绍


**9.Resources**标签
会列出所有的资源，以及HTML5的Database和LocalStore等，你可以对存储的内容编辑和删除 不做过多介绍


**10.Security**标签
可以告诉你这个网站的安全性，查看有效的证书等


**11.Audits**标签
可以帮你分析页面性能，有助于优化前端页面，分析后得到的报告
![chromeaudits](../images/chromeaudits.png)



#### Sources资源页面的断点调试
**1.如何调试**：
调试js代码，肯定是我们常用的功能，那么如何打断点，找到要调试的文件，然后在内容源代码左侧的代码标记行处点击即可打上一个断点
![chromedebugjs](../images/chromedebugjs.png)


**2.断点与 js代码修改**
看下面这张图，我在一个名为toggleTab的方法下打了两个断点，当开始执行我们的点击切换tab行为后，代码会在执行的断点出停下来，并把相关的数据展示一部分，此时可以在已经执行过得代码处，把鼠标放上去，即可查看相关的具体数据信息，同时我们可以使用右侧的功能键进行调试，右侧最上面一排分别是：暂停/继续、单步执行(**F10快捷键**)、单步跳入此执行块(**F11快捷键**)、单步跳出此执行块、禁用/启用所有断点。下面是各种具体的功能区
![chromedebug2](../images/chromedebug2.png)

- 在代码中打断点，临时修改
在当前的代码执行区域，在调试中如果发现需要修改的地方，也是可以立即修改的，修改后保存即可生效，这样就免去了再到代码中去书写，再刷新回看了
![chromedebugtemp](../images/chromedebugtemp.png)


**3.快速进入调试的方法**
当我们的代码执行到某个程序块方法处，这个方法上可能你并没有设置相关的断点，此时你可以F11进入此程序块，但是往往我们的项目都是经过很多源代码封装好的方法，有时候进入后，会走很多底层的封装方法，需要很多步骤才能真正进入这个函数块，此时将鼠标放在此函数上，会出现相关提示，会告诉你在该文件的哪一行代码处，点击即可直接看到这个函数，然后临时打上断点，按F10或者点击右上角的第二个按钮即可直接进入此函数的断点处
![chromeintomethod](../images/chromeintomethod.png)


**4.调试的功能区域**
每一个功能区，都有它相关的左右，先来看一张图，它都有哪些功能
![chromefunctionarea](../images/chromefunctionarea.png)


**5.Call Stack调用栈**：
当断点执行到某一程序块处停下来后，右侧调试区的 Call Stack 会显示当前断点所处的方法调用栈，从上到下由最新调用处依次往下排列，Call Stack 列表的下方是Scope Variables列表可以查看此时局部变量和全局变量的值。图中可以看出，我们最先走了toggleTab这个方法，然后走到了一个更新对象的方法上，当前调用在哪里，箭头会帮你指向哪里，同时我们可以点击，调用栈列表上的任意一处，即可回头再去看看代码
![chromecallback1](../images/chromecallback1.png)

但是若你想从新从某个调用方法出执行，可以右键Restart Frame， 断点就会跳到此处开头重新执行，**Scope** 中的变量值也会依据代码从新更改，这样就可以回退来从新调试，错过的调试也可以回过头来反复查看
![chromecallback2](../images/chromecallback2.png)


**6.Breakpoints**关于断点：所有当前js的断点都会展示在这个区域，你可以点击按钮用来“去掉/加上”此处断点，也可以点击下方的代码表达式，调到相应的程序代码处，来查看
![chromecallback3](../images/chromecallback3.png)


**7.XHR Breakpoints**
在XHR Breakpoints处，点击右侧的+号，可以添加请求的URL，一旦 XHR 调用触发时就会在 request.send() 的地方中断
![chromecallback4](../images/chromecallback4.png)


**8.DOM Breakpoints:**
可以给你的DOM元素设置断点，有时候真的需要监听和查看某个元素的变化情况，赋值情况，但是我们并是不太关心哪一段代码对它做的修改，只想看看它的变化情况，那么可以给它来个监听事件，这个时候DOM Breakpoints中会如图
![chromecallback5](../images/chromecallback5.png)
当要给DOM添加断点的时候，会出现选择项分别是如下三种修改1.子节点修改2.自身属性修改3.自身节点被删除。选中之后，Sources Panel 中右侧的 DOM Breakpoints 列表中就会出现该 DOM 断点。一旦执行到要对该 DOM 做相应修改时，代码就会在那里停下来


**9.Event listener Breakpoints** 
最后Event Listener 列表，这里列出了各种可能的事件类型。勾选对应的事件类型，当触发了该类型的事件的 JavaScript 代码时就会自动中断



#### 详细的调试
//todo



ref:
1.[超完整的 Chrome 浏览器客户端调试大全](http://web.jobbole.com/89344/),   2.[Chrome格式化JavaScript](https://www.cnblogs.com/chucklu/p/9101066.html),   3.[前端开发神一样的工具chrome调试技巧](https://blog.csdn.net/nanjingshida/article/details/72775687),   4.[谷歌浏览器怎么调试js](https://www.cnblogs.com/hongmaju/p/5115801.html),  5. [Google Chrome 调试JS简单教程(更新)](https://www.cnblogs.com/mq0036/p/3850035.html),   6.[谷歌Chrome浏览器开发者工具教程—JS调试篇](https://blog.csdn.net/cyyax/article/details/51242720),   7.[Chrome（谷歌）浏览器调试教程珍藏版](https://blog.csdn.net/milogenius/article/details/78897745),   8.[聊聊 Chrome DevTools 中你可能不知道的调试技巧](http://web.jobbole.com/95089/),   9.[Chrome 调试技巧](http://web.jobbole.com/95178/),   10.[chrome调试技巧--持续更新](https://www.cnblogs.com/freeyiyi1993/p/3620670.html),   11.