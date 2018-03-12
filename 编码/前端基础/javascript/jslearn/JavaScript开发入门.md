### JavaScript开发入门
***
##### 一、注意的规范

```
1．所有操作符左右需要空格
2．每个级别之间一个Tab格
3．代码结束之后需要英文分号;
4．除了需要输入文字之外，其他所有符号均使用英文
引号的使用，自我保持一致
```

##### 二、JavaScript引入方式

1．JavaScript引入方式分类

```
a.标签内联
b.内部书写
c.外部引入
```

2．JavaScript引入书写方式

```
a.标签内联
    <div class="wrap" onclick="alert('啊啊')"></div>

b.内部书写
    一般放在标签最后，即</body>的前面
        <script type="text/javascript">
            alert("啊啊");
    alert("我要\n换行");
    // 利用\n实现alert弹窗中换行。
        </script>
    JavaScript文件位置很重要，网页自上而下进行代码的运行。
    如果JavaScript放置在head标签当中，则会发生错误，如JavaScript效果因无法获取标签而无法运行。
    要解决此问题，则需要使用到widow.onload()事件。
    将JavaScript文件放置在所有标签后面</body>之前，能够保证网站的全部资源加载完成后再执行JavaScript的内容。

c.外部引入
    <script type="text/javascript" src="js/test.js" charset="UTF-8"></script>
    js文件中写入：
    alert("JS test");
    1)将type、src、charset等属性书写完整
    2)外部引入JavaScript的标签之间不允许有其他内容
    3)JavaScript文件位置很重要，网页自上而下进行代码的运行。
        如果JavaScript放置在head标签当中，则会发生错误，如JavaScript效果因无法获取标签而无法运行。
        要解决此问题，则需要使用到widow.onload()事件。
        将JavaScript文件放置在所有标签后面</body>之前，能够保证网站的全部资源加载完成后再执行JavaScript的内容。
    4)需要引入的JavaScript文件中，不要再出现<script></script>标签
```

3．JavaScript引入方式优先级

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
    2)没有很好的实现结构和JS的相分离

d.加载速度
    1)针对单页面，头部书写加载速度更快
    2)针对整站来说，外部引入加载速度更快
    3)外部引入有良好的使用了缓存机制
    4)外部引入有可能造成服务器的请求压力

e.引入方式选择依据
    代码量少 → 加载速度快 → 用户体验好
```

三、DOM操作 
1.DOM发展史

```
此处省略
```

2.DOM树 
![这里写图片描述](http://img.blog.csdn.net/20170511162928680?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

3.DOM主要节点

```
a.标签节点
b.属性节点
c.文本节点
```

4.节点的类型

```
使用nodeType判断节点类型

a.标签节点 —— 1
b.属性节点 —— 2
c.文本节点 —— 3
注意：在结构中输入的回车也会被认为是一个节点。
d.注释节点 —— 8
e.文档碎片 —— 11
```

5.DOM的节点操作

```
a.获取节点
带()的内容表示方法，如getElementById("demo")
    1)通过id名获取标签
        getElementById
        var demo = document.getElementById("demoId");

    2)通过类名获取标签
        getElementsByClassName
        var demo = document.getElementsByClassName("demoClassName");
        兼容性：谷歌、火狐支持、IE不支持
        兼容方法：
        类库封装
        http://www.h5course.com/a/2015042863.html

    3)通过标签名获取标签
        getElementsByTagName
        var demo = document.getElementsByTagName("div");

    4)通过属性获取标签
        <input type="text" name="ipt" value="获取标签">
        var iptEle = document.getElementsByName("ipt");
        兼容性：谷歌、火狐、IE都支持

    5)禁止直接用id名进行获取标签
        a)JavaScript变量名与id名重复的时候，部分浏览器会发生错误，特别是IE
        b)要防止id重复
        c)后期JavaScript代码不好维护
        d)id名与JavaScript属性名一样的时候会出现问题
            btn.onclick = function() {
                alert("我能弹出来嘛？");
            }
        // 可以弹出，但如果设定变量为var btn = 1;就会错误

b.获取节点类型
    // 获取outerEle的节点类型
    console.log(outerEle.nodeType);
    // 获取outerEle的所有子节点类型
    console.log(outerEle.childNodes);
    // 获取outerEle各个子节点的类型。
    console.log(outerEle.childNodes[0].nodeType);
    console.log(outerEle.childNodes[1].nodeType);
    console.log(outerEle.childNodes[2].nodeType);
    console.log(outerEle.childNodes[3].nodeType);

c.获取节点的名称
    // 获取outerEle的节点名称
    console.log(outerEle.nodeName);
    // 获取outerEle各个子节点的名称
    console.log(outerEle.childNodes[0].nodeName);
    console.log(outerEle.childNodes[1].nodeName);
    console.log(outerEle.childNodes[2].nodeName);
    console.log(outerEle.childNodes[3].nodeName);

