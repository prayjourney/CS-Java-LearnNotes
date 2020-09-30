## JSTL 标签详解

### Chapter 1
#### 一、JSTL标签介绍

##### 1.什么是JSTL？
JSTL是apache对EL表达式的扩展（也就是说JSTL依赖EL），JSTL是标签语言！JSTL标签使用以来非常方便，它与JSP动作标签一样，只不过它不是JSP内置的标签，需要我们自己导包，以及指定标签库而已
如果你使用MyEclipse开发JavaWeb，那么在把项目发布到Tomcat时，你会发现，MyEclipse会在lib目录下存放jstl的Jar包！如果你没有使用MyEclipse开发那么需要自己来导入这个JSTL的Jar包：jstl-1.2.jar

##### 2.JSTL标签库
JSTL一共包含四大标签库：
- core: **核心标签库，我们学习的重点**
- fmt: *格式化标签库，只需要学习两个标签即可*
- sql: 数据库标签库，不需要学习了，它过时了
- xml: xml标签库，不需要学习了，它过时了

##### 3.使用taglib指令导入标签库
除了JSP动作标签外，使用其他第三方的标签库都需要：
- 导包
- 在使用标签的JSP页面中使用taglib指令导入标签库

下面是导入JSTL的core标签库：

```html
1. <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>  
```

- `prefix="c"`: 指定标签库的前缀，这个前缀可以随便给值，但大家都会在使用core标签库时指定前缀为c
- `uri="http://java.sun.com/jstl/core"`: 指定标签库的uri，它不一定是真实存在的网址，但它可以让JSP找到标签库的描述文件

##### 4.core标签库常用标签
###### 1. out和set标签
| <c:out value=”aaa”/>                                         | 输出aaa字符串常量                                            |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <c:out value=”${aaa}”/>                                      | 与${aaa}相同                                                 |
| <c:out value=”${aaa}” default=”xxx”/>                        | 当${aaa}不存在时，输出xxx字符串                              |
| <%request.setAttribute("a","<script>alert('hello');</script>");%><c:out value="${a }" default="xxx" escapeXml="false" /> | 当escapeXml为false，不会转换“<”、“>”。这可能会受到JavaScript攻击。 |

| <c:set var=”a” value=”hello”/>                 | 在pageContext中添加name为a，value为hello的数据。 |
| ---------------------------------------------- | ------------------------------------------------ |
| <c:set var=”a” value=”hello” scope=”session”/> | 在session中添加name为a，value为hello的数据。     |

 

###### 2. remove标签
| <%                   pageContext.setAttribute("a","pageContext");                   request.setAttribute("a","session");                   session.setAttribute("a","session");                   application.setAttribute("a","application");  %>    <c: remove var="a"/>    <c: out value="${a}" default="none"/> | 删除所有域中name为a的数据！    |
| ------------------------------------------------------------ | ------------------------------ |
| <c:remove var="a" scope=”page”/>                             | 删除pageContext中name为a的数据 |

###### 3. url标签：该标签会在需要重写URL时添加
| <c:url value="/"/>                                           | 输出上下文路径：/项目名/                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <c:url value="/" var="a" scope="request"/>                   | 把本该输出的结果赋给变量a。范围为request                     |
| <c:url value="/AServlet"/>                                   | 输出：/项目名/AServlet                                       |
| <c:url value="/AServlet"><c:param name="username" value="abc"/><c:param name="password" value="123"/> | 输出：/项目名/AServlet?username=abc&password=123     如果参数中包含中文，那么会自动使用URL编码！ |

###### 4. if标签
if标签的test属性必须是一个boolean类型的值，如果test的值为true，那么执行if标签的内容，否则不执行

```html
1. <c:set var="a" value="hello"/>  
2. <c:if test="${not empty a }">  
3.     <c:out value="${a }"/>  
4. </c:if> 
```

###### 5. choose标签
choose标签对应Java中的if/else if/else结构。when标签的test为true时，会执行这个when的内容。当所有when标签的test都为false时，才会执行otherwise标签的内容

```html
1. <c:set var="score" value="${param.score }"/>  
2. c:choose  
3.     <c:when test="${score > 100 || score < 0}">错误的分数：${score }/c:when  
4.     <c:when test="${score >= 90 }">A级/c:when  
5.     <c:when test="${score >= 80 }">B级/c:when  
6.     <c:when test="${score >= 70 }">C级/c:when  
7.     <c:when test="${score >= 60 }">D级/c:when  
8.     c:otherwiseE级/c:otherwise  
9. </c:choose> 
```

###### 6. forEach标签
forEach当前就是循环标签了，forEach标签有多种两种使用方式：
- 使用循环变量，指定开始和结束值，类似`for(int i = 1; i <= 10; i++) {}`
- 循环遍历集合，类似`for(Object o : 集合)`

循环变量:
```html
1. <c:set var="sum" value="0" />   
2. <c:forEach var="i" begin="1" end="10">   
3.     <c:set var="sum" value="${sum + i}" />   
4. /c:forEach  
5. <c:out value="sum = ${sum }"/>  
6. <c:set var="sum" value="0" />  
7. <c:forEach var="i" begin="1" end="10" step ="2">  
8.     <c:set var="sum" value="${sum + i}" />  
9.</c:forEach> 
10. <c:out value="sum = ${sum }"/>  
```

遍历集合或数组方式:
```html
1. <%  
2. String[] names = {"zhangSan", "liSi", "wangWu", "zhaoLiu"};  
3. pageContext.setAttribute("ns", names);  
4. %>  
5. <c:forEach var="item" items="${ns }">  
6.     <c:out value="name: ${item }"/><br/>  
7. </c:forEach> 
```

