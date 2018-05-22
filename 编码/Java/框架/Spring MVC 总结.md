### Spring MVC 总结

***

#### Spring MVC架构简介

##### Spring MVC介绍

Spring MVC和Struts2都属于表现层的框架,它是Spring框架的一部分,我们可以从Spring的整体结构中看得出来：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/1.png)

##### Web MVC

mvc设计模式在b/s系统下应用：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/2.png)

1、用户发起request请求至控制器(Controller)控制接收用户请求的数据，委托给模型进行处理

2、控制器通过模型(Model)处理数据并得到处理结果模型通常是指业务逻辑

3、模型处理结果返回给控制器

4、控制器将模型数据在视图(View)中展示web中模型无法将数据直接在视图上显示，需要通过控制器完成。如果在C/S应用中模型是可以将数据在视图中展示的。

5、控制器将视图response响应给用户通过视图展示给用户要的数据或处理结果。



#### Spring MVC 架构

##### Spring MVC执行流程

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/2-2.png)

##### 架构图

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/3.png)

##### 架构流程

1.用户发送请求至前端控制器DispatcherServlet

2.DispatcherServlet收到请求调用HandlerMapping处理器映射器。

3.处理器映射器根据请求url找到具体的处理器，生成处理器对象及处理器拦截器(如果有则生成)一并返回给DispatcherServlet。

4.DispatcherServlet通过HandlerAdapter处理器适配器调用处理器

5.执行处理器(Controller，也叫后端控制器)。

6.Controller执行完成返回ModelAndView

7.HandlerAdapter将controller执行结果ModelAndView返回给DispatcherServlet

8.DispatcherServlet将ModelAndView传给ViewReslover视图解析器

9.ViewReslover解析后返回具体View

10.DispatcherServlet对View进行渲染视图（即将模型数据填充至视图中）。

11.DispatcherServlet响应用户

##### 组件说明

以下组件通常使用框架提供实现：

- DispatcherServlet：前端控制器
  用户请求到达前端控制器，它就相当于mvc模式中的c，dispatcherServlet是整个流程控制的中心，由它调用其它组件处理用户的请求，dispatcherServlet的存在降低了组件之间的耦合性。
- HandlerMapping：处理器映射器
  HandlerMapping负责根据用户请求找到Handler即处理器，springmvc提供了不同的映射器实现不同的映射方式，例如：配置文件方式，实现接口方式，注解方式等。
- Handler：处理器
  Handler 是继DispatcherServlet前端控制器的后端控制器，在DispatcherServlet的控制下Handler对具体的用户请求进行处理。由于Handler涉及到具体的用户业务请求，所以一般情况需要程序员根据业务需求开发Handler。
- HandlAdapter：处理器适配器
  通过HandlerAdapter对处理器进行执行，这是适配器模式的应用，通过扩展适配器可以对更多类型的处理器进行执行。
- View Resolver：视图解析器
  View Resolver负责将处理结果生成View视图，View Resolver首先根据逻辑视图名解析成物理视图名即具体的页面地址，再生成View视图对象，最后对View进行渲染将处理结果通过页面展示给用户。 springmvc框架提供了很多的View视图类型，包括：jstlView、freemarkerView、pdfView等。

一般情况下需要通过页面标签或页面模版技术将模型数据通过页面展示给用户，需要由程序员根据业务需求开发具体的页面。



#### Spring MVC入门程序

步骤一： 创建web工程

步骤二：导入SpringMVC所需要的jar包

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/4.png)

步骤三：配置web目录（配置前端控制器）

```xml
<?xml version="1.0" encoding="UTF-8"?>
<web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://java.sun.com/xml/ns/javaee" xsi:schemaLocation="http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_3_0.xsd" id="WebApp_ID" version="3.0">
  <display-name>springmvc-1</display-name>
  <welcome-file-list>
    <welcome-file>index.html</welcome-file>
    <welcome-file>index.htm</welcome-file>
    <welcome-file>index.jsp</welcome-file>
    <welcome-file>default.html</welcome-file>
    <welcome-file>default.htm</welcome-file>
    <welcome-file>default.jsp</welcome-file>
  </welcome-file-list>
  
<!-- The front controller of this Spring Web application, responsible for handling all application requests -->
	<servlet>
		<servlet-name>springDispatcherServlet</servlet-name>
		<servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
		<init-param>
			<param-name>contextConfigLocation</param-name>
			<param-value>classpath:springmvc.xml</param-value>
		</init-param>
		<load-on-startup>1</load-on-startup>
	</servlet>

	<!-- Map all requests to the DispatcherServlet for handling -->
	<servlet-mapping>
		<servlet-name>springDispatcherServlet</servlet-name>
		<url-pattern>/</url-pattern>
	</servlet-mapping>
  
</web-app>
```

步骤四：在类路径下新建springmvc.xml,并进行配置

```xml
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:tx="http://www.springframework.org/schema/tx"
	xmlns:mvc="http://www.springframework.org/schema/mvc"
	xmlns:context="http://www.springframework.org/schema/context"
	xsi:schemaLocation="http://www.springframework.org/schema/mvc http://www.springframework.org/schema/mvc/spring-mvc-4.1.xsd
		http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-4.1.xsd
		http://www.springframework.org/schema/context http://www.springframework.org/schema/context/spring-context-4.1.xsd
		http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx-4.1.xsd">

	<context:component-scan base-package="top.boder.controller"></context:component-scan>
	<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping"></bean>
	<bean class="org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter"></bean>
	<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
		<property name="prefix" value="/WEB-INF/jsp/"></property>
		<property name="suffix" value=".jsp"></property>
	</bean>
	
</beans>
```

步骤五：编写控制器类
HelloController3.java

```java
package top.boder.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HelloController3 {
	
	@RequestMapping("/hello")
	public String getHelloWorld(Model model){
		
		model.addAttribute("xxj", "Hello World");
		
		return "success";
	}
	
}
```

步骤六：编写页面：
index.jsp(关键部分)

```jsp
<a href="hello3">第三个示例</a>
```

编写success,jsp页面

```jsp
欢迎您，${xxj }
```



#### Spring MVC配置式开发

所谓配置式开发是指，“处理器类是程序员手工定义的、实现了特定接口的类，然后再
在 SpringMVC 配置文件中对该类进行显式的、明确的注册”的开发方式。

##### 处理器映射器HandlerMapping

HandlerMapping 接口负责根据 request 请求找到对应的 Handler 处理器及 Interceptor 拦
截器，并将它们封装在 HandlerExecutionChain 对象中，返回给中央调度器。
其常用的实现类有两种：
BeanNameUrlHandlerMapping
SimpleUrlHandlerMapping

###### BeanNameUrlHandlerMapping

BeanNameUrlHandlerMapping 处理器映射器，会根据请求的 url 与 spring 容器中定义的
处理器 bean 的 name 属性值进行匹配，从而在 spring 容器中找到处理器 bean 实例。

```java
<bean class="org.springframework.web.servlet.handler.BeanNameUrlHandlerMapping"></bean>
<bean name="/hello" class="top.boder.controller.HelloController3"></bean>
```

打开类的源码，从处理器映射器的方法中可以看出，对于处理器的 Bean 的名称，必须
以“/”开头，否则无法加入到 urls 数组中。而 urls 数组中的 url 则是中央调度器用于判定“该
url 所对应的类是否作为处理器交给处理器适配器进行适配”的依据。这也是处理器与其它
普通 Bean 的区别.

```java
public class BeanNameUrlHandlerMapping extends AbstractDetectingUrlHandlerMapping {

	@Override
	protected String[] determineUrlsForHandler(String beanName) {
		List<String> urls = new ArrayList<String>();
		if (beanName.startsWith("/")) {
			urls.add(beanName);
		}
		String[] aliases = getApplicationContext().getAliases(beanName);
		for (String alias : aliases) {
			if (alias.startsWith("/")) {
				urls.add(alias);
			}
		}
		return StringUtils.toStringArray(urls);
	}
}
```

###### SimpleUrlHandlerMapping

使用 BeanNameUrlHandlerMapping 映射器有两点明显不足：

- 处理器 Bean 的 id 为一个 url 请求路径，而不是 Bean 的名称，有些不伦不类。
- 处理器Bean的定义与请求url绑定在了一起。若出现多个url请求同一个处理器的情况，
  就需要在 Spring 容器中配置多个该处理器类的`<bean/>`。这将导致容器会创建多个该处理器类实例。

SimpleUrlHandlerMapping 处理器映射器，不仅可以将 url 与处理器的定义分离，还可以对 url 进行统一映射管理。

SimpleUrlHandlerMapping 处理器映射器，会根据请求的 url 与 Spring 容器中定义的处理器映射器子标签的 key 属性进行匹配。匹配上后，再将该 key 的 value 值与处理器 bean 的 id值进行匹配，从而在 spring 容器中找到处理器 bean。