d.针对节点本身的操作：增   删   改   查
    1)增加节点
        新增节点步骤：
        创建节点 —— 添加节点
        创建节点：
        创建标签节点
        document.createElement(标签名);
        创建文本节点
        document.createTextNode(文本内容);
            var newEle = document.createElement('h1');
            var newText = document.createTextNode('我是文本节点');
            console.log(newEle);
            console.log(newText);

        添加节点：

        appendChild()方法：
        parentNode.appendChild(node);
        appendChild方法添加的节点都在原有节点的最后一个。
        node是要添加的子节点
            // 将文本内容添加到新增标签中
            newEle.appendChild(newText);
            console.log(newEle);
            // 将新增标签添加到DOM树的outerEle节点中
            outerEle.appendChild(newEle);

        insertBefore()方法：
        parentNode.insertBefore(newNode, existingNode);
            // 将新增节点增加到原有outerEle节点中的innerEle标签之前
            outerEle.insertBefore(newEle, innerEle);

        appendChild()方法和insertBefore()方法都是对id的操作，只能操作一次，最后的操作会覆盖之前的所有操作。

    2)删除节点
        parentNode.removeChild(node);
        node是需要删除的节点
        删除parentNode的子节点中，指定的node节点及其包含的所有子节点，但该方法不能用来删除parentNode孙节点。
            // 删除outerEle节点中的innerEle节点，以及innerEle中的所有节点
            outerEle.removeChild(innerEle);

        删除所有子节点的方法：
        因在使用for循环删除所有子节点时，每删除一个子节点，子节点的数量就会边少。
        如果采用i++的方法进行操作，则会导致子节点的编号增加后，原本大编号的子节点因为节点数量减少，编号跟着减小而无法被找到。
        所以要使用i--的方式进行删除。
```

```
<body>
  <ul id="parentUl">
      <li>
        <a href="#">
          <img src="logo.png" alt="" title="">
        </a>
      </li>
      <li>
        <a href="#">
          <img src="logo.png" alt="" title="">
        </a>
      </li>
      <li>
        <a href="#">
          <img src="logo.png" alt="" title="">
        </a>
      </li>
  </ul>
  <script>
    var parent = document.getElementById('parentUl');
    var child = parent.childNodes;
    var len = child.length;

    parent.onclick = function() {
      for (var i = len - 1; i >= 0; i--) {
        console.log(i);
        console.log(parent.childNodes[i]);
        parent.removeChild(parent.childNodes[i]);
        console.log(parent.childNodes);
      }
    }
```

```
    3)替换节点
        parentNode.replaceChild(newNode, oldNode);
        将parentNode中的oldNode用newNode来进行替换，但该方法不能用来替换parentNode孙节点。
            outerEle.replaceChild(newEle, innerEle);

    4)查找节点
        节点关系：

        childNodes：所有子节点，包括所有类型
        console.log(outerEle.childNodes);

        children：所有是标签类型的子节点
        使用children属性获取子集，只可获取子集内的所有元素，而不可制定某种元素如div
        如：var boxChi = boxEle.children;
        console.log(outerEle.children);

        parentNode：父节点
            parentNode只是查找父级，与定位无关，只和DOM树结构有关
            console.log(innerEle.parentNode);

        offsetParent：获取一个元素用来定位的父级
            console.log(innerEle.offsetParent);
            参考的是有设置position定位（ position: relative;和position: absolute;都可以）的上一级（可能是父级，也可能是祖级等等）。
            如果没有设置定位，则参考body（实际指的是文档）。

        firstChild / firstElementChild：第一个子节点
        lastChild / lastElementChild：最后一个子节点
        nextSibling / nextElementSibling：下一个兄弟节点
        previousSibling / previousElementSibling：上一个兄弟节点
        注意：firstElementChild等查找标签节点的方法，只能IE9+支持，IE8-只能利用nextSibling +nodeType进行封装库函数进行查找。
            // 输出的是最后一个节点，无论节点类型。
            console.log(outerEle.lastChild);
            // 输出的是最后一个标签节点
            console.log(outerEle.lastElementChild);

    5)复制（克隆）节点
        node.cloneNode(deep);
        deep为布尔值，
        true：深复制：复制节点包含其后代的所有各类节点
        false：浅复制：只复制本身，不包含其中的所有内容，例如文本节点
        IE6~8会复制事件处理程序（用attachEvent绑定方法）
        解决办法：先移除事件再克隆

e.针对节点属性的操作
    1)样式
    a)获取标签样式的方法
```

<http://www.h5course.com/a/20150503117.html>

```
        function getStyle(eleObj, property) {
            var proVal = 0;
            // 因在火狐中有时用window.getComputedStyle获取不到样式，所以该为document.defaultView
            if (document.defaultView) {
                // 属性的两种写法
                proVal = document.defaultView.getComputedStyle(eleObj)[property];
                // proVal = document.defaultView.getComputedStyle(eleObj).property;
                // .property无效，因传进的参数是字符串，字符串和eleObj对象无关，所以无法使用。但.width的方法是可以使用的
            } else {
                proVal = eleObj.currentStyle[property];
                // proVal = eleObj.currentStyle.property;
            }
            // 函数的返回值
            return proVal;
        }
