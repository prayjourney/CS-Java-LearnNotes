### 一篇文章读懂Java Web的框架标签

---

在Java Web应用开发时，如果不是前后端分离进行数据交互的实现，一般都会通过JSP、FreeMarker、Velocity之类的技术进行页面的渲染。而在页面的渲染过程中，很多时候会使用到标签(taglib)这个技术。

在Java Web应用开发时，如果不是前后端分离进行数据交互的实现，一般都会通过JSP、FreeMarker、Velocity之类的技术进行页面的渲染。而在页面的渲染过程中，很多时候会使用到标签(taglib)这个技术。

比如为了控制页面一些显示逻辑，实现类似代码里if/else这种效果，就会使用到core标签里的内容，类似这样：

![tag1](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag1.jpg)

要实现一个容器数据的遍历，可以直接使用core标签的foreach。

![tag2](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag2.jpg)

要实现页面上数据的格式化，则可以直接使用format标签，进行对应数据的格式化展现。

甚至在一些MVC框架中，也都包含一些便捷的用于页面数据渲染的标签，可以直接使用。例如Spring中的form标签就可以直接进行数据的绑定。

那这些标签背后是如何工作的呢?

之前的文章里有写过JSP的工作原理，概括起来，就是会在执行时将JSP生成Servlet文件，然后再执行对应的service方法，进行请求的处理。其中涉及到使用标签的部分也会生成对应的执行逻辑。

而实际上，一个tag，对应的是一个Java类，根据规范实现相应的方法。由JSP生成的Servlet在执行标签的过程中，会直接调用标签对应类的指定方法，根据返回值，来进行页面上对应内容的输出。如果是继续则输出内容，如果是跳过内容就会被忽略。基本就是这样一个思路。

例如本文前面的 if 标签，对应生成的Servlet内容是这样的：

![tag3](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag3.jpg)

再看 foreach 这个标签，生成的内容是这样的：

![tag4](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag4.jpg)

我们看到，foreach 被直接转换成了do while 循环。

其中，最核心的两个方法是：

- doStartTag
- doEndTag

**doStartTag**

该方法会在JSP类内，被具体的标签实现类调用。用于实例的标签开始，执行时pageContext和一系列属性被认为已经设置完成。

会返回EVAL_BODY_INCLUDE或者SKIP_BODY，从这两个结果的变量名称可以看出，如果如果tag期望继续处理body，就返回前者，否则不处理就返回后者。

doEndTag用于确认该标签执行后，页面是否要继续渲染。

整个taglib使用起来都比较便捷，直接在JSP中声明 prefix 和 uri ，相当于把这部分内容依赖添加了进来，然后直接使用标签进行属性的设置，对应命名空间下标签的使用等。

而这些标签的声明，是通过类似这样的形式，被保存在Jar文件或者WEB-INF这些地方。

![tag5](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag5.jpg)

具体的标签实现类，一般继承TagSupport，然后重写我们上面提到的doStartTag 和 doEndTag 方法。

所以，对于一般在JSP页面内有大堆的 <% %>这种所谓的 scriptlet，可以直接定义一个标签，然后把逻辑移动到重写方法内即可。

这些Tag声明的tld，一般会在应用部署后启动时进行扫描，然后添加到Map里。

![tag6](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag6.jpg)

页面解析执行的时候，会判断对应声明的tld是否存在，没有就会停止页面执行。

![tag7](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag7.jpg)

页面解析生成Servlet类之后，执行时会调用具体标签的属性设置，doStartTag这些方法，此时如果一些属性不存在，绑定不成功等这些具体的标签逻辑会被暴露出来。

比如我们在使用 Spring 标签时，经常使用其 form 标签进行参数绑定。为了试验，我们随便写一个Spring 的标签使用

```html
<form:input path="abc" id="test"/> 
```

此时，JSP生成的内容是这样的：

![tag8](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag8.jpg)

然后页面渲染时，会真正的进行数据绑定，判断这些属性的合法性等等，这里由于是随便写的一行代码，无法绑定所有报错了。

![tag9](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag9.jpg)

所以，对于 Spring、Struts2 等等这些框架的标签，本质上执行也还是这些逻辑，如果页面在渲染的时候出现问题，了解清楚是在哪一步的时候出了问题，知道具体这些标签的工作原理。

例如下图 Spring 的 InputTag 继承关系，也没有脱离Servlet 的Tag这个框。

![tag`0](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/tag10.jpg)

总结下，Taglib的工作原理，是在应用部署的时候，解析tld的声明。页面渲染的时候，解析如果引入的tld不存在，就会报错。tld合法之后执行 tag 的具体逻辑，根据返回值判断是否继续页面的渲染。

框架的标签也是如此。



ref：

1.[一篇文章读懂Java Web的框架标签](http://zhuanlan.51cto.com/art/201706/541914.htm)