只需要修改 springmvc.xml 文件即可。

```xml
<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
 	<property name="mappings">
 		<props>
 			<prop key="/hello">helloController</prop>
 		</props>
 	</property>
 </bean>
 <bean class="top.boder.controller.HelloController" id="helloController"></bean>
```

也可以使用 urlMap 属性：

```xml
<bean class="top.boder.controller.HelloController" id="helloController"></bean>
<bean class="org.springframework.web.servlet.handler.SimpleUrlHandlerMapping">
 	<property name="urlMap">
 		<map>
 			<entry key="/hello" value-ref="helloController"></entry>
 		</map>
 	</property>
</bean>
```

#####  处理器适配器HandlerAdapter

适配器模式解决的问题是， 使得原本由于接口不兼容而不能一起工作的那些类可以在一起工作。所以处理器适配器所起的作用是，将多种处理器（实现了不同接口的处理器），通过处理器适配器的适配，使它们可以进行统一标准的工作，对请求进行统一方式的处理。

只所以要将 Handler 定义为 Controller 接口的实现类，就是因为这里使用的处理器适配器是 SimpleControllerHandlerAdapter。打开其源码，可以看到将 handler 强转为了 Controller。

在定义 Handler 时，若不将其定义为 Controller 接口的实现类，这里的强转要出错的。
当然，中央调度器首先会调用该适配器的 supports()方法，判断该 Handler 是否与Controller 具有 is-a 关系。在具有 is-a 关系的前提下，才会强转。

SimpleControllerHandlerAdapter 的源码如下：

```java
public class SimpleControllerHandlerAdapter implements HandlerAdapter {

	@Override
	public boolean supports(Object handler) {
		return (handler instanceof Controller);
	}

	@Override
	public ModelAndView handle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		return ((Controller) handler).handleRequest(request, response);
	}

	@Override
	public long getLastModified(HttpServletRequest request, Object handler) {
		if (handler instanceof LastModified) {
			return ((LastModified) handler).getLastModified(request);
		}
		return -1L;
	}
}
```

当然，强转后，就会调用我们自己定义的处理器的 handleRequest()方法。

###### SimpleControllerHandlerAdapter

所有实现了 Controller 接口的处理器 Bean，均是通过此适配器进行适配、执行的。
Controller 接口中有一个方法：

```java
protected abstract ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response)
	    throws Exception;
```

该方法用于处理用户提交的请求。通过调用 Service 层代码，实现对用户请求的计算响应，并最终将计算所得数据及要响应的页面，封装为一个对象 ModelAndView，返回给中央调度器。

###### HttpRequestHandlerAdapter

所有实现了 HttpRequestHandler 接口的处理器 Bean，均是通过此适配器进行适配、执行的。HttpRequestHandler 接口中有一个方法：

```java
void handleRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException;
```

该方法没有返回值，不能像 ModelAndView 一样，将数据及目标视图封装为一个对象。但可以将数据直接放入到 request、session 等域属性中，并由 request 或 response 完成到目标页面的跳转。

所以可以这样使用：

```java
public class HelloController2 implements HttpRequestHandler{
	@Override
		public void handleRequest(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
			String attribute = (String) request.getAttribute("name");
			request.getRequestDispatcher("/index.jsp").forward(request, response);
		}
}
```

当然，此时视图解析器也无需再配置前辍与后辍了。即在 springmvc.xml 中无需声明视图解析器的 Bean 了。

##### 处理器

处理器除了实现 Controller 接口外，还可以继承自一些其它的类来完成一些特殊的功能。

###### 继承自AbstractController类

若处理器继承自 AbstractController 类，那么该控制器就具有了一些新的功能。因为AbstractController 类还继承自一个父类 WebContentGenerator。WebContentGenerator 类具有 supportedMethods 属性，可以设置支持的 HTTP 数据提交方式。默认支持 GET、POST

WebContentGenerator 类：

```java
/**
* Set the HTTP methods that this content generator should support.
 * <p>Default is GET, HEAD and POST for simple form controller types;
 * unrestricted for general controllers and interceptors.
 */
public final void setSupportedMethods(String... methods) {
	if (methods != null) {
		this.supportedMethods = new HashSet<String>(Arrays.asList(methods));
	}
	else {
		this.supportedMethods = null;
	}
}
```

若处理器继承自 AbstractController 类，那么处理器就可以通过属性 supportedMethods来限制 HTTP 请求提交方式了。例如，指定只支持 POST 的 HTTP 请求提交方式。

注意，这里的 POST 必须写为大写。
那就意味着该请求只能通过表单或 AJAX 请求方式进行提交，而不能通过地址栏、超链接、Html 标签中的 src 方式进行提交。因为地址栏、超链接、Html 标签中的 src 方式都是GET 提交。否则，会给出请求方法不允许的 405 错误：

客户端浏览器常用的请求方式，及其提交方式有以下几种:

表单请求 : 默认 GET，可以指定 POST
AJAX 请求 : 默认 GET，可以指定 POST
地址栏请求: GET 请求
超链接请求:GET 请求
src 资源路径请求:GET 请求

不过，需要注意的是，AbstractController 类中有一个抽象方法需要实现：

```java
public class HelloController2  extends AbstractController{
	
	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
}
```

即定义处理器时，就需要实现其抽象方法 handleRequestInternal()。那么我们的处理器中实现的这个方法是什么时候被调用执行的呢？

由于AbstractController 类实现了 Controller 接口，所以 AbstractController 类就实现了 Controller 接口的 handleRequest()方法。但查看AbstractController 类的 handleRequest()方法源码，发现该方法最终返回的却是抽象方法handleRequestInternal()。

而 AbstractController 抽象类的实现类即我们自定义的子类，实现了该抽象方法。即，我们自定义的处理器的处理器方法 handleRequestInternal()最终被 AbstractController 类的handleRequest()方法调用执行。而 AbstractController 类的handleRequest()方法是被处理器适配器调用执行的。

###### 继承自MultiActionController类

MultiActionController 类继承自 AbstractController，所以继承自 MultiActionController 类的子类也可以设置 HTTP 请求提交方式。
除此之外，继承自该类的处理器中可以定义多个处理方法。这些方法的签名为公共的方法，返回值为 ModelAndView，包含参数 HttpServletRequest 与 HttpServletResponse，抛出Exception 异常，方法名随意。

```java
public class HelloController2  extends MultiActionController{	
	public ModelAndView doFirst(HttpServletRequest request,HttpServletResponse response){
		ModelAndView mv = new ModelAndView();
		mv.addObject("name", "zln");
		mv.setViewName("hello");
		return mv;
	}
```

