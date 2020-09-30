### war和war exploded的区别

***

##### war和war exploded的区别

在使用IDEA开发项目的时?, ?署Tomcat的时候通常会出现下边的情况：

![这里写图片描述](../../../images/war1.png)

是选择`war`还是`war exploded` 这里首先看一下他们两个的区别：

```shell
war模式：将WEB工程以包的形式上传到服务器;
war exploded模式：将WEB工程以当前文件夹的位置关系上传到服务器;
```

1.war模式这种可以称之为是发布模式, 看名字也知道, 这是先打成war包, 再发布；

2.war exploded模式是直接把文件夹、jsp页面 、classes等等移到Tomcat 部署文件夹里面, 进行加载部署. 因此这种方式支持热部署, 一般在开发的时候也是用这种方式. 

3.在平时开发的时候, 使用热部署的话, 应该对Tomcat进行相应的设置, 这样的话修改的jsp界面什么的东西才可以及时的显示出来. 

![这里写图片描述](../../../images/war2.png)

修改箭头指向的位置, 这样的话就可以实现热部署. 



##### 使用war模式开发的时候遇到的坑

**1.项目代码的位置如下：**

![这里写图片描述](../../../images/war3.png)

上述项目为SSM项目. 

**2.部署使用的Tomcat位置：**

![这里写图片描述](../../../images/war4.png)

**3.用于获取上下文环境绝对路径的代码：**

```java
String contextPath = request.getSession().getServletContext().getRealPath("/");1
```

**4.两种方式的实验过程和结果：**

- 在使用war模式开发的时候, 通过下边这段代码获取项目的相对路径：

```java
String contextPath = request.getSession().getServletContext().getRealPath("/");1
```

war模式始终是获取到的路径如下：

![这里写图片描述](../../../images/war5.png)

其中`C:\Software\apache-tomcat-8.0.32` 是我Tomcat的所在位置. 

可以看出通过`war模式`是最终打包部署到Tomcat的位置. 

- 然后再看`war exploded模式`,同样进行设置, 运行同一段代码, 运行结果如下：

![这里写图片描述](../../../images/war6.png)

可以看出最终得到的是我这个项目的位置, 其实就是这个项目target的位置. 

**5.总结**

根据上述两步的实验结果可以看到这两种方式得部署方式是不一样的, 因此在获取项目的相对路径的时候得到的结果是不一样的. 



ref:
1.[Tomcat部署时war和war exploded区别以及平时踩得坑](https://blog.csdn.net/xlgen157387/article/details/56498938)