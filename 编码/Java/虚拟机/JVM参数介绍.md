### JVM参数介绍

***

#####Java内存组成介绍：堆(Heap)和非堆(Non-heap)内存
按照官方的说法：“Java 虚拟机具有一个堆，堆是运行时数据区域，所有类实例和数组的内存均从此处分配。堆是在 Java 虚拟机启动时创建的。”“在JVM中堆之外的内存称为非堆内存(Non-heap memory)”。可以看出JVM主要管理两种类型的内存：**堆**和**非堆**。简单来说堆就是Java代码可及的内存，是留给开发人员使用的；非堆就是JVM留给 自己用的，所以方法区、JVM内部处理或优化所需的内存(如JIT编译后的代码缓存)、每个类结构(如运行时常数池、字段和方法数据)以及方法和构造方法 的代码都在非堆内存中。组成图如下

![JVM1](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_JVM1.jpg)

- **方法栈&本地方法栈**: 线程创建时产生，方法执行时生成栈帧
- **方法区**: 存储类的元数据信息，常量等
- **堆**: Java代码中所有的new操作
- **native Memory(C heap)**: Direct Bytebuffer JNI Compile GC



#####堆内存分配
JVM初始分配的内存由**-Xms**指定，默认是物理内存的1/64; JVM最大分配的内存由**-Xmx**指 定，默认是物理内存的1/4。默认空余堆内存小于40%时，JVM就会增大堆直到-Xmx的最大限制；空余堆内存大于70%时，JVM会减少堆直到 -Xms的最小限制。因此服务器一般设置-Xms、-Xmx相等以避免在每次GC 后调整堆的大小。对象的堆内存由称为垃圾回收器的自动内存管理系统回收。

![JVM2](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_JVM2.jpg)

| 组成               | 详解                                       |
| ---------------- | ---------------------------------------- |
| Young Generation | 即图中的Eden + From Space + To Space         |
| Eden             | 存放新生的对象                                  |
| Survivor Space   | 有两个，存放每次垃圾回收后存活的对象                       |
| Old Generation   | Tenured Generation 即图中的Old Space 主要存放应用程序中生命周期长的存活对象 |



#####非堆内存分配
JVM使用**-XX:PermSize**设置非堆内存初始值，默认是物理内存的1/64；由**-XX:MaxPermSize**设置最大非堆内存的大小，默认是物理内存的1/4。