遍历List:
```html
1. <%  
2.     List<String> names = new ArrayList<String>();  
3.     names.add("zhangSan");  
4.     names.add("liSi");  
5.     names.add("wangWu");  
6.     names.add("zhaoLiu");  
7.     pageContext.setAttribute("ns", names);  
8. %>  
9. <c:forEach var="item" items="${ns }">  
10.     <c:out value="name: ${item }"/><br/>  
11. </c:forEach>
```

遍历Map:
```html
1. <%  
2.     Map<String,String> stu = new LinkedHashMap<String,String>();  
3.     stu.put("number", "N_1001");  
4.     stu.put("name", "zhangSan");  
5.     stu.put("age", "23");  
6.     stu.put("sex", "male");  
7.     pageContext.setAttribute("stu", stu);  
8. %>  
9. <c:forEach var="item" items="${stu }">  
10.     <c:out value="${item.key }: ${item.value }"/><br/>  
11. </c:forEach> 
```

forEach标签还有一个属性: `varStatus`，这个属性用来指定接收“循环状态”的变量名，例如：`<forEach varStatus=”vs” …/>`，这时就可以使用vs这个变量来获取循环的状态了
- count：int类型，当前以遍历元素的个数
- index：int类型，当前元素的下标
- first：boolean类型，是否为第一个元素
- last：boolean类型，是否为最后一个元素
- current：Object类型，表示当前项目
```html
1. <c:forEach var="item" items="${ns }" varStatus="vs">  
2.     <c:if test="${vs.first }">第一行：/c:if  
3.     <c:if test="${vs.last }">最后一行：/c:if  
4.     <c:out value="第${vs.count }行: "/>  
5.     <c:out value="[${vs.index }]: "/>  
6.     <c:out value="name: ${vs.current }"/><br/>  
7. </c:forEach > 
```

##### 5.fmt标签库常用标签
fmt标签库是用来格式化输出的，通常需要格式化的有时间和数字
###### 格式化时间
```html
1. <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
2. ......  
3. <%  
4.     Date date = new Date();  
5.     pageContext.setAttribute("d", date);  
6. %>  
7. <fmt:formatDate value="${d }" pattern="yyyy-MM-dd HH:mm:ss"/>  
```

###### 格式化数字
```html
1. <%  
2.     double d1 = 3.5;  
3.     double d2 = 4.4;   
4.     pageContext.setAttribute("d1", d1);  
5.     pageContext.setAttribute("d2", d2);  
6. %>  
7. <fmt:formatNumber value="${d1 }" pattern="0.00"/><br/>  
8. <fmt:formatNumber value="${d2 }" pattern="#.##"/>  
```
*介绍了JSTL中的常用标签，那可以定义自己的标签吗？答案是：可以*



#### 二、自定义标签
##### 1. 自定义标签
###### 1.1 步骤
其实我们在JSP页面中使用标签就等于调用某个对象的某个方法一样，例如：<c:if test=””>，这就是在调用对象的方法一样。自定义标签其实就是自定义类一样！

- 定义标签处理类：必须是Tag或SimpleTag的实现类；
- 编写标签库描述符文件（TLD）；

		SimpleTag接口是JSP2.0中新给出的接口，用来简化自定义标签，所以现在我们基本上都是使用SimpleTag。

		Tag是老的，传统的自定义标签时使用的接口，现在不建议使用它了。

###### 1.2 SimpleTag接口介绍
SimpleTag接口内容如下：

- `void doTag()`：标签执行方法
- `JspTag getParent()`：获取父标签
- `void setParent(JspTag parent)`：设置父标签
- `void setJspContext(JspContext context)`：设置PageContext
- `void setJspBody(JspFragment jspBody)`：设置标签体对象

请记住，万物皆对象! 在JSP页面中的标签也是对象! 你可以通过查看JSP的源码，清楚的知道，所有标签都会变成对象的方法调用。标签对应的类我们称之为“标签处理类”! 

###### 1.3 标签的生命周期
*1、当容器（Tomcat）第一次执行到某个标签时，会创建标签处理类的实例；*
*2、然后调用setJspContext(JspContext)方法，把当前JSP页面的pageContext对象传递给这个方法；*
*3、如果当前标签有父标签，那么使用父标签的标签处理类对象调用setParent(JspTag)方法；*
*4、如果标签有标签体，那么把标签体转换成JspFragment对象，然后调用setJspBody()方法；*
*5、每次执行标签时，都调用doTag()方法，它是标签处理方法*。
`HelloTag.java`
```java
1. public class HelloTag implements SimpleTag {  
2.     private JspTag parent;  
3.     private PageContext pageContext;  
4.     private JspFragment jspBody;  
5.       
6.     public void doTag() throws JspException, IOException {  
7.         pageContext.getOut().print("Hello Tag!!!");  
8.     }  
9.     public void setParent(JspTag parent) {  
10.         this.parent = parent;  
11.     }  
12.     public JspTag getParent() {  
13.         return this.parent;  
14.     }  
15.     public void setJspContext(JspContext pc) {  
16.         this.pageContext = (PageContext) pc;  
17.     }  
18.     public void setJspBody(JspFragment jspBody) {  
19.         this.jspBody = jspBody;  
20.     }  
21. }  
```

###### 1.4 标签库描述文件(TLD)
标签库描述文件是用来描述当前标签库中的标签的！标签库描述文件的扩展名为tld，你可以把它放到WEB-INF下，这样就不会被客户端直接访问到了。

