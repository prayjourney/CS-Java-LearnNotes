### JSTL 表达式与 EL 语言

***

#### 1.什么是 EL 语言

**表达式语言（EL）**是 JSP 2.0 引入的一种计算和输出 Java 对象的简单语音。



#### 2.EL 语言的作用

为了使JSP写起来更加简单。表达式语言的灵感来自于 ECMAScript 和 XPath 表达式语言，它提供了在 JSP 中简化表达式的方法。**它是一种简单的语言，基于可用的命名空间（PageContext 属性）、嵌套属性和对集合、操作符（算术型、关系型和逻辑型）的访问符、映射到 Java 类中静态方法的可扩展函数以及一组隐式对象**。



#### 3.使用 EL 语言前的配置

- 导入**standard.jar**。
- 在需要使用 EL 语音的页面加上`**<%@ page isELIgnored="false" %>**`。注意 <%@ page isELIgnored="true" %> 表示是否禁用EL语言,TRUE表示禁止.FALSE表示不禁止.JSP2.0中默认的启用EL语言。
- 对于整个JSP应用程序，要修改WEB.XML配置(tomcat5.0.16默认是支持EL的)

```xml
1. <jsp-property-group>   
2.     <description> For config the ICW sample application </description>   
3.     <display-name>JSPConfiguration </display-name>  
4.     <url-pattern>/jsp/datareset.jsp </url-pattern>  
5.     <el-ignored>true< / el-ignored> < / el-ignored>  
6.     <page-encoding>UTF-8</page-encoding>   
7.     <scripting-invalid>true</scripting-invalid>  
8.     <include-prelude>/jsp/prelude.jspf</include-prelude>   
9.     <include-coda>/jsp/coda.jspf</include-coda>  
10. </jsp-property-group> 
```



#### 4.如何使用 EL 表达式

##### 1.EL 的内置对象

首先我们要知道 EL 的内置对象有哪些---**-pageScope、requestScope、sessionScope、applicationScope**，如果未指定scope，默认从 pageScope 到 applicationScope一次扩大范围查找属性名，也可以使用 xxxScope.属性名 直接指定在某个 scope 查找，如：
```jsp
1. ${ requestScope.tom }  
```

##### 2.语法结构

```jsp
1. ${expression}  
```

##### 3.[ ]与.运算符。

**EL 提供.和[]两种运算符来存取数据**。如：

```jsp
1. ${student.name}  
2. ${studentList[0].name}  
```
当要存取的属性名称中包含一些特殊字符，如.或?等并非字母或数字的符号，就一定要使用“[ ]“。如
```jsp
1. ${ student.My-Name}   <!-- ${ student.My-Name} 写法不正确，应该改为下面这种 -->  
2. ${ student["My-Name"] }  
```
如果要动态取值时，就可以用“[ ]“来做，而“.“无法做到动态取值。如：
```jsp
1. ${ sessionScope.student[property] }    <!-- 其中 property 是一个变量，动态取对象的属性，如"id", "name"等等 -->  
```

##### 4.使用 EL 取出内置对象的数据。
(1).普通对象和对象属性
服务器端：
```jsp
1. request.setAttribute("student", student);  
```
在浏览器上打印出服务器端绑定的数据：
```jsp
1. ${ student }  <!-- 相当于执行了 student.toString(); -->  
2. ${ student.name }  <!-- 相当于执行了 student.getName(); -->  
3. ${ student.teacher.name }  <!-- 相当于执行了 student.getTeacher().getName(); -->  
4. ...  
```

(2).数组中的数据
服务器端：
```jsp
1. String[] nameArray = new String[]{"Tom", "Lucy", "Lilei"};  
2. request.setAttribute(“nameArray”,nameArray);  
3. 
4. Student[] students = new Student[3];  
5. students[0] = stu1;  
6. students[1] = stu2;  
7. students[2] = stu3;  
8. request.setAttribute(“students”,students);  
```
在浏览器上打印出服务器端绑定的数组数据：
```jsp
1. ${ nameArray[0] }   <!-- Tom -->  
2. ${ nameArray[1] }   <!-- Lucy -->  
3. ${ nameArray[2] }   <!-- Lilei -->  
4. 
5. ${ students[0].id }   <!-- 输出第一个学生的ID -->  
6. ${ students[1].name }   <!-- 输出第二个学生的name -->  
7. ${ students[2].teacher.name }   <!-- 输出第三个学生的老师的name -->  
```

(3).List中的数据
服务器端：
```jsp
1. List<Student> studentList=new ArrayList<Student>();  
2. studentList.add(stu1);  
3. studentList.add(stu2);  
4. studentList.add(stu3);  
5. request.setAttribute(“studentList”,studentList);  
```
在浏览器上打印出服务器端绑定的List数据：
```jsp
1. ${ studentList[0].id }   <!-- 输出第一个学生的ID -->  
2. ${ studentList[1].name }   <!-- 输出第二个学生的name -->  
3. ${ studentList[2].teacher.name }   <!-- 输出第三个学生的老师的name -->  
```

(4).Map中的数据
服务器端：
```jsp
1. Map<String, Student> studentMap = new HashMap<String, Student>();  
2. studentMap.put("Tom", stu1);  
3. studentMap.put("Lucy", stu2);  
4. studentMap.put("Lilei", stu3);  
5. request.setAttribute(“studentMap”,studentMap);  
```
在浏览器上打印出服务器端绑定的Map数据：
```jsp
1. ${ studentMap.Tom.id }   <!-- 输出第一个学生的ID -->  
2. ${ studentMap.Lucy.name }   <!-- 输出第二个学生的name -->  
3. ${ studentMap.Lilei.teacher.name }   <!-- 输出第三个学生的老师的name -->  
```

##### 5.使用 EL 取出隐式对象中的数据
JSP 表达式语言定义了一组隐式对象，其中许多对象在 JSP scriplet 和表达式中可用。可使用的隐式对象如下:
|     属性    |                        含义                                   |
| ----------- | ------------------------------------------------------------ |
| pageContext | JSP 页的上下文。它可以用于访问 JSP 隐式对象，如请求、响应、会话、输出、servletContext 等。例如，${pageContext.response} 为页面的响应对象赋值。 |

此外，还提供几个隐式对象，允许对以下对象进行简易访问：

|     术语      |                     定义                                     |
| ------------ | ------------------------------------------------------------ |
| param        | 将请求参数名称映射到单个字符串参数值（通过调用 ServletRequest.getParameter (String name) 获得）。getParameter (String) 方法返回带有特定名称的参数。表达式 $(param . name) 相当于 request.getParameter (name)。 |
| paramValues  | 将请求参数名称映射到一个数值数组（通过调用 ServletRequest.getParameter (String name) 获得）。它与 param 隐式对象非常类似，但它检索一个字符串数组而不是单个值。表达式 ${paramvalues. name) 相当于 request.getParamterValues(name)。 |
| header       | 将请求头名称映射到单个字符串头值（通过调用 ServletRequest.getHeader(String name) 获得）。表达式 ${header. name} 相当于 request.getHeader(name)。 |
| headerValues | 将请求头名称映射到一个数值数组（通过调用 ServletRequest.getHeaders(String) 获得）。它与头隐式对象非常类似。表达式 ${headerValues. name} 相当于 request.getHeaderValues(name)。 |
| cookie       | 将 cookie 名称映射到单个 cookie 对象。向服务器发出的客户端请求可以获得一个或多个 cookie。表达式 ${cookie. name .value} 返回带有特定名称的第一个 cookie 值。如果请求包含多个同名的 cookie，则应该使用 ${headerValues. name} 表达式。 |
| initParam    | 将上下文初始化参数名称映射到单个值（通过调用 ServletContext.getInitparameter(String name) 获得）。 |