```

```
    b)通过style属性的样式属性操作

        changeDiv.style.width = "400px";

    c)通过style属性的cssText属性操作
        boxEle.style.cssText = "width: 200px;height: 200px;background-color: pink;"
```

<http://www.h5course.com/a/20151107308.html>

```
    d)通过类名操作
        changeDiv.className = "big";
        HTML5-类库制作 类名的各种操作
```

<http://www.h5course.com/a/2015042979.html>

```
    2)属性
        设置：ele.setAttribute(name, value);
        获取：ele.getAttribute(name);
        谷歌及IE8+获取类名alert(outerEle.getAttribute('class'));
        IE6、7获取类名alert(outerEle.getAttribute('className')); // IE6中认为className才对应类名
        移除：ele.removeAttribute(name);

    3)内容
        a)表单元素
            value
            value通常是表单元素的属性，可以进行获取和设置
            获取：console.log(firstVal.value);
            设置：sumResult.value= parseInt(firstVal.value) + parseInt(secondVal.value);
        b)标签元素
            innerHTML：设置或获取位于对象开始和结束标签内的HTML
            即获取<em id="result">200</em>标签内部的内容“200”
            console.log(sumResult.innerHTML); —— 获取
            console.log(sumResult.innerHTML = 600); —— 设置

            outerHTML：设置或获取对象（本身）及其内容的HTML形式
            innerText：设置或获取位于对象开始和结束标签内的文本
            outerText：设置（包含标签本身）或获取（不包括标签）对象的文本
```

![这里写图片描述](http://img.blog.csdn.net/20170511163628721?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

```
            兼容：FF不支持innerText和outerText
            区别：在IE6~8 innerHTML和outerHTML获取到的标签均为大写形式（无缩进）
              IE9+、谷歌、FF会将内容原样输出（包含空格、缩进）返回HTML。
              innerText与outerText获取的时候无区别，设置的时候，outerText不仅仅能够替换元素的子节点，还会替换整个元素（节点本身）。

<div class="wrap" id="box">
    123
    <div>456</div>
</div>
    // 这个目的是测试innerHTML获取谁的什么内容？
    // alert(boxEle.innerHTML);
    // console.log(boxEle.innerHTML);
    // // 这个目的是测试innerHTML给谁设置内容？
    // boxEle.innerHTML = "内容";

    // alert(boxEle.outerHTML);
    // console.log(boxEle.outerHTML);
    // boxEle.outerHTML = "内容";

    // alert(boxEle.innerText);
    // console.log(boxEle.innerText);
    // boxEle.innerText = "内容";

    // alert(boxEle.outerText);
    // console.log(boxEle.outerText);
    // boxEle.outerText = "内容";
```

![这里写图片描述](http://img.blog.csdn.net/20170511163850018?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvY2hlbmNsMTk4Ng==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

##### 四、详解

1.事件的种类

```
a.一般事件
    鼠标、键盘相关
b.表单事件
    表单相关
c.页面事件
    与页面有关的事件
    举例：
    load事件
    onload网站资源全部下载完成后才出发执行
    1)防止JavaScript无法正常获取标签
    2)防止JavaScript阻塞页面的渲染
    window.onload = function() {
        var test = document.getElementById("box");
        console.log(test);
    }   
    3)load事件下定义的变量、函数等，都属于window.onload事件，而不属于全局
    JavaScript文件位置很重要，网页自上而下进行代码的运行。
    如果JavaScript放置在head标签当中，则会发生错误，如JavaScript效果因无法获取标签而无法运行。
    要解决此问题，则需要使用到widow.onload()事件。
    将JavaScript文件放置在所有标签后面</body>之前，能够保证加载完html结构后再执行JavaScript的内容。
```

2.DOM0级事件

```
a.DOM0级事件绑定方法
    1)方法一
        对象.on事件类型 = function() {
        // 里面书写功能代码
        }
        sumBtn.onclick = function() {
            alert("111");
        }
    2)方法二
        对象.on事件类型 = 方法名;
        sumBtv.onclick = showResult;
        function showResult() {
            alert("222");
        }

b.DOM0级事件特点
    1)书写简单、阅读简单
    2)遵循冒泡的运行机制
    3)兼容性好
    4)绑定多个同种事件类型时，最后的一个会覆盖之前的事件
    5)为同一个对象绑定多个不同事件类型，不会发生覆盖，但有可能会同时触发，如单击事件和双击事件。
    6)IE中默认在window.even下，需要处理兼容。

    测试阻止冒泡是否对DOM0也有用
