### 常用JVM参数以及含义

---

`-X `  代表的是虚拟机指令

`- Xss`:  每个线程栈(stack)的大小

`- Xmx`:  Java堆的最大值，默认为物理内存的1/4

`- Xms`:   Java堆的最小值(初始值)，Server端最好设置Xmx与Xms大小相等

`- Xmn`:  Java堆中新生代(Young)区的大小(JDK 1.4 latter)

`- XX: NewSize=n`  设置新生代的大小(JDK 1.3/1.4)

`- XX: NewRatio=n`  设置老年代与新生代的比例，即老年代/新生代

![GC2](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_GC2.png)

`- XX: SurvivorRatio=n`  设置新生代中eden区和survivor区的比例，即 `-XX:SurvivorRatio` = eden/s0 = eden/s1，注意Survivor区有两个，如n=3，表示Eden：Survivor=3：2，一个Survivor区占整个年轻代的1/5。s0和s1空间又分别称为from空间和to空间，它们的大小是相同的，职能也是一样，并在Minor GC后，会互换角色

![GC3](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_GC3.png)

`- XX: PermSize=n` 设置Java堆之中永久区的大小

![GC1](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_GC1.png)

`- XX: MaxPermSize=n`  设置Java堆之中永久区的最大值

> 在JDK1.8中，取消了PermGen，取而代之的是Metaspace，所以PermSize和MaxPermSize参数失效，取而代之的是 `-XX:MetaspaceSize`  和 `-XX:MaxMetaspaceSize`

`- XX: +PrintFlagsFinal`  可以输出绝大多数参数名称及其默认值

`- XX: +PrintGC`  打印GC情况

`- XX: +PrintGCDetails`  打印GC详情

`- XX: +PrintGCTimeStamps` 打印GC时间戳

`- XX: +<option>`  开启option参数

`- XX: -<option>`  关闭option参数

`- XX: <option>=<value>`  将option参数的值设置为value

```java
-Xmx3550m -Xms3550m -Xss128k -XX:NewRatio=4 -XX:SurvivorRatio=4 -XX:MaxPermSize=16m -XX:MaxTenuringThreshold=0
  
JAVA_OPTS="-Xms1024m -Xmx2048m -Xss1024K  -XX:MetaspaceSize=512m -XX:MaxMetaspaceSize1024m"
  
-Xmx20m -Xms20m -Xmn7m -XX:SurvivorRatio=2 -XX:+PrintGCDetails

-Xmx20m -Xms20m -XX:NewRatio=1 -XX:SurvivorRatio=3 -XX:+PrintGCDetails
```



ref:

1.[Java虚拟机详解03----常用JVM配置参数](http://www.cnblogs.com/smyhvae/p/4736162.html),   2.[jdk8内存参数解析与修改（新的参数）](http://blog.csdn.net/lk7688535/article/details/51767333)
