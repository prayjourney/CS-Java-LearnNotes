### css 入门

***

####  CSS基础知识

1.CSS概念

```css
CSS（Cascading Style Sheet的缩写），可译为层叠样式表或级联样式表，是一组格式设置规则，用于控制web页面的外观。
```

2.CSS文件编写

```
@charset 'UTF-8'    （表示声明CSS文件中的字符格式，防止出现乱码）
```

3.浏览器默认样式

```
各个浏览器有为部分标签默认设定了样式，同样标签，在不同浏览器中会有不同显示，所以需要用reset.css文件进行重置
需要使用重置文件进行处理。在书写网页文件时，首先要引入样式的重置文件，以保证在不同浏览器下正常显示。
```

####  浏览器兼容

1．浏览器种类

```
种类、       内核、                          内核前缀
IE           Trident                           -ms-
Chrome    27版以下webkit   44版blink        -webkit-
Firefox     Gecko                             -moz-
Opera      以前Presto  现在Blink              前-o-  现-webkit-
```

2．IE hack技术

<http://www.h5course.com/a/20160111377.html> 
<http://baike.baidu.com/view/1119452.htm>

```
主要针对IE浏览器，想让某一款或某几款浏览器的样式进行调整，我们可以使用hack技术；
     技术符号：
```

```
*zoom:1;
.con {
    width: 800px;   各浏览器通用
    _width: 400px;  IE6
    +width: 500px;  IE6/7
    *width: 600px;  IE6/7
    width: 200px\9; IE6~10
    width: 100px\0  IE8~11
}
```

条件注释法：

```
< !--[if IE]>
这里是正常的html代码
< ![endif]-->
< !--[if IE 5]>
< h2> 版本 5< /h2>
< ![endif]-->

<!--[if !IE]><!--> 除IE外都可识别 <!--<![endif]-->
<!--[if IE]> 所有的IE可识别 <![endif]-->
<!--[if IE 5]> 仅IE5.0与IE5.5 <![endif]-->
<!--[if gt IE 5.0]> IE5.0以及IE5.0以上版本 <![endif]-->
<!--[if IE 6]> 仅IE6 <![endif]-->
<!--[if lt IE 6]> IE6以及IE6以下版本 <![endif]-->
<!--[if gte IE 6]> IE6以及IE6以上版本 <![endif]-->
<!--[if IE 7]> 仅IE7 <![endif]-->
<!--[if lt IE 7]> IE7以及IE7以下版本 <![endif]-->
<!--[if gte IE 7]> IE7以及IE7以上版本 <![endif]--> 
<!--[if ! IE 8]>这段文字在非IE8浏览器显示<![endif]-->
<!--[if !IE]>这段文字只在非IE浏览器显示<![endif]-->
```

3．浏览器内核以及内核前缀

```
a.谷歌/苹果
    内核：Webkit、Blink（谷歌的新内核）
    内核前缀：-webkit
b.火狐
    内核：Gecko
    内核前缀：-moz
c.IE
    内核：Trident
    内核前缀：-ms
d.Opera（欧朋）
    内核：Presto、新版改成webkit
    内核前缀：-o
```

4．浏览器兼容问题

```
a.块元素float后，有横行的margin情况下，在IE6.0显示margin比设置的大；
    常见症状是IE6中后面的一块被顶到下一行；
    解决：在float的标签样式控制中加入 display: inline;将其转化为行内属性。
b.行元素设置display: block后采用float布局，有横行的margin的情况；
IE6里的间距超过设置的间距；
    解决：在display: block;后面加display: inline; display: table。
c.图片默认有间距；
    解决：使用float属性为img布局。
d.嵌套img时，在不同浏览器会出现不同颜色的边框；
    关键是a里面的图片多了border的设置；
    解决：a下面的img加上border: none;这一属性解决。
e.IE6 不支持png-24格式的图片；
    解决： 单独图片处理，改为png-8来使用。
```

5．浏览器调试方法

```
a.F12控制台
b.注释法
    注释：为相应部分添加注释，提高代码的可读性。
    通过加注释+调试的方法，排查代码错误。
    快捷键ctrl+/，例如
    /*border-width: 5px 2px 10px 20px;*/
```

####  CSS引入方式

1．CSS引入方式种类

```
a.标签内部书写，样式座位标签的一个属性（style）而存在，为属性赋值，即可操作的一个标签的样式。
```

```
<p style="width:20px; height:10px;">HTML5学堂</p>
```

b.头部书写

```
使用style标签
<style></style>
配合CSS选择器，使用选择器选择到要操作的标签，之后为相应的标签书写样式
```

```
<style>CSS样式代码</style> 
```

```
Style表示引入文件类型的标签。Type表示文件类型。
优点：应用于大型互联网首页；相对于单页，代码量少；相对于标签书写，维护性好；没有服务器请求压力。
把CSS放在头部，可以让页面根据CSS样式逐步渲染；如果放在底部，要全部加载完成，才能渲染页面，这样有可能会看到没有样式的页面。
缺点：不利于改版，单个页面显得凌乱，CSS样式不能被其他HTML引用。

c.外部引入
    通过link标签，将CSS文件（自有样式代码）引入到html文件当中（或者说是与HTML文件产生关联），使用一个样式文件控制多个HTML网页文件。
```

```
    <link rel="stylesheet" type="text/css" href="common.css">（href表示路径，此为引用同级文件夹文件）
    <link rel="stylesheet" type="text/css" href="css/common.css">（引用同级文件夹中的文件）
    <link rel="stylesheet" type="text/css" href="../css/common.css">（“../”表示上一级文件夹，此为应用上一级文件夹中的css文件夹中的文件）123
```

```
一个css文件可以控制多个页面，便于维护，从整站上减少代码量，有效利用缓存机制。
对于单个页面，会有多余的代码；有可能会给服务器造成请求压力；

d.使用@import引入CSS
    劣势：
    在一个样式文件中使用@import会为页面总体加载时间增加更多一个返程（也就是增加页面的总体加载时间）

    在IE中使用@import 将会引起文件的下载顺序被改变。这更会引起样式文件花费更长的时间来下载，这会阻碍页面的渲染，让人感到页面比较慢。

    示例：
    XML/HTML代码
```

```
<link rel="stylesheet" rev="stylesheet" href="CSS文件" type="text/css" media="all" />   
XML/HTML代码
<style type="text/css" media="screen">   
@import url("CSS文件");   
</style>  
@import最优写法：
@import的写法一般有下列几种：
@import 'style.css' //Windows IE4/ NS4, Mac OS X IE5, Macintosh IE4/IE5/NS4不识别
@import "style.css" //Windows IE4/ NS4, Macintosh IE4/NS4不识别
@import url(style.css) //Windows NS4, Macintosh NS4不识别
@import url('style.css') //Windows NS4, Mac OS X IE5, Macintosh IE4/IE5/NS4不识别
@import url("style.css") //Windows NS4, Macintosh NS4不识别
由上分析知道，@import url(style.css) 和@import url("style.css")是最优的选择，兼容的浏览器最多。从字节优化的角度来看@import url(style.css)最值得推荐。12345678910111213
```

2．三种引入方式的区别