Step2：修改 springmvc.xml
注意处理器类的映射路径的写法：要求必须以/xxx/*的路径方式定义映射路径。其中`*`为通配符，在访问时使用要访问的方法名代替。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/5.png)

只 所 以 通 过 在 请 求 URI 中 写 上 方 法 名 就 可 以 访 问 到 指 定 方 法 ， 是 因 为 在MultiActionController 类中有一个专门处理方法名称的解析器 MethodNameResolver。该解析器作为一个属性出现，具有 get 与 set 方法。MethodNameResolver 是一个接口，不同的解析器实现类，其对方法名在 URI 中的写法要求也是不同的。



#### ModelAndView

ModelAndView 即模型与视图，通过 addObject()方法向模型中添加数据，通过setViewName()方法向模型添加视图名称。

##### 模型

A 、 模型的本质就是 HashMap

跟踪 addObject()方法，可以知道这里的模型就是 ModelMap，而 ModelMap 的本质就是个 HashMap，向模型中添加数据，就是向 HashMap 中添加数据。

B 、 HashMap 是一个单向查找数组

而我们知道，HashMap 的本质是一个单向链表数组。从以下源码跟踪中可以知道这点。查看 HashMap 的源码，其用于存放数据的底层数据结构为一个数组，而数组元素为一个 Entry 对象.

C 、 LinkedHashMap
LinkedHashMap 的本质是一个 HashMap，但其将 Entry 内部类进行了扩展。HashMap 中的 Entry 是单向的，只能通过 next 查找下一个元素。而 LinkedHashMap 中的 Entry 变为了双向的，可以通过 before 查找上一个元素，通过 after 查找下一个元素。即从性能上说，LinkedHashMap 的操作性能要高于 HashMap。

当然，这些都是底层的数据结构，我们了解即可，我们应该掌握的是 ModelAndView 中的模型对象是 ModelMap，其本质是一个 HashMap，向 ModelMap 中添加数据就是向 HashMap 中添加数据。只不过，这个 ModelMap 要比 HashMap 的性能更高。

##### 视图

通过 setViewName()指定视图名称。注意，这里的视图名称将会对应一个视图对象，一般是不会在这里直接写上要跳转的页面的。这个视图对象，将会被封装在ModelAndView中，传给视图解析器来解析，最终转换为相应的页面。但需要注意的是，这里的 View 对象本质仅仅是一个 String 而矣。后续的步骤中，还会继续对这个 View 对象进行进一步的封装。

当然，若处理器方法返回的 ModelAndView 中并没有数据要携带，则可直接通过ModelAndView 的带参构造器将视图名称放入 ModelAndView 中。

##### 视图解析器ViewResolver

视图解析器 ViewResolver 接口负责将处理结果生成 View 视图。常用的实现类有四种：

######  InternalResourceViewResolver视图解析器

该视图解析器用于完成对当前 Web 应用内部资源的封装与跳转。而对于内部资源的查找规则是，将 ModelAndView 中指定的视图名称与为视图解析器配置的前辍与后辍相结合的方式，拼接成一个 Web 应用内部资源路径。拼接规则是： 前辍 + 视图名称 + 后辍。InternalResourceView解析器会把处理器方法返回的模型属性都存放到对应的request中，然后将请求转发到目标 URL。

```java
public ModelAndView getHelloWorld(ModelAndView mav,Model model){	
	mav.addObject("xxj", "Hello World11");
	System.out.println(model.asMap().get("Name"));
	mav.setViewName("success");
	return mav;
}
```

配置视图解析器：

```xml
<bean	class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	<property name="prefix" value="/WEB-INF/jsp/"></property>
	<property name="suffix" value=".jsp"></property>
</bean>
```

当然，若不指定前辍与后辍，直接将内部资源路径写到 setViewName()中也可以。相当于前辍与后辍均为空串。

```java
public ModelAndView getInfo(){
	ModelAndView modelAndView = new ModelAndView();
	modelAndView.addObject("msg","我是第二个例子");
	modelAndView.setViewName("/WEB-INF/jsp/welcome.jsp");
	return modelAndView;
}
```

###### BeanNameViewResolver视图解析器

InternalResourceViewResolver 解析器存在两个问题，使其使用很不灵活：

- 只可以完成将内部资源封装后的跳转。但无法转向外部资源，如外部网页。
- 对于内部资源的定义，也只能定义一种格式的资源：存放于同一目录的同一文件类型的资源文件。

BeanNameViewResolver 视图解析器，顾名思义就是将资源封装为“Spring 容器中注册的Bean 实例”，ModelAndView 通过设置视图名称为该 Bean 的 id 属性值来完成对该资源的访问。所以在 springmvc.xml 中，可以定义多个 View 视图 Bean，让处理器中 ModelAndView 通过对这些 Bean 的 id 的引用来完成向 View 中封装资源的跳转。

###### XmlViewResolver视图解析器

当需要定义的 View 视图对象很多时，就会使 springmvc.xml 文件变得很大，很臃肿，不便于管理。所以可以将这些 View 视图对象专门抽取出来，单独定义为一个 xml 文件。这时就需要使用 XmlViewResolver 解析器了。

Step1：定义存放 View 对象的 xml 文件
直接将原来的 springmvc.xml 中 View 对象的注册 Bean，全部复制到单独的一个 xml 文件中。当然，该 xml 文件需要 Spring 配置文件中 bean 的约束。假设指定这个文件名为myViews.xml，存放于类路径下。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/6.png)

Step2：修改 springmvc.xml
将原来对于 View 的 Bean 的注册删除。将视图解析器修改为 XmlViewResolver 解析器.该解析器的配置中需要指出用于存放View 视图 Bean 的注册的 xml 文件的位置及文件名。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/7.png)

###### ResourceBundleViewResolver视图解析器

对于 View 视图对象的注册，除了使用 xml 文件外，也可以在 properties 文件中进行注册。只不过，此时的视图解析器需要更换为 ResourceBundleViewResolver 解析器。

该属性文件需要定义在类路径下，即 src 下。而对于属性文件的写法，是有格式要求的：
资源名称.(class)=封装资源的 View 全限定性类名
资源名称.url=资源路径

Step1：定义 properties 文件
在 src 下定义一个 properties 文件，文件名称随意，这里定义为 views.properties。文件内容如下：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/8.png)

Step2：修改 springmvc.xml
这里使用的的视图解析器为 ResourceBundleViewResolver，其需要设置一个属性basename，用于指定类路径下的 properties 文件的基本名。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/9.png)

###### 视图解析器的优先级

有时经常需要应用一些视图解析器策略来解析视图名称，即当同时存在多个视图解析器均可解析ModelAndView 中的同一视图名称时，哪个视图解析器会起作用呢？视图解析器有一个 order 属性，专门用于设置多个视图解析器的优先级。数字越小，优先级越高。数字相同，先注册的优先级高。一般不为 InternalResourceViewResolver 解析器指定优先级，即让其优先级是最低的。



#### Spring MVC注解式开发

##### 第一个注解式开发程序

###### 注册组件扫描器

这里的组件即处理器，需要指定处理器所在基本包。

```java
<context:component-scan base-package="top.boder.controller"></context:component-scan>

<bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
	<property name="prefix" value="/WEB-INF/jsp/"></property>
	<property name="suffix" value="*.jsp"></property>
</bean>
```

###### 定义处理器

此时的处理器类无需继承任何父类，实现任何接口。只需在类上与方法上添加相应注解即可。
@Controller：表示当前类为处理器
@RequestMapping：表示当前方法为处理器方法。该方法要对 value 属性所指定的 URL进行处理与响应。被注解的方法的方法名可以随意

```java
@Controller
public class Controller1 {
	@RequestMapping("/hello1")
	public String hello1(Model model){
		
		model.addAttribute("hello", "annotation develop!");
		return "hello1";
	}
}
```

##### 处理器的请求映射规则的定义

通过@RequestMapping 注解可以定义处理器对于请求的映射规则。该注解可以注解在方法上，也可以注解在类上，但意义是不同的。对请求URI的命名空间的定义@RequestMapping 的 value 属性用于定义所匹配请求的 URI。但对于注解在方法上与类上，其 value 属性所指定的 URI，意义是不同的。

一个@Controller 所注解的类中，可以定义多个处理器方法。当然，不同的处理器方法所匹配的 URI 是不同的。这些不同的 URI 被指定在注解于方法之上的@RequestMapping 的value 属性中。但若这些请求具有相同的 URI 部分，则这些相同的 URI，可以被抽取到注解在类之上的@RequestMapping 的 value 属性中。此时的这个 URI 称为命名空间。

换个角度说，要访问处理器的指定方法，必须要在方法指定 URI 之前加上处理器类前定义的命名空间。

###### 请求 URI 中通配符的应用

在处理器方法所映射的 URI 中，可以使用通配符，有两种用法。

###### 资源名称中使用通配符

在请求的资源名称中使用通配符，表示请求的资源名称中只要包含指定的字符即可完成匹配。

例如，下面的写法中/some*.do 表示的意思是，只要请求的资源名称以 some 开头即可；/*other.do 表示的意思是，只要请求的资源名称以 other 结尾即可。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/10.png)

###### 资源路径中使用通配符

在资源路径中使用通配符，有两种用法：路径级数的精确匹配，与路径级数的可变匹配。

/xxx/*/show.do：表示在 show.do 的资源名称前面，只能有两级路径，第一级必须是/xxx，而第二级随意。这种称为路径级数的精确匹配。

/xxx/**/show.do：表示在 show.do 的资源名称前面，必须以/xxx 路径开头，而其它级的路径是否包含，若包含又包含几级，各级又叫什么名称，均随意。这种称为路径级数的可变匹配.

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/11.png)

##### 对请求提交方式的定义

对于@RequestMapping，其有一个属性 method，用于对被注解方法所处理请求的提交方式进行限制，即只有满足该method属性指定的提交方式的请求，才会执行该被注解方法。
Method 属性的取值为 RequestMethod 枚举常量。常用的为 RequestMethod.GET 与RequestMethod.POST，分别表示提交方式的匹配规则为 GET 与 POST 提交。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/12.png)

也就是说，只要指定了处理器方法匹配的请求提交方式为 POST，则相当于指定了请求发送的方式：要么使用表单请求，要么使用 AJAX 请求。其它请求方式被禁用。

当然，若不指定 method 属性，则无论是 GET 还是 POST 提交方式，均可匹配。即对于请求的提交方式无要求。

##### 对请求中携带参数的定义

@RequestMapping 中 params 属性中定义了请求中必须携带的参数的要求。以下是几种情况的说明。

@RequestMapping(value=”/xxx.do”, params={“name”,”age”}) ：要求请求中必须携带请求参数 name 与 age

@RequestMapping(value=”/xxx.do”, params={“!name”,”age”}) ：要求请求中必须携带请求参数 age，但必须不能携带参数 name

