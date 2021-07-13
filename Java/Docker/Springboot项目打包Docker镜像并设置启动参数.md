### Springboot项目打包Docker镜像并设置启动参数

1. 新建项目
![img](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713165252.png)

2. 配置profle
![img](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713165453.png)

3. 编写Dockefile
![img](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713165548.png)
```yml
FROM java:8 MAINTAINER zgy<zgy@123.com> 

WORKDIR /usr/local/app 
COPY *.jar app.jar 
EXPOSE 8080 ENTRYPOINT ["java", "-Dspring.profiles.active=${SPRING_PROFILES_ACTIVE}", "-jar", "app.jar"]
```

4. 编译打包
![img](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713165639.png)

5. 传入Dockerfile和jar包
![img](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713165728.png)

6. 构建镜像
![img](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713165829.png)

7. 运行镜像
![img](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713165927.png)

8. 测试运行
![](https://raw.githubusercontent.com/prayjourney/img-home/master/img/20210713170020.png)

参考
> https://segmentfault.com/a/1190000011367595，https://mingshan.fun/2018/08/22/docker-enables-spring-profiles/，https://www.cnblogs.com/lshan/p/9717904.html，https://blog.csdn.net/qq_32106893/article/details/105828904，http://www.littlebigextra.com/use-spring-profiles-docker-containers/，https://spring.io/guides/gs/spring-boot-docker/