```
a.外部引入
    1)外部引入可维护性最强
    2)针对单页面，有代码冗余
    3)针对整站来说，外部引入加载速度最快
    4)外部引入良好的使用了缓存机制
    5)外部引入有可能造成服务器的请求压力
b.头部书写
    1)针对单页面，头部书写加载速度更快
    2)针对整站，存在代码冗余
    3)不会造成服务器请求压力
    4)代码可维护性一般
c.标签内部
    1)标签内部书写会存在代码冗余，不便于维护
    2)没有很好的实现结构和样式的相分离
d.加载速度
    1)针对单页面，头部书写加载速度更快
    2)针对整站来说，外部引入加载速度更快
    3)外部引入有良好的使用了缓存机制
    4)外部引入有可能造成服务器的请求压力
e.引入方式选择
    代码量少 → 加载速度快 → 用户体验好
```

3．link和@import的区别

```
区别1：link是XHTML标签，除了加载CSS外，还可以定义RSS等其他事务；@import属于CSS范畴，只能加载CSS。
区别2：link引用CSS时，在页面载入时同时加载；@import需要页面网页完全载入以后加载。
区别3：link是XHTML标签，无兼容问题；@import是在CSS2.1提出的，低版本的浏览器不支持。
区别4：link支持使用JavaScript控制DOM去改变样式；而@import不支持。
```

####  CSS选择器

```
CSS 1.0~3.0选择器
```

<http://www.h5course.com/a/20150505139.html> 
<http://www.h5course.com/a/20150508154.html> 
<http://www.h5course.com/a/20150509158.html>

1．CSS选择器种类

```
1)通配符选择器 —— 基本语法，“* ”，星号选择器将匹配页面里的每一个元素。
2)标签名选择器 ——（不需要定义）选择范围最广，权重最低
3)类名选择器 —— .后跟类名，class（需要定义）选择范围一般，权重一般
4)Id名选择器 —— #后跟id名，id（需要定义）通常只能选择一个标签（主要取决于定义时不能起重复的id名），权重高
5)群组选择器 —— 使用 , 分隔不同的选择器，各个选择器分别只计算他们自身即可
6)后代选择器 —— 使用多个选择器的组合来找到要控制的标签，使用空格分隔各个级别的选择器，优先级相加但不进位
7)子代选择器 —— 使用>分隔开多个选择器，只能对父代的下一代产生作用。
    而后代选择器可以对父代以下所有层级后代都作用
    IE6不支持
8):nth-child()选择器 —— p:nth-child(n) 选择器匹配属于其父元素的第 N 个子元素。
    不论元素的类型。n 可以是数字、关键词或公式。
    IE8-不支持
9)相邻选择器 —— 基本语法：X + Y，只选择紧贴在X元素之后Y元素。
10)兄弟选择器 —— 基本语法：X ~ Y，与相邻选择符（ul + div）仅选择前一个选择符后面的第一个元素比起来，兄弟选择符更宽泛。
    它会选择，我们上面例子中更在ul后面的任何div元素。
11)伪类选择器 —— 比较经典的伪类选择器有四种，分别是hover、link、active、visited。
    最初伪类选择器只能应用于a标签，从IE7之后，其他浏览器也支持其他标签的伪类效果了。
    可以把伪类理解为一种标签的状态。如，a:hover表示的就是当鼠标悬停在a标签上时的效果。
    a: link基本状态
    a: visited访问后的状态
    a: hover鼠标悬停状态
    a: active鼠标按下状态（鼠标点击与释放之间时）
    :link :visited :hover :active叫做伪类选择器（注意，不是伪元素！！！）
    伪类选择器，优先级0010
    书写顺序严格按照:link :visited :hover :active，因为优先级都一样，否则会互相覆盖！
12)属性选择器 —— 基本语法：X[title]，属性选择器。
    在我们上面的例子里，这只会选择有title属性的锚标签。
    没有此属性的锚标签将不受影响。
13)伪元素选择器 —— :before :after
```

2．CSS选择器的优先级

```
a.标签内部书写的style属性        1000
b.Id选择器                 0100
c.类名选择器                 0010
d.标签名选择器                0001
e.伪类选择器                 0010
```

![这里写图片描述](../../../../images/SouthEastweqweqw.png)

CSS选择器优先级 
<http://www.h5course.com/a/20150527191.html>

####  CSS important

<http://www.h5course.com/a/20150529202.html>

1.什么是important

```
!important是CSS1就定义的语法，作用是提高指定CSS属性的优先级。
```

2.important的语法

```
选择器名 { 
    CSS属性!important 
}
也就是定义在CSS属性值的后面1234
```

3.important 有何作用

```
默认情况下,CSS属性按级层覆盖，例如在CSS文件中的定义样式可以被style属性定义的样式覆盖，反之则不行。
然而,对覆盖平衡而言,加上一个“!important”优先级大于正常的CSS属性的优先级。
```

4.important的兼容

<http://www.h5course.com/a/20150529202.html>

```
IE7,IE8,firefox,chrome等高端浏览器下，已经可以识别 !important属性。
但是IE6仍然不能完全识别，含! important的样式属性和覆盖它的样式属性单独使用时(不在一个{}里)。
IE 6.0认为! important优先级较高。
否则当含! important的样式属性被同一个{}里的样式覆盖时，IE 6.0认为! important较低。
```

####  属性书写顺序

1．显示属性

```
a.display
b.visibility
c.overflow
d.float
e.clear
f.position
```

2．自身属性

```
a.width
b.height
c.margin
d.padding
e.border
```

3．文本属性

```
a.background
b.line-height
c.color
d.font-size
e.font-weight
f.font-style
g.font-family
h.text-align
i.text-indent
j.text-overflow
k.vertical-align
l.white-space
m.word-break
n.content
```

4．cursor属性 
5．z-index 
6．zoom 
7．outline 
8．CSS3属性

```
a.transform
b.transition
c.animation
d.box-shadow
e.text-shadow
f.border-radius
```

####  CSS显示属性

1.CSS显示属性种类

```
显示属性需要写在其他自身属性之上

a.clear 
b.overflow
c.visibility
d.display
e.position
f.float
```

2.clear属性

```
a.定义和用法
    clear 属性规定元素的哪一侧不允许其他浮动元素。

    说明
    clear 属性定义了元素的哪边上不允许出现浮动元素。
    在 CSS1 和 CSS2 中，这是通过自动为清除元素（即设置了 clear 属性的元素）增加上外边距实现的。
    在 CSS2.1 中，会在元素上外边距之上增加清除空间，而外边距本身并不改变。
    不论哪一种改变，最终结果都一样.
    如果声明为左边或右边清除，会使元素的上外边框边界刚好在该边上浮动元素的下外边距边界之下。

b.clear属性的值
```

```
    值       描述
    left    在左侧不允许浮动元素。
    right   在右侧不允许浮动元素。
    both    在左右两侧均不允许浮动元素，IE6/7不兼容。
    none    默认值。允许浮动元素出现在两侧。
    inherit 规定应该从父元素继承 clear 属性的值。123456
```

```
c.浏览器支持
    IE  Firefox Chrome  Safari  Opera
    所有主流浏览器都支持 clear 属性。
    注释：任何版本的 Internet Explorer （包括 IE8）都不支持属性值 "inherit"。
```

3.overflow

