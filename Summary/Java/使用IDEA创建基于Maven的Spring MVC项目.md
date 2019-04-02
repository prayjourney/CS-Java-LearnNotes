### 使用IDEA创建基于Maven的Spring MVC项目

***

##### 创建项目

新建一个maven project。选择create new project--->*Maven-Create from archetype*。找到maven-archetype-webapp这个骨架，点击next 
![project1](../../images/project1.jpg) 

输入GroupId和ArtifactId，这里的GroupId: **一般是写成com.xxx的模式，其实就是公司或者组织域名的倒写**，ArtifactID: **一般就是项目的名称**，填写好之后，点击next
![project2](../../images/project2.jpg) 

然后填写项目名，点击next，然后finish
![project3](../../images/project3.jpg) 

接下来idea开始创建项目，这里你要把maven自动导入打开
![project4](../../images/project4.jpg) 

然后等待maven创建项目成功
![project5](../../images/project5.jpg) 

完成以上步骤，我们就添加好了项目的框架



##### 添加pom依赖 

创建好之后的项目目录如图所示 
![project6](../../images/project6.jpg) 

我们打开其中的pom.xml，添加依赖。这里我把我的依赖全部放出来，复制到pom.xml的dependencies标签之间就可以了，pom文件依赖示例如下

```xml
<!--测试-->
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
    <scope>test</scope>
</dependency>
<!--日志-->
<dependency>
    <groupId>org.slf4j</groupId>
    <artifactId>slf4j-log4j12</artifactId>
    <version>1.7.21</version>
</dependency>
<!--J2EE-->
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>javax.servlet-api</artifactId>
    <version>3.1.0</version>
</dependency>
<dependency>
    <groupId>javax.servlet.jsp</groupId>
    <artifactId>jsp-api</artifactId>
    <version>2.2</version>
</dependency>
<dependency>
    <groupId>javax.servlet</groupId>
    <artifactId>jstl</artifactId>
    <version>1.2</version>
</dependency>
<!--mysql驱动包-->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>5.1.35</version>
</dependency>
<!--springframework-->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-web</artifactId>
    <version>4.2.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-webmvc</artifactId>
    <version>4.2.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>4.2.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-test</artifactId>
    <version>4.2.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>4.2.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>com.github.stefanbirkner</groupId>
    <artifactId>system-rules</artifactId>
    <version>1.16.1</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.aspectj</groupId>
    <artifactId>aspectjweaver</artifactId>
    <version>1.8.9</version>
</dependency>
<!--其他需要的包-->
<dependency>
    <groupId>org.apache.commons</groupId>
    <artifactId>commons-lang3</artifactId>
    <version>3.4</version>
</dependency>
<dependency>
    <groupId>commons-fileupload</groupId>
    <artifactId>commons-fileupload</artifactId>
    <version>1.3.1</version>
</dependency>
```

复制完了之后，maven就会开始下载相应的jar文件，等待下载完成即可



##### 添加框架支持 

配置完pom.xml之后，我们在idea中要添加一下框架的支持。 右击我们的项目文件夹，选择Add Framework Support
![project7](../../images/project7.jpg) 

然后在窗口中分别选中spring和springmvc，并且选择spring是，记得勾选springconfig.xml
![project8](../../images/project8.jpg) 

因为我们之前下载过相应的文件，所以这里直接用我们下载好的spring文件。 点击ok之后，我们会发现WEB-INF文件夹下多出了两个文件，这个就是我们之后要配置的文件，先不用管
![project9](../../images/project9.jpg) 

**此处有可能出现添加Framework支持，没有maven和spring的情况**

IDEA右键项目中的Add Frameworks Support没有spring和Maven

![project10](../../images/project10.jpg) 

转到文件>项目结构(**Ctrl+Alt+Shift+S**)，调出你文件目录和结构，会看到Spring(*你的项目的名字*)。在这种情况下，如下图的**HelloWorldDemo**。然后点击*Spring（HelloWorldDemo）*并选择删除
![project11](../../images/project11.jpg) 