```

3.DOM2级事件绑定

```
a.事件绑定
    1)eleObj.addEventListener（事件类型，函数名或者匿名函数，true/false）
        第三个参数：true代表捕获，false代表冒泡
        兼容：IE9+、FF
    2)eleObj.attachEvent(on+事件类型, 函数名/匿名函数);
        IE10-可以兼容、仅IE11不支持
    3)attachEvent方法的this指向问题
        attachEvent方法无论在何时何地被调用，他所指向的对象都是window
        test.attachEvent('onclick', show);
        function show(){
            console.log(this);
        }
        // 输出[object] window
    4)更改attachEvent方法的this指向
        利用call方法修改this指向由window改为触发事件的对象
        function addEvent(ele, eventType, handler) {
            if (ele.addEventListener) {
                ele.addEventListener(eventType, handler, false);
            } else if (ele.attachEvent) {
                ele.attachEvent("on" + eventType, function() {
                    // 修改指向
                    handler.call(ele);
                    return handler;
                });
            }
        }

b.事件移除
    1)eleObj.removeEventListener（事件类型，函数名或者匿名函数，true/false）
        第三个参数：true代表捕获，false代表冒泡
        兼容：IE9+、FF

    2)eleObj.detachEvent(on+事件类型, 函数名/匿名函数);
        IE10-可以兼容、仅IE11不支持

    3)总结：如果addEventListener、attachEvent绑定的事件处理函数是匿名函数，则事件无法移除。
        移除事件方法中的参数值与绑定事件方法中的参数值必须保持一致，否则无法移除事件。
        如下：
        outerEle.addEventListener('click', function() {
            conEle.innerHTML += 1;
            outerEle.removeEventListener('click', function() {

            }, false);
        }, false);
        此时需要使用函数名进行移除，如下：
        outerEle.addEventListener('click', function show() {
        // 此方法等同于使用匿名函数，不建议使用，会出现无法清除的情况
            conEle.innerHTML += 1;
            outerEle.removeEventListener('click', show, false);
        }, false);

        // 使用如下方法
        function showInfo() {
            alert(1);
            outerEle.removeEventListener('click', showInfo, false);
        }
        outerEle.addEventListener('click', showInfo, false);

c.事件流
    从页面中接收事件的顺序

    1)事件冒泡
        从最内层的标签事件往外逐步执行，直到执行到document事件
        如果某层标签不存在事件，则跳过。
        若不存在事件的层级为触发的层级，则执行外层的事件。
        注意：IE9+、FF将事件一直冒泡到window对象
        兼容：IE9+、FF兼容，执行到window
              IE8-兼容，只执行到document，不会执行window
        DOM0支持冒泡。

    2)事件捕获
        从window对象的事件，逐步向内层标签执行，最后执行点击的最内层的标签的事件。
        如果某层标签不存在事件，则跳过。
        若不存在事件的层级为触发的层级，则执行外层的事件。
        兼容：IE9+、FF
          IE8-不兼容

    3)DOM2级规范是从document开始接收事件，但事实上很多浏览器未按照此规范进行。

d.事件对象
    ele.onclick = function(e) {

    }
    事件对象存储与事件有关的所有信息，若要实现对标签的操作，需要获取标签，而事件目标对象不需要获取。
    在IE8-，用DOM0级绑定的事件方法，认为事件对象是在window.event下，导致通过e参数获取到事件对象

e.事件目标对象
    IE：e.srcElement
    document.attachEvent('onclick', function(e) {
        console.log(e.srcElement);
    });
    FF：e.target
    document.addEventListener('click', function(e) {
        console.log(e.target);
    }, false);

f.阻止默认事件
    IE：e.returnValue = false;
    FF：e.preventDefault();
    如下代码会阻止a标签的链接跳转
```

```
    <body>
        <a href="http://www.h5course.com/"class="outer-box" id="outerBox">

        </a>
        <script type="text/javascript">
            var outerEle = document.getElementById('outerBox');
            var innerEle = document.getElementById('innerBox');
            var conEle = document.getElementById('con');

            outerEle.addEventListener('click', function(e) {
               e.preventDefault();
            }, false);
        </script>
    </body>
```

```
g.阻止事件冒泡
    IE：e.cancelBubble = true;
    FF：e.stopPropagation();
    表示执行到当前冒泡代码，下一段冒泡代码不执行。
    如果e.stopPropagation();放在document中时，冒泡不执行document，但会执行window。
    如果e.stopPropagation();放在window中时，window不执行，其他会执行。
    如下代码outerEle会弹出，document和window被阻止
    window.addEventListener('click', function() {
        alert('window');                        
    }, false);

    document.addEventListener('click', function() {
        alert('第零个');
    }, false);

    outerEle.addEventListener('click', function(e) {
        e.stopPropagation();
        alert('第一个');
    }, false);

    innerEle.addEventListener('click', function() {
        alert('第二个');            
    }, false);

    conEle.addEventListener('click', function() {
        alert('第三个');            
    }, false);