```
超出显示隐藏，考虑后台数据传递时，可能传递的文字所占空间，超出了可视区域范围。
此时，考虑拥护体验，需要针对该元素设置超出隐藏/省略号（超出显示为省略号只能应用于单行）
    a.overflow: hidden（将文本超出块的部分内容隐藏）
    b.overflow: auto（文本超出块的之后，自动添加滚动条，一般是上下滚动条）
    c.overflow: scroll（无论文本是否超出块，都对块添加左右+上下滚动条）
    d.overflow: visible（显示超出内容，不剪切内容也不添加滚动条）
    e.滚动条本身占据18px，
    f.溢出显示省略号的写法
```

```
.wrap {
    overflow: hidden;
    width: 200px;
    height: 40px;
    margin: 0 auto;
    border: 10px solid #f00;
    font-size: 24px;
    line-height: 40px;
    text-overflow: ellipsis;
    /*当对象内的文本溢出时，显示为省略号标记，需要与overflow: hidden一起使用*/

    white-space: nowrap;
    word-break: keep-all;
    /*white-space/word-break的作用是让文字不换行*/
    /*黄色部分为标准写法，需要熟记*/
}12345678910111213141516
```

4.visibility

```
可视性
a.元素的三大类型（详见第七点）
b.隐藏元素
```

```
        .wrap {
            visibility: hidden;
            /*以行元素显示*/
            width: 200px;
            height: 200px;
            background: #fcc;
        }1234567
```

5.display

```
    显示属性display——显示类型
    display: block \ none \ inline \ inline-block \ table
    block:该元素以块属性显示 ；
    none:该元素隐藏，并且在网页中不占位置； 
    inline:以行内属性显示；
    inline-block：行内块元素，使元素既可以拥有块元素的特性，如可以设置宽高，又可以拥有行元素的性质，即可以显示在同一行。
    但会继承行元素所拥有的间隙bug，因行元素之间的换行符（即回车），会在页面中被渲染。
    体现为行元素之间有一个空隙，空隙的大小各个浏览器不相同。
    table:以表格的表现显示,经常对应table-cell使用。

    a.行块元素如何相互转换：通过使用display: inline和display: block实现块元素和行元素的转换
        display: block会让元素以块显示，同时会独占一行
```

```
<head>
        .wrap {
            display: inline;
            /*以行元素显示*/
            width: 200px;
            height: 200px;
            background: #fcc;
        }
        .box {
            display: block;
            /*以块元素显示*/
            width: 200px;
            height: 200px;
            margin: 10px;
            background: #ccf
        }
</head>
<body>
    <div class="wrap">div块元素</div>
    <span class="box">span行元素</span>
</body>
```

```
    b.元素不显示
        visibility: hidden;与display: none的区别：
        两者在表现上，均是隐藏元素。但是visibility: hidden会占据物理空间，display: none不占据物理空间
        display: none经常与JS做配合使用
```

```
        .wrap {
            display: none;
            /*将wrap块隐藏*/
            width: 200px;
            height: 200px;
            background: #fcc;
        }
```

```
c.display: inline-block;的间隙兼容处理
        父级设置：
        .wrap {
            /*因行元素之间的换行符（即回车），会在页面中被渲染，体现为行元素之间有一个空隙，空隙的大小各个浏览器不相同。*/
            /*因回车会被当做空白字符，所以可以在父级设置font-size: 0;，将字符的大小设置为0，回车即不会被显示*/
            font-size: 0;
        }
        子级设置：
        .inline-block {
            /*将元素转换为行内块元素，使其既可以拥有块元素的特性，如可以设置宽高，又可以拥有行元素的性质，即可以显示在同一行*/
            display: inline-block;
            /*因IE7以下浏览器不支持display: inline-block;所以要用display: inline;模拟display: inline-block;*/
            *display: inline;
        }
```

####  CSS显示属性：定位

1．定位代码

```
position: relative absolute fixed static inherit
    a.relative  相对定位
    b.absolute  绝对定位
    c.fixed 固定定位，定位于相对于浏览器窗口的指定坐标。
        此元素可以通过四个方向属性来规定，不管窗口是否滚动，元素都会留在那个位置。
    d.static    默认状态，没有触发定位
    e.inherit   继承父级
```

2．定位的特性

```
a.position: relative：
    1)relative相对定位可以设置定位值，其含义是相对自己定位，但不会脱离文档流，只会按为进行定位使的位置占据原来的空间。
    2)元素的浮动属性和相对定位属性会同时起作用。相对定位属性将在浮动之后起作用，即会以元素浮动之后的位置进行定位。
    3)设置了position: relative;属性的块元素，未设置宽度时，会默认占满父级整行
    4)当相对定位元素未设置宽高时。
        同时设置left/right、top/bottom值时，元素的宽高不会受到定位属性的影响，定位值只有left、top值会起作用对元素进行定位。

b.position: absolute：
    1)当浮动属性和绝对定位属性同时存在时，绝对定位属性起作用，浮动属性不起作用。
    2)无论是否设定left、right、top、bottom的值，都会脱离文档流。
    3)无论是否设置定位位置，在未设置宽度的情况下，都不会占满整行，改变为由内容撑开宽高，故需要另外设置宽度。
    4)元素未设置定位位置时，无论是否设置宽高，定位的位置在元素在文档流中的父级的左上角
    5)当绝对定位元素未设置宽高时，同时设置left/right、top/bottom值时，
        横向和纵向的值都会起作用，元素会按照left/right、top/bottom值被撑开。
    6)当绝对定位元素设置宽高时，同时设置left/right、top/bottom值时，只有left、top值会起作用。
    7)如果父级（或祖级）设置了定位，并且属性值为absolute、relative、fixed的任意一种，则针对该父级元素（最近的）进行定位
    8)如果父级（无限）没有设置position，则针对窗口（浏览器的左上角）进行定位

c.position: fixed
    1)定位属性设置为fixed的元素会脱离文档流
    2)为设定任何定位值时，默认以元素的上、左边缘定位在页面的左下角，元素整体显示在页面之外。
    3)当固定定位元素未设置宽高时，都不会占满整行，改变为由内容撑开宽高，故需要另外设置宽度
    4)当固定定位元素未设置宽高时，同时设置left/right、top/bottom值时，横向和纵向的值都会起作用，元素会按照left/right、top/bottom值被撑开。
    5)当固定定位元素设置宽高时，同时设置left/right、top/bottom值时，只有left、top值会起作用。

d.z-index属性——用于控制一个层的层叠顺序，在不设置z-index时，默认为0。值越大，层叠顺序越考前。可以为负值。
    以元素A和B为例
    1)当父级不设置或只有部分父级设置z-index时，父级未设置z-index的子级，直接当做父级与其他父级进行比较，不再比较子级之间的层叠关系。
    2)设置z-index之后会触发层级的比较。先比较父级，如果元素A的父级层叠关系大于元素B的父级层叠关系，此时A和B无论怎么设置，A都会在B之上。
    3)自身z-index和父级的z-index不会互相影响。换句话说，每个级别之间可以进行比较，但是不能相互比较。
```

3．IE6兼容position: fixed的方法