@RequestMapping(value=”/xxx.do”, params={“name=zs”,”ag=23”}) ：要求请求中必须携带请求参数 name，且其值必须为 zs；必须携带参数 age，其其值必须为 23

@RequestMapping(value=”/xxx.do”, params=“name!=zs”) ：要求请求中必须携带请求参数name，且其值必须不能为 zs

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/13.png)





#### 处理器方法的参数

处理器方法可以包含以下五类参数，这些参数会在系统调用时由系统自动赋值，即程序
员可在方法内直接使用。

- HttpServletRequest
- HttpServletResponse
- HttpSession
- 用于承载数据的 Model(Model或者是ModelAndView)
- 请求中所携带的请求参数

对于前四种参数，在以后的学习过程中会逐个用到。这里只举例讲解一下第五类参数：请求中所携带的请求参数。即处理器方法是如何接收请求参数的。

##### 逐个参数接收

只要保证请求参数名与该请求处理方法的参数名相同即可。

index 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/14.png)

处理器类 MyController

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/15.png)

添加 show 页面：在/WEB-INF/jsp 下添加 show.jsp 页面。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/16.png)

###### 请求参数中文乱码问题

对于前面所接收的请求参数，若含有中文，则会出现中文乱码问题。Spring 对于请求参数中的中文乱码问题，给出了专门的字符集过滤器：spring-web-4.2.1.RELEASE.jar 的org.springframework.web.filter 包下的 CharacterEncodingFilter 类。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/17.png)

###### 解决方案

在 web.xml 中注册字符集过滤器，即可解决 Spring 的请求参数的中文乱码问题。不过，最好将该过滤器注册在其它过滤器之前。因为过滤器的执行是按照其注册顺序进行的。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/18.png)

##### 源码分析

打开CharacterEncodingFilter 类的源码，发现有两个set属性：encoding与forceEncoding。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/19.png)

以上源码的意思是，若使用 encoding 指定了字符集，则一定使用该字符集的条件有两个：要么 forceEncoding 为 true，要么代码中没有指定字符集。

##### 校正请求参数名@RequestParam

所谓校正请求参数名，是指若请求 URL 所携带的参数名称与处理方法中指定的参数名不相同时，则需在处理方法参数前，添加一个注解@RequestParam(“请求参数名”)，指定请求 URL 所携带参数的名称。该注解是对处理器方法参数进行修饰的。
@RequestParam()有三个属性：

- value：指定请求参数的名称。
- required：指定该注解所修饰的参数是否是必须的，boolean 类型。若为 true，则表示请求中所携带的参数中必须包含当前参数。若为 false，则表示有没有均可。
- defaultValue：指定当前参数的默认值。若请求 URI 中没有给出当前参数，则当前方法参数将取该默认值。即使 required 为 true，且 URI 中没有给出当前参数，该处理器方法参数会自动取该默认值，而不会报错。

例如：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/20.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/21.png)

##### 整体参数接收

将处理器方法的参数定义为一个对象，只要保证请求参数名与这个对象的属性同名即可。参数名称中不用写为“对象.属性”的形式。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/22.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/23.png)

##### 域属性参数的接收

所谓域属性，即对象属性。当请求参数中的数据为某类对象域属性的属性值时，要求请求参数名为“域属性名.属性”。

###### 路径变量@PathVariable

对于处理器方法中所接收的请求参数，可以来自于请求中所携带的参数，也可以来自于请求的 URI 中所携带的变量，即路径变量。不过，此时，需要借助@PathVariable 注解。@PathVariable 在不指定参数的情况下，默认其参数名，即路径变量名与用于接收其值的属性名相同。若路径变量名与用于接收其值的属性名不同，则@PathVariable 可通过参数指出路径变量名称。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/24.png)





#### 处理器方法的返回值

使用@Controller 注解的处理器的处理器方法，其返回值常用的有四种类型：

- 第一种：ModelAndView
- 第二种：String
- 第三种：无返回值 void
- 第四种：返回自定义类型对象

根据不同的情况，使用不同的返回值。

##### 返回ModelAndView

若处理器方法处理完后，需要跳转到其它资源，且又要在跳转的资源间传递数据，此时处理器方法返回 ModelAndView 比较好。当然，若要返回 ModelAndView，则处理器方法中需要定义 ModelAndView 对象。

在使用时，若该处理器方法只是进行跳转而不传递数据，或只是传递数据而并不向任何资源跳转（如对页面的 Ajax 异步响应），此时若返回 ModelAndView，则将总是有一部分多余：要么 Model 多余，要么 View 多余。即此时返回 ModelAndView 将不合适。

##### 返回String

处理器方法返回的字符串可以指定逻辑视图名，通过视图解析器解析可以将其转换为物理视图地址。

(1 ) 返回内部资源逻辑视图名
若要跳转的资源为内部资源，则视图解析器可以使用 InternalResourceViewResolver 内部资源视图解析器。此时处理器方法返回的字符串就是要跳转页面的文件名去掉文件扩展名后的部分。这个字符串与视图解析器中的 prefix、suffix 相结合，即可形成要访问的 URI。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/25.png)

直接修改处理器类 MyController

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/26.png)

当然，也可以直接返回资源的物理视图名。不过，此时就不需要再在视图解析器中再配置前辍与后辍了。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/27.png)

##### 返回View对象名

若要跳转的资源为外部资源，则视图解析器可以使用 BeanNameViewResolver，然后在配置文件中再定义一些外部资源视图 View 对象，此时处理器方法返回的字符串就是要跳转资源视图 View 的名称。当然，这些视图 View 对象，可以是内部资源视图 View 对象。

Step1：修改配置文件

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/28.png)

Step2：修改处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/29.png)

##### 返回void

对于处理器方法返回 void 的应用场景，主要有两种：
（1 ） 过 通过 ServletAPI 传递数据并完成跳转通过在处理器方法的参数中放入的 ServletAPI 参数，来完成资源跳转时所要传递的数据及跳转。可在方法参数中放入 HttpServletRequest 或 HttpSession，使方法中可以直接将数据放入到 request、session 的域中，也可通过 request.getServletContext()获取到 ServletContext，从而将数据放入到 application 的域中。可在方法参数中放入 HttpServletRequest 与 HttpServletResponse，使方法可以完成请求转发与重定向。注意，重定向是无法完成对/WEB-INF/下资源的访问的。

- 请求转发：request.getRequestDispatcher(“目标页面”).forward(request,response);
- 重定向：response.sendRedirect(“目标页面”);

Step1：修改处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/30.png)

Step2：修改 SpringMVC 配置文件

修改 SpringMVC 配置文件，删除视图解析器的配置。因为处理器方法无视图返回，所以也就无需视图解析器了。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/31.png)

（2 ） AJAX 响应
若处理器对请求处理后，无需跳转到其它任何资源，此时可以让处理器方法返回 void。
例如，对于 AJAX 的异步请求的响应。

Step1：导入 Jar 包
由于本项目中服务端向浏览器传回的是 JSON（JavaScript Object Notation，JS 对象符号）数据，需要使用一个工具类将字符串包装为 JSON 格式，所以需要导入 JSON 的 Jar 包。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/32.png)

Step2：引入 jQuery 库
由于本项目要使用 jQuery 的 ajax()方法提交 AJAX 请求，所以项目中需要引入 jQuery 的库。在 WebRoot 下新建一个 Folder （文件夹），命名为 js，并将 jquery-1.8.3.js 文件放入其中。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/33.png)

当然，该 jQuery 库文件，需要在使用 ajax()方法的 index 页面中引入。

Step3：定义 index 页面
index 页面由两部分内容构成：一个是`<button/>`，用于提交 AJAX 请求；一个是`<script/>`，用于处理 AJAX 请求。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/34.png)

Step4：修改处理器类 MyController
处理器对于 AJAX 请求中所提交的参数，可以使用逐个接收的方式，也可以以对象的方式整体接收。只要保证 AJAX 请求参数与接收的对象类型属性同名。

以对象方式整体接收：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/35.png)

逐个接收:

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/36.png)

Step5：删除视图页面
由于是服务端直接向浏览器发回数据，所以也就无需视图页面了，所以需要删除WEB-INF 中的 jsp 目录及其中的 show 页面。

##### 返回Object

处理器方法也可以返回 Object 对象。但返回的这个 Object 对象不是作为逻辑视图出现的，而是作为直接在页面显示的数据出现的。

返回 Object 对象，需要使用@ResponseBody 注解，将转换后的 JSON 数据放入到响应体中。
（1 ） 环境搭建
A 、导入 Jar 包
由于返回 Object 数据，一般都是将数据转化为了 JSON 对象后传递给浏览器页面的。而这个由 Object 转换为 JSON，是由 Jackson 工具完成的。所以需要导入 Jackson 的相关 Jar 包。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/37.png)