除了上述两种类型的隐式对象之外，还有些对象允许访问多种范围的变量，如 Web 上下文、会话、请求、页面：

|                  |                                                              |
| ---------------- | ------------------------------------------------------------ |
| pageScope        | 将页面范围的变量名称映射到其值。例如，EL 表达式可以使用 \${pageScope.objectName} 访问一个 JSP 中页面范围的对象，还可以使用 \${pageScope .objectName. attributeName} 访问对象的属性。 |
| requestScope     | 将请求范围的变量名称映射到其值。该对象允许访问请求对象的属性。例如，EL 表达式可以使用 \${requestScope. objectName} 访问一个 JSP 请求范围的对象，还可以使用 \${requestScope. objectName. attributeName} 访问对象的属性。 |
| sessionScope     | 将会话范围的变量名称映射到其值。该对象允许访问会话对象的属性。例如： \${sessionScope. name} |
| applicationScope | 将应用程序范围的变量名称映射到其值。该隐式对象允许访问应用程序范围的对象。 |



#### 5.EL 操作符

JSP 表达式语言提供以下操作符，其中大部分是 Java 中常用的操作符：

| 术语   | 定义                                                         |
| ------ | ------------------------------------------------------------ |
| 算术型 | +、-（二元）、*、/、div、%、mod、-（一元）                   |
| 逻辑型 | and、&&、or、\|\|、!、not                                    |
| 关系型 | ==、eq、!=、ne、、gt、<=、le、>=、ge。可以与其他值进行比较，或与布尔型、字符串型、整型或浮点型文字进行比较。 |
| 空     | empty。空操作符是前缀操作，可用于确定值是否为空。            |
| 条件型 | A ?B :C。根据 A 赋值的结果来赋值 B 或 C。                    |

例如：

 ```jsp
1+2=${1+2}  
10/5=${10/5}  
10 div 5=${10 div 5}  
10%3=${10%3}  
10 mod 3=${10 mod 3}  
${empty  scope中的属性名}  
${!empty  scope中的属性名}  
 ```



#### 6.什么是 JSTL 表达式

 JSP 标准标记库（JSP Standard Tag Library，JSTL）是一个实现 Web 应用程序中常见的通用功能的定制标记库集，这些功能包括迭代和条件判断、数据管理格式化、XML 操作以及数据库访问。



#### 7.JSTL 表达式的作用

**JSTL标签库的使用是为类弥补html表的不足，规范自定义标签的使用而诞生的**。在告别modle1模式开发应用程序后，人们开始注重软件的分层设计，不希望在jsp页面中出现java逻辑代码，同时也由于自定义标签的开发难度较大和不利于技术标准化产生了自定义标签库。JSTL标签库可分为5类：
- 核心标签库
- I18N格式化标签库
- SQL标签库
- XML标签库
- 函数标签库



#### 8.JSTL 表达式在页面的配置

1.导入standard.jar和jstl.jar。
2.在JSP页面上引入 JSTL 的引用。如：
```jsp
1. <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
```



#### 9.JSTL 的使用

##### 1.核心标签库

JSTL的核心标签库标签共13个，从功能上可以分为4类：表达式控制标签、流程控制标签、循环标签、URL操作标签。使用这些标签能够完成JSP页面的基本功能，减少编码工作。如：

- 表达式控制标签：out标签、set标签、remove标签、catch标签。
- 流程控制标签：if标签、choose标签、when标签、otherwise标签。
- 循环标签：forEach标签、forTokens标签。
- URL操作标签：import标签、url标签、redirect标签。


下面，演示各个标签的使用。

###### 1.1.表达式控制标签

(1).<c:out>标签：用来显示数据对象（字符串、表达式）的内容或结果。相当于 <% out.println(“字符串”)%> 或 <%=表达式%>。

语法如下：
- 【语法1】：
```jsp
<c:out value=”要显示的数据对象” [escapeXml=”true|false”][default=”默认值”]>
```
- 【语法2】：
```jsp
<c:out value=”要显示的数据对象” [escapeXml=”true|false”]>默认值</c:out>
```

其中
**value**：指定要输出的变量或表达式。
**escapeXml**：设定是否转换特殊字符（如&lt、&gt等一些转义字符），在默认值为true的情况下直接在输出&lt的，如果改为false将会进行转义输出“<”等。
**default**：为默认输出结果。如果使用表达式得到的结果为null（注意与空区别），将会输出默认结果。

例如：
```jsp
1. <%@ page pageEncoding="utf-8" %>  
2. <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
3. <html>  
4.      <head>  
5.          <title>out标签的使用</title>  
6.      </head>  
7.      <body>  
8.          <ul>  
9.              <li>（1）<c:out value="普通一行字符串"></c:out></li>  
10.              <li>（2）<c:out value="&lt未使用字符转义&gt" /></li>  
11.              <li>（3）<c:out value="&lt未使用字符转义&gt" escapeXml="false"></c:out></li>  
12.              <li>（4）<c:out value="${null}">使用了默认值</c:out></li>  
13.              <li>（5）<c:out value="${null}"></c:out></li>  
14.          </ul>  
15.      </body>  
16. </html>  
```

输出：

```java
1. 普通一行字符串  
2. <未使用字符转义>  
3. <未使用字符转义>  
4. 使用了默认值 
```

(2).\<c:set>标签：主要用于将变量存取于JSP范围中或JavaBean属性中。

- 【语法1】：
```java
1. <c:set value=”值1” var=”name1” [scope=”page|request|session|application”]> 
```
把一个值放在指定（page、session等）的map中。

- 【语法2】：
```java
1. <c:set var=”name2” [scope=”page|request|session|application”]>  
```
把一个变量名为name2的变量存储在指定的scope范围内。

- 【语法3】：
```java
1. <c:set value=”值3” target=”JavaBean对象” property=”属性名”/>  
```
把一个值为“值3”赋值给指定的JavaBean的属性名。相当与setter()方法。

- 【语法4】：
```java
1. t=”JavaBean对象” property=”属性名”>值4</c:set>  
```
把一个值4赋值给指定的JavaBean的属性名。

提示：从功能上分语法1和语法2、语法3和语法4的效果是一样的只是把value值放置的位置不同至于使用那个根据个人的喜爱，语法1和语法2是向scope范围内存储一个值，语法3和语法4是给指定的JavaBean赋值。

 

(3).<c:remove>标签：主要用来从指定的JSP范围内移除指定的变量。

- 【语法】：
```xml
1. <c:remove var=”变量名” [scope=”page|request|session|application”]/>  
```
 其中var属性是必须的，scope可以以省略。

例如：

 ```jsp
1. <%@ page language="java" pageEncoding="utf-8"%>  
2. <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
3. <html>  
4.      <head>  
5.          <title>remove标签的使用</title>  
6.      </head>  
7.      <body>   
8.          <ul>  
9.              <li><c:set var="name" scope="session">张三/c:set  
10.              <li><c:set var="age" scope="session">22/c:set  
11.              <li><c:set var="sex" scope="session">男/c:set  
12.              <li><c:out value="${sessionScope.name}">/c:out  
13.              <li><c:out value="${sessionScope.age}">/c:out  
14.              <li><c:out value="${sessionScope.sex}">/c:out  
15.              <li><c:remove var="age"/>  
16.              <li><c:out value="${sessionScope.name}">/c:out  
17.              <li><c:out value="${sessionScope.age}">/c:out  
18.              <li><c:out value="${sessionScope.sex}">/c:out  
19.          </ul>  
20.      </body>  
21. </html>  
 ```