```
/*IE6中防止抖动的方法*/
/*在IE中，当滚动页面或调整浏览器大小时，IE会重置所有内容并重绘页面，此时IE会重新处理CSS表达式，此时固定定位的元素会同步调整在页面中的位置，造成滚动时会抖动的bug，处理方法如下*/
*html {
    /*为HTML元素增加一个背景图，由于此图片是在根元素html中加入的，使网页在滚动重绘页面时，需要先将这部分内容处理，这样就触发了页面重绘之前先处理CSS，同时计算position的表达式也被提前计算好后，在重绘到页面中，避免了先重绘页面再调整position位置造成的bug*/
    /*因为不需要给网页另外加入图片，以免影响页面加载速度，只需要触发代码的运行即可。所以路径设置about:blank，添加一个空白路径即可*/
    background-image: url(about:blank);
    /*background-attachment属性设置背景图像是否固定或者随着页面的其余部分滚动。   */
    /*使用background-attachment属性，将背景图固定，使其不跟随页面滚动而滚动。因position定位参考的也是html根元素，若不设置fixed的话，*/
    background-attachment: fixed;
}
.to-top {
    position: fixed;
    /*因IE6可识别left和right属性，不需要针对left和right进行特别处理。*/
    right: 100px;
    bottom: 100px;
    /*IE6读取代码*/
    /*因IE6不支持position: fixed;，使用IE hack技术，用position: absolute;代替position: fixed;*/
    _position: absolute;
    /*通过document.documentElement访问html根元素，获取所需的值进行计算*/
    /*CSS中使用expression只有ie才能识别。IE5及其以后版本支持在CSS中使用expression，用来把CSS属性和Javascript表达式关联起来，这里的CSS属性可以是元素固有的属性，也可以是自定义属性。*/
    /*eval(string) 函数可计算某个字符串，并执行其中的的 JavaScript 代码。通过计算 string 得到的值（如果有的话）。*/
    /*document.documentElement.scrollTop为当前页面的滚动位置*/
    /*document.documentElement.clientHeight为当前显示窗口的高度*/
    /*this.offsetHeight，this指向当前进行操作的元素，即返回顶部按钮，这句话获取的是返回顶部按钮的总高度*/
    /*100为返回顶部按钮的元素相对底部的定位高度*/
    /*返回顶部按钮相对页面底部定位位置 = 页面滚动位置 + 网页显示窗口高度 - 按钮的总高度 - 相对底部定位的高度*/
    _top: expression(eval(document.documentElement.scrollTop + document.documentElement.clientHeight - this.offsetHeight - 100));
    display: none;
    width: 148px;
    height: 216px;
    background: url("../images/rocket.png") 0 0 no-repeat;
    cursor: pointer;
}
```

####  CSS显示属性：浮动

1.浮动

```
a.为什么要用浮动？
默认块元素是独占一行，不能跟其他元素处于同一行，需要使用浮动进行布局

b.float 先浮后动（水槽原理） 
    1）所有的元素都可以浮动 
    2）具有float属性的元素在父标签中是不占空间的
    3）float能解决标签之间有间隙的问题 
c.如何进行浮动设置
    Float: left;
    Float: right;
d.浮动的特性
    1)对行元素的影响：float后能设置width和height属性，并支持margin和padding属性。
    2)对块元素的影响：能够让块元素和其他元素处于同一行，在没有设置宽高的情况下浮动后，内容撑开宽度高度，可以使块元素并排排列。
    3)浮动会使元素脱离文档流
    4)浮动会对兄弟级标签的布局造成影响，也会对父级高度造成影响（高度塌陷）
    5)左右浮动，空间受影响，浮动过程不受影响
    6)IE6中会触发双边距bug
    7)IE7-中，无论父级有无border-bottom或padding-bottom，margin-bottom无法显示，并且无法撑开父级，呈现消失的状态。
```

2.清浮动方法

```
a.处理兄弟级的布局问题
    1)在标签里添加clear: both;（左右均可清浮动）
```

<http://www.h5course.com/a/20150503113.html>

```
    clear:both的兼容问题
    一直都在用clear:both，但是貌似很少人了解这个属性的兼容问题。
    在IE6和IE7浏览器当中，是不兼容clear:both的。处理兼容的方法是使用hack技术，在样式代码中增加*float:none;这句代码。
    2)Clear: left; clear: right（清左浮动和右浮动）
    3)Clear属性清浮动只能影响兄弟级标签，对父级标签（高度）无作用

b.处理父级的高度塌陷问题
    1)空标签清浮动方法

```

```
        举例：
        /*定义轻浮动样式*/
        .clear {
            clear: both;
        }
        /*在兄弟级最下方，使用空标签进行清浮动*/
        <div class="clear"></div>1234567
```

```
        优点：代码简单，好理解
        缺点：可读性差，在网页文件中存在大量无意义标签，存在代码冗余。

    2)br标签清浮动方法
        <br>标签：属于单标签，含义为“换行符”，br标签能巩固清除浮动的基本原理在于，br标签存在一个clear属性。
        我们可以为其设置clear = “all”;来实现浮动的清除。

```

```
举例：
<!-- 在兄弟级最下方，使用br标签进行清浮动 -->
<br clear="all">123
```

```
        缺点：可读性差，在网页文件中存在大量无意义标签，存在代码冗余。

    3)overflow属性清浮动（overflow: hidden;或overflow: auto）

```

```
        属性分类
        overflow: hidden（将文本超出块的部分内容隐藏）
        overflow: auto（文本超出块的之后，自动添加滚动条，一般是上下滚动条）
        overflow: scroll（无论文本是否超出块，都对块添加左右+上下滚动条）1234
```

```
        用法：
        给父级增加overflow: hidden;或overflow: auto;（超出隐藏/超出自动处理）任意一种，均可清浮动。
        缺点：
        一旦出现需要显示在父级之外的元素，该元素会被隐藏，影响功能和样式的基本实现

    4)让父级也浮动起来——父级浮动会造成父级的相关元素布局受到影响，包括其兄弟级和上一级。
        如果希望所有的都没有影响，需要浮动到body，但是从布局需求上行不通。
        因此，不采用此方法清除浮动。

    5)after伪元素清浮动

```

```
        /*样式中定义.clearfix，一般reset.css文件中已经有定义*/
        .clearfix:after {
            content:"\200B"; 
            display:block; 
            height:0; 
            clear:both; 
        }
        /*IE6/7不支持伪元素，针对IE6-7，使用zoom触发IE6-7的layout，来实现清浮动的功能*/
        .clearfix { 
            *zoom:1; 
        }
        /*块中引用*/
        <div class=”wrap clearfix”>
            <div></div>
        </div>123456789101112131415
```

```
        伪元素：并不是一个标签，而是一个标签之后或者之前可以定义的假的元素，:after和:before分别表示标签后面的伪元素和前面的伪元素。
        伪元素清浮动的原理其实与空标签清浮动完全相同。
        content:"\200B";表示的是定义伪元素的内容，’\200B’为转义字符，表示“0宽度的空格”。
        书写本代码的目的在于，伪元素必须定义content，才能够显示在网页当中。
        而之所以使用0宽度的空格，在于防止内容对页面造成影响
        clear: both;用于清浮动
        height: 0;用于设置伪元素的高度，用于不希望伪元素的高度影响布局，因此高度设置为0;
        display: block;是让伪元素以块元素的形式（独占一行）来显示
```

