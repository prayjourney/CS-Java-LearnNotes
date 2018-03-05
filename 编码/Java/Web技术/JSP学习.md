## JSP快速入门教程

### 第一讲

##### 1.JSP 和 Java的关系

一般Java指的标注版 Java SE，另外两个版本: Java EE 和 Java ME
**JSP属于Java EE的一部分**，Java EE包括如下:

- 组件: Web层组件（JSP＋Servlet）＋业务层组件（EJB）
- 服务: JNDI，JDBC，RMI，JAAS，JavaMail等等
Java EE包括2个体系: 标准（上面介绍的）＋流行（Struts＋Hibernate＋Spring）,两套体系都是JSP＋Servlet为基础。

##### 2.JSP会涉及哪些内容

JSP语法基础（Java＋HTML）: 
对于*Java*:
- 需要掌握Java的基本语法（类定义，对象定义)
- 使用常用类库(如java.lang.*,java.util.*）

对于*HTML*:
- 主要表单元素（输入）＋表格（显示信息）＋基本HTML
- JSTL，标准标签库，用于输出和控制
- EL，通常与JSTL一起使用，主要用于输出
- Servlet，几乎所有介绍JSP的书和课程都包含Servlet，因为JSP实际上指的是Java Web开发。用Servlet主要是控制器
- JDBC，对数据库的访问
- JavaBean（Java类，作为数据的模型）

##### 3.JSP的运行环境

- JDK
- 服务器: 我们用Tomcat。其它的服务器: IBM Websphere + BEA WebLogic  + JBoss（免费的） + GlassFish(新出的Java EE 5服务器)

##### 4.JSP的开发环境

- 页面: DreamWeaver开发页面
- 代码: 本文编辑器 Eclipse, IDEA, MyEclipse

##### 5. Tomcat文件夹

- webapps: 主要各个应用，编写的每个应用（网站）都可以放在这个位置
- bin:  这个是启动服务器的相关文件，tomcat6用于命令行方式的启动，tomcat6w用于windows方式的启动
- conf: 用于配置，常用的是server.xml 另外一个是web.xml
- work:  存放临时文件
- logs:  系统运行时候的日志信息

##### 6.实例: hello.jsp

创建一个应用，实际上需要在webapps中创建文件夹，bookstore，相当于应用的名字，文件夹中要创建一个子文件夹WEB-INF，这个每个应用web应用都需要的。
在WEB-INF中需要web.xml，是web应用的配置文件，还应该有classes和lib子文件夹（存放类文件）
JSP文件和HTML文件直接放在bookstore下面。

hello.jsp:
```jsp
<%@ page contentType="text/html;charset=gb2312"%>
<!-- 上面的代码声明文档类型和编码方式，每个JSP文件基本上都会有 -->
<html>
   <head>
      <title>第一个JSP程序</title>
   </head>

   <body>
      Hello,晚上好！
   </body>   
</html>
```
先启动服务器: 访问程序: <http://127.0.0.1:8080/bookstore/hello.jsp>
http表示协议；127.0.0.1表示主机IP地址；也可以写主机名字；8080表示服务的端口，上网的时候不用输入端口，因为采用了默认的端口，默认端口80；bookstore表示应用，是应用的名字；  hello.jsp就是资源

##### 7. JSP的运行原理

过程: 
1.首先启动服务器，并且要保证应用在服务器上（把应用放在webapps下面，会自动加载）
2.在客户端通过浏览器发送请求（在地址栏中输入地址）
3.服务器接收到请求之后，查找有没有这个文件对应的Java文件的对象。如果没有这个对象，需要创建（先把JSP文件转换成Java文件，
4.编译成.class文件，加载类并创建对象），然后调用对象的相应方法，方法完成对用户的响应，通常是输出的html代码）
5.客户端接收到的是html代码，浏览器解析这个代码生成页面

##### 8.表格的语法

- 开始标志: `<table> `
- 结束标志: `</table>`
- 中间是行，每行是一个`<tr>  </tr>`
- 每行之间是列，每一列对应`<td> </td>`，`<td></td>`之间的内容就是每个表格中的信息


ref: 1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第1章



### 第二讲

##### 1.form
**只要是涉及向服务器提交信息，都应该使用form**
基本语法结构: 
```html
<form action="目标文件" method="get|post">
    各种表单元素
</form>
```
**action属性决定的目标文件来对用户提交的信息进行处理**



##### 2.常用的表单元素
1).**单行文本框**: 用于输入少量的信息
基本语法格式: 
```html
<input type="text" name="名字" value="值">
```
> type="text"就说明这是单行文本框
>
>  name指出文本框的名字，最好不要用汉字，最好使用有意义的名字；
>
>  value指出默认值，如果没有默认值，可以不要value属性，value属性经常在修改的时候使用。

注意: 如果有格式要求，要明确的告诉用户。



2).**密码框**: 用于输入密码。
基本的语法格式: 
```html
<input type="password" name="名字" value="值">
```
注意: 设置密码的时候，应该使用确认密码，应该有两个密码框。



3).**提交按钮**: 当点击它的时候，会把输入的信息提交给服务器。
基本语法格式: 

```html
<input type="submit" value="值">
```

> type应该为submit，value是显示在按钮上面的信息。



4).**复位按钮**: 当点击它的时候，会把各个表单元素的值恢复到默认值。
基本语法格式: 

```html
<input type="reset" value="值">
```



5).**普通按钮**: 也可以完成提交，还可以完成方法的调用。
基本语法格式: 

```html
<input type="button" value="值">
```



6).**单选按钮**: 通用用于在多个选项中选择一个。
基本语法格式: 
```html
   <input type="radio" name="名字" value="值">
```
这个表示一个单选按钮，并且仅仅是一个按钮。
```html
<!--例，选择性别: -->
<input type="radio" name="sex" value="1" checked>男
<input type="radio" name="sex" value="0">女
```
如果希望在多个选项中选择一个（有互斥性），必须让他们的名字一致。



7).**复选框**: 用于多选。
基本的语法格式: 
```html
<input type="checkbox" name="名字" value="值">
```
显示给用户的信息与提交给服务器的信息没有关系。如果希望多个选项是一组，应该使用相同的名字。



8).**下拉列表**: 用于选择，可以单选，也可以多选。
基本语法格式: 

```html
<select name="名字">
      <option value="1" selected>1</option>
      <option value="2">2</option>
      ...
</select>
```
每个选项使用一个option，使用value属性指出该选项的值，在<option>和</option>之间是显示给用户的值。

   

9).**文本域**: 用于输入大量的信息。
基本语法格式: 
```html
<textarea name="名字" cols="列数" rows="行数">
   默认值
</textarea>
```
要为这个文本域赋默认值，需要把值放在开始标志和结束标志之间，而不是使用value属性。



##### 3.完成输入的时候应该注意的问题
**对格式的要求必须明确**，包括长度、数字、日期、email、电话、必添。

*能够从系统中获取的信息不要让用户提供*，例如当前时间。

*能够选择的信息不要让用户输入*。

**按照信息的重要程度安排表单元素在界面中的位置**。



##### 4.对用户输入信息进行验证
1.要用JavaScript，使用下面的标记: 
```html
<script language="javascript">
    //JavaScript代码
</script>
```
2.要写方法
```javascript
function check(){
  }
```
方法可以不用定义返回值，但是可以有返回值

3.获取用户输入的值: 

```html
document.form1.username.value
```

document表示当前文档，form1表示表单的名字，username表示该表单中表单元素的名字，value表示得到值

4.把表单提交与方法关联: 可以使用表单的onSubmit事件

```html
onSubmit="return check();"
```

例: 

```css
<script language="javascript">
   function check(){
      username = document.form1.username.value;
      if(username.length<6 || username.length>8){
         alert("用户名长度不合适！");
         return false;
      }else{
         return true;
      }
   }
</script>
```