然后在回去Add Frameworks Support，就会有Spring和Maven了



##### 完善目录结构 

项目创建完成之后，进入**project structure**(Ctrl+Alt+Shift+S)，在界面的右上角进入project structure
![project12](../../images/project12.jpg) 

项目创建完成后，src-main下建立java目录后，是无法在该目录下创建新的包和java类等文件的。在idea中需要对目录进行标注
![project13](../../images/project13.jpg)      

> - Sources 一般用于标注类似 src 这种可编译目录。有时候我们不单单项目的 src 目录要可编译，还有其他一些特别的目录也许我们也要作为可编译的目录，就需要对该目录进行此标注。只有 Sources 这种可编译目录才可以新建 Java 类和包，这一点需要牢记。
> - Tests 一般用于标注可编译的单元测试目录。在规范的 maven 项目结构中，顶级目录是 src，maven 的 src 我们是不会设置为 Sources 的，而是在其子目录 main 目录下的 java 目录，我们会设置为 Sources。而单元测试的目录是 src - test - java，这里的 java 目录我们就会设置为 Tests，表示该目录是作为可编译的单元测试目录。一般这个和后面几个我们都是在 maven 项目下进行配置的，但是我这里还是会先说说。从这一点我们也可以看出 IntelliJ IDEA 对 maven 项目的支持是比较彻底的。
> - Resources 一般用于标注资源文件目录。在 maven 项目下，资源目录是单独划分出来的，其目录为：src - main -resources，这里的 resources 目录我们就会设置为 Resources，表示该目录是作为资源目录。资源目录下的文件是会被编译到输出目录下的。
>   Test Resources 一般用于标注单元测试的资源文件目录。在 maven 项目下，单元测试的资源目录是单独划分出来的，其目录为：src - test -resources，这里的 resources 目录我们就会设置为 Test Resources，表示该目录是作为单元测试的资源目录。资源目录下的文件是会被编译到输出目录下的。
> - Excluded 一般用于标注排除目录。被排除的目录不会被 IntelliJ IDEA 创建索引，相当于被 IntelliJ IDEA 废弃，该目录下的代码文件是不具备代码检查和智能提示等常规代码功能。
> - 通过上面的介绍，我们知道对于非 maven 项目我们只要会设置 src 即可。
>   （引用自http://wiki.jikexueyuan.com/project/intellij-idea-tutorial/eclipse-java-web-project-introduce.html）

标注完后，建立如下的目录
![project14](../../images/project14.jpg)        

然后在module中选择设置各个模块，其中java文件夹是 sources，test是Test，改完之后，点ok，文件夹会变色，然后在java文件夹之中创建包，com.example包，创建controller、dao、pojo(domain)、service等包。
![project15](../../images/project15.jpg)                                                                                                             

这样我们配置前的工作就完成了，接下来就是对springmvc进行配置。我把两种配置的方法分成两部分，以供参考。



##### 基于XML 的配置

###### 配置web.xml 

Maven默认生成的web.xml版本是2.3的，所以有些配置节点idea会识别不出来，因此我们重新添加一个3.0的或者3.1版本，web.xml主要就是创建一个中央的控制器，接收到的http请求通过DispatcherServlet进行分发。 DispatcherServlet 是Spring MVC的控制的非常重要的Controller。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns="http://xmlns.jcp.org/xml/ns/javaee"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://xmlns.jcp.org/xml/ns/javaee http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
         version="3.1">

    <display-name>Archetype Created Web Application</display-name>

    <!--welcome pages-->
    <welcome-file-list>
        <welcome-file>index.jsp</welcome-file>
    </welcome-file-list>

    <!--配置springmvc DispatcherServlet-->
    <servlet>
        <servlet-name>springMVC</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <!--配置dispatcher.xml作为mvc的配置文件-->
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/dispatcher-servlet.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
        <async-supported>true</async-supported>
    </servlet>
    <servlet-mapping>
        <servlet-name>springMVC</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
    <!--把applicationContext.xml加入到配置文件中-->
    <context-param>
        <param-name>contextConfigLocation</param-name>
        <param-value>/WEB-INF/applicationContext.xml</param-value>
    </context-param>
    <listener>
        <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
    </listener>