####  CSS元素的自身属性

1．盒模型基本概念

```
a.宽、高、边框
b.标签的内容距离边框的部分 —— 内编剧
c.标签之间的距离 —— 外边距

```

![这里写图片描述](../../../../images/SouthEastertewtwre.png)

2．外边距 margin

```
a.水平居中方法
    Margin在水平方向上设置auto，可以让div（所有的块元素）在父级中居中。
    例如：margin: 0 auto;

b.元素设置浮动时：
    横向margin：
        1)第一列浮动元素
            Chrome中元素、Firefox中元素、IE7+中元素：
            浮动方向margin可以正常显示。
            IE6中元素：
            横向双倍外边距BUG

```

<http://www.h5course.com/a/2015042861.html>

```
            在IE6中，当元素向左浮动并且设置了左侧的外边距，出现了这样的双边距bug。
            同理，元素向右浮动并且设置右边距也会出现同样的情况。
            同一行如果有多个浮动元素，第一个浮动元素会出现这个双边锯bug，其他的浮动元素则不会
            解决方式：将浮动元素设置成反方向浮动，将元素margin替换成父级padding，或者在浮动元素中加入display: inline;属性。

        2)元素之间的横向margin：
            Chrome中元素、Firefox中元素、IE中元素：
            两个元素设置横向外边距后，两个元素间的距离是外边距相加之和。

    纵向margin：

        1)第一行元素的margin-top：
            Chrome中元素、Firefox中元素、IE中元素：
            无论父级有无border-top或padding-top，margin-top都可以正常撑开父级

        2)元素之间的纵向margin：
            当设置浮动之后，元素之间的纵向margin不再叠加，而是取相加后的值。
            若在浮动元素之上有未浮动元素，浮动元素的纵向margin与其也不会叠加。

        3)最后一行元素的margin-bottom：
            Chrome中元素、Firefox中元素、IE8+中元素：
            无论父级有无border-bottom或padding-bottom，margin-bottom都可以正常撑开父级
            IE7-中元素：
            无论父级有无border-bottom或padding-bottom，margin-bottom无法显示，并且无法撑开父级，呈现消失的状态。

c.元素未设置浮动时：
    1)第一个元素的margin-top：
        ①　父级无border-top或padding-top时，Chrome中元素、Firefox中元素、IE8+中元素：
            margin-top无法作用在父级中，父级不会被margin撑开，但是margin会超出父级。
            与父级之外的上一个元素相互作用，将父级与上一个元素拉开margin的距离。
        ②　父级有border-top或padding-top时，Chrome中元素、Firefox中元素、IE8+中元素：
            margin-top将会作用在父级中，使父级被margin撑开。
        ③　无论父级有无border-top或padding-top时，IE7-中的div、dl、ul、ol：
            margin-top将会作用在父级中，使父级被margin撑开。

    2)元素之间的纵向margin：
        ①　当两个元素设置纵向外边距之后，外边距会重叠，两个元素间的距离是较大的那个纵向的margin值，即纵向外边距叠加。

    3)最后一个元素的margin-bottom：
        ①　无论父级有无border-bottom或padding-bottom，Chrome中的div/dl/ul/ol、Firefox中的divdiv/dl/ul/ol、IE中的divdiv/dl/ul/ol：
        margin-bottom将会作用在父级中，使父级被margin撑开。

    d.margin负值应用
        子级设置margin负值时：
        计算规则：
        1)计算margin负值的影响时，父级和子级需要分开计算，可以采用先计算对父级的影响，再计算子级间的影响，最终结果为两者叠加。
        2)父级的内容区域，会按照第一个和最后一个子级的负值方向及其值，延伸至子级中，但必须保证父级的内容区最小宽高为0
        3)子级自身的宽高、padding、border值不变
        4)子级之间的margin负值计算，可遵循先按宽高、padding、border的实体布局之后，子级将按照margin负值的方向延伸至相邻子级中
        5)子级之间的margin负值，遵循margin横纵向计算的规则，例如margin纵向叠加。
        层级关系：
        1)子级之间的层级关系为，之后的元素显示在之前元素之上
        2)若子级超出父级，则按照父级与其上下元素的层级关系显示，即子级的显示覆盖在父级之前的元素之上，并会被父级之后的元素覆盖
        3)子级之间的margin负值只影响子级之间的位置关系，父级的位置按照其在文档流中的位置

```

3．内边距 padding

```
padding会影响盒模型宽、高的计算，若设置了padding值，如果想要总宽高不变，必须在宽高中扣除padding值。

```

4．margin、padding写法

```
Margin和padding可以使用1~4个值进行样式设置，分别表示：
a.4个值：分别表示  上   右   下   左（从顶部开始顺时针方向）
b.3个值：上 左右  下
c.2个值：上下    左右
d.1个值：四个方向相同
e.padding-top: 单独控制上方距离
f.padding-right: 单独控制右边距离
g.padding-bottom: 单独控制下方距离
h.padding-left: 单独控制左边距离

```

5．margin和padding的父子级使用

```
两个标签是父子关系；
其之间什么都没有（例如border等）；
在子级中设置纵向的margin，则纵向margin作用于父级中。
解决：用父级的内边距（padding）替代掉子级的margin。
margin和padding的使用→
父子之间：padding；   同级之间用margin

```

6．边框 border

```
border是复合属性，根据其属性划分，包括了线宽、线型、颜色
通常写法border: 线宽、线型、颜色，例如border: 1px solid #000;

a.Border-width  表示线宽
b.Boder-style   表示线型：solid 实线、dotted 点线、dashed 虚线
c.Border-color  表示颜色
d.这3个属性也可以按padding的方向来写，例如：
    border-width: 5px 2px 10px 20px;
    border-style: dotted solid dashed solid;
    border-color: red green black blue;
    根据方向划分：
    Border-top | right | bottom | left
    既限定方向也先定属性
    Border-top-color: #f00
    border：none；表示当前元素没有边框。
    border：0；表示当前元素边框为0。

```

7．水平垂直居中方法 
<http://www.h5course.com/a/20150728278.html> 
<http://www.h5course.com/a/20150727271.html> 
<http://www.h5course.com/a/20150807290.html> 
<http://www.h5course.com/a/20150807292.html>

8．margin兼容问题

```
a.margin纵向计算
当两个元素设置纵向外边距之后，外边距会重叠，两个元素间的距离是较大的那个纵向的margin值，即纵向外边距叠加。

b.怪异解析
在IE6下，会以盒模型的宽度 = [margin + width]或者[padding + border]（两者取其大者）
解决方式：正常设置文档声明<!doctype html>

c.浮动元素margin-bottom失效

```

<http://www.h5course.com/a/20150502104.html>

```
子级设置浮动后，在IE6中，最下一行元素的margin-bottom会失效。
解决方案
为容器显式地设置高度。若容器高度不定。
则要避免在触发了 hasLayout 的容器内的浮动子元素上设置 'margin-bottom' 特性，可通过为容器设置 'padding-bottom' 达到相似的效果。
只要不同时触发父元素hasLayout、子元素左浮动、左浮动子元素拥有非零的 margin-bottom 值，这三个条件中任意一项，均可解决此问题。

d.横向双倍外边距BUG

```

<http://www.h5course.com/a/2015042861.html>