> 使用button的onClick事件进行验证: 
>
> 首先要把提交按钮修改成普通按钮；
>
> 在普通按钮上增加事件: onClick="javascript:check()" 
>
> 在验证成功的时候，提交表单: document.form1.submit();

ref:1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第2章



### 第三讲

##### 1.include指令

作用: 把多个文件中需要共享的代码放在单独的文件中，然后在需要的时候使用该指令引入这个文件。典型的应用，把网站的头部和版权信息放在单独的文件中，在其他文件中包含这两部分。
基本的语法格式: 
```html
<%@ include file="目标文件"%>
```
> file属性指出目标文件。

例: 把index.jsp和register.jsp中的共同部分做成单独的文件header.jsp（后缀名不一定是.jsp），然后在index.jsp和register.jsp中调用。
header.jsp: 
```html
<%@ page contentType="text/html;charset=gb2312"%>
<table  align="center" width=780>
   <tr height="100">
      <td align="center"><h1>电子书店</h1></td>
   </tr>
   <tr>
      <td align="center">
         <!-- 超链接的基本格式  -->
         <a href="register.jsp">注册</a> 
         最新图书 最畅销图书 查询图书 修改密码 查询订单 购物车</td>
   </tr>
   <tr>
      <td><hr></td>
   </tr>
</table>
```
在index.jsp中引入header.jsp的代码: 

```jsp
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="header.jsp"%>
   <tr>
      <td>
         <table>
             <tr>
                 <td>
                     <!--登录界面代码-->
                     <form action="login_process.jsp" method="post">
                        <!-- 主要是涉及提交信息，就要用到form，action决定了提交给哪个文件处理 -->
                        用户名: <input type="text" name="username" value="aaa"> <br>
                        口令: <input type="password" name="userpass" value=""> <br> 
                        <input type="submit" value="登录"><input type="reset" value="重写">
                     </form>
                 </td>
                 <td>
                      欢迎光临我们的书店！
                 </td>
             </tr>
         </table>
      </td>
   </tr>
```


运行过程: 在转换的时候，**当遇到include指令的时候会把include指令指向的目标文件的内容拷贝到当前位置，替换include指令，这样最后形成一个文件**。然后才编译形成class文件，然后运行



##### 2.<jsp:forward>标签

我们使用登录功能的模拟来介绍。首先，使用Java代码完成判断，使用<jsp:forward>完成跳转，代码如下: 

```html
<%@ page contentType="text/html;charset=gb2312"%>
<%
   // 先获取用户输入的用户名和口令，然后判断是否合法
   String username = request.getParameter("username");
   String userpass = request.getParameter("userpass");
   if(username.equals("zhangsan") && userpass.equals("zhangsan"))
   {
%>
       <jsp:forward page="success.jsp"/>
<%
   }else{
%>
       <jsp:forward page="index.jsp"/>
<%
   }
%>
```

> 注意: 不管跳转到success.jsp还是index.jsp，地址栏都是处理文件的名字。

<jsp:forward>的语法格式: 

```html
<jsp:forward page="目标文件"/>
```

> page属性指出转向的目标文件。最后的结束符为“/>”，斜杠不能省略。

另外一个可以完成跳转的方式是采用**response.sendRedirect()**。response和request一样，都是内容对象，可以直接访问。修改上面的文件: 

```html
<%@ page contentType="text/html;charset=gb2312"%>
<%
   // 先获取用户输入的用户名和口令，然后判断是否合法
   String username = request.getParameter("username");
   String userpass = request.getParameter("userpass");
   if(username.equals("zhangsan") && userpass.equals("zhangsan"))
   {
       response.sendRedirect("success.jsp");
   }else{
       response.sendRedirect("index.jsp");
   }
%>
```

**<jsp:forward**>和**response.sendRedirect**的运行效果相同（针对上面的这个例子），但是实现原理有差异
**相同点**: 都是转向目标文件。
**不同点**: 

- *地址栏中显示的内容是不相同的*，如果使用<jsp:forward>，地址栏显示**当前文件的名字**，如果使用response，地址栏显示的是**转向后的文件的名字**。
- *执行过程不同*，使用<jsp:forward>相当于**一次请求**，使用response相当于**两次请求**。

###### 使用<jsp:forward>的情况: 

index.jsp中输入用户名和口令，提交给login_process.jsp，服务器保存用户的输入信息，使用<jsp:forward>转向success.jsp之后，success.jsp还可以访问用户输入的信息，因为输入同一次请求。

###### 使用response的情况: 

index.jsp中输入用户名和口令，提交给login_process.jsp，服务器保存用户的输入信息，使用response的sendRedirect方法相当于重新向服务器发送一次请求，这样上次的请求内容（用户名和口令）就不能共享了。



##### 3.<jsp:include>标签

把index.jsp中<%@ include="header.jsp"%>替换成<jsp:include page="header.jsp"/>从运行效果上相同。

不同点在于: 

- 两个文件，目标文件是单独运行的，当前文件运行到<jsp:include>标签的时候，转向执行标签所指向的目标文件，执行之后返回继续标签之后的内容。
- `<%@ include%>`指令是在编译（转换）的时候使用，<jsp:include>在运行的时候起作用。

程序中如何选用: **要导入的内容是不是每次都执行，如果每次都执行的话，应该使用<%@ include%>**，*如果是在特定的条件下，应该使用<jsp:include>*。例如，登录之后要么转向success.jsp要么转向index.jsp，如果在程序中使用导入，应该用<jsp:include>。



##### 4.<jsp:include>和<jsp:forward>区别

把login_process.jsp中的<jsp:forward>替换成<jsp:include>: 

```jsp
<%@ page contentType="text/html;charset=gb2312"%>
<%
   // 先获取用户输入的用户名和口令，然后判断是否合法
   String username = request.getParameter("username");
   String userpass = request.getParameter("userpass");
   if(username.equals("zhangsan") && userpass.equals("zhangsan"))
   {
%>
       <jsp:include page="success.jsp"/>
<%
   }else{
%>
       <jsp:include page="index.jsp"/>
<%
   }
%>
```

运行效果是相同的。**但是有不同点**，修改代码如下: 

```jsp
<%@ page contentType="text/html;charset=gb2312"%>
处理文件的前半部分<br>
<%
   // 先获取用户输入的用户名和口令，然后判断是否合法
   String username = request.getParameter("username");
   String userpass = request.getParameter("userpass");
   if(username.equals("zhangsan") && userpass.equals("zhangsan"))
   {
%>
       <jsp:include page="success.jsp"/>
<%
   }else{
%>
       <jsp:include page="index.jsp"/>
<%
   }
%>
<br>处理文件的后半部分
```

两次运行结果不相同。
分析原因: 

<jsp:forward>:先执行标签之前的内容，遇到标签的时候转向执行目标文件，执行完不返回，显示的内容为目标文件的内容，标签之前的内容执行，但是不显示。标签之后的内容不会执行，当然更不会显示。

<jsp:include>: 先执行标签之前的内容，遇到标签转向执行目标文件，执行完返回，继续执行标签之后的内容，显示的内容为: 标签之前的内容+目标文件的内容+标签之后的内容，标签的前后都执行，都显示。



##### 5.使用标准标签库（JSTL）完成登录的判断过程
如何使用标签标签库: 

1).得到标签库的实现文件，jstl.jar和standard.jar，放在`WEB-INF`下面的`lib`子文件夹。

2).在JSP文件中要声明标签库，通过tablib指令进行声明:` <%@ taglib prefix="c" uri="[http://java.sun.com/jsp/jstl/core"%](http://java.sun.com/jsp/jstl/core)>` 

3).使用标签: `<c:if test="">  </c:if>`。要完成判断，可以使用标签标签库中的c:if标签。

标签的基本格式: 

