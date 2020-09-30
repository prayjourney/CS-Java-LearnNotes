### 浅谈@RequestMapping @ResponseBody 和 @RequestBody 注解的用法与区别
---

> **博主说**：首先，大家在使用SSM框架进行web开发的时候，经常会在Ctrl层遇到@RequestMapping、@ResponseBody以及@RequestBody这三个参数，博主就以自己在项目开发中总结的一些知识点浅谈一下三者之间微妙的关系。

##### 1.@RequestMapping

国际惯例先介绍什么是@RequestMapping，@RequestMapping 是一个用来处理请求地址映射的注解，可用于类或方法上。用于类上，表示类中的所有响应请求的方法都是以该地址作为父路径；用于方法上，表示在类的父路径下追加方法上注解中的地址将会访问到该方法，**此处需注意@RequestMapping用在类上可以没用，但是用在方法上必须有**。

**例如：**

```java
@Controller
//设置想要跳转的父路径
@RequestMapping(value = "/Controllers")
public class StatisticUserCtrl {
    //如需注入，则写入需要注入的类
    //@Autowired

            // 设置方法下的子路经
            @RequestMapping(value = "/method")
            public String helloworld() {

                return "helloWorld";

            }
}
```

其原理也非常好了解，其对应的 action 就是“ （父路径） controller/（父路径下方法路经）method ”。因此，在本地服务器上访问方法 <http://localhost:8080/controller/method> 就会返回（跳转）到“ helloWorld.jsp ”页面。

说到这了，顺便说一下 @PathVariable 注解，其用来获取请求路径（url ）中的动态参数。

**页面发出请求：**

```javascript
function login() {
    var url = "${pageContext.request.contextPath}/person/login/";
    var query = $('#id').val() + '/' + $('#name').val() + '/' + $('#status').val();
    url += query;
    $.get(url, function(data) {
        alert("id: " + data.id + "name: " + data.name + "status: "
                + data.status);
    });
}
```

**例如：**

```java
/**
* @RequestMapping(value = "user/login/{id}/{name}/{status}") 中的 {id}/{name}/{status}
* 与 @PathVariable int id、@PathVariable String name、@PathVariable boolean status
* 一一对应，按名匹配。
*/

@RequestMapping(value = "user/login/{id}/{name}/{status}")
@ResponseBody
//@PathVariable注解下的数据类型均可用
public User login(@PathVariable int id, @PathVariable String name, @PathVariable boolean status) {
//返回一个User对象响应ajax的请求
    return new User(id, name, status);
}
```



##### 2.@ResponseBody

@Responsebody 注解表示该方法的返回的结果直接写入 HTTP 响应正文（ResponseBody）中，一般在异步获取数据时使用，通常是在使用 @RequestMapping 后，返回值通常解析为跳转路径，加上 @Responsebody 后返回结果不会被解析为跳转路径，而是直接写入HTTP 响应正文中。 
**作用：** 
该注解用于将Controller的方法返回的对象，通过适当的HttpMessageConverter转换为指定格式后，写入到Response对象的body数据区。 
**使用时机：** 
返回的数据不是html标签的页面，而是其他某种格式的数据时（如json、xml等）使用；

**当页面发出异步请求：**

```javascript
function login() {
    var datas = '{"username":"' + $('#username').val() + '","userid":"' + $('#userid').val() + '","status":"' + $('#status').val() + '"}';
    $.ajax({
        type : 'POST',
        contentType : 'application/json',
        url : "${pageContext.request.contextPath}/user/login",
        processData : false,
        dataType : 'json',
        data : datas,
        success : function(data) {
            alert("userid: " + data.userid + "username: " + data.username + "status: "+ data.status);
        },
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            alert("出现异常，异常信息："+textStatus,"error");
        }
    });
};
```

**例如：**

```java
@RequestMapping(value = "user/login")
@ResponseBody
// 将ajax（datas）发出的请求写入 User 对象中,返回json对象响应回去
public User login(User user) {   
    User user = new User();
    user .setUserid(1);
    user .setUsername("MrF");
    user .setStatus("1");
    return user ;
}
```

异步获取 json 数据，加上 @Responsebody 注解后，就会直接返回 json 数据。



##### 3.@RequestBody

@RequestBody 注解则是将 HTTP 请求正文插入方法中，使用适合的 HttpMessageConverter 将请求体写入某个对象。

**作用：**

> 1) 该注解用于读取Request请求的body部分数据，使用系统默认配置的HttpMessageConverter进行解析，然后把相应的数据绑定到要返回的对象上； 
> 2) 再把HttpMessageConverter返回的对象数据绑定到 controller中方法的参数上。

**使用时机：**

A) GET、POST方式提时， 根据request header Content-Type的值来判断:

> application/x-www-form-urlencoded， 可选（即非必须，因为这种情况的数据@RequestParam, @ModelAttribute也可以处理，当然@RequestBody也能处理）； 
> multipart/form-data, 不能处理（即使用@RequestBody不能处理这种格式的数据）； 
> 其他格式， 必须（其他格式包括application/json, application/xml等。这些格式的数据，必须使用@RequestBody来处理）；

B) PUT方式提交时， 根据request header Content-Type的值来判断:

> application/x-www-form-urlencoded， 必须；multipart/form-data, 不能处理；其他格式， 必须；

说明：request的body部分的数据编码格式由header部分的Content-Type指定；

**例如：**

```java
@RequestMapping(value = "user/login")
@ResponseBody
// 将ajax（datas）发出的请求写入 User 对象中
public User login(@RequestBody User user) {   
// 这样就不会再被解析为跳转路径，而是直接将user对象写入 HTTP 响应正文中
    return user;    
}
```

------

> 最后感谢walkerjong的spring源码支持，如有问题请大家多多评论，你的建议是我成长道路中必不可少的养分，还是那句话，我们不止会New！



ref:

1.[浅谈@RequestMapping @ResponseBody 和 @RequestBody 注解的用法与区别 ](https://blog.csdn.net/ff906317011/article/details/78552426)