`hello.tld`
```html
1. <?xml version="1.0" encoding="UTF-8"?>  
2. <taglib version="2.0" xmlns="http://java.sun.com/xml/ns/j2ee"  
3.     xmlns:xml="http://www.w3.org/XML/1998/namespace"   
4.     xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"  
5.     xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee   
6.                         http://java.sun.com/xml/ns/j2ee/web-jsptaglibrary_2_0.xsd ">  
7. 
8.     <tlib-version>1.0</tlib-version>  
9.     <short-name>ywq</short-name>  
10.     <uri>http://www.ywq.cn/tags</uri>  
11.     <tag>  
12.         <name>hello</name>  
13.         <tag-class>cn.ywq.tag.HelloTag</tag-class>  
14.         <body-content>empty</body-content>  
15.     </tag>  
16. </taglib>
```
###### 1.5使用标签
在页面中使用标签分为两步：
- 使用taglib导入标签库；
- 使用标签；
```html
1.  <%@ taglib prefix="it" uri="/WEB-INF/hello.tld" %>  
2.    .......  
3.  <it:hello/>  
```

##### 2. 自定义标签进阶
###### 2.1 继承SimpleTagSupport
继承SimpleTagSuppport要比实现SimpleTag接口方便太多了，现在你只需要重写doTag()方法，其他方法都已经被SimpleTagSuppport完成了。

```java
1. public class HelloTag extends SimpleTagSupport {  
2.     public void doTag() throws JspException, IOException {  
3.         this.getJspContext().getOut().write("<p>Hello SimpleTag!</p>");  
4.     }  
5. }  
```

###### 2.2 有标签体的标签
我们先来看看标签体内容的可选值：
`<body-content>`元素的可选值有：
- empty：无标签体
- JSP：传统标签支持它，**SimpleTag已经不再支持使用<body-content>JSP</body-content>。**标签体内容可以是任何东西：EL、JSTL、<%=%>、<%%>，以及html
- scriptless：标签体内容不能是Java脚本，但可以是EL、JSTL等。在SimpleTag中，**如果需要有标签体，那么就使用该选项**
- tagdependent：标签体内容不做运算，由标签处理类自行处理，无论标签体内容是EL、JSP、JSTL，都不会做运算。**这个选项几乎没有人会使用！**

自定义有标签体的标签需要：
- 获取标签体对象：JspFragment jspBody = getJspBody()
- 把标签体内容输出到页面：jspBody.invoke(null)
- tld中指定标签内容类型：scriptless
```java
1. public class HelloTag extends SimpleTagSupport {  
2.     public void doTag() throws JspException, IOException {  
3.         PageContext pc = (PageContext) this.getJspContext();  
4.         HttpServletRequest req = (HttpServletRequest) pc.getRequest();  
5.         String s = req.getParameter("exec");  
6.         if(s != null && s.endsWith("true")) {  
7.             JspFragment body = this.getJspBody();  
8.             body.invoke(null);  
9.         }  
10.     }  
11. }  
```

```html
1.<tag>  
2.     <name>hello</name>  
3.     <tag-class>cn.ywq.tags.HelloTag</tag-class>  
4.     <body-content>scriptless</body-content>  
5.</tag>  
```

```html
1. <itcast:hello  >
2.     <h1>哈哈哈~</h1>  
3. </itcast:hello>  

```

###### 2.3 不执行标签下面的页面内容
如果希望在执行了自定义标签后，不再执行JSP页面下面的东西，那么就需要在doTag()方法中使用SkipPageException。

```java
1. public class SkipTag extends SimpleTagSupport {  
2.     public void doTag() throws JspException, IOException {  
3.         this.getJspContext().getOut().print("<h1>只能看到我！</h1>");  
4.         throw new SkipPageException();  
5.     }  
6. }
```
```html
1. <tag>  
2.     <name>skip</name>  
3.     <tag-class>cn.ywq.tags.SkipTag</tag-class>  
4.     <body-content>empty</body-content>  
5. </tag>  
```
```html
1. <itcast:skip/>  
2. <h1>看不见我！</h1>  
```

###### 2.4 带有属性的标签
一般标签都会带有属性，例如`<c:iftest=””>`，其test就是一个boolean类型的属性。完成带有属性的标签需要：
- 在处理类中给出JavaBean属性（提供get/set方法）
- 在TLD中部属相关属性

```java
1. public class IfTag extends SimpleTagSupport {  
2.     private boolean test;  
3.     public boolean isTest() {  
4.         return test;  
5.     }  
6.     public void setTest(boolean test) {  
7.         this.test = test;  
8.     }  
9.     @Override  
10.    public void doTag() throws JspException, IOException {  
11.        if(test) {  
12.            this.getJspBody().invoke(null);  
13.        }  
14.    }  
15.}  
```
```html
1. <tag>   
2.      <name>if</name>   
3.      <tag-class>cn.ywq.IfTag</tag-class>   
4.      <body-content>scriptless</body-content>  
5.      <attribute>  
6.          <name>test</name>  
7.          <required>true</required>  
8.          <rtexprvalue>true</rtexprvalue>  
9.      </attribute>   
10.</tag>  
```
```html
1. <%  
2.     pageContext.setAttribute("one", true);  
3.     pageContext.setAttribute("two", false);  
4. %>  
5. <it:if test="${one }">xixi</it:if>  
6. <it:if test="${two }">haha</it:if>  
7. <it:if test="true">hehe</it:if>  
```