```html
<c:if  test="">条件成功要执行的内容</c:if>
```
> test表示测试条件，测试条件可以写常量，可以是表达式语言（EL，主要用于输出），主要使用表达式语言。  

 例如: 要判断用户提交的用户名和口令是否是zhangsan。

```html
<c:if test="${param.username==/"zhangsan/" && param.userpass==/"zhangsan/"}"> 
    <jsp:forward page="success.jsp"/> 
</c:if>
```

注意: **添加完标准标签库之后，需要重新启动服务器**。



##### 6.使用session保存登录后的信息

在网站中设置了application, session, request, pageContext对象保存内存中的信息。application是网站所有用户共享的存储变量的位置。*session是网站为每个访问网站的人创建的，每个用户对应一个session，也是存放变量的位置*。**request是为每个用户的每次请求设置的存储信息的位置，每次访问会有一个request**。pageContext是每次访问的每个页面对应一个。**常用的session和request**。**多次访问之间要共享信息可以使用session**，如果在某次访问的多个页面之间共享信息使用request（例如，使用jsp:forwrad转向的文件和当前文件就属于同一次请求）。**登录后的用户信息应该放在session中**。
要在这些范围中保存信息，可以使用标准标签库中的<c:set>标签完成。
<c:set>的基本语法格式: 
```html
<c:set var="变量的名字" scope="范围" value="值"/>
```
  要把用户名放到session中: 

   ```html
<c:set var="username" scope="session" value="${param.username}"/>
   ```

ref：1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第3.4章



### 第四讲

##### 1.对Servlet的理解

Servlet是一种Java类。

Servlet能够完成与JSP相同的功能。能够接收用户的请求，能够调用功能类的方法，可以对用户进行响应。

Servlet和JSP同属于Java EE中Web层组件。



##### 2.如何编写一个Servlet

假设: 该Servlet的功能为显示欢迎信息。

Java文件的编写过程: (1)声明包 (2)引入用到的其他的类 (3)类的编写

对于类: （1）类头——修饰符 class关键字 类名 继承父类 实现接口
​              （2）类体——成员变量 构造方法 对属性进行操作的方法 功能类方法
对于成员变量: 修饰符 类型 变量名（对象名） 
对于方法（不包括构造方法）: 修饰符 返回值类型 方法名 参数列表 异常列表 方法体
对于方法体: 变量的声明 各种运算 调用其他的方法 返回结果

1).声明包，假设包名为servlet

```java
package servlet;
```

2.)引入用到的类，javax.servlet.* javax.servlet.http.* java.io.*

```java
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
```

3.)类头的定义
访问控制符: public
类名: HelloServlet
继承父类: javax.servlet.http.HttpServlet 
实现接口: 没有要实现的接口

```java
public class HelloServlet extends HttpServlet
```

4.)方法的定义
主要的方法: `init`方法（用于初始化），`destroy`方法（释放资源），`doGet`或者`doPost`（完成主要功能）
通常主要实现doGet方法或者doPost方法，分别对应客户端的get请求和post请求。

```java
public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
{
    // 设置编码方式
    response.setContentType("text/html;charset=gb2312");
    // 得到输出流对象
    PrintWriter out = response.getWriter();
    out.println("欢迎学习JSP！");
}
public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
{
   doGet(request,response);
}
```



##### 3.编译存放

需要用到`javax.servlet.*`和`javax.servlet.http.*`，**两个包的实现在tomcat下面的lib中，名字为servlet-api.jar**。

- 放在（编译后的Servlet）: WEB-INF/classes

- 配置path: 把C:/Program Files/Java/jdk1.6.0/bin添加到path中，但是不能破坏原有的路径。

- 配置classpath: 把C:/Program Files/Apache Software Foundation/Tomcat 6.0/lib/servlet-api.jar;添加到classpath中。

- 编译: 在命令行方式下进入到classes目录，然后使用 javac -d . HelloServlet.java   -d表示生成包的路径，.表示在当前位置生成。




##### 4.配置Servlet

- 配置文件及位置: WEB-INF下面的web.xml。
- 配置包括两个方面: Servlet的声明 以及 Servlet访问方式的声明

Servlet的声明: 

```xml
 <servlet>
    <servlet-name>hello</servlet-name>
    <servlet-class>servlet.HelloServlet</servlet-class>
 </servlet>
```

其中，<servlet-name>表示这个servlet的名字，可以随便起。<servlet-class>是对应的Servlet类，应该包含包的信息。

Servlet访问方式的声明: 

```xml
 <servlet-mapping>
    <servlet-name>hello</servlet-name>
    <url-pattern>/hello</url-pattern>
 </servlet-mapping>
```

其中，<servlet-name>和Servlet声明中的用法相同，并且应该与Servlet声明中的名字保持一致。<url-pattern>表示访问方式，决定了在客户端如何访问这个Servlet。



##### 5.访问Servlet

<http://127.0.0.1:8080/bookstore/hello>



##### 6.用Servlet完成login_process.jsp的功能

login_process.jsp主要功能，判断用户输入的用户名和口令是否合法，然后根据判断的结果选择界面对用户响应。
对于JSP文件来说，优势在于显示信息，login_process.jsp中的代码都不是显示信息的，主要用于控制。在Java Web应用中存在大量的这种现象。是Java Web中的控制功能。主要使用Servlet完成控制。
login_process.jsp的基本功能: 获取用户的输入信息；进行判断；转向。
如果使用Servlet完成，功能代码应该写在doGet或者doPost方法中。对应上面的3个功能分别实现如下: 
获取用户信息: 用户信息存储在doGet或者doPost方法的第一个参数中，所以从参数中获取，获取的代码为
```java
String username = request.getParameter("username");
String userpass = request.getParameter("userpass");
```
判断: 
```java
if( username.equals("zhangsan") && userpass.equals("zhangsan") )
```
转向响应界面: 
第一种方式: `response.sendRedirect("index.jsp");`
第二种方式: 与`<jsp:forward>`功能相同

```java
RequestDispatcher rd = request.getRequestDispatcher("index.jsp");  // 参数是要转向的页面
rd.forward(request,response); // 完成跳转
```



LoginProcessServlet.java代码如下: 
```java
package servlet;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginProcessServlet extends HttpServlet
{
  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
       // 获取用户输入的信息
        String username = request.getParameter("username");
        String userpass = request.getParameter("userpass");
        if( username.equals("zhangsan") && userpass.equals("zhangsan") )
        {
           RequestDispatcher rd = request.getRequestDispatcher("success.jsp");  // 跳转到成功的页面
           rd.forward(request,response); // 完成跳转 
        }else
        {
           RequestDispatcher rd = request.getRequestDispatcher("index1.jsp");  // 跳转到登录页面
           rd.forward(request,response); // 完成跳转 
        }
 }

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
     doGet(request,response);
  }
}
```
配置文件中添加如下代码: 

```xml
 <servlet>
    <servlet-name>login_process</servlet-name>
    <servlet-class>servlet.LoginProcessServlet</servlet-class>
 </servlet>
 <servlet-mapping>
    <servlet-name>login_process</servlet-name>
    <url-pattern>/login_process</url-pattern>
 </servlet-mapping>
```

修改index1.jsp的代码（修改form所在行）

修改前: 

```html
<form action="login_process.jsp" method="post">
```

修改后: 

```html
<form action="login_process" method="post">
```

ref:1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第6章





### 第五讲

##### 1.JavaBean

**JavaBean是使用Java语言编写的组件**。组件是组成一个大的系统的一部分，并且组件能够完成特定的功能，能够共享。可以认为JavaBean是Java类，但是具有特定的功能，并且这些功能是共享的。例如，连接数据库的功能可以封装单独的Java类，常用处理方法可以封装成JavaBean。



#####  2.早期的JSP中提供的对JavaBean的支持

<jsp:useBean>标签用于定义JavaBean的对象；<jsp:setProperty>标签用于设置JavaBean的属性；<jsp:getProperty>用于获取并输出JavaBean的属性。因为Java Web中，很少在JSP中直接访问JavaBean，所以实际上这些标签几乎没有用。现在主要在Servlet中访问JavaBean。