B 、注册注解驱动
将 Object 数据转化为 JSON 数据，需要由 Http 消息转换器 HttpMessageConverter 完成。而转换器的开启，需要由`<mvc:annotation-driven/>`来完成。当 Spring 容器进行初始化过程中，在`<mvc:annotation-driven/>`处创建注解驱动时，默认创建了七个 HttpMessageConverter 对象。也就是说，我们注册`<mvc:annotation-driven/>`，就是为了让容器为我们创建 HttpMessageConverter 对象。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/38.png)

（2 ）返回数值

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/39.png)

Step2：修改处理器
在处理器方法上添加@ResponseBody 注解，将数据放入到响应体中。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/40.png)

Step3：修改配置文件
在配置文件中注册 mvc 的注解驱动。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/41.png)

（3 ） 返回字符串对象
若要返回非中文字符串，将前面返回数值型数据的返回值直接修改为字符串即可。但若返回的字符串中带有中文字符 ，则接收 方页面将会出现 乱码 。此时需要使用
@RequestMapping 的 produces 属性指定字符集。
produces，产品，结果，即该属性用于设置输出结果类型。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/42.png)

（4 ） 返回自定义类型对象
返回自定义类型对象时，不能以对象的形式直接返回给客户端浏览器，而是将对象转换为 JSON 格式的数据发送给浏览器的。由于转换器底层使用了Jackson转换方式将对象转换为JSON数据，所以需要导入Jackson的相关 Jar 包。

Step1：定义 VO 类

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/43.png)

Step2：修改处理器 MyController

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/44.png)

Step3：修改 index 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/45.png)

（5 ）返回Map 集合

Step1：修改处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/46.png)

Step2：修改 index 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/47.png)

（6 ） 返回 List 集合

Step1：修改处理器 MyController

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/48.png)

Step2：修改 index 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/49.png)





#### Spring MVC核心技术

##### 请求转发与重定向

当处理器对请求处理完毕后，向其它资源进行跳转时，有两种跳转方式：请求转发与重定向。而根据所要跳转的资源类型，又可分为两类：跳转到页面与跳转到其它处理器。

注意，对于请求转发的页面，可以是WEB-INF中页面；而重定向的页面，是不能为WEB-INF中页面的。因为重定向相当于用户再次发出一次请求，而用户是不能直接访问 WEB-INF 中资源的。

\####返回ModelAndView 时的请求转发
默认情况下，当处理器方法返回 ModelAndView 时，跳转到指定的 View，使用的是请求转发。但也可显式的进行指出。此时，需在 setViewName()指定的视图前添加 forward:，且此时的视图不会再与视图解析器中的前辍与后辍进行拼接。即必须写出相对于项目根的路径。

故此时的视图解析器不再需要前辍与后辍。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/50.png)

请求转发到其它 Controller：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/51.png)

##### 请求转发到页面

当通过请求转发跳转到目标资源（页面或 Controller）时，若需要向下传递数据，除了可以使用 request，session 外，还可以将数据存放于 ModelAndView 中的 Model 中。页面通过 EL 表达式可直接访问该数据。

Step1：修改处理器类 StudentController

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/52.png)

Step2：修改 SpringMVC 配置文件

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/53.png)

##### 请求转发到其它 Controller

直接修改处理器类 MyController。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/54.png)

##### 返回ModelAndView时的重定向

返回ModelAndView时的重定向，需在 setViewName()指定的视图前添加 redirect:，且此时的视图不会再与视图解析器中的前辍与后辍进行拼接。即必须写出相对于项目根的路径。

故此时的视图解析器不再需要前辍与后辍。重定向的目标资源中，将无法访问用户提交请求 request 中的数据。

重定向到页面：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/55.png)

重定向到其它 Controller：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/56.png)

##### 重定向到页面

在重定向时，请求参数是无法通过 request 的属性向下一级资源中传递的。但可以通过以下方式将请求参数向下传递。

A 、 通过 ModelAndView 的 的 Model 携带参数

当 ModelAndView 中的 Model 存入数据后，视图解析器 InternalResourceViewResolver 会将 map 中的 key 与 value，以请求参数的形式放到请求的 URL 后。
不过需要注意以下几点：

- 由于视图解析器会将 Map 的 value 放入到 URL 后作为请求参数传递出去，所以无论什么类型的 value，均会变为 String。故此，放入到 Model 中的 value，只能是基本数据类型与 String，不能是自定义类型的对象数据。
- 重定向的面页中是无法从 request 中读取数据的。但由于 map 中的 key 与 value，以请求参数的形式放到了请求的 URL 后，所以，页面可以通过 EL 表达式中的请求参数 param读取。
- 重定向的页面不能是/WEB-INF 中的页面。

Step1：修改处理器类 MyController。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/57.png)

Step2：修改 show 页面位置
由于重定向的请求无法访问/WEB-INF/下的内容，所以此时的 show 页面需要调换位置：
将 show 页面放到项目的根路径 WebRoot 下。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/58.png)

Step3：修改 show 页面内容
由于 Model 中的数据是放在 URL 后的参数，所以页面需要使用 param 来接收。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/59.png)

B 、 使用 HttpSession 携带参数

Step1：修改处理器类

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/60.png)

Step2：修改 show 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/61.png)

##### 重定向到Controller

重定向到其它 Controller 时，若要携带参数，完全可以采用前面的方式。而对于目标Controller 接收这些参数，则各不相同。

##### 返回String 时的请求转发

当处理器方法返回 String 时，该 String 即为要跳转的视图。在其前面加上前辍 forward:，则可显式的指定跳转方式为请求转发。同样，视图解析器不会对其进行前辍与后辍的拼接。请求转发的目标资源无论是一个页面，还是一个 Controller，用法相同。

Step1：修改处理器类

注意，此时不能再使用 ModelAndView 传递数据了。因为在处理器方法中定义的ModelAndView 对象就是个局部变量，方法运行结束，变量销毁。而当前的处理器方法返回的为 String，而非 ModelAndView，所以这个创建的 ModelAndView 就不起作用了。

不过，需要注意的是，对于处理器方法返回字符串的情况，当处理器接收到请求中的参数后，发现用于接收这些参数的处理器方法形参为包装类对象，则除了会将参数封装为对象传递给形参外，还会存放到 request 域属性中。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/62.png)

Step2：修改 show 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/63.png)

##### 返回String时的重定向

在处理器方法返回的视图字符串的前面添加前辍 redirect:，则可实现重定向跳转。

当重定向到目标资源时，若需要向下传递参数值，除了可以直接通过请求 URL 携带参数，通过 HttpSession 携带参数外，还可使用其它方式。

###### 重定向到页面

A 、 通过 Model 形参携带参数

可以在 Controller 形参中添加 Model参数，将要传递的数据放入 Model 中进行参数传递。该方式同样也是将参数拼接到了重定向请求的 URL 后，所以放入其中的数据只能是基本类型数据，不能是自定义类型。

Step1：修改处理器类

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/64.png)

Step2：修改 show 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/65.png)

B 、 通过形参 RedirectAttributes的addAttribute() 携带参数

RedirectAttributes 是 Spring3.1 版本后新增的功能，专门是用于携带重定向参数的。它是一个继承自 Model 的接口，其底层仍然使用 ModelMap 实现。通过 addAttribute()方法会将参数名及参数值放入该 Map 中，然后视图解析器会将其拼接到请求的 URL 中。所以，这种携带参数的方式，不能携带自定义对象。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/66.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/67.png)

Step2：修改 springmvc 配置文件

由于 RedirectAttributes 是个接口，而这个接口参数的实参值是由 MVC 的注解驱动为其自动赋的值，所以若要使用 RedirectAttributes 参数，则需要在 SpringMVC 的配置文件中注册MVC 的注解驱动。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/68.png)

###### 重定向到Controller

重定向到Controller时，携带参数的方式，除了可以使用请求URL后携带方式，HttpSession携带方式，Model 形参携带方式，及 RedirectAttributes 形参的 addAttibute()携带方式外，还可以使用 RedirectAttributes 形参的 addFlushAttibute()携带方式。

A 、 通过 Model 形参携带参数

Step1：修改处理器类

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/69.png)

Step2：修改 show 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/70.png)

B 、通过形参 RedirectAttributes 的 的 addFlushAttribute() 携带参数

RedirectAttributes 形参的 addFlushAttibute()携带方式不会将放入其中的属性值通过请求URL 传递，所以其中可以存放任意对象。

addFlushAttibute()方法的传值的实现原理是，将其中数据临时性的放入到 HttpSession 中。一旦目标 Controller 接收到了这个数据，则系统会立即将这个放入到 HttpSession 中的数据删除。即刷新时会发现，这个数据已为空。