### Chapter 2
####  JSP标准标签库（JSTL）
jsp标准标签库（jstl）是一个JSP标签集合，它封装了jsp应用的通用核心功能。 
JSTL支持通用的、格式化的任务。比如：迭代、条件判断、XML文档操作、国际化标签、SQL标签。除了这些它还提供了一个框架来使用集成JSTL的自定义标签。 根据JSTL标签所提供的功能，可以将其分为5个类别：
1. 核心标签
2. 格式化标签
3. SQL标签
4. XML标签
5. JSTL函数

使用任何库，你必须在每个JSP文件中的头部包含`<taglib>`标签。

##### 1.核心标签
核心标签是最常用的JSTL标签。引用核心标签库的语法：
```html
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
```

| 标签            | 描述                                                         |
| --------------- | ------------------------------------------------------------ |
| `<c:out>`       | 用于在JSP中显示数据，就像<%= … >                             |
| `<c:set>`       | 用于保存数据                                                 |
| `<c:remove>`    | 用于删除数据                                                 |
| `<c:catch>`     | 用来处理产生错误的异常状况，并且将错误信息储存起来           |
| `<c:if>`        | 与我们在一般程序中用的if一样                                 |
| `<c:choose>`    | 本身只当做`<c:when>`和`<c:otherwise>`的父标签                |
| `<c:when>`      | `<c:choose>`的子标签，用来判断条件是否成立                   |
| `<c:otherwise>` | `<c:choose>`的子标签，接在`<c:when>`标签后，当`<c:when>`标签判断为false时被执行 |
| `<c:import>`    | 检索一个绝对或相对 URL，然后将其内容暴露给页面               |
| `<c:forEach>`   | 基础迭代标签，接受多种集合类型                               |
| `<c:forTokens>` | 根据指定的分隔符来分隔内容并迭代输出                         |
| `<c:param>`     | 用来给包含或重定向的页面传递参数                             |
| `<c:redirect>`  | 重定向至一个新的URL                                          |
| `<c:url>`       | 使用可选的查询参数来创造一个URL                              |

------

**<c:out>标签**

```html
<c:out>标签用来显示一个表达式的结果，与<%= %>作用相似，它们的区别就是<c:out>标签可以直接通过"."操作符来访问属性。
12
```

语法格式：

```html
<c:out value="<string>" default="<string>" escapeXml="<true|false>"/>
```

属性

| 属性      | 描述                | 是否必要 | 默认值       |
| --------- | ------------------- | -------- | ------------ |
| value     | 要输出的内容        | 是       | 无           |
| default   | 输出的默认值        | 否       | 主体中的内容 |
| escapeXml | 是否忽略XML特殊字符 | 否       | true         |

------

**<c:set>标签**

```html
<c:set>标签标签用于设置变量值和对象属性.
12
```

语法格式：

```html
<c:set var="<string>" value="<string>" target="<string>" property="<string>" scope="<string>"/>
```

属性

| 属性     | 描述                   | 是否必要 | 默认值       |
| -------- | ---------------------- | -------- | ------------ |
| value    | 要存储的内容           | 否       | 主体中的内容 |
| target   | 要修改的属性所属的对象 | 否       | 无           |
| property | 要修改的属性           | 否       | 无           |
| var      | 存储数据的变量         | 否       | 无           |
| scope    | var属性的作用域        | 否       | Page         |

------

**<c:remove>标签**

```html
<c:remove>标签用于移除一个变量，可以指定这个变量的作用域，若未指定，则默认为变量第一次出现的作用域。
12
```

语法格式：

```html
<c:remove var="<string>" scope="<string>"/>
```

属性

| 属性  | 描述             | 是否必要 | 默认值     |
| ----- | ---------------- | -------- | ---------- |
| var   | 要移除的变量名称 | 是       | 无         |
| scope | var属性的作用域  | 否       | 所有作用域 |

------

**<c:catch>标签**

```php+HTML
<c:catch>标签主要用来处理产生错误的异常状况，并且将错误信息储存起来。
12
```

语法格式：

```html
<c:catch var="<string>"> ... </c:catch>1
```

属性

| 属性 | 描述                   | 是否必要 | 默认值 |
| ---- | ---------------------- | -------- | ------ |
| var  | 用来储存错误信息的变量 | 否       | None   |

------

**<c:if>标签**

```php+HTML
<c:if>标签判断表达式的值，如果表达式的值为 true 则执行其主体内容。
12
```

语法格式：

```html
<c:if test="<boolean>" var="<string>" scope="<string>"> ... </c:if>1
```

属性

| 属性  | 描述                   | 是否必要 | 默认值 |
| ----- | ---------------------- | -------- | ------ |
| test  | 条件                   | 是       | 无     |
| var   | 用于存储条件结果的变量 | 否       | 无     |
| scope | var属性的作用域        | 否       | Page   |

------

**<c:choose>, <c:when>, <c:otherwise> 标签**

```html
<c:if>标签与Java switch语句的功能一样，用于在众多选项中做出选择。
switch语句中有case，而<c:choose>标签中对应有<c:when>，switch语句中有default，而<c:choose>标签中有<c:otherwise>。
```

语法格式：

```html
<c:choose>
    <c:when test="<boolean>"/>
        ...
    </c:when>
    <c:when test="<boolean>"/>
        ...
    </c:when>
    ...
    ...
    <c:otherwise>
        ...
    </c:otherwise>
</c:choose>
```

属性

<c:when>标签的属性如下：

| 属性 | 描述 | 是否必要 | 默认值 |
| ---- | ---- | -------- | ------ |
| test | 条件 | 是       | 无     |

------

**<c:import>标签**

```html
<c:import>标签提供了所有<jsp:include>行为标签所具有的功能，同时也允许包含绝对URL.
```

