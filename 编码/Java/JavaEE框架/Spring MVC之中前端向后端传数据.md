### Spring MVC之中前端向后端传数据

***

##### Spring MVC之中前端向后端传数据和后端向前端传数据是数据流动的两个方向, 在此先介绍前端向后端传数据的情况.

一般而言, 前端向后端传数据的场景, 大多是出现了表单的提交,**form**表单的内容在后端学习的md文档之中有所介绍,form标签的语法格式如下

```html
<FORM NAME="FORM1" ACTION="URL" METHOD="GET|POST" ENCTYPE="MIME" TARGET="...">
... ... 
</FORM> 
```

主要是三个参数的介绍,也就是**name**, **method**和**action**, 其中name可以省略, 只是一个标记符号, 用处不太大, 而action表示处理这个表单的方法, method表示将数据传输给后端的方式, 默认是get方式,这是基本的一些介绍.

##### 前端页面

数据是从前端的提交表单之中获取的, 所以首先必须得有一个表单, 此处使用了freemarker视图的页面, 命名为**login.ftl**, form的名字为"login", 其中在form之中的action表示的是要处理这"login"表单的后台url(方法), 也就是对应的controller之中的url(方法), 正好在LoginController.java之中,其中l**ogin.ftl**如下:

```html
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>第一个freemarker模板</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <!-- CSS样式 -->
</head>
<body>
<h4 class="text-primary">登录页面</h4>
<!-- 这些基本的东西貌似没有变,使用方法和在jsp之中一致,有变化的在于数据的获取-->
<form name="login" action="/freemarker/login" class="text-info">
    姓名:<input type="text" name="name"><br/>
    性别:<input type="text" name="gender"><br/>
    年龄:<input type="text" name="age"><br/>
    密码:<input type="password" name="password"><br/>
    <input type="submit" value="提交">
</form>
</body>
</html>
```
##### 后端方法

如下是处理前端页面提交内容的方法login, 但是在下面有两个方法, 其中此处用到的方法是login, **在这个Controller之中, 我们把从前台提交的数据处理, 需要注意的是, 我们在form之中定义的参数的名字, 也就是以上每个input的name属性, 和在LoginController之中login方法的参数的名称是一样的, 这样就可以保证数据的对应**, 但是这样也使得前端和后端耦合, 是现在不太推荐的.

```java
@Controller
@RequestMapping("/freemarker")
public class LoginController {
    private Logger logger = LoggerFactory.getLogger(LoginController.class);

    @RequestMapping(value = "/gotologin", method = RequestMethod.GET)
    public String gotoLogin() {
        //跳转到登录的login页面
        logger.debug("正在跳转到login页面!");
        return "login";
    }

    @RequestMapping(value = "/login", method = {RequestMethod.GET, RequestMethod.POST})
    public String login(String name, String gender, int age, String password, Model model) {
        //从页面之中提取输入的信息,并且封装好
        model.addAttribute("name", name);
        model.addAttribute("gender", gender);
        model.addAttribute("age", age);
        model.addAttribute("password", password);
        //获取了页面的信息之后,就将信息发送到想要展示的页面
        logger.debug("name: " + name + ", gender: " + gender + ", age: " + age + ", password: " + password);
        return "showinfo";
    }
}
```

##### 前台展示

其实完成以上两个步骤, 我们已经把从前台传输过来的数据,完成了后台的处理,并且把数据存储在了model之中,但是这样的情况下, 数据没有展示出来,其结果不直观, 那么,此时就需要将后端处理好的数据, 展示在前端页面, 为此我们创建一个页面, 将登陆后的信息展示出来,命名为showinfo.ftl

```html
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>第一个freemarker模板</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <!-- CSS样式 -->
</head>
<body>
<!-- freemarker获取信息 -->
<h3 class="text-justify"> 登录信息如下:</h3>
<h4 class="text-info"> 姓名:${name}</h4>
<h4 class="text-dark"> 性别:${gender}</h4>
<h4 class="text-primary"> 年龄:${age}</h4>
<h4 class="text-danger"> 密码:${password}</h4>
</body>
</html>
```

完成以上三个步骤,就完成了从前台输入,到后台处理, 再到前端展示的过程,示意图如下:


```flow
st=>start: 开始
e=>end: 结束
op1=>operation: 前台输入
op2=>operation: 后台处理
op3=>operation: 前台展示
st(right)->op1(right)->op2(right)->op3(right)->e
```
##### 后端直接传数据给前端

实际上, 如果没有前台输入, 后台自己造数据, 也是可以直接给前台展示的, 示意图如下:

```flow
st=>start: 开始
e=>end: 结束
op2=>operation: 后台处理
op3=>operation: 前台展示
st(right)->op2(right)->op3(right)->e
```

代码操作如下:

```java
@Controller
public class ToFrontController {
    private static Logger logger = LoggerFactory.getLogger(ToFrontController.class);

    //在把值传给前端页面的时候，一般是需要通过Model协助的，没有不需要Model或者接近的辅助处理方式的方法
    //此处其实不需要传值，因为不接收前端传来的值，只需要在里面自己设置即可
    @RequestMapping(value = "/toFrontTest")
    public String toFront(Model model) {
        logger.info("toFront方法被调用,应该返回toFrontInfo的视图!");
        User user1 = new User();
        user1.setAge(24);
        user1.setName("Wangsan Lee");
        user1.setPassword("dfasfagasdfsdafgyrt75");
        System.out.println(user1.getName() + "," + user1.getAge() + "," + user1.getPassword());
        model.addAttribute("user1", user1);
        return "tryandlearn/toFrontInfo";
    }
} 
```

```html
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sf1" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>toFrontInfo</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <!-- CSS样式 -->
</head>
<body>
<h4 class="text-info">toFrontInfo，此处是后端传给前端理后的信息，显示在此处</h4>
<p class="text-md-center text-area text-warning">后端传值给前端，涉及到的部分包括，ToFrontController之中的toFront方法处理，
    然后处理完成后，跳转到tryandlearn/toFrontInfo.jsp页面，ToFrontController之中的toFront方法里面的参数，都是写死了的，
    可以认为是已经从前端来，然后经过后端处理好了，需要传给前端的值</p>
<p class="text-info">ToFrontController.toFront(name,age,password,model)--->tryandlearn/toFrontInfo.jsp</p>

<h4 class="text-info">使用\<\form:form\>标签包起来的方式！</h4>
<form:form method="get" action="toFrontTest" modelAttribute="user1">
    name:${user1.name} </br>
    age:${user1.age} </br>
    password:${user1.password}</br>
</form:form>
<!-- form标签，jstl标签，sf标签，el表达式，各自使用在什么地方并且有什么区别？-->

<h4 class="text-info">使用\<\form:form\>标签包起来的方式！命名了不同的标签名字！</h4>
<sf1:form method="get" action="toFrontTest" modelAttribute="user1">
    name:${user1.name} </br>
    age:${user1.age} </br>
    password:${user1.password}</br>
</sf1:form>
<!-- form标签，jstl标签，sf标签，el表达式，各自使用在什么地方并且有什么区别？-->

<h4 class="text-warning">不使用\<\form:form\>标签包起来的方式！</h4>
name:${user1.name} </br>
age:${user1.age} </br>
password:${user1.password}</br>

</body>
</html>
```

##### 操作之中的错位感

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags" %>
<html>

<head>
    <title>一个有内涵的Index页面！</title>
    <!-- 新 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="http://cdn.bootcss.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="http://cdn.bootcss.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <!-- CSS样式 -->
</head>
<body>
<!-- Spring MVC貌似不支持从一个jsp页面通过<a href="sss.jsp">的方式跳转，都要通过controller的方式访问页面-->
<h3 class="text-info">我是XML方式配置的Spring MVC工程首页!</h3>
<a href="/freemarker/hello">freemarker的hello首页!(通过controller的方式访问页面)</a></br>
<a href="/freemarker/gotologin">跳转到登录首页</a></br>
</body>
</html>
```

我们知道,前端是一个展示的页面, 主要展示出来数据和页面, 当然也要收集数据, 但是总的一切都是为了收集数据,比如,我们要登录, 登录的页面是login.html, 但是如果想到达这个页面,  我们需要一个链接让其跳转到这个页面, 在`<a href="/freemarker/gotologin">跳转到登录首页</a></br>`之中说明处理这个跳转的url, 是的,我们跳转到了`http://localhost:8080/freemarker/gotologin`,但是这是在后台的Controller之中决定的, 是在第一段LoginController之中的gotologin方法之中,才决定跳转到login页面,所以其实有一个**延迟性**, 我们**想达成的, 都要做作为我们当前动作的结果出现**, 也就是说,比如我们想要到达登录页面, 那么这个结果必将是我们当前动作的结果, 而什么是当前的动作呢? 那就是要跳转到登录页面, 如果我们登录之后, 想要展示登陆的信息, 这两个操作是连贯的, 登录, 然后展示, 也就是说, login-->show, 意味着show是登录的结果, 那么show就要作为结果出现,在第一段代码的login方法中体现了出来, 也就是login方法返回的是showinfo, 而showinfo之中需要的信息, 就需要在后端返回的信息之中获取.

```html
<!-- freemarker获取信息 -->
<h3 class="text-justify"> 登录信息如下:</h3>
<h4 class="text-info"> 姓名:${name}</h4>
<h4 class="text-dark"> 性别:${gender}</h4>
<h4 class="text-primary"> 年龄:${age}</h4>
<h4 class="text-danger"> 密码:${password}</h4>
```