#####  3.JavaBean的编写和用法

例: 以用户信息验证为例介绍JavaBean的编写。

1).声明包

```java
package bean;
```

2).引入相应的类或者包

```java
import java.sql.*;
// java.sql是访问数据库所需要的包
```

3).类头的定义

```java
public class UserBean
```

4).成员变量

```java
private String username;
private String userpass;
```

5).构造方法

```java
// JavaBean要求应该提供一个无参数的构造方法
public UserBean(){
 }
public UserBean(String username,String userpass){
   this.username = username;
   this.userpass = userpass;
 }
```

6).对属性进行操作的方法
包括获取属性值的方法和对属性进行赋值的方法。
命名方法: 

- 对于普通属性来说，如果属性为a，应该提供setA(属性类型 a)方法和getA()方法。
- 对于布尔类型的属性来说，应该提供类似于isA()方法。

```java
  public void setUsername(String username){
      this.username = username;
   }
   public String getUsername(){
      return username;
   }

   public void setUserpass(String userpass){

      this.userpass = userpass;

   }

   public String getUserpass(){

      return userpass;

   }

```

7).功能类方法

该JavaBean完成的功能是判断用户信息是否合法，需要在JavaBean中编写相应的方法。   

```java
public boolean login(){
      return username.equals(userpass);
   }
```

8).编译JavaBean
9).部署
所有的Java类都应该放在WEB-INF下面的classes下面，所以该JavaBean也应该放在这个地方。



##### 4.使用JDBC的准备工作

JDBC是Java DataBase Connectivity的缩写，是一组标准的接口，用于完成Java应用与各种数据库之间的交互。

要使用JDBC需要做哪些准备工作？

- 创建数据库 
- 得到JDBC驱动程序，驱动程序是完成具体的交互过程的，每种数据库有自己特定的驱动程序，从数据库管理系统的提供商的网站下载 
- 要知道数据库的相关信息: JDBC驱动程序的名字、数据库的位置、数据库的端口、用户名和口令、url的格式（建立连接的时候用）

> 注意: 我们使用JDBC-ODBC桥的方式连接数据库。JDBC-ODBC桥是一种类型的驱动程序，共有4种类型的驱动程序，JDBC-ODBC桥是建立在ODBC数据源基础上的。驱动是JDK中附带的，不用下载。



##### 5.创建数据库及测试数据

```sql
create table usertable
(
   username varchar(10) primary key,
   userpass varchar(10)
)
insert into usertable values('lisi','lisi');
insert into usertable values('zhangsan','zhangsan');
```



##### 6.创建ODBC数据源

在 开始--〉设置--〉控制面板-->管理工具--〉数据源（ODBC）  设置ODBC数据源的名字为bookstore



##### 7.修改login方法，通过数据库进行验证

1).使用JDBC连接数据库的基本过程

- 加载驱动程序；
- 建立与数据库之间的连接；
- 创建一个执行SQL语句的语句对象；
- 编写要执行的SQL语句；
- 使用语句对象执行SQL语句；
- 如果有结果，需要对结果进行处理；
- 关闭相关对象；
- 注意: 异常处理。

2).修改login方法

```java
   public boolean login() throws Exception{
      // return username.equals(userpass);
      // 第一步: 加载驱动程序，如果使用其它的驱动程序，写出相应的名字即可
      Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
      // 第二步: 建立连接，第一个参数是url（定位数据库），第二个参数是用户名，第三个参数是口令
      Connection con = DriverManager.getConnection("jdbc:odbc:bookstore","","");  // bookstore是所创建的ODBC数据源的名字
      // 第三步: 创建SQL语句
      String sql = "select * from usertable where username=? and userpass=?";
      // 第四步: 创建语句对象，用于执行SQL语句的
      PreparedStatement stmt = con.prepareStatement(sql);
      // 对变量赋值，第一个参数表示变量的序号（第几个问号），第二个参数表示所赋的值
      stmt.setString(1,username);
      stmt.setString(2,userpass);
      // 第五步: 执行SQL语句，因为有查询结果，所以使用executeQuery方法，结果保存在rs中
      ResultSet rs = stmt.executeQuery();
      //  rs相当于一个表格，有若干行、若干列组成，指针指向第一条记录的前面
      // 第六步: 对结果进行处理，使用next方法进行遍历，使用get方法得到当前行的列
      boolean b = rs.next();
      // 第七步: 关闭相关对象
      rs.close(); 
      stmt.close();
      con.close();
      return b;      
   }
```

3).修改LoginProcessServlet.java

修改后的代码为: 

```java
package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import bean.*;
public class LoginProcessServlet extends HttpServlet
{
  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
        // 获取用户输入的信息
        String username = request.getParameter("username");
        String userpass = request.getParameter("userpass");
        // 调用JavaBean，创建对象、初始化、然后调用方法
        UserBean user = new UserBean();
        user.setUsername(username);
        user.setUserpass(userpass);
        boolean b = false;
        try{
            b = user.login();
        }catch(Exception e){
            // 当产生异常的时候，把异常信息输出在界面上
                // 设置编码方式
                response.setContentType("text/html;charset=gb2312");
                // 得到输出流对象
                PrintWriter out = response.getWriter();
                out.println(e.toString());
                return;
        }
        // 转向响应界面
        if(b){
           RequestDispatcher rd = request.getRequestDispatcher("success.jsp");  // 跳转到成功的页面
           rd.forward(request,response); // 完成跳转 
        }else{
           RequestDispatcher rd = request.getRequestDispatcher("index1.jsp");  // 跳转到登录页面
           rd.forward(request,response); // 完成跳转 
        }
/*
        if( username.equals("zhangsan") && userpass.equals("zhangsan") )
        {
           RequestDispatcher rd = request.getRequestDispatcher("success.jsp");  // 跳转到成功的页面
           rd.forward(request,response); // 完成跳转 
        }else
        {
           RequestDispatcher rd = request.getRequestDispatcher("index1.jsp");  // 跳转到登录页面
           rd.forward(request,response); // 完成跳转 
        }
*/
  }

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
     doGet(request,response);
  }
}
```