```
在IE6中，当元素向左浮动并且设置了左侧的外边距，出现了这样的双边距bug。
同理，元素向右浮动并且设置右边距也会出现同样的情况。
同一行如果有多个浮动元素，第一个浮动元素会出现这个双边距bug，其他的浮动元素则不会。
解决方式：将浮动元素设置成反方向浮动，将元素margin替换成父级padding，或者在浮动元素中加入display: inline;属性。

```

####  CSS文本属性

1.background背景属性

```
background: 背景颜色、图片、图片位置、图片重复情况、是否随着滚动条滚动。

a.颜色    color
b.图片    image
c.位置    position
    a)由两个值组成，第一个值表示水平方向，第二个值表示垂直方向。
    b)可以使用left right center bottom top等英文单词表示
    c)也可以使用固定单位进行设置
    相对度量单位：百分比(%)em
    绝对度量单位px
    d)position的值可以为负值（该属性与背景图合并息息相关）

d.重复    repeat  不进行重复填充操作，即平铺背景
    值           描述
    repeat      默认。背景图像将在垂直方向和水平方向重复。
    repeat-x    背景图像将在水平方向重复。
    repeat-y    背景图像将在垂直方向重复。
    no-repeat   背景图像将仅显示一次。
    inherit     规定应该从父元素继承 background-repeat 属性的设置。

e.滚动    attachment
    a)scroll    默认值。背景图像会随着页面其余部分的滚动而移动。
    b)fixed 背景图不随着页面的滚动而滚动，当页面的其余部分滚动时，背景图像不会移动。
    c)inherit   继承父级

```

```
body {  /*标签名选择器，直接对body进行作用，作用于整个页面背景*/
    background-color: #ccc;
    background-image: url("../../../weidian/291380664520367353.jpg");
    background-repeat: no-repeat;
    background-position: 100px 100px;
    background-attachment: fixed;
    /*background: #ccc url("../../../weidian/291380664520367353.jpg") no-repeat 100px 100px fixed;*/
    /*background属性可以缩写*/
    /*复合属性不可以写成
    *   background: #ccc;
    *   background: url("../../../weidian/291380664520367353.jpg") no-repeat 100px 100px fixed; 定义的颜色会被替换掉*/
}123456789101112
```

```
f.背景图合并
    1)背景图合并优势
    使用背景图合并技术，可以达到减少图片数量，从而减少HTTP请求的目的，对网站加速有着举足轻重的作用。
    背景图合并优势：可扩展，便于后期维护，当遇到排版变化时，比较容易维护。
    2)背景图合并原理
    把本网站用的多张背景图都合并到一张背景图上，利用CSS中的background-position属性去进行图片的定位。用来加快浏览器的显示速度。

```

2.color字体颜色属性

```
color 属性规定文本的颜色。
color: red; skyblue;等等
color: #ff0000;
color: #f00
color: rgb(255, 0, 0);
color: rgba(255, 0, 0, 1); rgba中的a为alpha透明度，1表示不透明，0表示不透明，0~1小数表示半透明。
rgba的颜色表示法，是CSS3新增属性，IE8不兼容
颜色的计算：
红 黄 绿 青 蓝 紫
越接近ffffff颜色越亮
越接近000000颜色越暗
三种颜色等量混合，为不同程度的灰色（或黑、白）

```

3.font字体属性

```
a.font复合属性
    font: italic bold 44px/100px "Microsoft YaHei";
    书写顺序不能错：font-style font-weight font size/line-height font-family
    （不同属性值之间使用空格分隔，但是字体大小和行高之间使用单斜杠“/”）
    注意：
    1)字体大小和字体必须写，否则font的写法失效
    2)书写顺序不能错误

b.font-size
    网页默认字体大小是16px
    网页的最小字体，通常支持到12px
    分否使用奇数的字体大小，如15px？——所有字体大小均使用偶数，且整数

c.font-family
    SimHei —— 黑体
    SimSun —— 宋体
    Microsoft YaHei —— 微软雅黑
    Arial —— 英文常用字体之一，表示无衬线字体
    sans-serif —— 英文常用字体之一，表示无衬线字体

d.font-weight
    font-weight: 属性值的书写方式：
    1)数值100~900不等，400等同于正常状态，700等同于加粗状态
    2)单词normal——正常，bold——加粗，bolder——更粗，lighter——更细，inherit——继承（继承父级的字体大小）

e.font-style
    normal —— 正常
    italic —— 斜体（常用）
    inherit —— 继承
    oblique —— 倾斜（不常用）

```

4.text文本属性

```
a.text-decoration
    underline; overline; line-through文本的修饰：下划线；上划线；删除线

b.text-align:
    left; center; right; 常用属性值，表示文本水平方向的对齐方式。center、right、justify（两端对齐）、inherit（继承）
    对于单行文本，水平垂直居中的方法：包含文本的元素，设置text-align: center;实现水平居中。

c.vertical-align
    vertical-align: 属性值可以是middle; top; bottom; middle; 但是只针对于表格类元素（即display类型为table、table-cell的元素）

d.text-indent:
    text-indent: 2em;   表示首行缩进（通常应用于段落）。
    em：相对度量单位，表示字符宽度1em = 1个字符宽度。
    如果当前元素的字体大小为12px，则1em == 12px，如果设定为-2em，这回反方向缩进2em，此时会向左超出该段落2字符
    px：绝对度量单位，表示像素

e.字间距
    word-spacing: 英文单词之间的间距
    letter-spacing: 英文字母、汉字之间的间距

f.断句
    word-wrap: break-word; 
        word-wrap 属性允许长单词或 URL 地址换行到下一行。

        值           描述
        normal      只在允许的断字点换行（浏览器保持默认处理）。
        break-word  在长单词或 URL 地址内部进行换行。

    word-break: break-all;
        word-break 属性规定自动换行的处理方法。
        提示：通过使用 word-break 属性，可以让浏览器实现在任意位置的换行。

        值           描述
        normal      使用浏览器默认的换行规则。
        break-all   允许在单词内换行。
        keep-all    只能在半角空格或连字符处换行。

    两者均用来“强制断句”

```

```
<head>
    <style>
        .wrap {
            /*display: table-cell;*/
            width: 400px;
            height: 200px;
            border: 1px solid #f00;
            line-height: 200px;
            text-align: left ;
            text-decoration: ;
            text-indent: 2em;
            vertical-align: middle;
            /*letter-spacing: 20px;*/
            /*word-spacing: 20px;*/
            word-break: break-word;
            /*word-wrap: break-word;*/
        }
    </style>
</head>
<body>
    <div class="wrap">HTML5</div>
</body>12345678910111213141516171819202122
```

5.line-height行高属性

```
设置line-height（行高），使其与父级元素高度一致，实现垂直方向的居中。
当块元素没有设置高度时，line-height会撑开元素的高度。

```

####  cursor属性

鼠标样式：pointer手，move 移动

```
        .wrap a:hover {
            color: #000;
            text-decoration: underline;
            cursor: pointer;
        }12345
```