语法格式：

```html
<c:import
   url="<string>"
   var="<string>"
   scope="<string>"
   varRender="<string>"
   context="<string>"
   charEncoding="<string>"/>
```

属性

| 属性         | 描述                                                         | 是否必要 | 默认值       |
| ------------ | ------------------------------------------------------------ | -------- | ------------ |
| url          | 待导入资源的URL，可以是相对路径和绝对路径，并且可以导入其他主机资源 | 是       | 无           |
| context      | 当使用相对路径访问外部context资源时，context指定了这个资源的名字。 | 否       | 当前应用程序 |
| charEncoding | 所引入的数据的字符编码集                                     | 否       | ISO-8859-1   |
| var          | 用于存储所引入的文本的变量                                   | 否       | 无           |
| scope        | var属性的作用域                                              | 否       | Page         |
| varReader    | 可选的用于提供java.io.Reader对象的变量                       | 否       | 无           |

------

**<c:forEach>, <c:forTokens> 标签**

```html
这些标签封装了Java中的for，while，do-while循环。
相比而言，<c:forEach>标签是更加通用的标签，因为它迭代一个集合中的对象。
<c:forTokens>标签通过指定分隔符将字符串分隔为一个数组然后迭代它们。
```

语法格式：

```html
<c:forEach
    items="<object>"
    begin="<int>"
    end="<int>"
    step="<int>"
    var="<string>"
    varStatus="<string>">
```

```html
<c:forTokens
    items="<string>"
    delims="<string>"
    begin="<int>"
    end="<int>"
    step="<int>"
    var="<string>"
    varStatus="<string>">
```

属性

<c:forEach>标签有如下属性：

| 属性      | 描述                                       | 是否必要 | 默认值       |
| --------- | ------------------------------------------ | -------- | ------------ |
| items     | 要被循环的信息                             | 是       | 无           |
| begin     | 开始的元素（0=第一个元素，1=第二个元素）   | 否       | 0            |
| end       | 最后一个元素（0=第一个元素，1=第二个元素） | 否       | Last element |
| step      | 每一次迭代的步长                           | 否       | 1            |
| var       | 代表当前条目的变量名称                     | 否       | 无           |
| varStatus | 代表循环状态的变量名称                     | 否       | 无           |

<c:forTokens>标签与<c:forEach>标签有相似的属性，不过<c:forTokens>还有另一个属性：

| 属性   | 描述   | 是否必要 | 默认值 |
| ------ | ------ | -------- | ------ |
| delims | 分隔符 | 是       | 无     |

------

**<c:param>标签**

```html
<c:param>标签用于在<c:url>标签中指定参数，而且与URL编码相关。
在<c:param>标签内，name属性表明参数的名称，value属性表明参数的值。
```

语法格式：

```html
<c:param name="<string>" value="<string>"/>
```

属性

| 属性  | 描述                    | 是否必要 | 默认值 |
| ----- | ----------------------- | -------- | ------ |
| name  | URL中要设置的参数的名称 | 是       | 无     |
| value | 参数的值                | 否       | Body   |

------

**<c:redirect>标签**

```html
<c:redirect>标签通过自动重写URL来将浏览器重定向至一个新的URL，它提供内容相关的URL，并且支持c:param标签。
```

语法格式：

```html
<c:redirect url="<string>" context="<string>"/>
```

属性

| 属性    | 描述                             | 是否必要 | 默认值       |
| ------- | -------------------------------- | -------- | ------------ |
| url     | 目标URL                          | 是       | 无           |
| context | 紧接着一个本地网络应用程序的名称 | 否       | 当前应用程序 |

------

**<c:url>标签**

```html
<c:url>标签将URL格式化为一个字符串，然后存储在一个变量中。
<c:url>标签只是用于调用response.encodeURL()方法的一种可选的方法。它真正的优势在于提供了合适的URL编码，包括<c:param>中指定的参数。
```

语法格式：

```html
<c:url
  var="<string>"
  scope="<string>"
  value="<string>"
  context="<string>"/>
```

属性

| 属性    | 描述                   | 是否必要 | 默认值        |
| ------- | ---------------------- | -------- | ------------- |
| value   | 基础URL                | 是       | 无            |
| context | 本地网络应用程序的名称 | 否       | 当前应用程序  |
| var     | 代表URL的变量名        | 否       | Print to page |
| scope   | var属性的作用域        | 否       | Page          |

##### 2.格式化标签

格式化标签用来格式化并输出文本、日期、时间、数字。引用格式化标签的语法：

```html
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
```

| 标签                    | 描述                                     |
| ----------------------- | ---------------------------------------- |
| `<fmt:formatNumber>`    | 使用指定的格式或精度格式化数字           |
| `<fmt:parseNumber>`     | 解析一个代表着数字，货币或百分比的字符串 |
| `<fmt:formatDate>`      | 使用指定的风格或模式格式化日期和时间     |
| `<fmt:parseDate>`       | 解析一个代表着日期或时间的字符串         |
| `<fmt:bundle>`          | 绑定资源                                 |
| `<fmt:setLocale>`       | 指定地区                                 |
| `<fmt:setBundle>`       | 绑定资源                                 |
| `<fmt:timeZone>`        | 指定时区                                 |
| `<fmt:setTimeZone>`     | 指定时区                                 |
| `<fmt:message>`         | 显示资源配置文件信息                     |
| `<fmt:requestEncoding>` | 设置request的请求编码                    |

------

**<fmt:formatNumber>标签**

```html
<fmt:formatNumber>标签用于格式化数字，百分比，货币。
```