~~找到:         boolean b = user.login();修改为:               boolean b = false;        try{            b = user.login();        }catch(Exception e){            // 当产生异常的时候，把异常信息输出在界面上                // 设置编码方式                response.setContentType("text/html;charset=gb2312");                // 得到输出流对象                PrintWriter out = response.getWriter();                out.println(e.toString());                return;        }~~

ref:1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第5、7章







### 第六讲

##### 1.分析登录功能

界面: 登录界面index1.jsp；登录成功的界面login_success.jsp。
功能: UserBean的login方法完成登录的判断。
Servlet: LoginServlet.java
(1)接收用户输入的用户名和口令;（2）调用UserBean的login方法进行判断;（3）根据方法的返回值选择界面响应。



##### 2.MVC模式

**M表示模型**，主要表示系统中的功能处理部分。例如，上面的UserBean就是一个模型，描述用户信息以及相关功能。
**V表示视图**，表示系统中与人进行交互的部分。例如，上面的index1.jsp和login_success.jsp。
**C表示控制器**，建立模型与视图之间的关联关系。例如，上面的LoginServlet.java。
**输入界面直接调用控制器，控制器接收用户在输入界面上输入的信息，控制器把信息传递给模型，调用模型的方法，方法会给控制器返回一个值，控制器根据这个值选择输出界面对用户响应**。MVC模式把系统的每一个功能都分解成这个3个部分。然后分别实现。



##### 3.采用MVC模式实现注册功能

**一般先考虑V**，包括输入界面和输出界面，对于注册功能来说，输入是注册界面，输出是注册成功或者失败的界面，通常使用JSP文件。
**接下来考虑M**，功能如何实现，对于注册功能来说，需要把用户提交的信息写到数据库中。需要在UserBean中编写添加用户的方法。
**考虑C，如何协调M和V**。需要编写Servlet，在doGet或者doPost方法中主要完成: 接收输入；调用UserBean的方法；选择界面响应。



##### 4.创建注册用的表

```sql
create table usertable2
(
   username varchar(10) primary key,
   userpass varchar(10),
   sex char(2),
   fav varchar(20),
   degree varchar(8),
   comment varchar(100),
   email varchar(30)
)
```



##### 5.V部分

采用原来的register.jsp和success.jsp。



##### 6.M部分

在UserBean中添加方法，add方法。方法代码如下: 

 ```java
  public boolean add(){
      // 定义变量
      Connection con = null;
      PreparedStatement stmt = null;
      String driverClass = "sun.jdbc.odbc.JdbcOdbcDriver";
      String url = "jdbc:odbc:bookstore";
      String sql = "insert into usertable2 values(?,?,?,?,?,?,?)";
      boolean success = true;
      try{
         // 第一步: 加载驱动
         Class.forName(driverClass);
         // 第二步: 建立连接
         con = DriverManager.getConnection(url,"","");
         // 第三步: 创建语句对象
         stmt = con.prepareStatement(sql);
         // 第四步: 对SQL语句中参数赋值
         stmt.setString(1,username);
         stmt.setString(2,userpass);
         stmt.setString(3,sex);
         stmt.setString(4,fav);
         stmt.setString(5,degree);
         stmt.setString(6,comment);
         stmt.setString(7,email);
         // 第五步: 执行SQL语句
         int n = stmt.executeUpdate();
         // 执行没有结果集返回的SQL语句使用executeUpdate方法，方法的返回值是整数，表示操作成功的记录数
         if(n==0)
            success = false;
      }catch(Exception e){
         success = false;
         System.out.println(e.getMessage());
      }finally{
         try{ stmt.close(); }catch(Exception ee){}
         try{ con.close(); }catch(Exception ee){}
      }
      return success;
   }
 ```



##### 7.C部分

**编写Servlet，完成添加的控制**。控制器的代码如下: 

```java
package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import bean.*;

public class AddUserServlet extends HttpServlet
{
  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
        // 请求中采用的编码方式是8859_1，当前的编码是gb2312，需要转换
        request.setCharacterEncoding("gb2312");
        
        // 第一句话: 获取用户输入的信息
        String username = request.getParameter("username");
        String userpass1 = request.getParameter("userpass1");
        String sex = request.getParameter("sex");
        // 因为允许多选，所以结果有可能是多个，应该使用数组接收。
        String fav[] = request.getParameterValues("fav");
        String favStr = "";
        for(int i=0;i<fav.length;i++)
        {
           favStr += fav[i]+";";
        }
        String degree = request.getParameter("degree");
        String comment = request.getParameter("content");
        String email = request.getParameter("email");
        
        // 第二句话: 调用JavaBean，创建对象、初始化、然后调用方法
        UserBean user = new UserBean();
        user.setUsername(username);
        user.setUserpass(userpass1);
        user.setSex(sex);
        user.setFav(favStr);
        user.setDegree(degree);
        user.setEmail(email);
        user.setComment(comment);
        boolean b = user.add();

        // 第三句话: 向页面传递信息
        if(b)
            request.setAttribute("info","注册成功！");
        else
            request.setAttribute("info","注册失败！");
            
        // 第四句话: 转向响应界面
        RequestDispatcher rd = request.getRequestDispatcher("success.jsp"); 
        rd.forward(request,response); // 完成跳转
/*
        if( username.equals("zhangsan") && userpass.equals("zhangsan") )
        {
           RequestDispatcher rd = request.getRequestDispatcher("success.jsp");  // 跳转到成功的页面
           rd.forward(request,response); // 完成跳转 
        }else
        {
           RequestDispatcher rd = request.getRequestDispatcher("index1.jsp");  // 跳转到登录页面
           rd.forward(request,response); // 完成跳转 
        }
*/
  }

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
     doGet(request,response);
  }
}
```

之后对Servlet进行配置，在web.xml中添加如下代码: 

```xml
   <servlet>
      <servlet-name>addUser</servlet-name>
      <servlet-class>servlet.AddUserServlet</servlet-class>
   </servlet>
   <servlet-mapping>
      <servlet-name>addUser</servlet-name>
      <url-pattern>/addUser</url-pattern>
   </servlet-mapping>
```

需要修改register.jsp中的form的属性action: 

```java
<form action="addUser" method="post" name="form1">
```



##### 8.测试

编译、启动服务器，然后运行。

ref:1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第6、9章



### 第七讲

##### 1.共享连接数据库的代码

连接数据库的基本过程: 
1）.加载驱动程序；
2）.创建连接；
3）.编写SQL语句；
4）.创建语句对象；
5）.对参数赋值；
6）.执行SQL 语句；
7）.对结果进行处理；
8）.关闭对象。

对于不同的SQL的执行，不同的地方: 
- SQL语句；
- 参数；
- 结果的处理方式；

提取相同部分分别编写成方法: 
```java
   Connection con = null;
   PreparedStatement stmt = null;
   ResultSet rs = null;
   String driverClass = "sun.jdbc.odbc.JdbcOdbcDriver";
   String url = "jdbc:odbc:bookstore";

   // 完成连接的创建，相当于第1.2步
   public Connection getConnection() throws Exception{
      Class.forName(driverClass); // 加载驱动程序
      if(con == null)
         con = DriverManager.getConnection(url,"","");
      return con;
   }

   // 创建语句对象
   public PreparedStatement createStatement(String sql) throws Exception{
      stmt = getConnection().prepareStatement(sql);
      return stmt;
   }  

   // 执行有结果集返回的方法
   public ResultSet executeQuery() throws Exception{
      rs = stmt.executeQuery();
      return rs;
   }

   // 执行没有结果集返回的方法
   public int executeUpdate() throws Exception{
      return stmt.executeUpdate();
   }

   // 关闭对象
   public void close(){
      if(rs != null) 
         try{ rs.close();  }catch(Exception e){} 
      if(stmt != null) 
         try{ stmt.close();  }catch(Exception e){} 
      if(con != null) 
         try{ con.close();  }catch(Exception e){} 
   }
```


##### 2.修改上一次课的添加功能，使用这些共享方法

```java
String sql = "insert into usertable2 values(?,?,?,?,?,?,?)";
boolean success = true;    
try{
   // 创建语句对象
      createStatement(sql);

   // 对SQL语句中参数赋值
      stmt.setString(1,username);
      stmt.setString(2,userpass);
      stmt.setString(3,sex);
      stmt.setString(4,fav);
      stmt.setString(5,degree);
      stmt.setString(6,comment);
      stmt.setString(7,email);

    // 执行SQL语句
      int n = executeUpdate();

    // 执行没有结果集返回的SQL语句使用executeUpdate方法，方法的返回值是整数，表示操作成功的记录数
      if(n==0)
         success = false;
   }catch(Exception e){
      success = false;
      System.out.println(e.getMessage());
   }finally{
      close();
   }  
return success;
```



##### 3.查询所有图书

1）创建图书表

```sql
   create table books(
      bookid varchar(10) primary key,
      bookname varchar(30),
      author varchar(20),
      price float,
      publisher varchar(20)
   )
```

插入一些模拟数据

```sql
insert into books values('00001','Java','zhangsan',20,'电子工业')
insert into books values('00002','JSP','lisi',22,'人民邮电')
insert into books values('00003','Java EE','wang',30,'人民邮电')
```

2）V部分
V主要与人进行交互，要考虑输入和输出。输入: 在导航条中添加“查看所有图书”的超链。

```html
显示所有图书
```

输出: 显示所有图书信息的JSP文件。
文件名: books.jsp

```jsp
<%@ page contentType="text/html;charset=gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="header.jsp"%>
   <tr>
      <td>
          <table align="center" border="1">
             <tr>
                <td>图书编号</td><td>图书名称</td><td>作者</td><td>价格</td><td>出版社</td>
             </tr>
              
             <!-- c:forEach用于循环控制，items属性指出要循环遍历的集合，var定义一个循环变量，表示集合中的一个元素 -->
             <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.bookid}</td>
                    <td>${book.bookname}</td>
                    <td>${book.author}</td>
                    <td>${book.price}</td>
                    <td>${book.publisher}</td>
                </tr>
              </c:forEach>
          </table>
      </td>
   </tr>
</table>
```

3）M部分
完成功能: 从数据库中查询所有的图书。
文件名: BookBean.java

```java
package bean;

import java.sql.*; 
import java.util.ArrayList;

public class BookBean extends Base{
   // 描述图书的属性
   private String bookid;
   private String bookname;
   private String author;
   private float price;
   private String publisher;

   // 编写对乘员进行操作的方法
   public void setBookid(String bookid){
      this.bookid = bookid;
   }

   public String getBookid(){
      return bookid;
   }

   public void setBookname(String bookname){
      this.bookname = bookname;
   }

   public String getBookname(){
      return bookname;
   }

   public void setAuthor(String author){
      this.author = author;
   }

   public String getAuthor(){
      return author;
   }

   public void setPrice(float price){
      this.price = price;
   }

   public float getPrice(){
      return price;
   }

   public void setPublisher(String publisher){
      this.publisher = publisher;
   }

   public String getPublisher(){
      return publisher;
   }  

   public ArrayList findAllBooks(){
      ArrayList books = new ArrayList();
      String sql = "select * from books";
      try{
         createStatement(sql);
         rs = executeQuery();

         // 使用while循环遍历结果集
         while(rs.next())
         {
            // 使用rs的getString方法，以字符串的形式获取第一列，参数也可以是列的名字
            // 可以得到当前记录的每一列
            String tempBookid = rs.getString(1);
            String tempBookname = rs.getString(2);
            String tempAuthor = rs.getString(3);
            float tempPrice = rs.getFloat(4);
            String tempPublisher = rs.getString(5);
            
            // 创建图书对象
            BookBean book = new BookBean();
            book.setBookid(tempBookid);
            book.setBookname(tempBookname);
            book.setAuthor(tempAuthor);
            book.setPrice(tempPrice);
            book.setPublisher(tempPublisher);

            // 把书添加到链表中
            books.add(book);
         }
      }catch(Exception e){
         System.out.println(e.toString());
      }finally{
         close();
      }
      return books;
   }
}
```

4）C部分
控制器: 4句话。本功能只用到3句。
文件名: FindAllBooks。
```java
package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import bean.*;
import java.util.ArrayList;

public class FindAllBooks extends HttpServlet
{
  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
        // 第二句话: 调用JavaBean，创建对象、初始化、然后调用方法
        BookBean book = new BookBean();
        ArrayList books = book.findAllBooks();

        // 第三句话: 向页面传递信息，第一个参数是使用的名字，应该和显示时候使用的名字一致，第二个参数传递的值本身
        request.setAttribute("books",books);

        // 第四句话: 转向响应界面
        RequestDispatcher rd = request.getRequestDispatcher("books.jsp"); 
        rd.forward(request,response); // 完成跳转

  }

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
     doGet(request,response);
  }
}
```
在web.xml中进行配置

```xml
   <servlet>
      <servlet-name>findAllBooks</servlet-name>
      <servlet-class>servlet.FindAllBooks</servlet-class>
   </servlet>

   <servlet-mapping>
      <servlet-name>findAllBooks</servlet-name>
      <url-pattern>/findAllBooks</url-pattern>
   </servlet-mapping>
```

ref:1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第7章



### 第八讲

##### 1.删除功能设计

1）V部分
输入: 可以在图书列表界面中添加一列，使用超链链接到删除功能，需要把将要删除的图书的编号传递过去。
输出: 删除成功或者失败的提示界面。

2）M部分
删除功能需要在BookBean添加一个删除的方法，方法需要参数来指定删除哪一本书。

3）C部分
4句话: 从输入界面获取要删除的图书的编号；根据编号调用JavaBean的删除图书的方法；把删除成功或者失败的消息传递到界面（通过request）；转向响应界面。



##### 2.输入界面

在books.jsp中的表格后面增加一列。

```jsp
<%@ page contentType="text/html;charset=gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="header.jsp"%>

   <tr>
      <td>
          <table align="center" border="1">
             <tr>
                <td>图书编号</td><td>图书名称</td><td>作者</td><td>价格</td><td>出版社</td><td></td>
             </tr>

             <!--  c:forEach用于循环控制，items属性指出要循环遍历的集合，var定义一个循环变量，表示集合中的一个元素 -->
             <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.bookid}</td>
                    <td>${book.bookname}</td>
                    <td>${book.author}</td>
                    <td>${book.price}</td>
                    <td>${book.publisher}</td>
                    <td> 删除 </td>
                </tr>
             </c:forEach>
          </table>
      </td>
   </tr>
</table>
```



##### 3.输出界面

把success.jsp作为输出界面。



##### 4.M部分

在BookBean中添加deleteBook方法，代码如下: 

```java
   // 根据编号删除图书
   public boolean deleteBook(String bookid){

      // 表示删除成功还是失败
      boolean success=true;

      // 编写SQL语句
      String sql = "delete from books where bookid=?";
      try{
         // 创建语句对象
         createStatement(sql);
          
         // 对SQL中的参数赋值
         stmt.setString(1,bookid);
         if( stmt.executeUpdate()>0 )
            success = true;
         else
            success = false;
      }catch(Exception e){
         success = false;
         System.out.println(e.toString());         
      }finally{
         close();
      }
      return success;
   }
```



##### 5.C部分

记住4句话即可。参考代码如下: 

```java
package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import bean.*;
import java.util.ArrayList;

public class DeleteBook extends HttpServlet

{

  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException

  {

        // 第一句话: 获取要删除的图书 
        String bookid = request.getParameter("bookid");

        // 第二句话: 调用JavaBean，创建对象、初始化、然后调用方法
        BookBean book = new BookBean();
        boolean success = book.deleteBook(bookid);

        // 第三句话: 向页面传递信息，第一个参数是使用的名字，应该和显示时候使用的名字一致，第二个参数传递的值本身
        String info;
        if(success)
           info="删除成功！";
        else
           info="删除失败";
        request.setAttribute("info",info);

        // 第四句话: 转向响应界面
        RequestDispatcher rd = request.getRequestDispatcher("success.jsp"); 
        rd.forward(request,response); // 完成跳转
  }

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
     doGet(request,response);
  }
}
```

在web.xml中添加配置，相关代码如下: 

```xml
   <servlet>
      <servlet-name>deleteBook</servlet-name>
      <servlet-class>servlet.DeleteBook</servlet-class>
   </servlet>

   <servlet-mapping>
      <servlet-name>deleteBook</servlet-name>
      <url-pattern>/deleteBook</url-pattern>
   </servlet-mapping>
```



##### 6.图书信息修改功能设计

用户操作过程:**首先先显示要修改的图书信息，然后修改后提交更新数据库**。首先考虑显示信息的过程: 根据用户的选择显示相应图书的信息。
采用MVC模式设计如下: 
V部分: 输入可以采用与删除功能类似的方式，在图书列表之后增加一修改列。输出是修改界面。
M部分: 根据图书编号查询图书信息。需要在BookBean中添加一个根据编号查询图书的方法。
C部分: 4句话，获取图书编号；把编号作为参数调用JavaBean中查询图书的方法；把查询到的图书对象保存到request；转向修改界面。



##### 7.输入界面

修改books.jsp

```jsp
<%@ page contentType="text/html;charset=gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="header.jsp"%>
   <tr>
      <td>
          <table align="center" border="1">
             <tr>
                <td>图书编号</td><td>图书名称</td><td>作者</td><td>价格</td><td>出版社</td><td></td><td></td>
             </tr>

             <!--  c:forEach用于循环控制，items属性指出要循环遍历的集合，var定义一个循环变量，表示集合中的一个元素 -->
             <c:forEach var="book" items="${books}">
                <tr>
                    <td>${book.bookid}</td>
                    <td>${book.bookname}</td>
                    <td>${book.author}</td>
                    <td>${book.price}</td>
                    <td>${book.publisher}</td>
                    <td> 删除 </td>
                    <td> 修改 </td>
                </tr>
             </c:forEach>
          </table>
      </td>
   </tr>
</table>
```



##### 8.输出界面

修改界面: 显示从控制器传递过来的BookBean对象book。

```jsp
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="header.jsp"%>

   <tr>
      <td>
           <form action="updateBook" method="post" name="form1">
               <table align="center">
                  <tr> 
                      <td>图书编号: </td>
                      <td><input type="hidden" name="bookid" value="${book.bookid}">${book.bookid}</td>
                  </tr>
                  <tr>
                      <td>图书名: </td>
                      <td><input type="text" name="bookname" value="${book.bookname}"></td>
                  </tr>
                  <tr>
                      <td>作者: </td>
                      <td><input type="text" name="author"  value="${book.author}"></td>
                  </tr>
                  <tr>
                      <td>价格: </td>
                      <td><input type="text" name="price"  value="${book.price}"></td>
                  </tr>
                  <tr>
                      <td>出版社: </td>
                      <td><input type="text" name="publisher"  value="${book.publisher}"></td>
                  </tr>
                  <tr>
                      <td><input type="submit" value="提交"></td>
                      <td><input type="reset" value="重写"></td>
                  </tr>
               </table>
           </form>
      </td>
  </tr>
</table><!--开始的一部分table标签在header.jsp之中-->
```



##### 9.编写根据ID查询图书的方法

在BookBean中添加方法

```java
   // 根据编号查询图书
   public BookBean findBookByID(String bookid){
      BookBean book=new BookBean();
      String sql = "select * from books where bookid=?";
      try{
         createStatement(sql);
         stmt.setString(1,bookid);
         rs = executeQuery();
         // 转换成对象
         rs.next();

         // 使用rs的getString方法，以字符串的形式获取第一列，参数也可以是列的名字
         // 可以得到当前记录的每一列
         String tempBookname = rs.getString(2);
         String tempAuthor = rs.getString(3);
         float tempPrice = rs.getFloat(4);
         String tempPublisher = rs.getString(5);

         // 创建图书对象
         book.setBookid(bookid);
         book.setBookname(tempBookname);
         book.setAuthor(tempAuthor);
         book.setPrice(tempPrice);
         book.setPublisher(tempPublisher);

      }catch(Exception e){
         System.out.println(e.toString());
      }finally{
         close();
      }
      return book;
  }
```



##### 10.编写Servlet控制器

```java
package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import bean.*;
import java.util.ArrayList;

public class FindBookByID extends HttpServlet
{
  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
        // 第一句话: 获取用户选择图书编号
        String bookid = request.getParameter("bookid");

        // 第二句话: 调用JavaBean，创建对象、初始化、然后调用方法
        BookBean book = new BookBean();
        book = book.findBookByID(bookid);

        // 第三句话: 向页面传递信息，第一个参数是使用的名字，应该和显示时候使用的名字一致，第二个参数传递的值本身
        request.setAttribute("book",book);

        // 第四句话: 转向响应界面
        RequestDispatcher rd = request.getRequestDispatcher("updateBook.jsp"); 
        rd.forward(request,response); // 完成跳转
  }

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
     doGet(request,response);
  }
}
```

在web.xml中配置: 

```xml
   <servlet>
      <servlet-name>findBookByID</servlet-name>
      <servlet-class>servlet.FindBookByID</servlet-class>
   </servlet>

   <servlet-mapping>
      <servlet-name>findBookByID</servlet-name>
      <url-pattern>/findBookByID</url-pattern>
   </servlet-mapping>
```



##### 11.修改功能的设计

**V部分**: 输入是修改界面不用修改，只要设置form的action属性为updateBook即可。输出可以采用success.jsp界面。
**M部分**: 在BookBean中添加修改方法。
**C部分**: 4句话，获取用户修改后的信息；调用JavaBean，包括初始化；把执行的结果传递到界面；转向界面。



##### 12.修改BookBean中的代码

增加update方法，代码如下: 

```java
   // 更新图书信息
   public boolean update(){
      boolean success = false;
      String sql = "update books set bookname=?,author=?,price=?,publisher=? where bookid=?";
      try{
         createStatement(sql);
         stmt.setString(1,bookname);
         stmt.setString(2,author);
         stmt.setFloat(3,price);
         stmt.setString(4,publisher);
         stmt.setString(5,bookid);
         int n = executeUpdate();
         if(n>0)
            success = true;
         else
            success = false;
      }catch(Exception e){
         success = false;     
         System.out.println(e.toString());
      }finally{
         close();
      }
      return success;
  }
```


##### 13.编写控制器
为了解决乱码，在控制器中获取信息之前，增加如下语句: 
```html
request.setCharacterEncoding("gb2312");
```
代码如下: 
```html
package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import bean.*;
import java.util.ArrayList;

public class UpdateBook extends HttpServlet
{
  public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
        request.setCharacterEncoding("gb2312");
        // 第一句话: 获取用户选择图书编号
        String bookid = request.getParameter("bookid");
        String bookname = request.getParameter("bookname");
        String price = request.getParameter("price");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        float fPrice = 0f;
        try{
           // 把字符串转换成浮点型变量
           fPrice = Float.parseFloat(price); 
        }catch(Exception e){
        }

        // 第二句话: 调用JavaBean，创建对象、初始化、然后调用方法
        BookBean book = new BookBean();
        book.setBookid(bookid);
        book.setBookname(bookname);
        book.setPrice(fPrice); 
        book.setAuthor(author);
        book.setPublisher(publisher);

        boolean success = book.update();

        String info ;
        if(success)
           info = "修改成功！";
        else
           info = "修改失败";

        // 第三句话: 向页面传递信息，第一个参数是使用的名字，应该和显示时候使用的名字一致，第二个参数传递的值本身
        request.setAttribute("info",info);

        // 第四句话: 转向响应界面
        RequestDispatcher rd = request.getRequestDispatcher("success.jsp"); 
        rd.forward(request,response); // 完成跳转
  }

  public void doPost(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException
  {
     doGet(request,response);
  }
}
```
修改配置文件:
```xml
   <servlet>
      <servlet-name>updateBook</servlet-name>
      <servlet-class>servlet.UpdateBook</servlet-class>
   </servlet>

   <servlet-mapping>
      <servlet-name>updateBook</servlet-name>
      <url-pattern>/updateBook</url-pattern>
   </servlet-mapping>
```
ref:1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第10章





### 第九讲

##### 1.在JSP中如何存储信息

前面介绍过的: 在数据库中存储信息；在request对象中存储信息。**分为两类: 内存 和 持久存储**

1).内存中如何组织数据: 