输出：

```java
1. 张三 
2. 22 
3. 男 
4. 张三 
5. 
6. 男
```

(4).\<c:catch>标签：用来处理JSP页面中产生的异常，并将异常信息存储。

- 【语法】：

```java
1.<c:catch var=”name1”>容易产生异常的代码</c:catch>
```
，var表示由用户定义存取异常信息的变量的名称。省略后也可以实现异常的捕获，当就不能显示的输出异常信息。

例如：

```java
1. <%@ page language="java" pageEncoding="utf-8"%>  
2. <%@ uri="http://java.sun.com/jsp/jstl/core" taglib prefix="c" %>  
3. <html>  
4.     <head>  
5.          <title>JSTL: -- catch标签实例</title>  
6.      </head>  
7.      <body>  
8.          <h4>catch标签实例</h4>  
9.          <hr>  
10.          <c:catch  var=”error”>  
11.              <c:set target="Dank" property="hao"></c:set>  
12.          </c:catch>  
13.          <c:out value="${error}"/>  
14.      </body>  
15. </html>  
```

###### 1.2.流程控制标签
流程控制标签主要用于对页面简单业务逻辑进行控制。流程控制标签包含有4个：\<c:if>标签、\<c:choose>标签、\<c:when>标签和\<c:otherwise>标签。下面将介绍这些标签的功能和使用方式。

(1).\<c:if>标签：同程序中的if作用相同，用来实现条件控制。

- 【语法1】：
```java
1. <c:if test=”条件1” var=”name” [scope=”page|request|session|application”]> 
```

- 【语法2】：
```java
1. <c:if test=”条件2” var=”name” [scope=”page|request|session|application”]>结果2</c:if>  
```
[参数说明]:
I、test属性用于存放判断的条件，一般使用EL表达式来编写。
II、var指定名称用来存放判断的结果类型为true或false。
III、scope用来存放var属性存放的范围。

(2).\<c:choose>、\<c:when>和\<c:otherwise>标签：这3个标签通常情况下是一起使用的，\<c:choose>标签作为\<c:when>和\<c:otherwise>标签的父标签来使用。

- 【语法1】：3个标签的嵌套使用方式，<c:choose>标签只能和<c:when>标签共同使用。如：
```java
1. <c:choose>  
2.      <c:when test="条件1">  
3.          …..//业务逻辑1  
4.      </c:when>  
5.      <c:when test="条件2">  
6.          …..//业务逻辑2  
7.      </c:when>  
8.      <span style="white-space: pre;">    </span><c:otherwise>  
9.          …..//业务逻辑3  
10.     </c:otherwise>  
11. </c:choose>  
```

- 【语法2】：\<c:when>标签的使用方式，该标签都条件进行判断，一般情况下和\<c:choose>共同使用。如：
```java
1. <c:when text=”条件”> 
2.      表达式 
3. </c:when> 
```
- 【语法3】：<c:otherwise>不含有参数，只能跟<c:when>共同使用，并且在嵌套中只允许出现一次。如：
```java
1. <c:otherwise> 
2.      表达式 
3. </c:otherwise> 
```
```jsp
1. <%@ page language="java" pageEncoding="gbk"%> 
2. <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
3. <html> 
4. <head> 
5.      <title>JSTL: -- choose及其嵌套标签标签示例</title> 
6. </head> 
7.     <body> 
8.          <h4>choose及其嵌套标签示例</h4> 
9.          <hr> 
10.          <c:set var="score">85</c:set> 
11.          <c:choose> 
12.              <c:when test="${ score>=90 }">
13.                  你的成绩为优秀！ 
14.              </c:when> 
15.              <c:when test="${ score>=70 && score<90 }"> 
16.                  您的成绩为良好! 
17.              </c:when> 
18.              <c:when test="${ score>60 && score<70 }"> 
19.                  您的成绩为及格 
20.              </c:when> 
21.              <c:otherwise> 
22.                  对不起，您没有通过考试！ 
23.              </c:otherwise> 
24.          </c:choose> 
25.      </body> 
26. </html> 
```
###### 1.3.循环标签

循环标签主要实现迭代操作。主要包含两个标签：\<c:forEach>和\<c:forTokens>标签，接下来将详细介绍这两个标签的用法。
(1)\<c:forEach>标签：该标签根据循环条件遍历集合（Collection）中的元素。
- 【语法】：
```jsp
1. <c:forEach var=”name” items=”Collection” varStatus=”StatusName” begin=”begin” end=”end” step=”step”> 
2.      所有内容 
3. </c:forEach> 
```
循环标签属性说明：

| 名称      | EL   | 类型                                                | 是否必须 | 默认值             |
| --------- | ---- | --------------------------------------------------- | -------- | ------------------ |
| var       | N    | String                                              | 是       | 无                 |
| items     | Y    | ArraysCollectionIteratorEnumerationMapString []args | 是       | 无                 |
| begin     | Y    | int                                                 | 否       | 0                  |
| end       | Y    | int                                                 | 否       | 集合中最后一个元素 |
| step      | Y    | int                                                 | 否       | 1                  |
| varStatus | N    | String                                              | 否       | 无                 |

其中varStatus有4个状态属性，如下：

| 属性名 | 类型    | 说明             |
| ------ | ------- | ---------------- |
| index  | int     | 当前循环的索引值 |
| count  | int     | 循环的次数       |
| frist  | boolean | 是否为第一个位置 |
| last   | boolean | 是否为第二个位置 |

(2).\<c:forTokens>标签：该标签用于浏览字符串，并根据指定的字符将字符串截取。
- 【语法】：
```jsp
1. <c:forTokens items=”strigOfTokens” delims=””delimiters [var=”name” begin=”begin” end=”end” step=”len” varStatus=”statusName”] > 
```
【参数说明】
I、items指定被迭代的字符串。
II、delims指定使用的分隔符。
III、var指定用来存放遍历到的成员。
IV、begin指定遍历的开始位置（int型从取值0开始）。 
V、end指定遍历结束的位置（int型，默认集合中最后一个元素）。
VI、step遍历的步长（大于0的整型）。 
VII、varStatus存放遍历到的成员的状态信息。 

注：\<c:forToken>的属性varStatus的使用同\<c:forEach>的使用方法相同，在此就再不表述。

###### 1.4.URL操作标签

JSTL包含3个与URL操作有关的标签，分别为：\<c:import>、\<c:redirect>和\<c:url>标签。它们的作用为：显示其他文件的内容、网页导向、产生URL。下面将详细介绍这3个标签的使用方法。

(1).\<c:import>标签：该标签可以把其他静态或动态文件包含到本JSP页面。同\<jsp:include>的区别为：只能包含同一个web应用中的文件。而\<c:import>可以包含其他web应用中的文件，甚至是网络上的资源。

- 【语法1】：
```jsp
1. <c:import url=”url” [context=”context”][ value=”value”][scope=”page|request|session|application”] [charEncoding=”encoding”]> 
```

- 【语法2】：
```jsp
1. <c:import url=”url” varReader=”name” [context=”context”][charEncoding=”encoding”]> 
```

\<c:import>标签参数说明

