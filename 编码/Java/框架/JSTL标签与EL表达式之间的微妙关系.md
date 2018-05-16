### JSTL标签与EL表达式之间的微妙关系

***

我们在java开发过程中经常会在jsp中嵌入一些java代码，比如`<%=request.getParameter("id")%>`,在了解java代码的人员看来，这很简单，可是对于美工或者前台不懂java代码的人员，这就是个头疼事儿了。那么今天我们就来解决一下这个问题。



#### EL表达式

##### EL相关概念

JSTL一般要配合EL表达式一起使用,来实现在jsp中不出现java代码段。所以我们先来学习EL表达式 

> EL（Expression Language）**表达式语言**：用于计算和输出存储在标志位置（page、request、session、application）的java对象的值,然后对它们执行简单操作；EL是JSP2.0规范的一部分，只要容器支持Servlet2.4/JSP2.0，就可以在JSP2.0网页中直接使用EL。通常与 JSTL 标记一起作用，能用简单而又方便的符号来表示复杂的行为。

##### EL基本格式

EL表达式的格式：**用美元符号 $ 定界,内容包括在花括号 {} 中**;

例如: 

```jsp
点号记法：${BeanName.beanProperty}
数组记法：${BeanName[“beanProperty”]}
```

此外，您可以将多个表达式与静态文本组合在一起以通过字符串并置来构造动态属性值;

```jsp
例如:Hello {loginInfoBean.suser} ${loginInfoBean.spwd}
```

##### EL语法组成-标识符

- **EL隐藏对象** 
**常用** 
![jstlobj](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/jstlobj.png) 

![jstlel1](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/jstlel1.png)

##### **PS：使用EL的时候，默认会以一定顺序（pageContext、request、session、application）搜索四个作用域，将最先找到的变量值显示出来。**

- **EL存取器**

> 存取器用来检索对象的特性或集合的元素。存取器: 通过 “[]” 或 “.” 符号获取相关数据

```jsp
例:
//获取输出bean中的suser属性值;
${userBean.suser}  或  ${userBean[“suser”]}
//获取map中key为id对应的值;
${mcType[“id”]}
```

- **EL运算符** 

![jstlel2](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/jstlel2.png)


![jstlel3](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/jstlel3.png)



##### 开启和关闭EL表达式

- **开启方法**

在servlet2.4之后默认方法为false，即可以不写或写成

```jsp
<%@ page isELIgnored="false" %>
```

- **关闭方法**

```jsp
<%@ page isELIgnored="true" %>
```

> 还有一种批量禁用EL的方法，可以在WEB-INF/web.xml中使用jsp-property-group标签批量禁用el，web.xml中进行如下配置。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://java.sun.com/xml/ns/j2ee"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://java.sun.com/xml/ns/j2ee http://java.sun.com/xml/ns/j2ee/web-app_2_4.xsd"
    version="2.4">
    <jsp-config>
        <jsp-property-group>
            <url-pattern>*.jsp</url-pattern>
            <el-ignored>true</el-ignored>
        </jsp-property-group>
    </jsp-config>
</web-app>
```



####  JSTL标签库

##### 相关概念

JSTL(JSP Standard Tag Library,JSP标准标签库)是一个不断完善的开放源代码的JSP标签库，是由apache的jakarta小组来维护的。JSTL1.0 由四个定制标记库(core、format、xml 和 sql)和一对通用标记库验证器组成。

> 如果要使用JSTL，则必须引用jstl.jar和 standard.jar两个包。



##### JSTL标签库分类

![jstl1](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/jstl1.png)

**core 标签库**：提供了定制操作，通过限制了作用域的变量管理数据，以及执行页面内容的迭代和条件操作。它还提供了用来生成和操作 URL 的标记。 

**format 标签库**：定义了用来格式化数据(尤其是数字和日期)的操作。它还支持使用本地化资源束进行JSP页面的国际化。 

**xml 标签库**：包含一些标记，这些标记用来操作通过XML表示的数据。

**sql 标签库**：定义了用来查询关系数据库的操作。 

两个 JSTL 标记库验证器允许开发人员在其 JSP 应用程序中强制使用编码标准。



##### JSTL的优点

![jstl2](https://raw.githubusercontent.com/prayjourney/_mypictures/master/blog/jstl2.png)



#####  为什么要用JSTL

>我们JSP用于开发信息展现页非常方便;也可以嵌入java代码(scriptlet、表达式和声明)代码用来实现相关逻辑控制。看下面程序。但这样做会带来如下问题:


- jsp维护难度增加;
- 出错提示不明确，不容易调试;
- 分工不明确;(即jsp开发者是美工,也是程序员);
- 最终增加程序的开发成本;

> 解决上面的问题可以使用定制标记库，JSTL使JSP开发者可以减少对脚本元素的需求，甚至可以不需要它们，从而避免了相关的维护成本。使分工更明确。JSTL一般配合EL一起使用,因此先看看EL.



#####  使用方法

**需要引入标签库**

```
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/xml" prefix="x"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
123456
```

**详细步骤见下一篇博客：**[java学习——Jstl标签库大全](http://blog.csdn.net/u010168160/article/details/49183659)



#### 总结：

我们通过对jstl和el的学习，可以在前台使用简单的标签来代替我们需要的java代码编写，让我们分工更加明确。我们这个世界就是需要把复杂的东西简单化，划分粒度要适当，正如我们之前所说的保证单一职责的原则。希望通过我们不断的积累和总结，我们以后的学习会越来越简单，进步越来越快。



ref:
1.[https://blog.csdn.net/u010168160/article/details/49182867](Java学习——JSTL标签与EL表达式之间的微妙关系)