​    **pageContext对象**，存储当前页面的信息；请求涉及多少个文件，就会创建多少个pageContext对象。
​    **request对象**，一次请求会创建一个request对象，如果希望在同一次请求的多个文件之间共享信息，可以保存在request中。
​    **session对象**，每个客户端对应一个session，session中用于存储在用户的整个访问过程中要使用的信息。最典型的应用把用户的登录信息保存在session中，这样在后续的页面中使用登录信息。
​    **application对象**，整个网站对应这样一个对象，访问网站的所有用户在访问所有网页的时候都可以使用。典型的应用是公有的聊天室，聊天信息所有人都可以看到，这时候就应该使用application对象。

2).持久存储: 
​    **数据库**，通过JDBC访问。
​    **文件**，通过IO进行操作。
​    **Cookie**，信息存储在客户端。如果使用数据库和文件，信息都存在服务器端。



##### 2.网上购物车的基本功能
浏览图书信息；把图书添加到购物车中；对购物车中的物品进行管理；查看购物车的信息；生成订单。



##### 3.如何保存在购物过程中选择的物品？

关心购物车中有哪些类型的物品，每种类型的物品有多少。物品的种类数量不确定。每次请求只能选择某一种物品。根据这些特点，应该设计购物车的存储结构如下: 

1）.需要把购物车放到session中，这样才能进行多个页面之间的共享；
2）.因为物品种类不确定，所以一般选择ArrayList来存储物品种类以及数量；
3）.对于每一种物品，包含物品本身的信息以及物品的购买数量，通常使用订单项来表示，里面包含了物品对象及其数量。



