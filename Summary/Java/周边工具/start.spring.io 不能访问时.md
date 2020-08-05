### start.spring.io 不能访问
#### 1.  使用阿里云https://start.aliyun.com/ 地址直接替代
![](https://img2020.cnblogs.com/blog/637525/202008/637525-20200805152035164-1144651694.png)



#### 2.  安装IDEA插件Cloud Toolkit，重启之后，便可创建工程
![](https://img2020.cnblogs.com/blog/637525/202008/637525-20200805152046626-444375049.png)
![](https://img2020.cnblogs.com/blog/637525/202008/637525-20200805152053300-1123817518.png)



#### 3.  直接上start.spring.io创建项目
![](https://img2020.cnblogs.com/blog/637525/202008/637525-20200805152120275-1332145459.png)



#### 4. 自己搭建本地的服务器
  - cloen代码：git clone https:*//github.com/spring-io/start.spring.io* 
  - 打包编译：cd start.spring.io ，执行mvnw clean package -Dmaven.test.skip=true
  - target 文件下两个jar 用*-exec.jar 可以直接**java -jar -Dserver.port=8080 target\start-site-exec.jar** 运行
  - IDEA之中，使用Custom，填入localhost:8080然后创建项目
  - ![](https://img2020.cnblogs.com/blog/637525/202008/637525-20200805152128154-1226759422.png)


<hr/>

ref:
1.[解决 start.spring.io 不能访问 使用阿里云国服链接替代](https://blog.csdn.net/lishizhen1991/article/details/106241666/), 2.[解决 start.spring.io 不能访问，可以用Cloud Toolkit在代替](https://blog.csdn.net/elvishehai/article/details/107607153), 3.[解决start.spring.io网络连接不稳定问题，自行搭建](https://blog.csdn.net/u010385090/article/details/107186380), 4.[start.spring.io项目地址](https://github.com/spring-io/start.spring.io)