h.事件委托
    原理：事件绑定到父级（祖父、document也行，只要能接收到事件就行）。
    利用冒泡的原理，当事件接收到父级的时候，检测目标对象（target/srcElement）。
    判断点击的是不是你想要的目标，如果是执行相应的操作。
    注意：事件委托只能同一类型事件。
    var outerEle = document.getElementById('outerBox');
    // 1. 父级绑定事件
    outerEle.addEventListener('click', function(e) {
        // 2. 检测目标对象是否是你想要的
        if (e.target.className == "bg") {
            // 3. 执行相应的操作
            e.target.style.backgroundColor = 'red';
        }
        console.log(e.target.nodeName);
        // 2. 检测目标对象是否是你想要的
        if (e.target.nodeName == "P") {
            // 3. 执行相应的操作
            e.target.style.backgroundColor = 'red';
        }
    }, false);
    优势：
    1)大大减少了事件处理程序的数量，在页面中设置事件处理程序的时间就更少了
        （DOM引用减少——也就是我们通过id去获取标签，所需要的查找操作以及DOM引用也就更少了）。
    2)document（注：最为推荐的是绑定在document上）对象可以很快的访问到。
        而且可以在页面生命周期的任何时点上为它添加事件处理程序，并不需要等待DOMContentLoaded或者load事件。
        换句话说，只要可单击的元素在页面中呈现出来了，那么它就立刻具备了相应的功能。
        2.1 绑定方面：
        如果存在绑定document和父级的情况，在绑定的时候，document在网页加载的时候就会直接绑定事件。
        绑定父级的话，需要等父级加载完成之后才可以进行绑定操作，所以绑定的时间会比document慢。
        任意时间就可以触发。
        2.2 事件的触发（参考）：
        事件的触发时，如果事件绑定在document上。
        同时从点击的对象以上的各级中，未绑定同样事件的时候，事件的就直接冒泡到document，中间的各级都不需要触发事件。
        如果绑定在父级上，事件冒泡时，同样遵循一直冒泡到document。
        但是在冒泡的过程中，父级会触发事件，触发的过程会造成事件的运行，消耗一定的时间。
        所以绑定在document运行时会较快。
    3)整个页面占用的内存空间会更少，从而提升了整体的性能。

i.兼容库书写
    1)事件绑定
    2)事件移除
    3)事件目标对象
    4)阻止默认事件
    5)阻止事件冒泡
```

- 五、函数

1．函数的概念

```
函数的封装：代码量、性能、维护性、可阅读性强
函数用来封装一段可执行代码，可以同时在不同地方进行调用，减少相同代码重复书写，减少代码量，提高运行性能。
维护性好，只需要更改函数内部代码，即可实现功能的转换。
函数单独封装后，与其他代码分离，提高阅读性。
```

2．函数的定义语法

```
function 函数名() {
// 功能代码
return 返回值
}
举例
// 实现两个数之间的和
function sum(start, end) {
    var sum = 0;
    for (var i = start; i <= end; i++) {
        sum += i;
    };
    return sum;
}
console.log(sum(1, 100));
console.log(sum(10, 1000));
console.log(sum(100, 10000));
```

3．形参、实参的概念和区别

```
实参是具有实际意义，是一个实际的值。

形参不具有实际意义，其值在函数调用时再传入，传递参数时形参与实参一一对应（推荐）。
若函数的形参名和内部定义的变量名相同时，在定义的变量没有被赋值之前，该变量的值由形参传入，赋值之后，改为被赋值的新值。

函数没有对应实参时，默认返回值为undefined。
```

```
// 函数的调用/执行：函数名(实参)；
function sum() {
    var a = 10;
    var b = 20;
    // console.log(a + b);
    // 函数返回值
    return a + b;
}
// 函数的调用/执行：函数名(形参)；
function sum(first, second) {
    return first + second;
}
console.log(sum(20, 40));
```

4．arguments

```
a.arguments是什么
    arguments是在函数内部以一个类似数组的形式来存储参数的东西，而这个“东西”是对象，不是数组~
    函数在被调用时，传递进去的参数被保存在arguments对象中（再次强调：类似数组的方式），arguments的长度取决于传进函数的参数个数。
    如果传进的参数少于函数定义接收的个数，那么后面的参数视为未定义（即假设函数接收3个参数，如果只传进2个，那么第3个参数值视为undefined）。
    如果传进的参数大于函数定义接收的个数，多出来的参数值也会被保存在arguments中，只是在函数执行时，多出来的参数不会被使用。

b.arguments的存储规则
    1)arguments在函数实参传入时进行创建，此时传入的参数定义了arguments的初始长度。
        形参和arguments的一一对应关系在此时建立，之后不可更改。
        但形参与arguments的值可以在函数中使用arguments[i] = j;的方式进行添加和修改。
```

```
    function show (a, b) {
        arguments[2] = 3;
        arguments[3] = 4;
        console.log(arguments);
    }show(1, 2);
    // 输出[1, 2, 2: 3, 3: 4]
```

```
    2)函数传入实参多余定义的形参时，则顺位存储在arguments中，可被输出。

```

```
    function show (a, b) {
        console.log(arguments);
    }show(1, 2, 3);
    // 输出 [1, 2, 3]