##### 4.完成向购物车中添加图书的功能

**V部分**: 输入，是选择物品向购物车添加的界面，使用物品信息查看界面；
​             输出，显示购物车信息的页面。
**M部分**: 把选择的物品添加到购物车中，需要知道原来购物车中有什么信息，购物车在session中保存，所以需要对session进行操作。
**C部分**: 第一句话，获取信息，从输入界面获取要添加的图书，从session中获取原有的购物车信息。
​            第二句话，调用M部分的添加购物车功能。
​            第三句话，保存信息，把修改后的购物车重新写入session中。
​            第四句话，转向显示购物车信息的页面。



##### 5.构建订单项类

```java
package bean;

// 表示购物项
public class Item{
   private BookBean book;
   private int quantity;
   public void setBook(BookBean book){
      this.book = book;
   }
   public BookBean getBook(){
      return book;
   }

   public void setQuantity(int quantity){
      this.quantity = quantity;
   }
   public int getQuantity(){
      return quantity;
   }
}
```



##### 6.输入界面

在books.jsp中的图书列表后增加“添加到购物车”这样的超链接。



##### 7.删除功能、修改购物车信息

界面: 
删除的代码: 

```html
   <form action="deleteItem" method="post">
      <input type="hidden" name="bookid" value="${item.book.bookid}">
      <input type="submit" value="删除"> 
   </form>
```