应用场景：适合于在各 Controller 间传递对象，但这个被传递的对象，不适合在页面显示。因为该对象数据是“昙花一现”的。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/71.png)

##### 返回void 时的请求转发

当处理器方法返回 void 时，若要实现请求转发，则需要使用 HttpServletRequest 的请求转发方法。无论下一级资源是页面，还是 Controller，用法相同。

不过，需要注意的是，若有数据需要向下一级资源传递，则需要将数据放入到 request或 session 中。不能将数据放到 Model、RedirectAttributes 中。因为它们中的数据都是通过拼接到处理器方法的返回值中，作为请求的一部分出现向下传递的。这里没有返回值，所以它们中的数据便无法向下传递了。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/72.png)

##### 返回void 时的重定向

当处理器方法返回 void 时，若要实现重定向，则需要使用 HttpServletResponse 的重定向方法 sendRedirect()。

不过，需要注意的是，若有数据需要向下一级资源传递，则需要将数据放入到 session中。





#### 异常处理

常用的 Spring MVC 异常处理方式主要有三种：

- 使用系统定义好的异常处理器 SimpleMappingExceptionResolver
- 使用自定义异常处理器
- 使用异常处理注解

##### SimpleMappingExceptionResolver 异常处理器

该方式只需要在 SpringMVC 配置文件中注册该异常处理器 Bean 即可。该 Bean 比较特殊，没有 id 属性，无需显式调用或被注入给其它`<bean/>`，当异常发生时会自动执行该类。

提示：当请求参数的值与接收该参数的处理器方法形参的类型不匹配时，会抛出类型匹配有误异常 TypeMismatchException。

##### 自定义异常类

定义三个异常类：NameException、AgeException、StudentException。其中 StudentException是另外两个异常的父类。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/73.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/74.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/75.png)

##### 修改Controller

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/76.png)

##### 注册异常处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/77.png)

- exceptionMappings：Properties 类型属性，用于指定具体的不同类型的异常所对应的异常响应页面。Key 为异常类的全限定性类名，value 则为响应页面路径
- defaultErrorView：指定默认的异常响应页面。若发生的异常不是 exceptionMappings 中指定的异常，则使用默认异常响应页面。
- exceptionAttribute：捕获到的异常对象。一般异常响应页面中使用。

##### 定义异常响应页面

在 WebRoot 下新建一个目录 errors，在其中定义三个异常响应页面。

其中一个;

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/78.png)

##### 自定义异常处理器

使用 Spring MVC 定义好的 SimpleMappingExceptionResolver 异常处理器，可以实现发生指定异常后的跳转。但若要实现在捕获到指定异常时，执行一些操作的目的，它是完成不了的。此时，就需要自定义异常处理器。

自定义异常处理器，需要实现HandlerExceptionResolver接口，并且该类需要在SpringMVC配置文件中进行注册。

###### 定义异常处理器

当一个类实现了 HandlerExceptionResolver 接口后，只要有异常发生，无论什么异常，都会自动执行接口方法 resolveException()。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/79.png)

###### 注册异常处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/80.png)

######异常处理注解
使用注解@ExceptionHandler 可以将一个方法指定为异常处理方法。该注解只有一个可选属性 value，为一个 Class<?>数组，用于指定该注解的方法所要处理的异常类，即所要匹配的异常。

而被注解的方法，其返回值可以是 ModelAndView、String，或 void，方法名随意，方法参数可以是 Exception 及其子类对象、HttpServletRequest、HttpServletResponse 等。系统会自动为这些方法参数赋值。

对于异常处理注解的用法，也可以直接将异常处理方法注解于 Controller 之中。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/81.png)

不过，一般不这样使用。而是将异常处理方法专门定义在一个 Controller 中，让其它Controller 继承该 Controller 即可。但是，这种用法的弊端也很明显：Java 是“单继承多实现”的，这个 Controller 的继承将这唯一的一个继承机会使用了，使得若再有其它类需要继承，将无法直接实现。

###### 定义异常处理的Controller

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/82.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/83.png)

###### 修改Controller

让普通 Controller 继承自定义好的异常处理 Controller。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/84.png)





#### 类型转换器

在前面的程序中，表单提交的无论是 int 还是 double 类型的请求参数，用于处理该请求的处理器方法的形参，均可直接接收到相应类型的相应数据，而非接收到 String 再手工转换。那是因为在 SpringMVC 框架中，有默认的类型转换器。这些默认的类型转换器，可以将 String类型的数据，自动转换为相应类型的数据。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/85.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/86.png)

但默认类型转换器并不是可以将用户提交的 String，转换为所有用户需要的类型。此时，就需要自定义类型转换器了。

例如，在 SpringMVC 的默认类型转换器中，没有日期类型的转换器，因为日期的格式太多。若要使表单中提交的日期字符串，被处理器方法形参直接接收为 java.util.Date，则需要自定义类型转换器了。

##### 搭建测试环境

要求：日期格式为 yyyy/MM/dd

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/87.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/88.png)

##### 自定义类型转换器

若要定义类型转换器，则需要实现 Converter 接口。该 Converter 接口有两个泛型：第一个为待转换的类型，第二个为目标类型。而该接口的方法 convert()，用于完成类型转换。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/89.png)

##### 对类型转换器的配置

类型转换器定义完毕后，需要在 SpringMVC 的配置文件中对类型转换进行配置。首先要注册类型转换器，然后再注册一个转换服务 Bean。将类型转换器注入给该转换服务 Bean。最后由处理器适配器来使用该转换服务 Bean。

##### 注册类型转换器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/90.png)

##### 创建转换服务Bean

对于类型转换器，并不是直接使用，而是通过转换服务 Bean 来调用类型转换器。而转换服务 Bean 的创建，是由转换服务工厂 Bean – ConversionServiceFactoryBean 完成。

该工厂 Bean 有一个 Set 集合属性 converters，用于指定该转换服务可以完成的转换，即可以使用的转换器。从 Set 集合可知，各转换器间无先后顺序。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/91.png)

由于 SpringMVC 对于类型转换的完成，不是直接使用类型转换器，而是通过创建出具有多种转换功能的转换服务 Bean 来完成的。所以，SpringMVC 同时支持多种类型转换器。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/92.png)

##### 使用转换服务Bean

转换服务 Bean 是由处理器适配器直接调用的。采用 mvc 的注解驱动注册方式，可以将转换服务直接注入给处理器适配器。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/93.png)

##### Spring MVC配置文件总的配置

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/94.png)

##### 接收多种日期格式的类型转换器

要求：日期格式可以为 yyyy/MM/dd、yyyy-MM-dd 或 yyyyMMdd。

直接修改类型转换器即可。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/95.png)

##### 数据回显

当数据类型转换发生异常后，需要返回到表单页面，让用户重新填写。但正常情况下，发生类型转换异常，系统会自动跳转到 400 页面。所以，若要在发生类型转换异常后，跳转到指定页面，则需要将异常捕获，然后通过异常处理器跳转到指定页面。

若仅仅是完成跳转，则使用系统定义好的 SimpleMappingExceptionResolver 就可以。但，当页面返回到表单页面后，还需要将用户原来填写的数据显示出来，让用户更正填错的数据。

也就是还需要完成数据回显功能。此时就需要自定义异常处理器了。

##### 修改处理器

类型转换异常为 TypeMismatchException。

数据回显原理：在异常处理器中，通过 request.getParameter()将用户输入的表单原始数据获取到后，直接放入到 ModelAndView 中的 Model 中，然后从要转向的页面中就可以直接通过 EL 表达式读取出，也就实现了数据回显。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/96.png)

##### 修改页面表单

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/97.png)

##### 修改类型转换器

以上代码只能解决当年龄输入有误，但日期输入正确的回显问题。但，若日期输入有误，年龄输入正确时，将无法实现回显。因为当日期格式输入有误时，SimpleDateFormat 的 parse()方法将会抛出 ParseException，而非 TypeMismatchException。

那就让异常处理器再捕获 ParseException 完成跳转不也行吗?但类型转换器接口Converter的 convter()方法是没有抛出异常的，那也就是说，我们所实现的自定义类型转换器中的 convert()方法了不能抛出异常，对异常的处理方式必须为 try-catch。换句话说，convert()方法要将异常自己消化，而非抛出给调用者，即 JVM。即当 ParseException 发生时，convert()方法自己处理了异常，而对于 JVM 来说，根本就不知道有 ParseException 异常的发生。这样的话，异常处理器也就无法捕获到 ParseException 了。所以，解决的策略是，当用户输入的日期格式不符合要求时，手工抛出一个类型匹配异常。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/98.png)

不过，对于 TypeMismatchException 类，其没有无参构造器，这里使用了一个带两个参数的构造器。第一个参数为要匹配的值，第二个参数为要匹配的类型。即当第一个参数的类型与第二参数的类型没有 is-a 关系时，该异常发生。