```

```
    3)函数传入的实参少于定义的形参时，已传入的参数存储在arguments中，同时将已传参的形参和arguments的值一一对应。
        未传参的形参不再和arguments一一对应，即再次定义或修改形参的值时，相当于在函数内部另外开辟一个空间存储形参。
        而新增加的arguments值，即使其位置与未传参的形参相同，也不再影响未传参形参的值。
```

```
        function show (a, b, c) {
            console.log(a);
            console.log(b);
            console.log(c);
            console.log(arguments[0]);
            console.log(arguments[1]);
            console.log(arguments[2]);
            a = 1;
            b = 2;
            c = 3;
        // 运行以上三个赋值语句时，输出11, 22, undefined, 11, 22, undefined, 1, 2, 3, 1, 2, undefined
            // arguments[0] = 1;
            // arguments[1] = 2;
            // arguments[2] = 3;
        // 运行以上三个赋值语句时，输出11, 22, undefined, 11, 22, undefined, 1, 2, undefined, 1, 2, 3
            console.log(a);
            console.log(b);
            console.log(c);
            console.log(arguments[0]);
            console.log(arguments[1]);
            console.log(arguments[2]);
        }show(11, 22);
```

```
c.arguments.callee
    arguments.callee是arguments的属性，表示对函数本身的引用（可以理解为代表的是函数名或函数的地址）。
    可用于递归调用，防止函数名变动后由于递归调用时的函数名未手动变更造成错误。
```

```
    function show () {
        console.log(arguments.callee);
        arguments.callee();
    }show();


    // 无限循环输出
    // function show () {
    //  console.log(arguments.callee);
    //  arguments.callee();
    // }show();

    d.arguments.callee.caller或函数名.caller
    .caller属性将返回引用当前函数的函数
    注意：
    1).caller属性只有在应用当前函数的函数被调用时才有效
    2)如果当前函数未被其他函数调用时，默认为被最顶层即window调用，则.caller输出null

    function parent () {
        child();
    }
    function child () {
        console.log(arguments.callee.caller);
    }
    child();        // 当执行child();时，输出null
    // parent();    // 当执行parent();时，输出function parent () {
        child();
    }
```

5．函数的调用/执行

```
a.函数名后加()即表示调用该函数。
b.将函数赋值给变量的方法为，直接将函数名赋值给变量，函数名之后不能加()。若加()则表示将函数运行后的结果赋值给变量
c.函数的未书写return时，默认返回值为undefined
d.函数在使用 return 语句时，函数会停止执行，并返回指定的值。
e.函数的return语句后，若是一个赋值语句，会在赋值之后，同时将所赋的值做为函数运行的结果返回给函数
f.实参是具有实际意义，是一个实际的值。
g.形参不具有实际意义，其值在函数调用时再传入，传递参数时形参与实参一一对应（推荐）。
h.函数没有对应实参时，默认返回值为undefined。
i.arguments访问的是实际参数，对实参或arguments的修改都会同步反映到两者身上，但能arguments访问的前提是实参必须先被定义
```

```
// 函数名加括号()时，表示调用函数，未加()时，表示函数本身。
function a() {
    n = n + 1;
}
var y = a;          // 表示将函数a赋值给变量y，函数并不进行调用运行
console.log(y); 输出函数
var y = a();        // 表示调用运行a函数，并把a函数的结果赋值给y
console.log(y); 因函数没有返回值，默认返回值undefined，故输出undefined12345678
```

```
// 函数的调用/执行：函数名(实参)；
function sum() {
    var a = 10;
    var b = 20;
    // console.log(a + b);
    // 函数返回值
    return a + b;
}
console.log(sum());
// 函数的调用/执行：函数名(形参)；
function sum(first, second) {
    return first + second;
}
console.log(sum(20, 40));
```

```
// 使用 return 语句时，函数会停止执行，并返回指定的值
function outer(num) {
    num++;
    console.log(num);
    return function() {
        num++;
        console.log(num);
    }
    num++;              // 不执行
    console.log(num);       // 不执行
}
var result1 = outer(0);     // 输出1
result1();                  // 输出2
result1();                  // 输出3
var result2 = outer(1);     // 输出2
result2();                  // 输出3
result2();                  // 输出4
```

```
// 匿名函数
// 可用来解决命名冲突
var year = 2016;
(function() {
    var year = 2015;
    console.log(year);
})();
console.log(year)
```

```
// 非匿名函数也可以解决命名冲突
var year = 2016;
function show() {
    var year = 2015;
    console.log(year);
} show();
console.log(year)
```

6．作用域

```
a.作用域分类
    1)全局作用域：在window下属于全局作用域
    2)局部作用域：每个函数，均会创建一个局部作用域
b.不同作用域的访问关系：
    函数外部不能访问函数外部
    var year = 2016;
    function show() {
        var year = 2015;
        console.log(year);
    } show();
    console.log(year)
    输出：
    2015
    2016
```

7．编译

```
a.预编译期：进行空间的创建（var和function才会创建空间）

b.执行期：用于空间的赋值，顺序从上到下