| 名称         | 说明                                     | EL   | 类型   | 必须 | 默认值 |
| ------------ | ---------------------------------------- | ---- | ------ | ---- | ------ |
| url          | 被导入资源的URL路径                      | Y    | String | 是   | 无     |
| context      | 相同服务器下其他的web工程，必须以“"”开头 | Y    | String | 否   | 无     |
| var          | 以String类型存入被包含文件的内容。       | N    | String | 否   | 无     |
| Scope        | var变量的JSP范围                         | N    | String | 否   | page   |
| charEncoding | 被导入文件的编码格式                     | Y    | String | 否   | 无     |
| varReader    | 以Reader类型存储被包含文件内容           | N    | String | 否   | 无     |


【参数说明】：
I、URL为资源的路径，当应用的资源不存在时系统会抛出异常，因此该语句应该放在<c:catch></c:catch>语句块中捕获。应用资源有两种方式：绝对路径和相对路径。使用绝对路径示例如下：
```jsp
<c:import url=”http://www.baidu.com”> 
```
使用相对路径的实例如下：
```jsp
<c:import url=”aa.txt”> 
```
aa.txt放在同一文件目录。如果以“/”开头表示应用的根目录下。例如：tomcat应用程序的根目录文件夹为webapps。导入webapps下的文件bb.txt的编写方式为：
```jsp
<c:import url=”/bb.txt”> 
```
如果访问webapps管理文件夹中其他web应用就要用context属性。

II、context属性用于在访问其他web应用的文件时，指定根目录。例如，访问root下的index.jsp的实现代码为：
```jsp
<c:import url=”/index.jsp” context=”/root”> 
```
等同于webapps/root/index.jsp
III、var 属性表示为资源起的别名。
IV、scope 属性标识该资源访问的范围。
V、charEncoding 属性标识该资源的编码方式。
VI、varReader 这个参数的类型是Reader,用于读取资源。  

 

(2).\<c:redirect>标签：用来实现了请求的重定向。同时可以在url中加入指定的参数。例如：对用户输入的用户名和密码进行验证，如果验证不成功重定向到登录页面；或者实现web应用不同模块之间的衔接。
- 【语法1】：
```jsp
1. <c:redirect url=”url” [context=”context”]> 
```

- 【语法2】：
```jsp
1. <c:redirect url=”url”[context=”context”]> 
2.      <c:param name=”name1” value=”value1”> 
3. </c:redirect> 
```



【参数说明】：
I、url 指定重定向页面的地址，可以是一个string类型的绝对地址或相对地址。
II、context用于导入其他web应用中的页面。
例如，当请求页面时重定向到tomcat首页：
```jsp
1. <%@ page contentType="text/html;charset=GBK" %> 
2. <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
3. <c:redirect url="http://127.0.0.1:8080"> 
4.      <c:param name="uname">root</c:param> 
5.      <c:param name="password">123456</c:param> 
6. </c:redirect> 
```

(3).\<c:url>标签：该标签用于动态生成一个String类型的URL，可以同<c:redirect>标签共同使用，也可以使用html的<a>标签实现超链接。
- 【语法1】：指定一个url不做修改，可以选择把该url存储在JSP不同的范围中。
```jsp
  1. <c:url value=”value” [var=”name”][scope=”page|request|session|application”][context=”context”]/> 
```

- 【语法2】：给url加上指定参数及参数值，可以选择以name存储该url。
```jsp
1. <c:url value=”value” [var=”name”][scope=”page|request|session|application”][context=”context”]> 
2.     <c:param name=”参数名” value=”值”> 
3. </c:url> 
```
例如，使用动态生成url实现了网页的超链接：
```jsp
1. <%@ page contentType="text/html;charset=GBK" %> 
2. <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
3. <c:out value="url标签使用"></c:out> 
4. <h4>使用url标签生成一个动态的url，并把值存入session中.</h4> 
5. <hr> 
6. <c:url value="http://127.0.0.1:8080" var="url" scope="session"> 
7. </c:url> 
8. <a href="${url}">Tomcat首页</a> 
```



##### 2.I18N格式标签库

JSTL标签提供了对国际化（I18N）的支持，它可以根据发出请求的客户端地域的不同来显示不同的语言。同时还提供了格式化数据和日期的方法。实现这些功能需要I18N格式标签库（I18N-capable formation tags liberary）。引入该标签库的方法为：
```jsp
1. <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
```

- 数字日期格式化。formatNumber标签、formatData标签、parseNumber标签、parseDate标签、timeZone标签、setTimeZone标签。
- 读取消息资源。bundle标签、message标签、setBundle标签。
- 国际化。setlocale标签、requestEncoding标签。

接下将详细介绍这些标签的功能和使用方式。

###### 2.1.数字日期格式化标签：数字日期格式化标签共有6个，用来将数字或日期转换成设定的格式。

- 【语法1】：
```jsp
1. <frm:formatNumber value=”被格式化的数据”[type=”number|currency|percent”] 
2.     [pattern=”pattern”] 
3.     [currencyCode=”code”] 
4.     [currencySymbol=”symbol”] 
5.     [groupingUsed=”true|false”] 
6.     [maxIntergerDigits=”maxDigits”] 
7.     [minIntergerDigits=”minDigits”] 
8.     [maxFractionDigits=”maxDigits”] 
9.     [minFractionDigits=”minDigits”] 
10.    [var=”name”] 
11.    [scope=page|request|session|application]  
12. /> 
```

- 【语法2】：
```jsp
1. <frm:formatNumber [type=”number|currency|percent”] 
2.      [pattern=”pattern”] 
3.      [currencyCode=”code”] 
4.      [currencySymbol=”symbol”] 
5.      [groupingUsed=”true|false”] 
6.      [maxIntergerDigits=”maxDigits”] 
7.      [minIntergerDigits=”minDigits”] 
8.      [maxFractionDigits=”maxDigits”] 
9.      [minFractionDigits=”minDigits”] 
10.      [var=”name”][scope=page|request|session|application] 
11. /> 
```

\<fmt:formatNumber>标签参数说明：

| 名称              | 说明                                 | EL   | 类型    | 必须 | 默认值 |
| ----------------- | ------------------------------------ | ---- | ------- | ---- | ------ |
| value             | 要格式化的数据                       | 是   | String  | 是   | 无     |
| type              | 指定类型（单位、货币、百分比等）见表 | 是   | String  | 否   | number |
| pattern           | 格式化的数据样式                     | 是   | String  | 否   | 无     |
| currencyCode      | 货币单位代码                         | 是   | String  | 否   | 无     |
| cuttencySymbol    | 货币符号（$、￥）                    | 是   | String  | 否   | 无     |
| groupingUsed      | 是否对整数部分进行分组如（9，999）   | 是   | boolean | 是   | true   |
| maxIntergerDigits | 整数部分最对显示多少位数             | 是   | int     | 否   | 无     |
| minIntergerDigits | 整数部分最少显示多少位               | 是   | int     | 否   | 无     |
| maxFractionDigits | 小数部分最多显示多少位               | 是   | int     | 否   | 无     |
| minFractionDigits | 小数部分最少显示多少位               | 是   | int     | 否   | 无     |
| var               | 存储格式化后的数据                   | 否   | String  | 否   | 无     |
| scope             | var的JSP范围                         | 否   | String  | 否   | page   |

Type属性的类型应用见表：

