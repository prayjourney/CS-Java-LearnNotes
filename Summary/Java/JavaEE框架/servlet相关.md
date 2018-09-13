### servlet相关

---

##### servlet的生命周期

`public void init(ServletConfig);` 初始化方法

`public service(ServletRequest,ServletResponse);` 服务方法，doGet()，doPost()

`public destroy();`  销毁方法

默认情况下，servlet对象在第一次请求的时候调用构造函数创建， 创建之后自动调用带参的init方法，然后调用service方法。destroy方法在停止服务器或者停止应用的时候调用。整个过程中，init方法和destroy方法只会调用一次，而service方法会反复调用



##### servlet的创建问题

创建一个servlet有3中方式，如下

- 采用实现servlet接口, （不推荐）
- 采用继承GenericServlet类( 不推荐)
- 采用继承HttpServlet(推荐)




##### serlvet的线程安全

明确:   Servlet的设计是一个单实例多线程，线程安全要求将变量创建成一个局部变量，而不要创建成实例变量