```
值           描述
url         需使用的自定义光标的 URL。
            注释：请在此列表的末端始终定义一种普通的光标，以防没有由 URL 定义的可用光标。
default     默认光标（通常是一个箭头）
auto        默认。浏览器设置的光标。
crosshair   光标呈现为十字线。
pointer     光标呈现为指示链接的指针（一只手）
move        此光标指示某对象可被移动。
e-resize    此光标指示矩形框的边缘可被向右（东）移动。
ne-resize   此光标指示矩形框的边缘可被向上及向右移动（北/东）。
nw-resize   此光标指示矩形框的边缘可被向上及向左移动（北/西）。
n-resize    此光标指示矩形框的边缘可被向上（北）移动。
se-resize   此光标指示矩形框的边缘可被向下及向右移动（南/东）。
sw-resize   此光标指示矩形框的边缘可被向下及向左移动（南/西）。
s-resize    此光标指示矩形框的边缘可被向下移动（南）。
w-resize    此光标指示矩形框的边缘可被向左移动（西）。
text        此光标指示文本。
wait        此光标指示程序正忙（通常是一只表或沙漏）。
help        此光标指示可用的帮助（通常是一个问号或一个气球）。

```

####  CSS3新增属性

1.border-radius应用

<http://blog.sina.com.cn/s/blog_61671b520101gelr.html>

```
a.4个方向的应用
每个方向的4个值的书写顺序，和margin类似。
1个值：四个方向
2个值：左上角右下角      右上角左下角
3个值：左上角 右上角和左下角 右下角
4个值：左上角开始 顺时针方向

b.考虑兼容性的书写
    -webkit-border-radius: 50px 200px 100px 0px;
    -moz-border-radius: 50px 200px 100px 0px;
    border-radius: 50px 200px 100px 0px;
                    左上 右上   右下  左下

c.椭圆写法
    -webkit-border-radius: 300px/200px;
    -moz-border-radius: 300px/200px;
    -ms-border-radius: 300px/200px;
    -o-border-radius: 300px/200px;
    border-radius: 300px/200px;
                   长方向/宽方向

d.border-radius属性写法详细分析
    border-radius：[ length | percentage ]{1,4} [ / [ length | percentage ]{1,4} ]?
    [xxx]{n,m}  表示中括号中的内容可以出现n~m次
    [xxx]?  表示中括号中的内容出现0~1次
    [xxx]*  表示中括号中的内容出现0~无数次
    [A|B]表示A或B
    默认值：0
    属性值可以使用长度值或百分比。
    可以出现1个值到8个值，前4个值表示水平方向，后4个值表示垂直方向，水平与垂直方向之间使用“/”进行分隔。
    如果水平和垂直方向相同，可以不书写后面的四个值。

e.单个圆角的设置
    除了同时设置四个圆角以外，还可以单独对每个角进行设置。对应四个角，CSS3提供四个单独的属性：
    * border-top-left-radius
    * border-top-right-radius
    * border-bottom-right-radius
    * border-bottom-left-radius
    这四个属性都可以同时设置1到2个值。如果设置1个值，表示水平半径与垂直半径相等。
    如果设置2个值，第一个值表示水平半径，第二个值表示垂直半径。

    border-top-left-radius: 50px;
    border-top-left-radius: 50px 100px;//第一个值表示水平半径，第二个值表示垂直半径。

```

2.text-shadow文本阴影效果

```
text-shadow: 10px -10px 20px; #f00;
text-shadow: 水平偏移量 垂直偏移量 阴影模糊值 阴影颜色;
不设置阴影颜色时，阴影颜色默认和字体颜色相同

多重阴影效果：
text-shadow: 10px 10px #39f, -10px 10px #f00, 10px -10px #00f, -10px -10px #0f0;
text-shadow：none | shadow [ , shadow ]* 
shadow = length{2,3} && color? 

```

3.box-shadow盒阴影 —— 元素阴影

```
阴影不算像素，边框算像素，所以用阴影做边框较方便
box-shadow: 阴影位置 水平偏移量 垂直偏移量 阴影模糊值 阴影外延值/扩展值 阴影颜色;
box-shadow: 10px -10px 20px -5px rgba(0, 0, 0, 0.3);

inset表示内部阴影
box-shadow: inset -10px -5px rgba(0, 0, 0, 0.5);

扩展值 —— 可以为负值（缩小）    正值（放大）

box-shadow：none | shadow [ , shadow ]* 
shadow = length{2,4} && color? 

```

4.background-origin背景图原点

```
background-origin: 背景原点，用语定义背景图从哪个位置开始显示
border-box | padding-box（默认） | content-box，分别从border、padding、content位置开始显示。

```

5.background-clip: 背景切割

```
background-clip: 背景切割，用于定义背景颜色、图片从哪个位置开始显示，除此之外的位置不显示
border-box（默认） | padding-box | content-box

```

6.opacity透明度

```
a.rgba()
    RGBA 颜色值得到以下浏览器的支持：IE9+、Firefox 3+、Chrome、Safari 以及 Opera 10+。
    RGBA 颜色值是 RGB 颜色值的扩展，带有一个 alpha 通道 - 它规定了对象的不透明度。
    RGBA 颜色值是这样规定的：rgba(red, green, blue, alpha)。alpha 参数是介于 0.0（完全透明）与 1.0（完全不透明）的数字。
    实例
    p
    {
        background-color:rgba(255,0,0,0.5);
    }

b.opacity 属性
    定义和用法
    opacity 属性设置元素的不透明级别。
    兼容性：
    IE8及以下不支持
    语法
    opacity: value|inherit;
    value   规定不透明度。从 0.0 （完全透明）到 1.0（完全不透明）。
    inherit 应该从父元素继承 opacity 属性的值。

c.filter 属性
    IE8 以及更早的版本支持替代的 filter 属性。
    取值为0~100。
    例如：filter:Alpha(opacity=50)。

```

####  CSS3高级

1．CSS3变形 —— 二维与三维变形