| 类型     | 说明       | 示例   |
| -------- | ---------- | ------ |
| number   | 数字格式   | 0.8    |
| currency | 当地货币   | ￥0.80 |
| percent  | 百分比格式 | 80%    |

###### 2.2.\<frm:parseNumber>标签：将格式化后的数字、货币、百分比都转化为数字类型。
- 【语法1】：
```jsp
1. <fmt:parseNumber value="number" [type=”number|currency|percent”] 
2.      [pattern=”pattern”] 
3.      [parseLocale=”locale”] 
4.      [intergerOnly=”true|false”] 
5.      [scope=page|request|session|application”] 
6. /> 
```

- 【语法2】：
```jsp
1. <fmt:parseNumber [type=”number|currency|percent”] 
2.     [pattern=”pattern”] 
3.     [parseLocale=”locale”] 
4.    [intergerOnly=”true|false”] 
5.     [scope=”page|request|session|application”]>  
6. Number 
7. </fmt:parseNumber> 
```

\<fmt:parseNumber>标签参数说明：

| 名称        | 说明                           | EL   | 类型                     | 是否必须 | 默认值       |
| ----------- | ------------------------------ | ---- | ------------------------ | -------- | ------------ |
| value       | 被解析的字符串                 | 是   | String                   | 是       | 无           |
| type        | 指定单位（数字、货币、百分比） | 是   | String                   | 是       | number       |
| pattern     | 格式样式                       | 是   | String                   | 否       | 无           |
| parseLocale | 用来替代默认区域的设定         | 是   | String，Java.util.Locale | 是       | 默认本地样式 |
| var         | 存储已经格式化的数据           | 否   | String                   | 否       | 无           |
| scope       | var变量的作用域                | 否   | String                   | 是       | page         |

\<fmt:parseNumber>可以看作是\<fmt:formatNumber>的逆运算。相应的参数和类型的配置和使用\<fmt:formatNumber>格式化时相同。

###### 2.3.\<fmt:formatDate>标签：该标签主要用来格式化日期和时间。

- 【语法】：
```jsp
1. <fmt: formatDate value=”date” [type=”time|date|both”] 
2.     [pattern=”pattern”] 
3.     [dateStyle=”default|short|medium|long|full”] 
4.     [timeStyle=”default|short|medium|long|full”] 
5.     [timeZone=”timeZone”] 
6.     [var=”name”] 
7.     [scope=”page|request|session|application”] 
  8. /> 
```
\<fmt:formatDate>标签属性说明：

| 属性名    | 说明                               | EL   | 类型           | 必须 | 默认值       |
| --------- | ---------------------------------- | ---- | -------------- | ---- | ------------ |
| value     | 将要格式化的日期对象。             | 是   | Java.util.Date | 是   | 无           |
| type      | 显示的部分（日期、时间或者两者）。 | 是   | String         | 否   | date         |
| partten   | 格式化的样式。                     | 是   | String         | 否   | 无           |
| dateStyle | 设定日期的显示方式。               | 是   | String         | 否   | default      |
| timeStyle | 设定时间的显示方式。               | 是   | String         | 否   | default      |
| timeZone  | 设定使用的时区。                   | 是   | String         | 否   | 当地所用时区 |
| var       | 存储已格式化的日期或时间。         | 否   | String         | 否   | 无           |
| scope     | 指定var存储的JSP范围。             | 否   | String         | 否   | 无           |

| 参数名 | 说明           |
| ------ | -------------- |
| time   | 只显示时间     |
| date   | 只显示时期     |
| both   | 显示日期和时间 |


###### 2.4.\<fmt:parseDate>标签：主要将字符串类型的时间或日期转化为时间或日期对象。

- 【语法1】：
```jsp
1. <fmt:parseDate value=”date” [type=”time|date|both”] 
2.      [pattern=”pattern”] 
3.      [parseLocale=”locale”] 
4.      [dateStyle=”default|short|medium|long|full”] 
5.      [timeStyle=”default|short|medium|long|full”] 
6.      [timeZone=”timezone”] 
7.      [var=”name”] 
8.      [scope=”page|request|session|application”] 
9. /> 
```

- 【语法2】：
```jsp
1. <fmt:parseDate [type=”time|date|both”] 
2.     [pattern=”pattern”] 
3.      [parseLocale=”locale”] 
4.      [dateStyle=”default|short|medium|long|full”] 
5.      [timeStyle=”default|short|medium|long|full”] 
6.      [timeZone=”timezone”] 
7.      [var=”name”] 
8.      [scope=”page|request|session|application”]> 
9.      Date 
10. </fmt:parseDate> 
```

\<fmt:parseData>标签属性说明：

| 属性名      | 说明                             | EL   | 类型   | 必须 | 默认值   |
| ----------- | -------------------------------- | ---- | ------ | ---- | -------- |
| value       | 将要格式化的日期时间             | 是   | String | 是   | 无       |
| type        | 字符串的类型（日期、时间或全部） | EL   | String | 是   | date     |
| pattern     | 字符串使用的时间样式             | 是   | String | 是   | 无       |
| parseLocale | 取代默认地区设定                 | 是   | String | 是   | 默认地区 |
| dateStyle   | 字符串使用的日期显示方式         | 是   | String | 否   | default  |
| timeStyle   | 字符串使用的时间显示格式         | 是   | String | 否   | default  |
| timeZone    | 使用的时区                       | 是   | String | 否   | 当地区时 |
| var         | 使用var定义的名字保存对象        | 否   | String | 否   | 无       |
| scope       | var的JSP范围                     | 否   | String | 否   | page     |

###### 2.5.\<fmt:setTimeZone>标签：该标签用于设定默认时区或者将时区存储在指定的JSP范围内。
- 【语法】：
```jsp
1. <fmt:timeZone value=”timeZone”> 
2.     ….. 
3. </fmt:timeZone> 
```

1. 使用\<fmt:timeZone>\</fmt:timeZone>只会应用到标签体内使用的时区，对标签外部将不产生影响。  



##### 3.读取消息资源

读取消息资源用到的标签主要有4个：<fmt:message>标签、<fmt:param>标签、<fmt:bundle>标签和<fmt:setBundle>标签。主要用于从资源文件中读取信息。

###### 3.1.\<fmt:bundle>标签：该标签主要用于将资源文件绑定于它的标签体中的显示。

- 【语法】：
```jsp
  1. <fmt:bundle basename=”name”[prefix=”prefix”]> 
  2.      ….标签主题 
  3. </fmt:bundle> 
```
\<fmt:bundle>标签属性说明：

| 参数名   | 说明                     | EL   | 类型   | 必须 | 默认值 |
| -------- | ------------------------ | ---- | ------ | ---- | ------ |
| basename | 指定使用的资源文件的名称 | 是   | String | 是   | 无     |
| prefix   | 前置关键字               | 是   | String | 否   | 无     |


###### 3.2.\<fmt:setBundle>标签：该标签主要用于绑定资源文件或者把资源文件保存在指定的JSP范围内。
- 【语法】：
```jsp
1. <fmt:setBundle basename=”name” [var=”name”] 
2.      [scope=”page|request|session|application”] 
3. /> 
```
\<fmt:setBundle>标签属性说明：

| 参数名   | 说明                        | EL   | 类型   | 必须 | 默认值 |
| -------- | --------------------------- | ---- | ------ | ---- | ------ |
| basename | 指定使用的资源文件的名称    | 是   | String | 是   | 无     |
| var      | 指定将资源文件保存的名称    | 否   | String | 否   | 无     |
| scope    | 设定将资源文件保存的JSP范围 | 否   | String | 否   | page   |