| 组成                   | 详解                                       |
| -------------------- | ---------------------------------------- |
| Permanent Generation | 保存虚拟机自己的静态(refective)数据主要存放加载的Class类级别静态对象如class本身，method，field等等permanent generation空间不足会引发full GC(详见[HotSpot VM GC种类](http://www.cnblogs.com/redcreen/archive/2011/05/04/2037029.html)) |
| Code Cache           | 用于编译和保存本地代码（native code）的内存JVM内部处理或优化    |



#####JVM内存限制(最大值)
JVM内存的最大值跟操作系统有很大的关系。简单的说就32位处理器虽然 可控内存空间有4GB,但是具体的操作系统会给一个限制，这个限制一般是2GB-3GB（一般来说Windows系统下为1.5G-2G，Linux系统 下为2G-3G），而64bit以上的处理器就不会有限制了。



#####JVM典型参数配置
*配置1*

**-Xmx3550m  -Xms3550m -Xmn2g** **-Xss128k**
**-Xmx3550m**:  设置JVM最大可用内存为3550M
**-Xms3550m**:  设置JVM促使内存为3550m。此值可以设置与-Xmx相同，以避免每次垃圾回收完成后JVM重新分配内存。
**-Xmn2g**：设置年轻代大小为2G。**整个JVM内存大小=年轻代大小 + 年老代大小 **。持久代一般固定大小为64m，所以增大年轻代后，将会减小年老代大小。此值对系统性能影响较大，Sun官方推荐配置为整个堆的3/8。
**-Xss128k**：设置每个线程的堆栈大小。JDK5.0以后每个线程堆栈大小为1M，以前每个线程堆栈大小为256K。根据应用的线程所需内存大小进行调整。在相同物理内存下，减小这个值能生成更多的线程。但是操作系统对一个进程内的线程数还是有限制的，不能无限生成，经验值在3000~5000左右。

*配置2*

**-Xmx3550m -Xms3550m -Xss128k -XX:NewRatio=4 -XX:SurvivorRatio=4 -XX:MaxPermSize=16m -XX:MaxTenuringThreshold=0**
**-XX:NewRatio=4**:设置年轻代（包括Eden和两个Survivor区）与年老代的比值（除去持久代）。设置为4，则年轻代与年老代所占比值为1：4，年轻代占整个堆栈的1/5
**-XX:SurvivorRatio=4**：设置年轻代中Eden区与Survivor区的大小比值。设置为4，则两个Survivor区与一个Eden区的比值为2:4，一个Survivor区占整个年轻代的1/6
**-XX:MaxPermSize=16m**:设置持久代大小为16m。
**-XX:MaxTenuringThreshold=0**：设置垃圾最大年龄。**如果设置为0的话，则年轻代对象不经过Survivor区，直接进入年老代**。对于年老代比较多的应用，可以提高效率。**如果将此值设置为一个较大值，则年轻代对象会在Survivor区进行多次复制，这样可以增加对象再年轻代的存活时间**，增加在年轻代即被回收的概论。



#####JVM辅助信息
JVM提供了大量命令行参数，打印信息，供调试使用。主要有以下一些：
- **-XX:+PrintGC**
  输出形式:

  ​                 **[GC 118250K->113543K(130112K), 0.0094143 secs]**

  ​                 **[Full GC 121376K->10414K(130112K), 0.0650971 secs]**

- **-XX:+PrintGCDetails**
  输出形式:

  ​                 **[GC [DefNew: 8614K->781K(9088K), 0.0123035 secs] 118250K->113543K(130112K), 0.0124633 secs]**

  ​                 **[GC [DefNew: 8614K->8614K(9088K), 0.0000665 secs][Tenured: 112761K->10414K(121024K), 0.0433488 secs] 121376K->10414K(130112K), 0.0436268 secs]**

- **-XX:+PrintGCTimeStamps** -XX:+PrintGC：PrintGCTimeStamps可与上面混合使用
  输出形式:

  ​                 **11.851: [GC 98328K->93620K(130112K), 0.0082960 secs]**

- **-XX:+PrintGCApplicationConcurrentTime:** 打印每次垃圾回收前，程序未中断的执行时间。可与上面混合使用
  输出形式:

  ​                 **Application time: 0.5291524 seconds**

- **-XX:PrintHeapAtGC**:打印GC前后的详细堆栈信息
  输出形式:
  ​                 34.702: [GC {Heap before gc invocations=7:def new generation   total 55296K, used 52568K [0x1ebd0000, 0x227d0000, 0x227d0000)**eden space 49152K,  99% used** [0x1ebd0000, 0x21bce430, 0x21bd0000)**from space 6144K,  55% used** [0x221d0000, 0x22527e10, 0x227d0000)to   space 6144K,   0% used [0x21bd0000, 0x21bd0000, 0x221d0000)tenured generation   total 69632K, used 2696K [0x227d0000, 0x26bd0000, 0x26bd0000)**the space 69632K,   3% used** [0x227d0000, 0x22a720f8, 0x22a72200, 0x26bd0000) compacting perm gen  total 8192K, used 2898K [0x26bd0000, 0x273d0000, 0x2abd0000) the space 8192K,  35% used [0x26bd0000, 0x26ea4ba8, 0x26ea4c00, 0x273d0000)
  ro space 8192K,  66% used [0x2abd0000, 0x2b12bcc0, 0x2b12be00, 0x2b3d0000) rw space 12288K,  46% used [0x2b3d0000, 0x2b972060, 0x2b972200, 0x2bfd0000) 34.735: [DefNew: 52568K->3433K(55296K), 0.0072126 secs] 55264K->6615K(124928K)**Heap after gc invocations=8:** def new generation   total 55296K, used 3433K [0x1ebd0000, 0x227d0000, 0x227d0000) **eden space 49152K,   0% used** [0x1ebd0000, 0x1ebd0000, 0x21bd0000) from space 6144K,  55% used [0x21bd0000, 0x21f2a5e8, 0x221d0000) to   space 6144K,   0% used [0x221d0000, 0x221d0000, 0x227d0000) tenured generation   total 69632K, used 3182K [0x227d0000, 0x26bd0000, 0x26bd0000) **the space 69632K,   4% used **[0x227d0000, 0x22aeb958, 0x22aeba00, 0x26bd0000) compacting perm gen  total 8192K, used 2898K [0x26bd0000, 0x273d0000, 0x2abd0000) the space 8192K,  35% used [0x26bd0000, 0x26ea4ba8, 0x26ea4c00, 0x273d0000) ro space 8192K,  66% used [0x2abd0000, 0x2b12bcc0, 0x2b12be00, 0x2b3d0000) rw space 12288K,  46% used [0x2b3d0000, 0x2b972060, 0x2b972200, 0x2bfd0000)
  }, 0.0757599 secs]

- **-Xloggc:filename**:  与上面几个配合使用，把相关日志信息记录到文件以便分析



#####JVM常见配置汇总

堆设置
- **-Xms**:初始堆大小
- **-Xmx**:最大堆大小
- **-XX:NewSize=n**:设置年轻代大小
- **-XX:NewRatio=n:**设置年轻代和年老代的比值。如:为3，表示年轻代与年老代比值为1：3，年轻代占整个年轻代年老代和的1/4
- **-XX:SurvivorRatio=n**:年轻代中Eden区与两个Survivor区的比值。注意Survivor区有两个。如：3，表示Eden：Survivor=3：2，一个Survivor区占整个年轻代的1/5
- **-XX:MaxPermSize=n**:设置持久代大小

收集器设置
- **-XX:+UseSerialGC**:设置串行收集器
- **-XX:+UseParallelGC**:设置并行收集器
- **-XX:+UseParalledlOldGC**:设置并行年老代收集器
- **-XX:+UseConcMarkSweepGC**:设置并发收集器

垃圾回收统计信息
- **-XX:+PrintGC**
- **-XX:+PrintGCDetails**
- **-XX:+PrintGCTimeStamps**
- **-Xloggc:filename**

并行收集器设置
- **-XX:ParallelGCThreads=n**:设置并行收集器收集时使用的CPU数。并行收集线程数。
- **-XX:MaxGCPauseMillis=n**:设置并行收集最大暂停时间
- **-XX:GCTimeRatio=n**:设置垃圾回收时间占程序运行时间的百分比。公式为1/(1+n)

并发收集器设置
- **-XX:+CMSIncrementalMode**:设置为增量模式。适用于单CPU情况。
- **-XX:ParallelGCThreads=n**:设置并发收集器年轻代收集方式为并行收集时，使用的CPU数。并行收集线程数。



ref:

1.[Xms Xmx PermSize MaxPermSize 区别](http://www.cnblogs.com/mingforyou/archive/2012/03/03/2378143.html),  2.[JVM系列一：JVM内存组成及分配](http://www.cnblogs.com/redcreen/archive/2011/05/04/2036387.html),  3.[HotSpot VM GC 的种类](http://www.cnblogs.com/redcreen/archive/2011/05/04/2037029.html),  4.[Xmx -Xmn -Xss](http://unixboy.iteye.com/blog/174173)