由于本例中要判断的值确定为 String 类型，而目标类型确定为 Date 类型，所以第一个参数就随便写了一个 String 常量。因为这里的判断与具体的数值无关，只与类型有关。

##### 自定义类型转换失败后提示信息

SpringMVC 并没有专门的用于自定义类型转换失败后提示信息的功能。需要程序员自己实现。

查看类型转换失败后系统给出的提示信息，发现内容很多，但其中却包含着用户所提交的输入数据。所以，可以通过从系统提示信息中查找用户输入数据的方式，来确定是哪个数据出现了类型转换异常。使用 String 类的 contains()方法来判断系统异常信息中是否存在用户输入数据。一旦出问题的数据被确定，则异常信息就可以进行准确替换了。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/99.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/100.png)

##### 修改处理器

对于处理器，需要修改两处：

A 、 定义一个方法
在处理器中定义一个方法，用于根据发生类型转换异常的数据的不同而生成不同提示信息。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/101.png)

B 、 修改异常处理方法
在异常处理方法中将新生成的异常信息写入到 ModelAndView 中的 Model，用于页面中通过 EL 表达式显示。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/102.png)

##### 修改index页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/103.png)





#### 数据验证

在 Web 应用程序中，为了防止客户端传来的数据引发程序的异常，常常需要对数据进行验证。输入验证分为客户端验证与服务器端验证。客户端验证主要通过 JavaScript 脚本进行，而服务器端验证则主要是通过 Java 代码进行验证。

为了保证数据的安全性，一般情况下，客户端验证与服务器端验证都是要进行的。

我们这里所讲的是 SpringMVC 在服务端是如何对数据进行验证的。

需求：要求用户输入的表单数据满足如下要求：

- 姓名：非空，且长度 3-6 个字符
- 成绩：0-100 分
- 手机号：非空，且必须符合手机号格式

#####  搭建测试环境

###### 导入Jar 包

SpringMVC 支持 JSR（Java Specification Requests，Java 规范提案）303 - Bean Validation数据验证规范。而该规范的实现者很多，其中较常用的是 Hibernate Validator。需要注意的是，Hibernate Validator 是与 Hibernate ORM 并列的 Hibernate 的产品之一。这一点从 Hibernate 官网上所提供的资源形式可以看出它们之间的关系。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/104.png)

所以，除了 SpringMVC 的 Jar 包外，我们还需要导入 Hibernate Validator 的 Jar 包。这些Jar 包，可以从 Hibernate 官网中直接下载。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/105.png)

###### 定义实体

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/106.png)

###### 定义index

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/107.png)

###### 定义Controller

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/108.png)

###### 定义show

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/109.png)

###### 定义Spring MVC配置文件

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/110.png)

##### 实现数据验证

###### 修改spring mvc 配置文件

验证器由 SpringMVC 框架的 LocalValidtorFactoryBean 类生成，而真正验证器的提供者则是 HibernateValidator。

在 SpringMVC 配置文件中将验证器注册后，需要将其注入给注解驱动。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/111.png)

###### 在实体属性上添加验证注解

使用的验证器注解均为 javax.validation.constraints 包中的类。

在注解的 message 属性中，可以使用{ 属性名}的方式来引用指定的注解的属性值。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/112.png)

Hibernate Validator 中常用的验证注解介绍：

@Null 被注释的元素必须为 null
@NotNull 被注释的元素必须不为 null
@AssertTrue 被注释的元素必须为 true
@AssertFalse 被注释的元素必须为 false
@Min(value) 被注释的元素必须是一个数字，其值必须大于等于指定的最小值
@Max(value) 被注释的元素必须是一个数字，其值必须小于等于指定的最大值
@DecimalMin(value) 被注释的元素必须是一个数字，其值必须大于等于指定的最小值
@DecimalMax(value) 被注释的元素必须是一个数字，其值必须小于等于指定的最大值
@Size(max=, min=) 被注释的元素的大小必须在指定的范围内
@Digits (integer, fraction) 被注释的元素必须是一个数字，其值必须在可接受的范围内
@Past 被注释的元素必须是一个过去的日期
@Future 被注释的元素必须是一个将来的日期
@Pattern(regex=,flag=) 被注释的元素必须符合指定的正则表达式

Hibernate Validator 附加的 constraint
@NotBlank(message =) 验证字符串非null，且长度必须大于0
@Email 被注释的元素必须是电子邮箱地址
@Length(min=,max=) 被注释的字符串的大小必须在指定的范围内
@NotEmpty 被注释的字符串的必须非空
@Range(min=,max=,message=) 被注释的元素必须在合适的范围内

`注意@NotNull 与@NotEmpty 的区别。`

###### 修改Controller

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/113.png)

由于这里使用的验证器为 Bean 对象验证器，所以对于要验证的参数数据，需要打包后由处理器方法以 Bean 形参类型的方式接收，并使用@Validated 注解标注。注意，不能将@Validated 注解在 String 类型与基本类型的形参前。

紧跟着@Validated 所注解的形参的后面，是一个 BindingResult 类型的形参。通过该形参可获取到所有验证异常信息。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/114.png)

只要发生数据验证失败，则需要将页面重新跳转到 index.jsp 表单页面，让用户重填。

BindingResult 接口中常用的方法有：

- getAllErrors()：获取到所有的异常信息。其返回值为 List，但若没有发生异常，则该 List为也被创建，只不过其 size()为 0，而非 List 为 Null。
- getFieldError()：获取指定属性的异常信息
- getErrorCount()：获取所有异常的数量
- getRawFieldValue()：获取到用户输入的引发验证异常的原始值

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/115.png)

若各个数据均通过验证，则代码正常执行

##### 页面显示验证异常信息

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/116.png)





#### 文件上传

##### 上传单个文件

###### 导入Jar包

SpringMVC 实现文件上传，需要再添加两个 Jar 包。一个是文件上传的 Jar 包，一个是其所依赖的 IO 包。这两个 Jar 包，均在 Spring 支持库的 org.apache.commons 中。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/117.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/118.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/119.png)

###### 定义上传页面

定义具有文件上传功能的页面 index.jsp，其表单的设置需要注意，method 属性为 POST，enctype 属性为 multipart/form-data。另外，需要注意 file 表单元素的参数名称，Controller中需要使用。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/120.png)

###### 定义处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/121.png)

对于处理器的定义，需要注意以下几点：

A 、 处理器方法的形参
用于接收表单元素所提交参数的处理器方法的形参类型不是 File，而是 MultipartFile。MultipartFile 为一个接口，专门用于处理文件上传问题。该接口中具有很多有用的方法，例如 获 取 参 数 名 称 getName() ， 本 例 指 的 是 homework ； 获 取 文 件 的 原 始 名 称getOriginalFilename()；获取文件大小 getSize()；判断文件是否为空 isEmpty()；文件上传transferTo()等。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/122.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/123.png)

MultipartFile 接口常用的实现类为 CommonsMultipartResolver。而该实现类中具有设置上传文件大小、上传文件字符集等属性，可以通过为其注入值，来限定上传的文件。

B 、 未选择上传文件
若用户未选择上传的文件就直接提交了表单，此时处理器方法的 MultipateFile 形参所接收到的实参值并非为 null，而是一个内容为 empty 的文件。所以，对于未选择上传文件的情况的处理，其判断条件为 file.isEmpty()，而非 file == null。

C 、 上传文件类型
SpringMVC 的文件上传功能并未有直接的用于限定文件上传类型的方法或属性，需要对获取到的文件名后辍加以判断。此时使用 String 的 endWith()方法较为简捷。

D 、 上传方法
对于上传单个文件，直接使用 MultipartFile 的 transferTo()方法，就可以完成上传功能。**但是，需要注意的是，该方法要求服务端用于存放客户上传文件的目录必须存在，否则报错。即其不会自己创建该目标目录。如本例中，必须手工创建 images 目录**。

##### 在SpringMVC中注册文件上传处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/124.png)

A 、 Bean 名称固定
在 SpringMVC 的配置文件中注册 MultipartFile 接口的实现类 CommonsMultipartResolver的 Bean。要求该 Bean 的 id 必须为 multipartResolver。

是否进行文件上传，实际上是在中央调度器 DispatcherServlet 执行处理器映射器RequestMapping 之前先进行判断的。

首先会先从容器中加载一个名称为 multipartResolver 的 Bean。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/125.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/126.png)

如果容器中定义了名称为 multipartResolver 的 Bean，且请求也为 multipart 类型（即enctype 属性值为 multipart/form-data），则返回 MultipartHttpServletRequest 请求类型，完成文件上传功能。否则，返回普通的 HttpServletRequest 请求类型。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/127.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/128.png)