###### 3.3.\<fmt:message>标签：该标签主要负责读取本地资源文件，从指定的消息文本资源文件中读取键值，并且可以将键值保存在指定的JSP范围内。

- 【语法1】：
```jsp
1. <fmt:message key=”keyName”[bundle=”bundle”] 
2.     [scope=”page|request|session|application”] 
3. /> 
```

- 【语法2】：
```jsp
  1. <fmt:message key=”keyName”[bundle=”bundle”] 
  2.      [scope=”page|request|session|application”]> 
  3.      <fmt:param/> 
  4. </fmt:message> 
```

- 【语法3】：
```jsp
  1. <fmt:message key=”keyName”[bundle=”bundle”] 
  2.      [scope=”page|request|session|application”]> 
  3.      key<fmt:param/> 
  4.      … 
  5. </fmt:message> 
```
\<fmt:message>标签属性说明：

| 参数名 | 说明                   | EL   | 类型                | 必须 | 默认值 |
| ------ | ---------------------- | ---- | ------------------- | ---- | ------ |
| key    | 指定键值的名称（索引） | 是   | String              | 是   | 无     |
| bundle | 指定消息文本的来源     | 是   | LocalizationContext | 否   | 无     |
| var    | 指定存储键值的变量名   | 否   | String              | 否   | 无     |
| scope  | 指定var的作用域        | 否   | String              | 否   | page   |

提示：建议此处的bundle使用EL表达式，因为属性bundle的类型为LocalizationContext，而不是一个String类型的URL。

###### 3.4.\<fmt:param>标签：该标签主要用于当<fmt:message>中资源文件中获得键值时，动态的为资源文件中的变量赋值。

- 【语法1】：
```jsp
1. <fmt:param value=”value”/> 
```

- 【语法2】：
```jsp
1. <fmt:param > 
2.      …标签主体 
3. </fmt:param> 
```

【示例代码】：
创建资源文件。在message.properties文件中增加一个key和value。
news={0} welcome to out website!
today is :{1,date}
表达的含义是键news对应的是一个字符串，字符串中还有动态变量{0}表示第一个动态变量，{1,date}表示第二个动态变量并且该变量是一个日期类型的对象。
通过标签从资源文件中取出键值，并给动态变量赋值显示在页面。
```jsp
1. <fmt:bundle basename="message"> 
2.     <fmt:message key="news"> 
3.         <fmt:param value="root" /> 
4.          <fmt:param value="${date}"/> 
5.     </fmt:message> 
6. </fmt:bundle> 
```

###### 3.5.国际化。

国际化这个分类中共包含两个标签：用于设定语言地区\<fmt:setLocale/>和用于设定请求的字符编码的\<fmt:requestEncoding>标签。
(1).\<fmt:setLocale>标签：用来设定用户语言区域。

- 【语法】：
```jsp
1. <fmt:setLocale value=”locale”[variant=”variant”] 
2.      [scope=”page|request|session|application”] 
3. /> 
```

\<fmt:setLocale>标签属性说明：

| 参数名  | 说明               | EL   | 类型                   | 必须 | 默认值 |
| ------- | ------------------ | ---- | ---------------------- | ---- | ------ |
| value   | 指定区域代码       | 是   | Stringjava.util.Locale | 是   | 无     |
| variant | 操作系统的类型     | 是   | String                 | 是   | 无     |
| scope   | 设定时区的作用范围 | 否   | String                 | 是   | page   |

value属性用来指定使用的语言代码，可以从浏览器的【工具】---【Internet选项】---【语言】---【添加】中查看浏览器支持的语言种类及语言代码。例如：中文（zh_cn）、台湾（zh_tw）、香港（zh_mo）等。

(2).\<fmt:requestEncoding>标签：用于设定请求的编码格式。功能同servletRequest.setCharacterEncoding()方法相同。

- 【语法】：
```jsp
1. <fmt:requestEncoding [value=”charEncoding”] /> 
```
【参数说明】：
value属性用来指定使用的编码集例如：gbk、gb2312等。当没有给出value的值时将会自动搜索取寻找合适的编码方式，因此能够很好的解决中文乱码问题。



##### 4.SQL标签库

JSTL提供了与数据库相关操作的标签，可以直接从页面上实现数据库操作的功能，在开发小型网站是可以很方便的实现数据的读取和操作。本章将详细介绍这些标签的功能和使用方法。
SQL标签库从功能上可以划分为两类：设置数据源标签、SQL指令标签。
引入SQL标签库的指令代码为：
```jsp
1. <%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>  
```


###### 4.1.设置数据源：使用\<sql:setDataSource>标签可以实现对数据源的配置。

- 【语法1】：直接使用已经存在的数据源。
```jsp
1. <sql:setDataSource dataSource=”dataSource”[var=”name”] 
2.     [scope=”page|request|session|application”] 
3. /> 
```

\<sql:DataSource>标签属性说明：

| 参数名     | 说明                    | EL   | 类型                       | 必须 | 默认值 |
| ---------- | ----------------------- | ---- | -------------------------- | ---- | ------ |
| dataSource | 数据源                  | 是   | StringJavax.sql.DataSource | 否   | 无     |
| driver     | 使用的JDBC驱动          | 是   | String                     | 否   | 无     |
| url        | 连接数据库的路径        | 是   | String                     | 否   | 无     |
| user       | 连接数据库的用户名      | 是   | String                     | 否   | 无     |
| password   | 连接数据库的密码        | 是   | String                     | 否   | 无     |
| var        | 指定存储数据源的变量名  | 否   | String                     | 否   | 无     |
| scope      | 指定数据源存储的JSP范围 | 否   | String                     | 否   | page   |

提示：是否必须是相对的，比如说如果使用数据源则，driver、url等就不再被使用。如果使用JDBC则要用到driver、url、user、password属性。
例如连接SQL Server需要进行如下配置：

```java
1. Driver="com.microsoft.jdbc.sqlserver.SQLServerDriver" 
2. url=”"jdbc:microsoft:sqlserver://localhost:1433; DatabaseName=pubs" 
3. user="sa" 
4. password="" 
```
```jsp
1. <fmt:setDataSource driver=”com.microsoft.jdbc.sqlserver.SQLServerDriver”  
2. url=”jdbc.microsoft:sqlserver://localhost:1433;DatabaseName=pubs” 
3. ser=”sa” 
4. password=””> 
```


###### 4.2.SQL操作标签：JSTL提供了\<sql:query>、\<sql:update>、\<sql:param>、\<sql:dateParam>和\<sql:transaction>这5个标签，通过使用SQL语言操作数据库，实现增加、删除、修改等操作。下面将介绍这5个标签的功能和使用方式。

(1).\<sql:query>标签：用来查询数据。

- 【语法1】：
```jsp
1. <sql:query sql=”sqlQuery” var=”name” [scope=”page|request|session|application”] 
2.      [dataSource=”dateSource”] 
3.      [maxRow=”maxRow”] 
4.      [startRow=”starRow”] 
5. /> 
```

- 【语法2】：
```jsp
1. <sql:query var=”name” [scope=”page|request|session|application”] 
2.      [dataSource=”dateSource”] 
3.      [maxRow=”maxRow”] 
4.      [startRow=”starRow”]> 
5.      sqlQuery 
6. </sql:query> 
```

\<sql:query>标签属性说明：