修改的: 

```jsp
<form action="updateCart" method="post">
<input type="text" name="quantity" value="${item.quantity}">
      <input type="hidden" name="bookid" value="${item.book.bookid}">
      <input type="submit" value="修改"> 
   </form>
```

M部分: 
从ArrayList对象cart中删除Item对象item: cart.remove(item)   cart.remove(i)
修改功能: 在添加过程中如果要添加的图书已经存在，就相当于修改。

C部分: 与添加功能中的代码非常类似。

ref:1.[《Java Web程序设计基础教程》](http://blog.csdn.net/JavaEETeacher/archive/2008/03/11/2168471.aspx)第14章



### 第十讲

##### 1.MVC模式分析

对任何功能来说，首先考虑人如何来使用这个功能。如何把人的请求发送给系统，系统如何把处理的结果返回给用户，实际上就是输入和输出。输入MVC模式中的V部分。**输入: 用户发送请求，通过超链接，通过浏览器的地址栏，通过表单提交**。请求时候如何要提交数据，在超链接中以及地址栏中可以通过？的形式来传递值，表单方式通过表单元素提交信息。非常典型的应用，隐藏域，用于在多个页面之间传递信息。注意: 输入一定要进行客户端的格式验证。**输出: 主要服务器得到的信息显示给用户**。输出提示信息: ${info}  输出对象信息: 在更新界面中显示信息${book.bookid}  输出多个对象的信息: 

```html
<c:forEach var="book" items="${books}">
   <tr>
      <td>${book.bookid}</td>
      <td>${book.bookname}</td>
      <td>${book.author}</td>
      <td>${book.price}</td>
      <td>${book.publisher}</td>
      <td> 删除 </td>
      <td> 修改 </td>
      <td> 添加到购物车 </td>
   </tr>
</c:forEach>
```

**功能（M部分）: 通常转换成方法**。因为Java是面向对象的语言，方法应该输入某个类的。所以通常需要创建JavaBean（比较特殊的类），然后在JavaBean中添加这个方法。方法的实现主要依赖你的Java基本功。
**控制器（C部分）: 通常使用Servlet来实现**。对于控制器需要记住4句话: 获取信息；调用JavaBean；保存信息；响应。
获取信息: 
​            获取请求信息request.getParameter(paraname)  request.getParameterValues(paraname)
​            获取session中信息  session.getAttribute(属性名)  注意: 获取到之后需要进行强制类型转换
​            获取Cookie中信息  request.getCookies()  返回的是Cookie数组
​            获取请求头信息 
​            获取Servlet的配置信息
​            通过其他的JavaBean来获取一些信息
调用JavaBean的方法: 
​            实例化，使用new加上构造方法来实例化，如果要调用的方法是静态方法，不需要实例化。
​            初始化，可能需要使用上面获取的信息来对JavaBean进行初始化。
​            调用方法，可以通过参数传递需要的信息
保存信息（主要为后续的页面和处理服务的）: 
​            保存到session中，session.setAttribute(属性名,要保存的对象)，供用户后续的所有访问过程使用。
​            保存到request中，request.setAttribute(属性名,要保存的对象)，供后续页面使用（页面与当前的Servlet属于同一次请求）
​            保存到cookie，Cookie cookie = new Cookie("name","value"); response.addCookie(cookie);  ，供客户端在以后的时间访问
响应: 
​            直接输出: 
​               `response.setContentType("text/html;charset=gb2312");`
​               `PrintWriter out = response.getWriter();`
​               `out.println("欢迎学习JSP！");`
​            使用专门的文件进行响应: 
​               方式一: 
​                   `RequestDispatcher rd = request.getRequestDispatcher(目标文件);` 
​                   `rd.forward(request,response); // 完成跳转 `
​               方式二: 
​                   `response.sendRedirect(目标文件);`
​               注意: 如果当前功能完成的是对数据库的插入操作，如果用户刷新就会产生错误。要避免错误，不能使用`RequestDispatcher`，可以使用方式二。如果使用方式二，就不能在当前文件和目标文件之间通过request共享信息了。如果要共享可以session，使用session的时候，用完之后一定要删除这个对象`session.removeAttribute`(属性名)。



##### 2.如何使用其他的数据库管理系统

###### 准备工作: 

1).安装数据库；创建表。（这个过程通常是由数据库管理员完成的，对于变成人员来说需要知道数据库的IP地址、端口、数据库名字、用户名、口令）。
2). 要得到数据库的JDBC驱动程序，通常是压缩包，可以从响应的数据库提供商的网站上下载。需要把驱动程序放在: C:/Program Files/Apache Software Foundation/Tomcat 6.0/lib 或者 应用的WEB-INF/lib下面。

###### 在程序中使用: 

与现在使用JDBC-ODBC桥方式基本相同，不同点在于: 驱动程序的名字；URL（通常包含IP地址、端口、数据库名字）的格式不同（与驱动程序有关）；用户名和口令。

###### 常见的错误: 

1).ClassNotFoundException   通常是因为JDBC驱动程序加载失败，找不到。确认JDBC驱动程序在正确的位置以及版本是否正确。
2).没有合适的驱动程序 Not a suitable driver  通常是因为URL的格式不正确。
3).连接不能被创建，数据库服务器没有正常运行获取主机、端口、数据库名有误。
4).Access Denied  用户名和口令错误
5).java.sql.SQLException 通常SQL语句错误。





ref:1.[JSP快速入门教程——全十讲](http://blog.csdn.net/javaeeteacher/article/details/1932447),   2.[JSP 教程](http://www.runoob.com/jsp/jsp-tutorial.html)