```
a.二维变形
元素的二维变形不影响盒模型，仅影响渲染效果，在原文档流中的位置及大小，即在其之前和之后的元素都按照和其未渲染时的原位置进行排版。

    1)旋转：transform: rotate(); 
        transform: rotate(30deg);   让块旋转30°
        如果角度为正值，它的旋转方向为顺时针
        如果角度为负值，它的旋转方向为逆时针
        transform-orgin: x y;
        x y：单词（left、right、center）、百分比、px、rem等
        例子：
        -webkit-transform:  rotate(-30deg);
        -moz-transform:  rotate(-30deg);
        -ms-transform:  rotate(-30deg);
        -o-transform:  rotate(-30deg);
        transform:  rotate(-30deg);
        -webkit-transform-origin: center center;
        -moz-transform-origin: center center;
        -ms-transform-origin: center center;
        -o-transform-origin: center center;
        transform-origin: center center;

    2)平移
        translate(x, y); translateX(); translateY();
        translate(x, y);只有一个值的时候，对应于x轴
        x y：单词（left、right、center）、百分比、px、rem等
        性能优于定位、scrollLeft等
        例子：
        -webkit-transform: translate(100px, 100px);
        -moz-transform: translate(100px, 100px);
        -ms-transform: translate(100px, 100px);
        -o-transform: translate(100px, 100px);
        transform: translate(100px, 100px);

    3)缩放
        scale(x, y); scaleX(); scaleY();
        但scale()中只有一个值的时候，x轴和y轴都会同时进行缩放。
        取值范围：0~1为缩小，1~正无穷为放大
        例子：
        -webkit-transform: scale(0.5, 2);
        -moz-transform: scale(0.5, 2);
        -ms-transform: scale(0.5, 2);
        -o-transform: scale(0.5, 2);
        transform: scale(0.5, 2);

    4)扭曲
        skew(x, y); skewX(); skewY();
        单位：角度deg
        skew()中只有一个值时，对应于skewX()
        skewX的作用为以Y轴为基准，正值为向逆时针方向扭曲。
        skewY的作用为以X轴为基准，正值为向顺时针方向扭曲。
        例子：
        -webkit-transform: skewX(30deg);
        -moz-transform: skewX(30deg);
        -ms-transform: skewX(30deg);
        -o-transform: skewX(30deg);
        transform: skewX(30deg);

    5)多重变形
        多个属性之间用空格隔开
        当变形出现两个或两个以上时，属性值写入的顺序会互相影响，例如当元素旋转时，它自身对应的坐标轴会进行旋转，从而影响平移的位置。
        例子：
        -webkit-transform: rotate(30deg) translate(100px, 100px);
        -moz-transform: rotate(30deg) translate(100px, 100px);
        -ms-transform: rotate(30deg) translate(100px, 100px);
        -o-transform: rotate(30deg) translate(100px, 100px);
        transform: rotate(30deg) translate(100px, 100px);
        -webkit-transform: translate(100px, 100px) rotate(30deg);
        -moz-transform: translate(100px, 100px) rotate(30deg);
        -ms-transform: translate(100px, 100px) rotate(30deg);
        -o-transform: translate(100px, 100px) rotate(30deg);
        transform: translate(100px, 100px) rotate(30deg);

b.二维变形与三维变形的区别
    坐标轴的不同
    声明当前变形方式的类型，需要写在父级，且只作用于父级的子级
    transform-style: preserve-3d;
    设置视角
    perspective: 300px;
    -webkit-perspective设置为0的时候，或者不写的时候，默认是无限远的距离。设置不同的视角大小，指的是视角距离物体的px值。
    将视角放置在不同的层上，也会有不同的效果。

```

![这里写图片描述](../../../../images/SouthEast123123asfa.png)

```
    1)旋转
        rotate3d(x, y, z, deg); rotateX(); rotateY(); rotateZ()
        rotate3d(x, y, z, deg); 中的x, y, z的值为0或1相当于旋转的开关，设置为1时，为开启其中某轴的旋转
        x轴旋转：旋转轴默认为元素的中心线，正值为元素的正面向上翻，负值为元素的正面向下翻
        y轴旋转：旋转轴默认为元素的中心线，正值为元素的正面向左翻，负值为元素的正面向下翻
        z轴旋转：旋转轴默认为元素的中心点向z方向延伸，正值为顺时针旋转，负值为逆时针旋转
        rotate3d和rotateX+Y的不同点
        transform: rotateX(360deg) rotateY(360deg); 先转动X轴再转动Y轴
        transform: rotate3d(1, 1, 0, 360deg);           同时转动X轴和Y轴
        例子：
        -webkit-transform: rotate3d(0, 1, 0, 30deg);
        -moz-transform: rotate3d(0, 1, 0, 30deg);
        -ms-transform: rotate3d(0, 1, 0, 30deg);
        -o-transform: rotate3d(0, 1, 0, 30deg);
        transform: rotate3d(0, 1, 0, 30deg);
    2)平移
        translate3d(x, y, z); translateX(); translateY(); translateZ();
    3)缩放
        scale3d(x, y, z); scaleX(), scaleY, scaleZ()
        scaleZ()方向的放大缩小设置基本无效，因为Z方向无法观察
    4)扭曲
        不存在三维的扭曲

```

2．CSS3过渡

```
a.浏览器支持程度

```

![这里写图片描述](../../../../images/SouthEastdasfasdfgsd.png)

```
b.拆分书写
    1)需要过渡的属性
        transition-property: 属性(如width);
    2)过渡的时间
        transition-duration: 2s;
    3)过渡的动画类型
        transition-timing-function: ease;
        属性值：
        linear;     线性
        ease;           逐渐变慢
        ease-in;        由慢到快
        ease-in-out;    由慢到快再到慢
    4)过渡的延迟时间
        transition-delay: 1s;

c.合写方式
    transition: 需要过渡的属性 过渡的时间 过渡的动画类型 过渡的延迟时间;
    transition:  transform 2s ease;
    属性值之间用空格隔开，没有的可以省略。
    若有多个属性需要过渡，可以用逗号隔开，分别设置属性。
    如果多个过渡的属性值都一样，可以property的值设置为all
    transition:  all 2s ease;

```

3．CSS3动画 —— 关键帧、动画特效

```
代码规范
父级中设置：
属性animation: 
animation的参数
    1)关键帧名 
    2)时间(2s) 
    3)ease 
    4)延迟(2s) 
    5)动画的循环次数(infinite无限循环，或设置次数(如3，即3次)) 
    6)定义动画的播放方向
    alternate动画播放在偶数次是向前播放，奇数次是反方向播放关键帧;



a.设置关键帧
设置关键帧的动作，中间的动作浏览器自己补齐
@keyframes 关键帧名{
    from {

    }
    to {

    }
}

例子
父级设置：
.box {
    position: relative;
    height: 200px;
    transform-style: preserve-3d;
    animation: change 10s linear infinite alternate;
}
设置关键帧
@keyframes change {
    from {
        transform: rotateX(0deg) rotateY(0deg);
    }
    to {
        transform: rotateX(360deg) rotateY(360deg);
    }
}
@keyframes change {
    0% {
        transform: rotateX(0deg) rotateY(0deg);
    }
    50% {
        transform: rotateX(360deg) rotateY(0deg);
    }
    100% {
        transform: rotateX(360deg) rotateY(360deg);
    }
}

b.过渡与动画的区别
    1)transition不能自行触发，通过hover或者结合JavaScript进行触发。animation可以自行运行。
    2)transition可控性相对较弱只能够指定起始状态和结束状态。animation可以定义多个关键帧
    3)animation多两个参数，可以进行循环次数的控制和动画方向的控制
        a)transition: 需要过渡的属性 过渡的时间 过渡的动画类型 过渡的延迟时间;
        transition: property duration timing-function delay;
        b)animation: 关键帧名 时间(2s) ease 延迟(2s) 动画的循环次数(infinite无限循环，或设置次数(如3，即3次)) 定义动画的播放方向
        animation: name duration timing-function delay iteration-count direction;
    4)animation结束之后会返回到初始的状态，transition不会执行返回初始状态，需要鼠标hover取消时，才会返回状态
```

####  CSS3提供的新单位

```
rem     针对html（根元素）的字体大小进行比例计算
rem * rem —— 部分设备不支持，横向rem解读有无
目前使用为：横向百分比、纵向rem
盒模型     盒模型：主要影响line-height、font-size

ch      字符0（零）的宽度
vw      viewport width 1vw = 视窗宽度的1%
vh      viewport height 1vh = 视窗宽度的1%
vmin    vw和vh中较小的那个
```

ref:1.[HTML5学习笔记 —— CSS开发入门](http://blog.csdn.net/chencl1986/article/details/71618484)