B 、 文件上传字符集
对于文件名为中文的文件，默认情况下上传完成后，文件名为乱码，因为默认情况下文件上传处理器使用的字符集为 ISO-8859-1。可以通过设置属性 defaultEncoding 来指定文件上传所使用的字符集。

C 、 限定文件大小
MultipartFile 接 口 的 实 现 类 CommonsMultipartResolver 继 承 自CommonsFileUploadSupport 类，而该类有一个属性 maxUploadSize 可以用来限定上传文件的大小，单位字节 B。如果不对该属性进行设置，或指定其值为-1，则表示不对上传文件大小作限制。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/129.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/130.png)

注意，该大小为上传文件的总大小。即，若上传多个文件，则多个文件的大小之和不能大小该设定值。

当然，也可通过设置属性 maxUploadSizePerFile，再添加对每个上传文件的大小设置。即每个文件的大小不能超过 maxUploadSizePerFile 指定值，而文件大小总和也不能超过maxUploadSize 指定值。

##### 设置文件超出大小的异常处理

当上传文件超出指定大小时，会抛出 MaxUploadSizeExceededException 异常。通过在SpringMVC 配置文件中设置 SimpleMappingExceptionResolver，可实现对该异常的处理。

###### 注册异常处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/131.png)

###### 定义异常响应页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/132.png)

###### 定义上传成功与失败页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/133.png)

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/134.png)

##### 上传多个文件

项目：fileupload-multifile。在项目 fileupload-singlefile 的基础上修改。

###### 修改 index

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/135.png)

###### 修改处理器类

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/136.png)

A 、 处理器方法的形参

用于接收表单元素所提交参数的处理器方法的形参类型为 MultipartFile 数组，且必须使用注解@RequestParam 修饰。

为什么上传单个文件时 MultipartFile 参数不用使用@RequestParam 修饰，而上传多个文件时 MultipartFile[]就需要@RequestParam 修饰呢？

因为在上传多个文件时，每个表单中的文件对象框架均会将其转换为MultipartFile类型，这是与上传单个文件是相同的，不需要@RequestParam 修饰。但上传多个文件时，处理器方法需要的不是 MultipartFile 类型参数，而是 MultipartFile[]数组类型。默认情况下框架只会将一个一个的表单元素转换为一个一个的对象，但并不会将这多个对象创建为一个数组对象。

此时，需要使用@RequestParam 来修饰这个数组参数，向框架表明，表单传来的参数与处理器方法接收的参数名称与类型相同，需要框架调用相应的转换器将请求参数转换为方法参数类型。所以，对于上传多个文件，处理器方法的 MultipartFile[]数组参数必须使用注解@RequestParam 修饰。

B 、 未选择上传文件
即使没有选择任何要上传的文件，MultipartFile 数组也不为 null。不仅不为 null，其 length值也大于 0。因为系统会为每个 file 表单元素创建一个 File 对象，只不过没有选择上传文件的这个 File 将不会被赋予真正的文件，只是一个为 empty 的 File。所以对于没有选择任何要

上传的文件的情况的处理，只能逐个文件表单元素进行判断，判断文件是否为 empty。





#### 拦截器

SpringMVC 中的 Interceptor 拦截器是非常重要和相当有用的，它的主要作用是拦截指定的用户请求，并进行相应的预处理与后处理。其拦截的时间点在“处理器映射器根据用户提交的请求映射出了所要执行的处理器类，并且也找到了要执行该处理器类的处理器适配器，在处理器适配器执行处理器之前”。当然，在处理器映射器映射出所要执行的处理器类时，已经将拦截器与处理器组合为了一个处理器执行链，并返回给了中央调度器。

##### 一个拦截器的执行

###### 自定义拦截器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/137.png)

自定义拦截器，需要实现 HandlerInterceptor 接口。而该接口中含有三个方法：

- preHandle(request, response, Object handler) ：该方法在处理器方法执行之前执行。其返回值为 boolean，若为 true，则紧接着会执行处理器方法，且会将 afterCompletion()方法放入到一个专门的方法栈中等待执行。
- postHandle(request, response, Object handler, modelAndView) ：该方法在处理器方法执行之后执行。处理器方法若最终未被执行，则该方法不会执行。由于该方法是在处理器方法执行完后执行，且该方法参数中包含 ModelAndView，所以该方法可以修改处理器方法的处理结果数据，且可以修改跳转方向。
- afterCompletion(request, response, Object handler, Exception ex) ：当 preHandle()方法返回 true 时，会将该方法放到专门的方法栈中，等到对请求进行响应的所有工作完成之后才执行该方法。即该方法是在中央调度器渲染（数据填充）了响应页面之后执行的，此时对 ModelAndView 再操作也对响应无济于事。

拦截器中方法与处理器方法的执行顺序如下图：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/138.png)

换一种一表现方式，也可以这样理解：

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/139.png)

###### 注册拦截器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/140.png)

`<mvc:mapping/>`用于指定当前所注册的拦截器可以拦截的请求路径，而/**表示拦截所有请求。

###### 修改 index 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/141.png)

###### 修改处理器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/142.png)

###### 修改 show 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/143.png)

###### 控制台输出结果

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/144.png)



##### 多个拦截器的执行

###### 再定义一个拦截器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/145.png)

###### 多个拦截器的注册 与执行

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/146.png)

###### 控制台执行结果

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/147.png)

当有多个拦截器时，形成拦截器链。拦截器链的执行顺序，与其注册顺序一致。需要再次强调一点的是，当某一个拦截器的 preHandle()方法返回 true 并被执行到时，会向一个专门的方法栈中放入该拦截器的 afterCompletion()方法。

多个拦截器中方法与处理器方法的执行顺序如下图

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/148.png)

从图中可以看出，只要有一个 preHandle()方法返回 false，则上部的执行链将被断开，其后续的处理器方法与 postHandle()方法将无法执行。但，无论执行链执行情况怎样，只要方法栈中有方法，即执行链中只要有 preHandle()方法返回 true，就会执行方法栈中的afterCompletion()方法。最终都会给出响应。


##### 阅读源码

查看中央调度器 DispatcherServlet 的 doDispatch()方法源码：在执行处理器方法之前，会执行处理器执行链对象 mappedHandler 的 applyPreHandle()方法。然后执行 Handler，最后执行处理器执行链对象的 applyPostHandle()方法。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/149.png)

applyPreHandle()方法用于执行处理器执行链中的所有拦截器的 preHandle()方法。applyPreHandle()方法的返回结果取决于执行链中的每一个拦截器的 preHandle()方法。只要有一个 preHandle()方法返回 false，则其就会返回 false。然后就执行了 return;即结束了doDispatch()方法，即该请求的处理结束。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/150.png)

对于处理器执行链的 applyPostHandle()方法，其是循环倒序执行所有拦截器的postHandle()方法的。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/151.png)

那么 afterCompletion()方法是什么时候执行的呢？
在刚才的处理器执行链的 applyPreHandle()方法中看到，若存在任一个拦截器的preHandle()方法返回 false，则会调用执行处理器执行链的 triggerAfterCompletion()方法，即会触发所有 afterCompletion()方法的执行。

在 doDispatch()方法中也存在一个 catch(){}语句，表示若发生异常，则会调用执行triggerAfterCompletion()方法。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/152.png)

但在正常情况下，即所有的 preHandle()方法返回均为 true，且 doDispatch()方法没有异常发生的情况下，afterCompletion()方法是在视图解析器后执行的。

查看中央调度器 DispatcherServlet 的 processDispatchResult()方法源码可知，在对视图渲染过后，会调用执行处理器执行链的 triggerAfterCompletion()方法，即执行所有的afterCompletion()方法。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/153.png)

打开处理器执行链的 triggerAfterCompletion()方法，可以看到，其对拦截器的afterCompletion()方法的执行，也是循环倒序执行的。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/154.png)

##### 权限拦截器举例

只有经过登录的用户方可访问处理器，否则，将返回“无权访问”提示。

本例的登录，由一个 JSP 页面完成。即在该页面里将用户信息放入 session 中。也就是说，只要访问过该页面，就说明登录了。没访问过，则为未登录用户。

###### 修改 index 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/155.png)

######  定义 Controller

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/156.png)

###### 定义 welcome 页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/157.png)

###### 定义权限拦截器

当 preHandle()方法返回 false 时，需要使用 request 或 response 对请求进行响应。

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/158.png)

###### 定义fail页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/159.png)

###### 注册权限拦截器

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/160.png)

###### 定义login页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/161.png)

###### 定义logout页面

![Spring MVC](http://of2m1l60v.bkt.clouddn.com/2017.05.30/162.png)



ref:

1.[Spring MVC 总结](https://www.bcoder.top/2017/06/01/Spring-MVC-%E6%80%BB%E7%BB%93/),   2.[Spring MVC配置介绍 ](https://blog.csdn.net/suifeng3051/article/details/51596511)