| 参数名     | 说明                       | EL   | 类型                       | 必须 | 默认值 |
| ---------- | -------------------------- | ---- | -------------------------- | ---- | ------ |
| sql        | 查询数据的SQL语句          | 是   | String                     | 是   | 无     |
| dataSource | 数据源对象                 | 是   | StringJavax.sql.DataSoutce | 否   | 无     |
| maxRow     | 设定最多可以暂存数据的行数 | 是   | String                     | 否   | 无     |
| startRow   | 设定从那一行数据开始       | 是   | String                     | 否   | 无     |
| var        | 指定存储查询结果的变量名   | 否   | String                     | 是   | 无     |
| scope      | 指定结果的作用域           | 否   | String                     | 否   | page   |

使用\<sql:query>必须指定数据源，dataSource是可选的，如果未给定该属性标签会在page范围内查找是否设置过数据源，如果没有找到将抛出异常。
一般情况下使用\<sql:setDateSource>标签设置一个数据源存储在session范围中，当需要数据库连接时使用dataSource属性并实现数据库的操作。
\<sql:query>的var属性是必须的用来存放结果集，如果没有指定scope范围则默认为page，即在当前页面我们可以随时输出查询结果。结果集有一系列的属性如表9-17所示。
maxRows和startRow属性用来操作结果集，使用SQL语句首先吧数据放入内存中，检查是否设置了startRow属性，如果设置了就从starRow指定的那一行开始取maxRows个值，如果没有设定则从第一行开始取。

结果集参数说明：

| 属性名           | 类型          | 说明                                      |
| ---------------- | ------------- | ----------------------------------------- |
| rowCount         | int           | 结果集中的记录总数                        |
| Rows             | Java.util.Map | 以字段为索引查询的结果                    |
| rowsByIndex      | Object[]      | 以数字为作索引的查询结果                  |
| columnNames      | String[]      | 字段名称数组                              |
| limitedByMaxRows | boolean       | 是否设置了maxRows属性来限制查询记录的数量 |

提示：limitedByMaxRows用来判断程序是否收到maxRows属性的限制。并不是说设定了maxRows属性，得到结果集的limitedByMaxRows的属性都为true，当取出的结果集小于maxRows时，则maxRows没有对结果集起到作用此时也为false。例如可以使用startRow属性限制结果集的数据量。
结果集的作用就是定义了数据在页面中的显示方式。下面给出了结果集每个属性的作用。
- rowCount属性。该属性统计结果集中有效记录的量，可以使用于大批量数据分页显示。
- Rows属性。等到每个字段对应的值。返回的结果为：字段名={字段值···}
- rowsByIndex属性。常用得到数据库中数据的方式，从有效行的第一个元素开始遍历，到最后一个有效行的最后一个元素。
- columnNames属性。用于得到数据库中的字段名。
- limitedByMaxRows属性。用于判断是否受到了maxRows的限制。

(2).\<sql:update>标签：用来实现操作数据库如：使用create、update、delete和insert等SQL语句，并返回影响记录的条数。

- 【语法1】：
```jsp
1. <sql:update sql=”SQL语句” [var=”name”]  
2.      [scope=”page|request|session|application”] 
3.      [dateSource=”dateSource”] 
4. /> 
```

- 【语法2】：
```jsp
1. <sql:update [var=”name”] 
2.      [scope=”page|request|session|application”] 
3.      [dateSource=”dateSource”]> 
4.      SQL语句 
5. </sql:update> 
```

\<sql:update>标签属性说明：

| 参数名     | 说明                     | EL   | 类型                       | 必须 | 默认值 |
| ---------- | ------------------------ | ---- | -------------------------- | ---- | ------ |
| sql        | 查询数据的SQL语句        | 是   | String                     | 是   | 无     |
| dataSource | 数据源对象               | 是   | StringJavax.sql.DataSoutce | 否   | 无     |
| var        | 指定存储查询结果的变量名 | 否   | String                     | 是   | 无     |
| scope      | 指定结果的作用域         | 否   | String                     | 否   | page   |

提示：\<sql:update>标签的属性同\<sql:query>标签的属性相比只减少了maxRows和startRow2个属性。其他参数用法一样。
使用\<sql:update>可以实现数据表的创建、插入数据、更行数据、删除数据。使用时只须在标签中放入正确的SQL语句即可，同时要捕获可能产生的异常。本节只对一个简单的插入操作进行说明。

(3).\<sql:param>标签：用于动态的为SQL语句设定参数，同<sql:query>标签共同使用。可以防止SQL注入作用类似于java.sql.PreparedStatement。

- 【语法1】：
```jsp
1. <sql:param value=”value”/> 
```

- 【语法2】：
```jsp
1. <sql:param>Value</sql:param> 
```
【参数说明】：
value的作用为SQL中的参数赋值。
【使用示例】：
```jsp
1. <sql:query var=”result”> 
2.      select * from person where 序号=？ 
3. <sql:query> 
```


(4).\<sql:dateParam>标签：主要用于为SQL标签填充日期类型的参数值。
- 【语法】：
```jsp
1. <sql:dateParam value=”date”[type=”timestamp|time|date”] /> 
```

【参数说明】：
- value属性：java.util.Date类型的参数。
- type属性：指定填充日期的类型timestamp（全部日期和时间）、time（填充的参数为时间）、date（填充的参数为日期）。

(5).\<sql:transaction>标签：提供了数据操作的一种安全机制（即事务回滚），当操作数据库的某条SQL语句发生异常时，取消\<sql:transaction>标签体中的所有操作，恢复原来的状态，重新对数据库进行操作。

- 【语法】：
```jsp
1. <sql:transaction [dataSource=”dataSource”] 
2.      [isolation=”read_committed|read_uncommitted|repeatable|serializable”]> 
3.      <sql:query> 
4.      <sql:uptade> 
5. </sql:transation> 
```



##### 5.XML标签库

JSTL提供了操作xml文件的标签库，使用xml标签库可以省去使用Dom和SAX标签库的繁琐，能轻松的读取xml文件的内容。

###### 5.1.\<x:parse>标签：用来解析指定的xml文件
- 【语法1】：
```jsp
1. <x:parse doc=”xmlDocument”  
2.      {var=”name”[scope=”page|request|session|application”]|varDom=”name” 
3.      [scope=”page|request|session|application”]} 
4.      systemId=”systemId” 
5.      filter=”filter” 
6. /> 
```

- 【语法2】：
```jsp
1. <x:parse var=”name” >
2.      [scope=”page|request|session|application”]|varDom=”name” 
3.      [scope=”page|request|session|application”]} 
4.      systemId=”systemId” 
5.      filter=”filter”> 
6.      xmlDocument 
7. </x:parse> 
```
\<x:parse>标签属性说明：

| 属性名   | 说明                                              | EL   | 类型               | 必须 | 默认值 |
| -------- | ------------------------------------------------- | ---- | ------------------ | ---- | ------ |
| doc      | 指定解析的xml文件                                 | 是   | String/Reader      | 是   | 无     |
| var      | 存储解析后的xml文件                               | 否   | String             | 否   | 无     |
| scope    | 指定var的JSP范围                                  | 否   | String             | 否   | page   |
| varDom   | 以（org.w3c.dom.Doucemet）的形式存储解析的xml文件 | 否   | String             | 否   | 无     |
| scopeDom | 指定varDom的JSP范围                               | 否   | String             | 否   | page   |
| systemId | xml文件的url                                      | 是   | String             | 否   | 无     |
| filter   | 解析xml文件的过滤器                               | 否   | Org.xml.sax.Filter | 否   | 无     |