</web-app>
```

###### 配置dispatcher-servlet.xml 
这个文件负责mvc的配置，包括启用注解，扫描装配，静态资源映射等

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xmlns:mvc="http://www.springframework.org/schema/mvc"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc.xsd">
    <!--此文件负责整个mvc中的配置-->

    <!--启用spring的一些annotation -->
    <context:annotation-config/>

    <!-- 配置注解驱动 可以将request参数与绑定到controller参数上 -->
    <mvc:annotation-driven/>

    <!--静态资源映射-->
    <!--本项目把静态资源放在了webapp的statics目录下，资源映射如下-->
    <mvc:resources mapping="/css/**" location="/WEB-INF/statics/css/"/>
    <mvc:resources mapping="/js/**" location="/WEB-INF/statics/js/"/>
    <mvc:resources mapping="/image/**" location="/WEB-INF/statics/image/"/>

    <!-- 对模型视图名称的解析，即在模型视图名称添加前后缀(如果最后一个还是表示文件夹,则最后的斜杠不要漏了) 使用JSP-->
    <!-- 默认的视图解析器 在上边的解析错误时使用 (默认使用html)- -->
    <bean id="defaultViewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="viewClass" value="org.springframework.web.servlet.view.JstlView"/>
        <property name="prefix" value="/WEB-INF/view/"/><!--设置JSP文件的目录位置-->
        <property name="suffix" value=".jsp"/>
        <property name="exposeContextBeansAsAttributes" value="true"/>
    </bean>

    <!-- 自动扫描装配 -->
    <context:component-scan base-package="example.controller"/>
</beans>
```

###### 配置applicationContext.xml 
其实这个文件没什么好配置的，这个文件主要负责一些非mvc组件（或者其他组件）的配置，暂时没有，所以是空的，但你也可以扫描一下。

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context.xsd">
    <context:component-scan base-package="example"/>
</beans>
```

###### 配置log4j.properties

日志文件是debug中一个必不可少的工具，因此添加了log4j日志包。配置文件如下。

```json
#配置根Logger 后面是若干个Appender
log4j.rootLogger=DEBUG,A1,R
#log4j.rootLogger=INFO,A1,R

# ConsoleAppender 输出
log4j.appender.A1=org.apache.log4j.ConsoleAppender
log4j.appender.A1.layout=org.apache.log4j.PatternLayout
log4j.appender.A1.layout.ConversionPattern=%-d{yyyy-MM-dd HH:mm:ss,SSS} [%c]-[%p] %m%n

# File 输出 一天一个文件,输出路径可以定制,一般在根路径下
log4j.appender.R=org.apache.log4j.DailyRollingFileAppender
log4j.appender.R.File=log.txt
log4j.appender.R.MaxFileSize=500KB
log4j.appender.R.MaxBackupIndex=10
log4j.appender.R.layout=org.apache.log4j.PatternLayout
log4j.appender.R.layout.ConversionPattern=%d{yyyy-MM-dd HH:mm:ss,SSS} [%t] [%c] [%p] - %m%n
```

###### 添加Controller
三个配置文件配置好之后，就可以测试了。首先在controller文件夹下创建一个IndexController，代码如下：

```java
@Controller
@RequestMapping("/home")
public class IndexController {

    @RequestMapping("/index")
    public String index() {
        return "index";
    }
}
```

###### 创建视图和样式
views文件夹下创建index.jsp，statics/css/下创建test.css

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Index</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/test.css"/> "/>
</head>
<body>
<p>Spring MVC based on XML config success!</p>
</body>
</html>
```