c.多个作用域形成作用域链
    在局部作用域当中出现变量的时候，首先查找当前的作用域是否具有存储空间（开辟空间）。
    如果有则直接采用，如果没有则需要向父级进行查找，如果父级没有则继续往上查找，知道找到window下为止。
    如果window下也不存在该存储空间，会在全局作用域下进行空间的创建。而这种作用域层层的关系，成为作用域链。

d.函数的编译执行规则
1)同名的函数所创建的空间即函数本身会发生覆盖，后创建的函数覆盖之前的函数
2)若是匿名函数被调用多次，其所开辟的空间互相之间相互独立，相互之间不影响
```

```
    (function() {
        var a = 1;
        function inner() {
            a += 1;
            console.log(a);
        }inner();
    })();
    // 输出2
    (function() {
        var a = 1;
        function inner() {
            a += 1;
            console.log(a);
        }inner();
    })();
    // 输出2
    (function() {
        var a = 1;
        function inner() {
            a += 1;
            console.log(a);
        }inner();
    })();
    // 输出2123456789101112131415161718192021222324
```

```
    3)同一个函数被赋值给不同变量时，各变量所代表的都是单独的函数，各自之间开辟的空间互相不受影响
        匿名函数也具有相同性质，一旦被赋值给某个变量，在被调用时，就会在该变量下开辟固定的空间来存放变量。
```

```
        function outer() {
            var a = 1;
            return function inner() {
                a += 1;
                console.log(a);
            }
        }
        var f1 = outer();
        f1();           // 输出2
        f1();           // 输出3
        var f2 = outer();
        f2();           // 输出2
        f2();           // 输出3

        function outer() {
            var a = 1;
            return function() {
                a += 1;
                console.log(a);
            }
        }
        var f1 = outer();
        f1();           // 输出2
        f1();           // 输出3
        var f2 = outer();
        f2();           // 输出2
        f2();           // 输出3

        var f1 = (function() {
            var a = 1;
            return function() {
                a += 1;
                console.log(a);
            }
        })();
        f1();           // 输出2
        f1();           // 输出3
        var f2 = (function() {
            var a = 1;
            return function() {
                a += 1;
                console.log(a);
            }
        })();
        f2();           // 输出2
        f2();           // 输出312345678910111213141516171819202122232425262728293031323334353637383940414243444546
```

```
    4)若函数的形参名和内部定义的变量名相同时，在定义的变量没有被赋值之前，该变量的值由形参传入，赋值之后，改为被赋值的新值。

```

```
    // 例子
    var a = 100;
    function show (a) {
        console.log(a);
        a++;
        console.log(a);
        var a = 10;
        console.log(a);
        var a = a++ + 20;
        console.log(a);
        a = ++a + 20;
        console.log(a);
    }show(600)
    600 601 10 30 51

    // 例子变化
    var a = 100;
    function show (a) {
        console.log(a);
        a++;
        console.log(a);
        var a = 10;
        console.log(a);
        a = a++;
        console.log(a);
        var a = a + a++ + a + 20;
        console.log(a);
        a = ++a + 20;
        console.log(a);
    }show(600);
    console.log(a);
    600 601 10 10 51 72 1001234567891011121314151617181920212223242526272829303132
```

```
    5)全局变量只有赋值语句才可以定义，包括连续赋值的语句。
        单独用一个a;的语句是无法定义出undefined的全局变量的，此时浏览器会报错。
        因为只有赋值语句才会触发向上查找该变量的存储空间，若未查找到，才会开辟空间，而a;语句没有赋值，所以不会触发查找。
```

```
        function outer() {
            function inner() {
                a;
                console.log(a);
            }inner();
        }outer();
        // 报错

        (function() {
            var a = b = 5;                  // b变量被赋值语句定义为全局变量
            console.log(a);                 // 输出5
            console.log(typeof(a));         // 输出number
            console.log(b);             // 输出5
            console.log(typeof(b));         // 输出number
        })();
        // console.log(a);                  // 无法输出a，因a是函数中的变量，在全局中未定义，输出则会报错
        console.log(typeof(a));             // 输出undefined
        console.log(b);                 // 输出5
        console.log(typeof(b));             // 输出number12345678910111213141516171819
```

```
    6)全局变量的调用语句只有在全局变量定义的语句之后才有效，如果在定义语句之前，则会报错。
        因为变量在被赋值的时候才开始向上查找该变量的值，若未在父级查找到，才会在全局作用域上开辟空间。
        在赋值语句运行之前是不会开辟空间的，所以变量在被调用时，无法查找到空间，即会报错

```

```
        function outer() {
            console.log(a);
            function inner() {
                a = "内容";
                console.log(a);
            }inner();
        }outer();
        // 报错，a未定义12345678
```

```
    7)对于同一变量名，同时存在局部变量和全局变量，或者局部变量和父函数的局部变量时。
        无论调用局部变量是在定义之前还是之后，都只会查找局部变量。