语法格式：

```html
<fmt:formatNumber
  value="<string>"
  type="<string>"
  pattern="<string>"
  currencyCode="<string>"
  currencySymbol="<string>"
  groupingUsed="<string>"
  maxIntegerDigits="<string>"
  minIntegerDigits="<string>"
  maxFractionDigits="<string>"
  minFractionDigits="<string>"
  var="<string>"
  scope="<string>"/>
```

属性

| 属性              | 描述                               | 是否必要 | 默认值         |
| ----------------- | ---------------------------------- | -------- | -------------- |
| value             | 要显示的数字                       | 是       | 无             |
| type              | NUMBER，CURRENCY，或 PERCENT类型   | 否       | Number         |
| pattern           | 指定一个自定义的格式化模式用与输出 | 否       | 无             |
| currencyCode      | 货币码（当type=”currency”时）      | 否       | 取决于默认区域 |
| currencySymbol    | 货币符号（当type=”currency”时）    | 否       | 取决于默认区域 |
| groupingUsed      | 是否对数字分组 (TRUE 或 FALSE)     | 否       | true           |
| maxIntegerDigits  | 整型数最大的位数                   | 否       | Print to page  |
| minIntegerDigits  | 整型数最小的位数                   | 否       | Page           |
| maxFractionDigits | 小数点后最大的位数                 | 否       | 无             |
| minFractionDigits | 小数点后最小的位数                 | 否       | 当前应用程序   |
| var               | 存储格式化数字的变量               | 否       | Print to page  |
| scope             | var属性的作用域                    | 否       | Page           |

pattern属性

| 符号 | 描述                         |
| ---- | ---------------------------- |
| 0    | 代表一位数字                 |
| E    | 使用指数格式                 |
| #    | 代表一位数字，若没有则显示0  |
| .    | 小数点                       |
| ,    | 数字分组分隔符               |
| ;    | 分隔格式                     |
| -    | 使用默认负数前缀             |
| %    | 百分数                       |
| ?    | 千分数                       |
| X    | 指定可以作为前缀或后缀的字符 |
| ‘    | 在前缀或后缀中引用特殊字符   |

------

**<fmt:parseNumber>标签**

```html
<fmt:parseNumber>标签用来解析数字，百分数，货币。
```

语法格式：

```html
<fmt:parseNumber
  value="<string>"
  type="<string>"
  pattern="<string>"
  parseLocale="<string>"
  integerOnly="<string>"
  var="<string>"
  scope="<string>"/>
```

属性

| 属性        | 描述                                      | 是否必要 | 默认值        |
| ----------- | ----------------------------------------- | -------- | ------------- |
| value       | 要显示的数字                              | 是       | 无            |
| type        | NUMBER，CURRENCY，或 PERCENT类型          | 否       | Number        |
| parseLocale | 解析数字时所用的区域                      | 否       | 默认区域      |
| integerOnly | 是否只解析整型数（true）或浮点数（false） | 否       | false         |
| pattern     | 自定义解析模式（同formatNumber中的使用）  | 否       | 无            |
| var         | 存储格式化数字的变量                      | 否       | Print to page |
| scope       | var属性的作用域                           | 否       | Page          |

------

**<fmt:formatDate>标签**

```html
<fmt:formatDate>标签用于使用不同的方式格式化日期。
```

语法格式：

```html
<fmt:formatDate
  value="<string>"
  type="<string>"
  dateStyle="<string>"
  timeStyle="<string>"
  pattern="<string>"
  timeZone="<string>"
  var="<string>"
  scope="<string>"/>
```

属性

| 属性      | 描述                                  | 是否必要 | 默认值        |
| --------- | ------------------------------------- | -------- | ------------- |
| value     | 要显示的数字                          | 是       | 无            |
| type      | DATE, TIME, 或 BOTH                   | 否       | date          |
| dateStyle | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否       | default       |
| timeStyle | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否       | default       |
| pattern   | 指定一个自定义的格式化模式用与输出    | 否       | 无            |
| timeZone  | 显示日期的时区                        | 否       | 默认时区      |
| var       | 存储格式化日期的变量名                | 否       | Print to page |
| scope     | var属性的作用域                       | 否       | Page          |

日期格式

| 符号 | 描述                                                         | 实例                       |
| ---- | ------------------------------------------------------------ | -------------------------- |
| G    | 时代标志                                                     | AD                         |
| y    | 不包含纪元的年份。如果不包含纪元的年份小于 10，则显示不具有前导零的年份。 | 2002                       |
| M    | 月份数字。一位数的月份没有前导零。                           | April & 04                 |
| d    | 月中的某一天。一位数的日期没有前导零。                       | 20                         |
| h    | 12 小时制的小时。一位数的小时数没有前导零。                  | 12                         |
| H    | 24 小时制的小时。一位数的小时数没有前导零。                  | 0                          |
| m    | 分钟。一位数的分钟数没有前导零。                             | 45                         |
| s    | 秒。一位数的秒数没有前导零。                                 | 52                         |
| S    | 毫秒                                                         | 970                        |
| E    | 周几                                                         | Tuesday                    |
| D    | 一年中的第几天                                               | 189                        |
| F    | 一个月中的第几个周几                                         | 2 (一个月中的第二个星期三) |
| w    | 一年中的第几周                                               | 27                         |
| W    | 一个月中的第几周                                             | 2                          |
| a    | a.m./p.m. 指示符                                             | PM                         |
| k    | 小时(12 小时制的小时)                                        | 24                         |
| K    | 小时(24 小时制的小时)                                        | 0                          |
| z    | 时区                                                         | 中部标准时间               |
| ‘    |                                                              | 转义文本                   |
| “    |                                                              | 单引号                     |