```css
p
{
    background-color: brown;
    font-family: "Courier New";
    font-size:100px;
}
```

###### 容器的配置和运行
一般的Java Web项目，都需要运行在如tomcat, jetty的Servlet容器之中，Servlet容器有两种配置方式

- 配置本地的tomcat服务器
- 配置maven插件

**配置tomcat**
本地如果没有tomcat，去官网下载tomcat7以上的版本即可。 右上角 
![project16](../../images/project16.jpg) 

然后选择tomcat 
![project17](../../images/project17.jpg) 

配置相关信息 
![project18](../../images/project18.jpg) 

还有deployment
![project19](../../images/project19.jpg) 

选择第二个 
![project20](../../images/project20.jpg) 

这里的名称和项目名一样。 
![project21](../../images/project21.jpg) 

上面的Application context可以直接设置成/，也可以设置成/XXX，XXX表示的是项目名称。然后点击OK，完成配置。

其中主要有以下几个要点需要注意

- 选择本地的tomcat容器
- 可以选择修改访问路径
- On Update action 当我们按 Ctrl + F10 进行容器更新的时候，可以根据我们配置的这个事件内容进行容器更新。其中我选择的 Update classes and resources 事件是最常用的，表示我们在按 Ctrl + F10 进行容器更新的时候，我们触发更新编译的类和资源文件到容器中
- 默认 Tomcat 的 HTTP 端口是 8080，如果你需要改其端口可以在这里设置
- 在 Deployment 选项卡中添加了 Artifact

**配置maven插件**

maven插件的话有tomcat和jetty，两者都是servlet的容器。此处配置的是jetty。插件已经在pom.xml中配置如下

```xml
<plugins>
     <!--servlet容器 jetty插件-->
     <plugin>
           <groupId>org.eclipse.jetty</groupId>
           <artifactId>jetty-maven-plugin</artifactId>
           <version>9.3.10.v20160621</version>
     </plugin>
</plugins>
```

再在idea中配置jetty
![project22](../../images/project22.jpg) 

###### 运行第一个Spring MVC应用

最后运行tomcat，在浏览器输入<http://localhost:8080/Demo/home/index> 即可。 
![project23](../../images/project23.jpg) 

出现上面的页面，表示运行成功

##### 基于Java配置 
java配置参考*spring in action* 第四版这个书，所以此处这里更加倾向于把java配置和xml配置中的相同功能的部分进行比较，也是能对java配置又以有一个更加直观的认识。 

首先我们先完成准备工作，也就是本文的前四个直到文件目录完成，但是目录需要一点小的修改，因为多了配置类，如下图。 
![project24](../../images/project24.jpg) 

可以看到我们多了一个config包，这个里面就是放配置类的。

###### 去除web.xml 
web.xml里面的内容可以删掉了。 在config中创建WebXml类

```java
public class WebXml extends AbstractAnnotationConfigDispatcherServletInitializer {
    /*
     <context-param>
         <param-name>contextConfigLocation</param-name>
         <param-value>/WEB-INF/applicationContext.xml</param-value>
     </context-param>
     <listener>
         <listener-class>org.springframework.web.context.ContextLoaderListener</listener-class>
     </listener>
      */
    @Override
    protected Class<?>[] getRootConfigClasses() {
        return new Class<?>[] {ApplicationContextXml.class};
    }

    /*
    <servlet>
        <servlet-name>springMVC</servlet-name>
        <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
        <init-param>
            <!--配置dispatcher.xml作为mvc的配置文件-->
            <param-name>contextConfigLocation</param-name>
            <param-value>/WEB-INF/dispatcher-servlet.xml</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
        <async-supported>true</async-supported>
    </servlet>
     */
    @Override
    protected Class<?>[] getServletConfigClasses() {
        return new Class<?>[] {DispatcherServletXml.class};
    }

    /*
    <servlet-mapping>
        <servlet-name>springMVC</servlet-name>
        <url-pattern>/</url-pattern>
    </servlet-mapping>
     */
    @Override
    protected String[] getServletMappings() {
        return new String[] {"/"};
    }
}
```

