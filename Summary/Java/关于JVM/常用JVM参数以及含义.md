### 常用JVM参数以及含义

---

`-X `  代表的是虚拟机指令

`- Xss`:  每个线程栈(stack)的大小

`- Xmx`:  Java堆的最大值，默认为物理内存的1/4

`- Xms`:   Java堆的最小值(初始值)，Server端最好设置Xmx与Xms大小相等

`- Xmn`:  Java堆中新生代(Young)区的大小(JDK 1.4 latter)

`- XX: NewSize=n`  设置新生代的大小(JDK 1.3/1.4)

`- XX: NewRatio=n`  设置老年代与新生代的比例，即老年代/新生代
**新生代:老年代= 1:3, 新生代之中: Eden:Survivor(s0+s1)=8:2, 也就是Eden: s0:s1=8:1:1 **
![GC2](../../../images/GC2.png)

MinorGC发生在新生代, 当eden满了之后发生, **Major GC == Full GC **, 是对老年代/永久代的stop the world的GC
`- XX: SurvivorRatio=n`  设置新生代中eden区和survivor区的比例，即 `-XX:SurvivorRatio` = eden/s0 = eden/s1，注意Survivor区有两个，如n=3，表示Eden：Survivor=3：2，一个Survivor区占整个年轻代的1/5。s0和s1空间又分别称为from空间和to空间，它们的大小是相同的，职能也是一样，并在Minor GC后，会互换角色
![GC3](../../../images/GC3.png)

`- XX: PermSize=n` 设置Java堆之中永久区的大小
![GC1](../../../images/GC1.png)

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

**tips**:

>一般而言 -Xm..有m表示和内存有关, 也就是此处的堆内存, -XX一般后续还要跟一个: 指令, 比如新生代的带下, Eden和survivor的比率等设置, 我们关注的一般是内存的大小, 也就是-Xms, -XMx, -Xmn的大小 和新生代 老年代比率, eden和生存者的比率这些基本参数.

ref:

1.[Java虚拟机详解03----常用JVM配置参数](http://www.cnblogs.com/smyhvae/p/4736162.html),   2.[jdk8内存参数解析与修改（新的参数）](http://blog.csdn.net/lk7688535/article/details/51767333),   3.[聊聊JVM（四）深入理解Major GC, Full GC, CMS](https://blog.csdn.net/ITer_ZC/article/details/41825395)