------

**<fmt:parseDate>标签**

```html
<fmt:parseDate>标签用于解析日期。
```

语法格式：

```html
<fmt:parseDate
   value="<string>"
   type="<string>"
   dateStyle="<string>"
   timeStyle="<string>"
   pattern="<string>"
   timeZone="<string>"
   parseLocale="<string>"
   var="<string>"
   scope="<string>"/>
```

属性

| 属性      | 描述                                  | 是否必要 | 默认值        |
| --------- | ------------------------------------- | -------- | ------------- |
| value     | 要显示的数字                          | 是       | 无            |
| type      | DATE, TIME, 或 BOTH                   | 否       | date          |
| dateStyle | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否       | default       |
| timeStyle | FULL, LONG, MEDIUM, SHORT, 或 DEFAULT | 否       | default       |
| pattern   | 指定一个自定义的格式化模式用与输出    | 否       | 无            |
| timeZone  | 显示日期的时区                        | 否       | 默认时区      |
| var       | 存储格式化日期的变量名                | 否       | Print to page |
| scope     | var属性的作用域                       | 否       | Page          |

------

**<fmt:setLocale>标签**

```html
<fmt:setLocale>标签用来将给定的区域存储在locale配置变量中。
```

语法格式：

```html
<fmt:setLocale value="<string>" variant="<string>" scope="<string>"/>
```

属性

| 属性    | 描述                                | 是否必要 | 默认值 |
| ------- | ----------------------------------- | -------- | ------ |
| value   | 指定ISO-639 语言码和ISO-3166 国家码 |          |        |
| variant | 特定浏览器变体                      | 否       | 无     |
| scope   | Locale配置变量的作用域              | 否       | Page   |

##### 3.SQL标签
JSTL SQL标签库提供了与关系型数据库（Oracle、mysql、sqlserver等等）进行交互的标签。引用SQL标签的语法：

```html
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
```

| 标签                  | 描述                                                         |
| --------------------- | ------------------------------------------------------------ |
| `<sql:setDataSource>` | 指定数据源                                                   |
| `<sql:query>`         | 运行SQL查询语句                                              |
| `<sql:update>`        | 运行SQL更新语句                                              |
| `<sql:param>`         | 将SQL语句中的参数设为指定值                                  |
| `<sql:dataParam>`     | 将SQL语句中的日期参数设为指定的java.util.Date 对象值         |
| `<sql:transaction>`   | 在共享数据库连接中提供嵌套的数据库行为元素，将所有语句以一个事务的形式来运行 |

用的较少不做详细讲解

##### 4.XML标签
JSTL XML标签库提供了创建和操作XML文件的标签。引用XML标签的语法：
```html
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
```

| 标签            | 描述                                                         |
| --------------- | ------------------------------------------------------------ |
| `<x:out>`       | 与<%= … >,类似，不过只用于XPath表达式                        |
| `<x:parse>`     | 解析 XML 数据                                                |
| `<x:set>`       | 设置XPath表达式                                              |
| `<x:if>`        | 判断XPath表达式，若为真，则执行本体中的内容，否则跳过本体    |
| `<x:forEach>`   | 迭代XML文档中的节点                                          |
| `<x:choose>`    | 本身只当做`<c:when>`和`<c:otherwise>`的父标签                |
| `<x:when>`      | `<c:choose>`的子标签，用来判断条件是否成立                   |
| `<x:otherwise>` | `<c:choose>`的子标签，接在`<c:when>`标签后，当`<c:when>`标签判断为false时被执行 |

用的较少不做详细讲解

##### 5.JSTL函数
JSTL包含一系列函数，大部分是通用的字符串处理函数。引用JSTL函数的语法：

```html
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
```