###### 去除dispatcher-servle.xml

```java
@Configuration
@EnableWebMvc
@ComponentScan("web.example.controller")
public class DispatcherServletXml extends WebMvcConfigurerAdapter{
    /*
    <bean id="defaultViewResolver" class="org.springframework.web.servlet.view.InternalResourceViewResolver">
        <property name="viewClass" value="org.springframework.web.servlet.view.JstlView"/>
        <property name="prefix" value="/WEB-INF/view/"/><!--设置JSP文件的目录位置-->
        <property name="suffix" value=".jsp"/>
        <property name="exposeContextBeansAsAttributes" value="true"/>
    </bean>
     */
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setViewClass(org.springframework.web.servlet.view.JstlView.class);
        resolver.setPrefix("/WEB-INF/views/");
        resolver.setSuffix(".jsp");
        resolver.setExposeContextBeansAsAttributes(true);
        return resolver;
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
        super.configureDefaultServletHandling(configurer);
    }
    // 静态资源配置
    /*
    <mvc:resources mapping="/css/**" location="/WEB-INF/statics/css/"/>
    <mvc:resources mapping="/js/**" location="/WEB-INF/statics/js/"/>
    <mvc:resources mapping="/image/**" location="/WEB-INF/statics/image/"/>
     */
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/css/**").addResourceLocations("/WEB-INF/statics/css/");
        registry.addResourceHandler("/js/**").addResourceLocations("/WEB-INF/statics/js/");
        registry.addResourceHandler("/image/**").addResourceLocations("WEB-INF/statics/image/");
        super.addResourceHandlers(registry);
    }
}
```

###### 去除applicationContext.xml

```java
@Configuration
@ComponentScan(basePackages = {"web"},
        excludeFilters = {
                @ComponentScan.Filter(type = FilterType.ANNOTATION, value = EnableWebMvc.class)
        })
public class ApplicationContextXml {
}
```

上面三个配置类中的每一个设置我都对应的给出了原xml文档中的对应部分，两边对照着看，应该很容易理解。 
然后按照之前的测试方法，测试成功。

#####  结束语 

参考资料： 

[项目下载](http://download.csdn.net/detail/cquwel/9768478)

[IntelliJ IDEA上创建Maven Spring MVC项目](http://www.cnblogs.com/parryyang/p/5783399.html)

[IntelliJ idea创建Spring MVC的Maven项目](http://www.cnblogs.com/winner-0715/p/5294917.html)

[Intellij IDEA使用Maven快速创建Spring MVC Web项目工程](http://www.tuicool.com/articles/aMzM7jR)

[applicationContext.xml和dispatcher-servlet.xml的区别](http://www.cnblogs.com/parryyang/p/5783399.html)

[Servlet 3 + Spring MVC零配置：去除所有xml](http://blog.csdn.net/xiao__gui/article/details/46803193)

[Spring(三）：使用java config配置spring mvc](http://blog.csdn.net/sbjiesbjie/article/details/53264340)




ref:

1.[IDEA右键项目中的Add Frameworks Support没有spring](https://ask.csdn.net/questions/391520),   2.[IDEA用maven创建springMVC项目和配置](http://www.cnblogs.com/shang-shang/p/7477607.html),   3.[ IDEA用maven创建springMVC项目和配置（XML配置和Java配置）](https://blog.csdn.net/cquwel/article/details/59495083),   4.[IntelliJ IDEA上创建Maven Spring MVC项目](https://www.cnblogs.com/Sinte-Beuve/p/5730553.html)