提示：doc指定解析的xml文件并不是指定xml文件的路径，而是同\<c:import>共同使用，由\<c:import>加载并存储，然后使用\<x:parse>解析。

例如：如果解析person.xml文件需要通过如下代码实现对xml文件的解析。
\<c:import var="docString" url="person.xml"/><!--引入person.xml文件-->
\<x:parse var="doc" doc="${docString}"/>
\<c:import>语句用来导入或存储文件到JSP。如果不使用var来存储，xml文件将显式的出现在JSP文件中。
\<x:parse>标签只用来解析xml文件，并不显示xml文件中的内容，如果想得到xml的节点元素或值需要使用\<x:out>元素来实现。

###### 5.2.\<x:out>标签：主要用来输出xml的信息

- 【语法】：
```jsp
1. <x:out select=”XpathExperssion”[excapeXml=”true|false”]> 
```
\<x:out>标签属性说明：

| 属性名    | 说明                    | EL   | 类型    | 必须 | 默认值 |
| --------- | ----------------------- | ---- | ------- | ---- | ------ |
| select    | 指定使用的XPath语句     | 否   | String  | 是   | 无     |
| escapeXml | 是否转换特殊字符。如<等 | 否   | boolean | 是   | true   |

提示：使用XPath语句需要用到xalan.jar支持包，可以从示例程序的lib中获取，获得直接从myEclipse中可以找到。

###### 5.3.\<x:set>标签：用于将从xml文件节点解析的内容存储到JSP属性范围中。

- 【语法】：
```jsp
1. <x:set select="XPathExperssion" 
2.      var="name" 
3.      scope="page|request|session|application"> 
```

###### 5.4.XML流程控制：使用xml标签库的流程控制标签可以迭代处理xml文件的内容，流程控制可以分为以下两个方面的内容：
- 条件判断。
- 循环功能。

(1).\<x:if>标签：主要用于条件判断。

- 【语法1】：未含有本体内容。

```jsp
1. <x:if select=”XPathExperssion” var=”name”[scope=”page|request|session|application”] /> 
```

- 【语法2】：含有本体内容。

```jsp
1. <x:if select=”XPathExperssion” var=”name”[scope=”page|request|session|application”]> 
2.      本体内容 
3. </x:if> 
```

I、select用来指定使用的XpathExperssion表达式。
II、var设定标量名用来存储表达式的结果。
III、scope指定var存储的JSP属性范围。

(2).\<x:choose>、\<x:when>和\<x:otherwise>标签：同核心标签库的\<c:choose>、\<c:when>和\<c:otherwise>标签作用相似，只是使用的条件表达式不同。
\<x:choose>是主标签，\<x:when>和\<x:otherwise>放在\<x:choose>标签体内共同使用。

- 【语法1】：
```jsp
1. <x:choose> 
2.      <x:when> 
3.      <x:when> 
4.      <x:otherwise> 
5. </x:choose> 
```
其中只有\<x:when>有属性。

- 【语法2】：
```jsp
1. <x:when select=”XPathExperssion”>  
```

(3).\<x:forEach>标签：实现了对xml文档的遍历

- 【语法】：
```jsp
1. <x:forEach select=”XPathExperssion” 
2.      [var=”name”] 
3.      [varStartus=”StartusName”] 
4.      [begin=”begin”] 
5.      [end=”end”] 
6.      [step=”step”]> 
7.      //标签主体 
8. </x:forEach> 
```
\<x:forEach>标签属性说明： 

| 属性名    | 说明                           | EL   | 类型   | 必须 | 默认值 |
| --------- | ------------------------------ | ---- | ------ | ---- | ------ |
| select    | 指定使用的XPath语句            | 否   | String | 是   | 无     |
| var       | 用于存储表达式的结果           | 否   | String | 否   | 无     |
| varStatus | 用来存放循环到的变量的相关信息 | 否   | String | 否   | 无     |
| begin     | 循环的起始位置                 | 是   | int    | 否   | 无     |
| end       | 循环的终止位置                 | 是   | int    | 否   | 无     |

###### 5.5.xml的文件转换
\<x:transform>和\<x:param>能轻易使用XSLT样式包装xml文件，成为另一种显示方式。
(1).\<x:transform>标签：可以轻松的实现xml到XSLT的转化。
- 【语法1】：
```jsp
1. <x:transform doc=”xmldoc” 
2.      xslt=”XSLTStytlesheet” 
3.      [docSystemId=”xmlsystemid”] 
4.      [result=”result”] 
5.      [var=”name”] 
6.      [scope=”scopeName”] 
7.      [xsltSystemId=”xsltsystemid”] 
8. /> 
```

- 【语法2】：
```jsp
1. <x:transform doc=”xmldoc” 
2.      xslt=”XSLTStytlesheet” 
3.      [docSystemId=”xmlsystemid”] 
4.      [result=”result”] 
5.      [var=”name”] 
6.      [scope=”scopeName”] 
7.      [xsltSystemId=”xsltsystemid”]> 
8.      <x:param/> 
9. </x:transform> 
```

- 【语法3】：
```jsp
1. <x:transform doc=”xmldoc” 
2.      xslt=”XSLTStytlesheet” 
3.      [docSystemId=”xmlsystemid”] 
4.      [result=”result”] 
5.      [var=”name”] 
6.      [scope=”scopeName”] 
7.      [xsltSystemId=”xsltsystemid”]> 
8.      Xml文件内容 
9.      <x:param/> 
10. </x:transform> 
```

\<x:transform>标签属性说明：

| 属性名       | 说明                                      | EL   | 类型               | 必须 | 默认值 |
| ------------ | ----------------------------------------- | ---- | ------------------ | ---- | ------ |
| doc          | 指定xml文件来源                           | 是   | String             | 是   | 无     |
| xslt         | 转化xml的样式模板                         | 是   | String             | 是   | 无     |
| docSystemId  | xml文件的URI                              | 是   | String             | 否   | 无     |
| xsltSystemId | xslt文件的URI                             | 是   | String             | 否   | 无     |
| result       | 用来存储转换后的结果对象                  | 是   | java.xml.transform | 是   | 无     |
| var          | 以org.w3c.dom.Documet类型存储转换后的结果 | 否   | String             | 否   | 无     |
| scope        | var的属性范围                             | 否   | String             | 否   | 无     |

(2).\<x:param>标签：用来为<x:transform>标签转换参数。
- 【语法1】：
```jsp
1. <x:param name=”name” value=”value” /> 
```

- 【语法2】：
```jsp
1. <x:param name=”name” value=”value”>Value</x:param> 
```
【参数说明】：
- name指定参数的名称。
- value指定参数值。



ref:

1.[JSTL 表达式与 EL 语言](http://leon906998248.iteye.com/blog/1502569),   2.[java学习——Jstl标签库大全](https://blog.csdn.net/u010168160/article/details/49183659),   3.[SpringMVC入门之七：使用JSP作为视图](https://blog.csdn.net/zhoucheng05_13/article/details/56669118),   4.http://baike.baidu.com/view/1488964.htm,   5.http://www.cnblogs.com/jinzhengquan/archive/2011/02/13/1953150.html,   6.http://www.blogjava.net/maverick1003/articles/236575.html,   7.https://www.ibm.com/developerworks/cn/java/j-jstl0211/,   8.[走进Java（五）JSTL和EL表达式 ](https://blog.csdn.net/u010096526/article/details/50038365)