```

```
    function outer() {
        a = "内容1";
        function inner() {
            console.log(a);
            var a = "内容2";
            console.log(a);
        }inner();
    }outer();
    console.log(a);

    // 输出undefined 内容2 内容11234567891011
```

```
8)预编译期创建空间时，不会对变量进行赋值操作，此时变量的值为undefined，赋值是在函数被调用执行的时候才会进行。
如果调用函数时，函数内部在定义变量的语句之前调用变量，则此变量的值为undefined。

```

```
    function outer() {
        var a = "内容1";
        function inner() {
            console.log(a);
            var a = "内容2";
            console.log(a);
        }inner();
    }outer();

    // 输出undefined 内容212345678910
```

```
    9)在定义变量之前的语句调用该变量时，变量的值虽然是undefined，但也是可以参与运算，只是将undefined的值当做一个字符串参与计算。
```

```
    var a = "HTML5";
    b = "你好";
    Test();
    function Test() {
        console.log(a + " " + b);
        var a = "welcome";
        var b = "h5";
        console.log(a + " " + b);
    }
    console.log(a + " " + b);

    // 输出undefined undefined
    // 输出welcome h5
    // 输出HTML5 你好1234567891011121314
```

```
    10)函数如果在其内部调用外部函数时，外部函数所开辟的空间，即外部函数内部的变量，与调用的函数空间无关，只与外部函数的空间相关。
        即两个单独开辟空间的函数，无论如何调用，都不影响它们的空间之间的关系。
        函数的空间值在预编译期被开辟，与执行期（调用的过程）无关。
```

```
        var name = "a";
        function first() {
            alert(name);
        }
        function second() {
            var name = "b";
            first();
        }
        second();
        // 输出a12345678910
```

```
    11)函数如果调用其内部函数或兄弟函数中的变量时，会因查找不到该变量而认为该变量为未定义，造成报错
```

```
        function outer() {
            var a = 2;
        }outer();
        function show() {
            var b = 0;
            b += a;
            function inner() {
                var a = 1;
            }inner();
            console.log(b);
        }show();
        // 报错a未定义123456789101112
```

##### 六、调试

1．调试方法分类

```
a.注释方式
b.弹窗命令
c.控制台
d.文档命令
```

2．调试方法详解

```
a.注释方式
    1)单行注释
        // 空格书写注释内容
        // alert("JS test");
        单行注释不可换行
    2)多行注释（块注释）（函数功能的注释）
        注释规范：
        多行注释可以换行
```

```
        <script type="text/javascript">
            /*
             * [sum 求和的功能]
             * @param {[数字]} a [第一个数字]
             * @param {[数字]} b [第二个数字]
             * @return {[数字]}  [求和的结果]
             * sum(1, 100) 使用范例
             * 作者：陈立
             * 时间：2015.12.30
             */
            function sum(a, b) {
                return a + b;
            }
        </script>使用范围：1234567891011121314
```

```
        针对文件/函数的功能以及用法进行描述的时候用块注释，其他情况下一般使用单行注释。
b.弹窗命令
    弹窗命令种类：alert、confirm、prompt
        alert("警告弹窗");
        confirm("确认弹窗");
        prompt("对话弹窗");
```

```
        <script type="text/javascript">
            alert("警告弹窗");
            confirm("确认弹窗");
            prompt("对话弹窗");
        </script>
```

```
    注意：此方法不常用。
c.控制台调试
    1)  谷歌控制台
        a)查看谷歌控制台（console）的提示信息
        b)控制台输出命令
```

```
        <script type="text/javascript">
            console.log("你好");
        </script>123
```

```
            注意：此方法常用
        c)测试JavaScript代码的执行时间，timeName需要保持
            兼容：IE8+支持
            命令：
            console.time(timeName);
                console.timeEnd(timeEnd);
            例子：
```

```
            console.time('test');
            for (var i = 0; i < 100; i++) {
                for ( var j = 0; j < 100; j++) {
                    console.log(i * j);
                }
            }
            console.timeEnd('test');1234567
    2)firebug
    3)IE Developer Tools
d.文档命令
    document.write();
    document.writeln();
例子：
    document.write("<p>啊啊</p>");
    document.writeln("哦哦");
    document.writeln("哦哦<br />");
    document.writeln("<pre>啦啦</pre>");
    // pre元素可以定义预格式的文本（原样输出）
    含义：document是文档对象，write是方法/功能
    对象：方法的调试调用write功能
    区别：write与writeln方法类似，只是writeln每个表达式之后会多写一个换行符号（\n属于转义字符，含义就是换行。
    但需要用<pre></pre>才会运行\n）。
    注意：面试要能写，因会在网页中显示内容，影响排版，故不常用。

e.使用高级计时器计算代码运行时间
```

`// 计算代码运行时间方法 var time1 = new Date(); // 需要计算运行时间的代码 var time2 = new Date(); var difference = time1.getTime() - time2.getTime(); console.log(difference); `

ref：1.[HTML5学习笔记 —— JavaScript开发入门](http://blog.csdn.net/chencl1986/article/details/71644465)