| 标签                        | 描述                                                     | 示例                                                         |
| --------------------------- | -------------------------------------------------------- | ------------------------------------------------------------ |
| `<fn:contains()>`           | 测试输入的字符串是否包含指定的子串                       | <c:if test=”${fn:contains(<原始字符串>, <要查找的子字符串>)}”>…</if> |
| `<fn:containsIgnoreCase()>` | 测试输入的字符串是否包含指定的子串，大小写不敏感         | 同上                                                         |
| `<fn:endsWith()>`           | 测试输入的字符串是否以指定的后缀结尾                     | <c:if test=”${fn:endsWith(<原始字符串>, <要查找的子字符串>)}”>…</c:if> |
| `<fn:escapeXml()>`          | 跳过可以作为XML标记的字符                                | ${fn:escapeXml(<要转义标记的文本>)}                          |
| `<fn:indexOf()>`            | 返回指定字符串在输入字符串中出现的位置                   | ${fn:indexOf(<原始字符串>,<子字符串>)}                       |
| `<fn:join()>`               | 将数组中的元素合成一个字符串然后输出                     | ${fn:join([数组], <分隔符>)}                                 |
| `<fn:length()>`             | 返回字符串长度                                           | ${fn:length(collection                                       |
| `<fn:replace()>`            | 将输入字符串中指定的位置替换为指定的字符串然后返回       | ${fn:replace(<原始字符串>, <被替换的字符串>, <要替换的字符串>)} |
| `<fn:split()>`              | 将字符串用指定的分隔符分隔然后组成一个子字符串数组并返回 | ${fn:split(<带分隔符的字符串>, <分隔符>)}                    |
| `<fn:startsWith()>`         | 测试输入字符串是否以指定的前缀开始                       | 同fn:endsWith()                                              |
| `<fn:substring()>`          | 返回字符串的子集                                         | ${fn:substring(<string>, <beginIndex>, <endIndex>)}          |
| `<fn:substringAfter()>`     | 返回字符串在指定子串之后的子集                           | ${fn:substringAfter(<string>, <substring>)}                  |
| `<fn:substringBefore()>`    | 返回字符串在指定子串之前的子集                           | ${fn:substringBefore(<string>, <substring>)}                 |
| `<fn:toLowerCase()>`        | 将字符串中的字符转为小写                                 | ${fn.toLowerCase(<string>)}                                  |
| `<fn:toUpperCase()>`        | 将字符串中的字符转为大写                                 | ${fn.toUpperCase(<string>)}                                  |
| `<fn:trim()>`               | 移除首位的空白符                                         | ${fn.trim(<string>)}                                         |

#### 自定义标签

自定义标签是用户自定义的jsp语言元素。当jsp包含一个自定义的标签时将被转为servlet。标签转化为对被 称为tag handler的对象的操作，即当servlet执行时Web container调用那些操作。

JSP标签扩展可以让你创建新的标签并且可以直接插入到一个JSP页面。 JSP 2.0规范中引入Simple Tag Handlers来编写这些自定义标记。

你可以继承SimpleTagSupport类并重写的doTag()方法来开发一个最简单的自定义标签。

**创建“Hello”标签**

我们创建一个自定义标签`<ex:Hello>`,标签格式为：

```html
<ex:Hello />
```

要创建自定义的JSP标签，首先需创建处理该标签的java类，创建一个HelloTag类，如下：

```java
public class HelloTag extends SimpleTagSupport {

    //重写父类的方法
    public void doTag() throws JspException,IOException{
        JspWriter out = getJspContext().getOut();
        out.println("Hello Custom Tag!");
    }
}
```

以上代码重写了doTag()方法，方法中使用了getJSPContext()方法来获取当前的JspContext对象，并将“Hello Custom Tag!”传递给JspWriter对象。

编译以上类，并将其复制到环境变量CLASSPATH目录中。最后创建如下标签库：`<Tomcat安装目录>webapps\ROOT\WEB-INF\custom.tld`。

```html
<taglib>
  <tlib-version>1.0</tlib-version>
  <jsp-version>2.0</jsp-version>
  <short-name>Example TLD</short-name>
  <tag>
    <name>Hello</name>
    <tag-class>com.runoob.HelloTag</tag-class>
    <body-content>empty</body-content>
  </tag>
</taglib>
```

接下来我们可以在jsp中使用自定义的标签：

```html
<%@ taglib prefix="ex" uri="WEB-INF/custom.tld"%>
<html>
  <head>
    <title>A sample custom tag</title>
  </head>
  <body>
    <ex:Hello/>
  </body>
</html>
```

以上程序输出结果：

```html
Hello Custom Tag!
```

**自定义标签属性**

你可以在自定义标准中设置各种属性，要接收属性，值自定义标签类必须实现setter方法， JavaBean 中的setter方法如下所示：

```java
public class HelloTag extends SimpleTagSupport {

   private String message;

   public void setMessage(String msg) {
      this.message = msg;
   }

   StringWriter sw = new StringWriter();

   public void doTag()
      throws JspException, IOException
    {
       if (message != null) {
          /* 从属性中使用消息 */
          JspWriter out = getJspContext().getOut();
          out.println( message );
       }
       else {
          /* 从内容体中使用消息 */
          getJspBody().invoke(sw);
          getJspContext().getOut().println(sw.toString());
       }
   }
}
```

属性的名称是”message”，所以setter方法是的setMessage()。我们在TLD文件中使用的`<attribute>`元素添加此属性：

```html
<taglib>
  <tlib-version>1.0</tlib-version>
  <jsp-version>2.0</jsp-version>
  <short-name>Example TLD with Body</short-name>
  <tag>
    <name>Hello</name>
    <tag-class>com.runoob.HelloTag</tag-class>
    <body-content>scriptless</body-content>
    <attribute>
       <name>message</name>
    </attribute>
  </tag>
</taglib>
```

我们在JSP文件中使用message属性:

```html
<%@ taglib prefix="ex" uri="WEB-INF/custom.tld"%>
<html>
  <head>
    <title>A sample custom tag</title>
  </head>
  <body>
    <ex:Hello message="This is custom tag" />
  </body>
</html>
```

注：还可以使用的属性

| 属性        | 描述                                                   |
| ----------- | ------------------------------------------------------ |
| name        | 定义属性的名称。每个标签的属性名称必须是唯一的         |
| required    | 指定属性是否是必须的或者可选的,如果设置为false为可选。 |
| type        | 定义该属性的Java类类型 。默认指定为 String             |
| description | 描述信息                                               |

相关实例：

```html
    <attribute>
      <name>attribute_name</name>
      <required>false</required>
      <type>java.util.Date</type>
      <description>......</fragment>
    </attribute>
```



ref:

1.[JSTL 标签大全详解](http://blog.csdn.net/qq_25827845/article/details/53311722),   2.[常用JSTL标签详解](http://blog.csdn.net/xwl5242/article/details/66969502),   3.[Spring学习总结（四）——表达式语言 Spring Expression Language](http://blog.csdn.net/zhangguo5/article/details/62423345),   4.[jsp中的JSTL与EL表达式用法](http://www.cnblogs.com/fxwl/p/5754143.html),   5.[JSP和El表达式和JSTL标签库使用](http://www.cnblogs.com/nextgg/p/7673889.html)