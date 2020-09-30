### Java虚拟机内存模型与垃圾回收

***

#### Java虚拟机内存模型
JVM内存模型可以分为两个部分, 如下图所示, **堆和方法区是所有线程共有的**, 而虚拟机栈, 本地方法栈和程序计数器则是线程私有的. 下面我们就来一一分析一下这些不同区域的作用. **以下五个部分就是Java虚拟机的内存内存空间组成**.
![jvm](../../../images/jvm.png)



#### 虚拟机内存各部分作用
##### 1.程序计数器
**定义**:

- 一块较小的内存空间, **可看作当前线程正在执行的字节码的行号指示器**. 也就是说, **程序计数器里面记录的是当前线程正在执行的那一条字节码指令的地址**. *但如果当前线程正在执行的是一个本地方法, 那么此时程序计数器为空*.

**作用**:
1. 字节码解释器通过改变程序计数器来依次读取指令, 从而实现代码的流程控制, 如: 顺序执行, 选择, 循环, 异常处理.
2. 在多线程的情况下, 程序计数器用于记录当前线程执行的位置, 从而当线程被切换回来的时候能够知道该线程上次运行到哪儿了.

**特点**:
1. 是一块较小的存储空间
2. **线程私有. 每条线程都有一个程序计数器**.
3. **是唯一一个不会出现`OutOfMemoryError`的内存区域**.
4. 生命周期随着线程的创建而创建, 随着线程的结束而死亡.


##### 2. Java虚拟机栈(JVM Stack)
**定义**:
- **Java虚拟机栈是描述Java方法运行过程的内存模型**, Java虚拟机栈会为每一个即将运行的Java方法创建一块叫做“栈帧”的区域，这块区域用于存储该方法在运行过程中所需要的一些信息, 这些信息包括: 1.局部变量表(存放基本数据类型变量, 引用类型的变量, returnAddress类型的变量); 2.操作数栈; 3. 动态链接; 4. 方法出口信息等.  

**作用**:
- 当一个方法即将被运行时, Java虚拟机栈首先会在Java虚拟机栈中为该方法创建一块**“栈帧”**, 栈帧中**包含局部变量表, 操作数栈, 动态链接, 方法出口信息等**. *当方法在运行过程中需要创建局部变量时, 就将局部变量的值存入栈帧的局部变量表中, 当这个方法执行完毕后, 这个方法所对应的栈帧将会出栈, 并释放内存空间*.
>注意: 人们常说, Java的内存空间分为“栈”和“堆”, 栈中存放局部变量, 堆中存放对象.
这句话不完全正确! 这里的“堆”可以这么理解, 存放的是Java对象, 但这里的“栈”只代表了Java虚拟机栈中的局部变量表部分. 真正的Java虚拟机栈是由一个个栈帧组成, 而每个栈帧中都拥有: 局部变量表, 操作数栈, 动态链接, 方法出口信息等.

**特点**:
1. 局部变量表的创建是在方法被执行的时候, 随着栈帧的创建而创建. 而且, 局部变量表的大小在编译时期就确定下来了, 在创建的时候只需分配事先规定好的大小即可. 此外, 在方法运行的过程中局部变量表的大小是不会发生改变的.
2. Java虚拟机栈会出现两种异常: `StackOverFlowError`和`OutOfMemoryError`.
   a) `StackOverFlowError`: 
   若Java虚拟机栈的内存大小不允许动态扩展, 那么当线程请求栈的深度超过当前Java虚拟机栈的最大深度的时候, 就抛出`StackOverFlowError`异常. 
   b) `OutOfMemoryError`: 
   若Java虚拟机栈的内存大小允许动态扩展, 且当线程请求栈时内存用完了, 无法再动态扩展了, 此时抛出`OutOfMemoryError`异常.
3. **Java虚拟机栈也是线程私有的**, 每个线程都有各自的Java虚拟机栈, 而且随着线程的创建而创建, 随着线程的死亡而死亡. 
> 注意: `StackOverFlowError`和`OutOfMemoryError`的异同? 
`StackOverFlowError`表示当前线程申请的栈超过了事先定好的栈的最大深度, 但内存空间可能还有很多.  而`OutOfMemoryErro`r是指当线程申请栈时发现栈已经满了, 而且内存也全都用光了.


##### 3. 本地方法栈
**定义**:
**本地方法栈和Java虚拟机栈实现的功能类似, 只不过本地方法区是本地方法运行的内存模型**.

**作用**:
本地方法被执行的时候, 在本地方法栈也会创建一个栈帧, 用于存放**该本地方法**的局部变量表, 操作数栈, 动态链接, 出口信息. 方法执行完毕后相应的栈帧也会出栈并释放内存空间.

**特点**:
也会抛出`StackOverFlowError`和`OutOfMemoryError`异常.
>本地方法
简单地讲, 一个Native Method就是一个java调用非java代码的接口. 一个Native Method是这样一个java的方法: 该方法的实现由非java语言实现, 比如C语言, 这个特征并非java所特有, 很多其它的编程语言都有这一机制, 比如在C++中, 你可以用extern "C"告知C++编译器去调用一个C的函数.


##### 4. 堆
**定义**:
**堆是用来存放对象的内存空间, 几乎所有的对象都存储在堆中**.堆是java 虚拟机内存之中最重要的部分之一, 几乎所有的对象在此分配, 非常重要. 如下是堆的组成结构, 可通过下图提前预览.
![heapstructer](../../../images/heapstructer.png)

**特点**:
1. **线程共享 , 整个Java虚拟机只有一个堆**, 所有的线程都访问同一个堆. 而程序计数器, Java虚拟机栈, 本地方法栈都是一个线程对应一个的.
2. 在虚拟机启动时创建
3. **垃圾回收的主要场所**, *所以此处有各种对象标记和内存回收的问题*.
4. **可以进一步细分为: 新生代, 老年代, (永久代) . 新生代又可被分为: Eden, S0(From Survior), S1(To Survior)**. 
   不同的区域存放具有不同生命周期的对象. 这样可以根据不同的区域使用不同的垃圾回收算法, 从而更具有针对性, 从而更高效.

5. 堆的大小既可以固定也可以扩展, 但主流的虚拟机堆的大小是可扩展的, 因此当线程请求分配内存, 但堆已满, 且内存已满无法再扩展时, 就抛出`OutOfMemoryError`.


##### 5. 方法区
**定义**:
Java虚拟机规范中定义方法区是堆的一个逻辑部分

**作用**:
方法区中存放已经被虚拟机加载的类信息, 常量, 静态变量, 即时编译器编译后的代码等.

**特点**:
1. **线程共享 **,方法区是堆的一个逻辑部分, 因此和堆一样, 都是线程共享的. **整个虚拟机中只有一个方法区**.
2. 永久代, 方法区中的信息一般需要长期存在,  而且它又是堆的逻辑分区, 因此用堆的划分方法, 我们把方法区称为老年代. 永久代在Java1.8中已经除去, 改而取代的是**元空间**.
3. 内存回收效率低 , 方法区中的信息一般需要长期存在, 回收一遍内存之后可能只有少量信息无效. 对方法区的内存回收的主要目标是: 对**常量池的回收**和 对**类型的卸载**.
4. Java虚拟机规范对方法区的要求比较宽松, 和堆一样, 允许固定大小, 也允许可扩展的大小, 还允许不实现垃圾回收.
>运行时常量池
>方法区中存放三种数据: 类信息, 常量, 静态变量, 即时编译器编译后的代码. **其中常量存储在运行时常量池中**.
>我们一般在一个类中通过`public static final`来声明一个常量. 这个类被编译后便生成Class文件, 这个类的所有信息都存储在这个class文件中. 当这个类被Java虚拟机加载后, class文件中的常量就存放在方法区的运行时常量池中. 而且在运行期间, 可以向常量池中添加新的常量. 如: String类的intern()方法就能在运行期间向常量池中添加字符串常量. 当运行时常量池中的某些常量没有被对象引用, 同时也没有被变量引用, 那么就需要垃圾收集器回收.


##### 6. 直接内存
**直接内存是除Java虚拟机之外的内存, 但也有可能被Java使用**.
在NIO中引入了一种基于通道和缓冲的IO方式. 它可以通过调用本地方法直接分配Java虚拟机之外的内存, 然后通过一个存储在Java堆中的`DirectByteBuffer`对象直接操作该内存, 而无需先将外面内存中的数据复制到堆中再操作, 从而提升了数据操作的效率. **直接内存的大小不受Java虚拟机控制, 但既然是内存, 当内存不足时就会抛出OOM异常**.


##### **总结**
| **名称**     | **特征**                                                     | **作用**                                                     | **配置参数**                             | **异常**                                |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ---------------------------------------- | --------------------------------------- |
| 程序计数器   | 线程私有, 占用内存小, 生命周期与线程相同                     | 大致为字节码行号指示器                                       | 无                                       | 无                                      |
| 栈区         | 线程私有, 生命周期与线程相同, 使用连续的内存空间, 分为本地方法栈和虚拟机栈 | Java 方法执行的内存模型, 存储局部变量表, 操作栈, 动态链接, 方法出口等信息 | `-Xss`                                   | `StackOverflowError` `OutOfMemoryError` |
| java堆       | 线程共享, 生命周期与虚拟机相同, 可以不使用连续的内存地址     | 保存对象实例, 所有对象实例(含数组)都要在堆上分配             | `-Xms,-Xmx,-Xmn`                         | `OutOfMemoryError`                      |
| 方法区       | 线程共享, 生命周期与虚拟机相同, 可以不使用连续的内存地址     | 存储已被虚拟机加载的类信息, 常量, 静态变量, 即时编译器编译后的代码等数据 | `-XX:PermSize:16M`  `-XX:MaxPermSize64M` | `OutOfMemoryError`                      |
| 运行时常量池 | 方法区的一部分, 具有动态性                                   | 存放字面量及符号引用                                         |                                          |                                         |



#### 堆内存
**Java中的堆是JVM所管理的最大的一块内存空间, 主要用于存放各种类的实例对象**. 下图是堆内存和方法区(永久代)的示意图, 堆内存是heap
![javamm](../../../images/javamm.png)
由上图可以看出来, 堆被划分成两个不同的区域: 新生代(Young Generation), 老年代(Old Generation). 新生代又被划分为三个区域: Eden, S0(From Survivor),S1(To Survivor).这样划分的目的是为了使 JVM 能够更好的管理堆内存中的对象, 包括内存的分配以及回收. 
![youngold](../../../images/youngold.png)
堆的内存模型大致为: Java堆=新生代+老年代. 堆的大小可通过参数`–Xms`(堆的初始容量), `-Xmx`(堆的最大容量)来指定, 其中, 新生代(Young)被细分为 Eden 和 两个 Survivor 区域, 这两个Survivor区域分别被命名为from和to, 以示区分, 也叫s0和s1, 二者的大小是相等的, 每一个时刻只有一个区域被使用, 另一个区域为空. 可通过`-Xmn`参数来指定新生代的大小，也可以通过`-XX:SurvivorRation`来调整Eden及Survivor Space的大小.  默认情况下, **Eden: s0  :s1 = 8 : 1 : 1**. 即: Eden = 8/10 的新生代空间大小,s0= s1 = 1/10 的新生代空间大小. JVM 每次只会使用Eden和其中的一块Survivor区域来为对象服务，所以无论什么时候, 总是有一块 Survivor 区域是空闲着的. **新生代实际可用的内存空间为 9/10 ( 即90% )的新生代空间**. ***新生代和老年代的默认比例 young: old= 1:2(还是1:3), 记不太清楚了***. 老年代用于存放经过多次新生代GC仍然存活的对象, 例如缓存对象, 新建的对象也有可能直接进入老年代(*但是新建的对象绝大多数是存放在新生代的eden区域的*), 主要有两种情况: 1.大对象, 可通过启动参数设置`-XX:PretenureSizeThreshold=1024`(单位为字节, 默认为0, 1024相当于一个阈值)来代表超过多大时就不在新生代分配, 而是直接在老年代分配. 2. 大的数组对象, 且数组中无引用外部对象. **老年代所占的内存大小为`-Xmx`对应的值减去`-Xmn`对应的值**. 如果在堆中没有内存完成实例分配, 并且堆也无法再扩展时, 将会抛出`OutOfMemoryError`异常. 老年代和新生代的比例,使用`-XX:NewRatio`来设置, 如`-XX:NewRatio= 2`,则表示新生代占堆空间的1/3, 老年代占2/3.
![heapme](../../../images/heapme.png)
下面列举众多命令之中的几个常用和容易掌握的配置选项, 表格下方的图片显示了各个区域之间的比例.

|               指令                | 含义                                                         |
| :-------------------------------: | ------------------------------------------------------------ |
|              `-Xms`               | **初始堆大小**. 如: -Xms256m                                 |
|              `-Xmx`               | **最大堆大小**. 如:-Xmx512m                                  |
|              `-Xmn`               | **新生代大小**.通常为 Xmx 的 1/3 或 1/4.新生代 = Eden + 2 个 Survivor 空间. 实际可用空间为 = Eden + 1 个 Survivor, 即 90% |
|              `-Xss`               | JDK1.5+ 每个线程堆栈大小为 1M, 一般来说如果栈不是很深的话, 1M 是绝对够用了的. |
|          `-XX:NewRatio`           | **新生代与老年代的比例**, 如 –XX:NewRatio=2, 则新生代占整个堆空间的1/3, 老年代占2/3 |
|       `-XX:SurvivorRation`        | **新生代中 Eden 与 Survivor 的比值**. 默认值为 8. 即 Eden 占新生代空间的 8/10, 另外两个 Survivor 各占 1/10 |
|          `-XX:PermSize`           | 永久代(方法区)的初始大小                                     |
|         `-XX:MaxPermSize`         | 永久代(方法区)的最大值                                       |
|       `-XX:+PrintGCDetails`       | 打印 GC 信息                                                |
| `-XX:+HeapDumpOnOutOfMemoryError` | 让虚拟机在发生内存溢出时 Dump 出当前的内存堆转储快照, 以便分析用 |
![jvmbili](../../../images\jvmbili.png)
各个参数所起作用的内存位置, 可以通过下图很清晰的得知
![javacanshu](../../../images/javacanshu.png)



#### 垃圾回收(GC: Garbage Collection)
##### 判断对象是否可回收的方法
GC是通过对象是否存活来决定是否进行回收, 判断对象是否存活主要有两种算法:**引用计数算法**和**可达性分析算法**(根搜索算法)
- 引用计数算法
引用计数的算法原理是给对象添加一个引用计数器, 每被引用一次计数器加1, 引用失效时减1, 当计数器0后表示对象不再被引用, 可以被回收了, 引用计数法**简单高效**, 但是存在对象之间循环引用问题, 可能导致无法被GC回收, 需要花很大精力去解决循环引用问题,**很难检测出对象之间的相互引用(引用循环问题)**
- 可达性分析算法
可达性分析的算法原理是从对象根引用(堆栈, 方法表的静态引用和常量引用区, 本地方法栈)开始遍历搜索所有可到达对象, 形成一个引用链, 遍历的同时标记出可达对象和不可达对象, **不可达对象表示没有任何引用存在**, 可以被GC回收, 如下是可达性的示意.
![rootsearch](../../../images/rootsearch.png)

##### 对象的引用
上述检测垃圾对象的两种算法都是基于对象引用, 在Java语言中, 将引用分为**强引用, 软引用, 弱引用, 虚引用**四种类型. *引用强度依次减弱*. 具体如下图所示
![img](../../../images/616953-20160226160743208-1648960890.png)
对于可达性分析算法而言, 未到达的对象并非是“非死不可”的, **若要宣判一个对象死亡, 至少需要经历两次标记阶段**. 1. 如果对象在进行可达性分析后发现没有与GCRoots相连的引用链, 则该对象被第一次标记并进行一次筛选, 筛选条件为是否有必要执行该对象的finalize方法, 若对象没有覆盖finalize方法或者该finalize方法是否已经被虚拟机执行过了, 则均视作不必要执行该对象的finalize方法, 即该对象将会被回收. 反之, 若对象覆盖了finalize方法并且该finalize方法并没有被执行过, 那么, 这个对象会被放置在一个叫F-Queue的队列中, 之后会由虚拟机自动建立的, 优先级低的Finalizer线程去执行, 而虚拟机不必要等待该线程执行结束, 即虚拟机只负责建立线程, 其他的事情交给此线程去处理. 2.对F-Queue中对象进行第二次标记, 如果对象在finalize方法中拯救了自己, 即**关联上了GCRoots引用链**, 如把this关键字赋值给其他变量, 那么在第二次标记的时候该对象将从“即将回收”的集合中移除, 如果对象还是没有拯救自己, 那就会被回收. 如下代码演示了一个对象如何在finalize方法中拯救了自己, 然而, 它只能拯救自己一次, 第二次就被回收了. 具体代码如下:

```java
/*
 * 此代码演示了两点：
 * 1.对象可以再被GC时自我拯救
 * 2.这种自救的机会只有一次，因为一个对象的finalize()方法最多只会被系统自动调用一次
 * */
public class FinalizeEscapeGC {
    public String name;
    public static FinalizeEscapeGC SAVE_HOOK = null;

    public FinalizeEscapeGC(String name) {
        this.name = name;
    }

    public void isAlive() {
        System.out.println("yes, i am still alive :)");
    }
    
    @Override
    protected void finalize() throws Throwable {
        super.finalize();
        System.out.println("finalize method executed!");
        System.out.println(this);
        FinalizeEscapeGC.SAVE_HOOK = this;
    }

    @Override
    public String toString() {
        return name;
    }

    public static void main(String[] args) throws InterruptedException {
        SAVE_HOOK = new FinalizeEscapeGC("leesf");
        System.out.println(SAVE_HOOK);
        // 对象第一次拯救自己
        SAVE_HOOK = null;
        System.out.println(SAVE_HOOK);
        System.gc();
        // 因为finalize方法优先级很低，所以暂停0.5秒以等待它
        Thread.sleep(500);
        if (SAVE_HOOK != null) {
            SAVE_HOOK.isAlive();
        } else {
            System.out.println("no, i am dead : (");
        }

        // 下面这段代码与上面的完全相同,但是这一次自救却失败了
        // 一个对象的finalize方法只会被调用一次
        SAVE_HOOK = null;
        System.gc();
        // 因为finalize方法优先级很低，所以暂停0.5秒以等待它
        Thread.sleep(500);
        if (SAVE_HOOK != null) {
            SAVE_HOOK.isAlive();
        } else {
            System.out.println("no, i am dead : (");
        }
    }

}
```
运行结果如下：
```shell
　　leesf
　　null
　　finalize method executed!
　　leesf
　　yes, i am still alive :)
　　no, i am dead : (
```
由结果可知, 该对象拯救了自己一次, 第二次没有拯救成功, **因为对象的finalize方法最多被虚拟机调用一次**. 此外, 从结果我们可以得知, 一个堆对象的this(放在局部变量表中的第一项)引用会永远存在, 在方法体内可以将this引用赋值给其他变量, 这样堆中对象就可以被其他变量所引用, 即不会被回收.

##### 垃圾回收算法
当找到可回收对象后, 如何进行回收呢? 这就是垃圾回收算法应该处理的问题. 垃圾回收算法主要有**标记-清除**, **停止-复制**, **标记-整理**, **分代收集算法**, 不同算法使用在不同的场景, **总体来说停止-复制算法适合对象存活时间短, 存活率低的新生代, 标记-清除和标记-整理算法适合对象存活时间长, 存活率高的老年代**, 分代回收算法是在不同的生存年代使用不同的策略, 是一种组合的操作.

- 标记-清除(Mark-Sweep)
  **通过可达性分析算法标记所有不可达对象, 然后清理不可达对象. 这种算法会形成大量的内存碎片**. 具体过程是首先标记出所有需要回收的对象, 使用**可达性分析算法**判断一个对象是否为可回收, 在标记完成后统一回收所有被标记的对象. 下图是算法具体的一次执行过程后的结果对比.
  ![marksweep](../../../images/marksweep.png)

  说明: 1.**效率问题**, 标记和清除两个阶段的效率都不高. 2.**空间问题**, 标记清除后会产生大量不连续的内存碎片, 以后需要给大对象分配内存时, 会提前触发一次垃圾回收动作.

- 停止-复制(Stop-Copy)
  也叫复制算法. 将内存分为两等块, 每次使用其中一块. 当这一块内存用完后, 就将还存活的对象复制到另外一个块上面, 然后再把已经使用过的内存空间一次清理掉.
  ~~将新生代内存按照8:1:1的比例分为一个eden区和两个survivor(survivor0,survivor1)区, 回收时先将eden区存活对象复制到一个survivor0区, 然后清空eden区, 当这个survivor0区也存放满了时,  则将eden区和survivor0区存活对象复制到另一个survivor1区, 然后清空eden和这个survivor0区, 此时survivor0区是空的, 然后将survivor0区和survivor1区交换, 即保持survivor1区为空, 如此往复, 当survivor1区不足以存放 eden和survivor0的存活对象时, 就将存活对象直接存放到老年代(这时我们可能回想,若是老年代也满了就会触发一次Full GC也就是新生代, 老年代都进行回收, 若是内存还不够就`OutOfMemory`, 从停止-复制算法的原理上我们可以看到, 这种算法对于存活率较低的对象回收有着非常高的效率, 而且不会形成内存碎片, 但是会浪费一定的内存空间 , 适合对象存活率较低的新生代使用, 如果在对象存活率较高的老年代采用这种算法, 那将会是一场灾难.~~如下是算法的示意图
  ![copysuanfa](../../../images/copysuanfa.png)
  说明: 1.**无内存碎片问题**, 2.**可用内存缩小为原来的一半**.  3.**不适合村和数量很多的情况**. 当存活的对象数量很多时, 复制的效率很慢

- 标记-整理(Mark-Compact)
  通过**可达性分析算法**标记所有不可达对象, 然后将存活对象都向一个方向移动, 然后清理掉边界外的内存. 这种算法是将存活对象向着一个方向聚集, 然后将剩余区域清空, 这种算法适合对象存活率较高的老年代, 标记 - 整理算法示意图如下:
  ![markcompact](../../../images/markcompact.png)
  说明: 1.无需考虑内存碎片问题.

##### GC的分类
Java 中的堆也是 GC 收集垃圾的主要区域. GC 分为两种: **Minor GC**, **Major GC**(或称为**Full GC**), *目前而言, 对于GC的种类的定义除了Minor GC明确定义之外, Major GC和Full GC 没有明确的定义, 可以把Major GC和Full GC划等号, 也可以认为Full GC= Major GC +Minor GC*.
![GC1](../../../images/gctype.png)

- Minor GC: 清理年轻代空间(包括 Eden 和 Survivor 区域)
- Major GC: 是清理永久代空间
- Full GC: 清理整个堆空间—包括年轻代和永久代
![gc3dai](D:\MarkdowNotes\CS-Java-LearnNotes\images\gc3dai.png)

###### Minor GC
Minor GC 是发生在新生代中的垃圾收集动作, 所采用的是**复制算法**.
新生代几乎是所有 Java 对象出生的地方, 即 Java 对象申请的内存以及存放都是在这个地方. Java中的大部分对象通常不需长久存活, 具有朝生夕灭的性质. 当一个对象被判定为"死亡"的时候, GC就有责任来回收掉这部分对象的内存空间, 新生代是GC收集垃圾的频繁区域. Minor GC回收过程如下: 
>当对象在 Eden(包括一个 Survivor 区域, 这里假设是 from 区域)出生后, 在经过一次 Minor GC 后, 如果对象还存活, 并且能够被另外一块 Survivor 区域所容纳(上面已经假设为 from 区域, 这里应为 to 区域, 即to区域有足够的内存空间来存储 Eden 和 from 区域中存活的对象), 则使用复制算法将这些仍然还存活的对象复制到另外一块Survivor 区域(即 to 区域)中, 然后清理所使用过的 Eden 以及 Survivor 区域(即from区域), 并且将这些对象的年龄设置为1, 以后对象在Survivor区每熬过一次Minor GC, 就将对象的年龄 +1, **当对象的年龄达到某个值时(默认是15**, 可以通过参数 `-XX:MaxTenuringThreshold` 来设定), 这些对象就会进入老年代. **但这也不是一定的, 对于一些较大的对象(即需要分配一块较大的连续内存空间),  则是直接进入到老年代, 如大对象, 大数组对象**.

###### Major GC
Major GC是发生在老年代的垃圾收集动作, 所采用的是**标记-清除算法**.
现实的生活中, 老年代的人通常会比新生代的人"早死". 堆内存中的老年代(Old)不同于此, 老年代里面的对象几乎个个都是在 Survivor区域中熬过来的, 它们是不会那么容易就"死掉"了的. 因此, **Major GC发生的次数不会有Minor GC那么频繁, 并且做一次Major GC 要比进行一次 Minor GC的时间更长, 一般是Minor GC的 10倍以上.** 
>标记-清除算法收集垃圾的时候会产生许多的内存碎片(即不连续的内存空间), 此后需要为较大的对象分配内存空间时, 若无法找到足够的连续的内存空间, 就会提前触发一次Minor GC的收集动作. 可把Full GC认为是Minor GC+Major GC, 新生代老年代都发生了GC

######  Minor GC, Full GC触发条件
Minor GC触发条件: 当Eden区满时, 触发Minor GC.
Major GC触发条件: 
- 调用System.gc时, 系统建议执行Major GC, 但是不必然执行
- 老年代空间不足
- 方法去空间不足
- 通过Minor GC后进入老年代的平均大小大于老年代的可用内存
- 由Eden区, From Space区向To Space区复制时, 对象大小大于To Space可用内存, 则把该对象转存到老年代, 且老年代的可用内存小于该对象大小

###### GC日志分析
分析如下的代码, 设置VM参数为`-verbose:gc`, `-XX:+PrintGCTimeStamps`, `-XX:+PrintGCDetails`
```java
public static void main(String[] args) {
    Object obj = new Object();
    System.gc();
    System.out.println();
    obj = new Object();
    obj = new Object();
    System.gc();
    System.out.println();
}
```
![gcinfo1](../../../images/gcinfo1.png)
再看下2图, 分别为第一次执行`System.gc()`和第二次执行`System.gc()`, 情况如下:
第一次`System.gc()`
![gcinfo2](../../../images/gcinfo2.png)
第二次执行`System.gc()`
![gcinfo3](../../../images/gcinfo3.png)
对比这两次`System.gc()`的结果: 
从Full GC中可以看出, 新生代的可用内存约为38M, 老年代可用内存约为86M, 堆的可用总内存约为124M. 可以看出: 新生代内存占用Java虚拟机堆内存的1/3, 老年代内存占用Java虚拟机堆总内存的2/3. GC堆新生代内存回收比较乐观. 对老年代,以及方法区的回收并不明显, 或者说不如新生代. 
除此之外: 再来观察: 第一次`System.gc()`, 新生代回收情况是665K->648K, 而老年代将新生代的648K回收至0K. 放入了老年代, 所以老年代是从0K增加到470K. 所以,新生代回收内存情况是665K->648K, 老年代回收情况是648K->470K. 第二次`System.gc()`可看出, 此处Full GC处理时间是Minor GC的17倍.



#### 垃圾收集器
如果说收集算法是内存回收的方法论，垃圾收集器就是内存回收的具体实现. HotSpot虚拟机包含的所有收集器如下
![hotvmcollector](../../../images/hotvmcollector.png)
GC采用分代回收算好后, 起着重要作用的是GC收集器, GC收集器分为新生代收集器和老年代收集器, 不同的收集器使用不同的收集算法, 有着不同的特点, 由于目前的收集器在内存回收时无法消除(Stop-the-world), 即在回收内存时不可避免的停止用户线程, 目前的收集器只能使停顿时间越来越短, 但是无法彻底消除, 主要的收集其中Parallel Scavenge和Parallel Old是追求吞吐量为目标, 其它的收集器都是追求高响应, 低停顿. 如下是新生代和老年代使用到的垃圾收集器.

- **新生代收集器**：`Serial`, `PraNew`, `Parallel Scavenge`
- **老年代收集器**：`Serial Old`, `Parallel Old`, `CMS`, `G1`

##### Serial收集器(复制算法)
**新生代单线程收集器, 标记和清理都是单线程, 优点是简单高效**. 串行收集器是最古老, 最稳定以及效率高的收集器, 可能会产生较长的停顿, 只使用**一个线程**去回收. 新生代, 老年代使用**串行**回收; **新生代复制算法**, **老年代标记-压缩**; 垃圾收集的过程中会产生`Stop The World`(服务暂停)的问题
参数控制: `-XX:+UseSerialGC` 串行收集器
![SerialCollector](../../../images/seriacollector.png)

##### Serial Old收集器(标记-整理算法)
老年代单线程收集器, Serial收集器的老年代版本.

##### ParNew收集器(停止-复制算法)
ParNew收集器其实就是Serial收集器的多线程版本. **新生代并行, 老年代串行;**新生代复制算法, 老年代标记-压缩算法, 新生代收集器, 可以认为是Serial收集器的多线程版本, 在多核CPU环境下有着比Serial更好的表现.
参数控制: `-XX:+UseParNewGC`  使用ParNew收集器`-XX:ParallelGCThreads`限制线程数量
![parnewcollector](../../../images/parnewcollector.png)

##### Parallel Scavenge收集器(停止-复制算法)
Parallel Scavenge收集器类似ParNew收集器, Parallel收集器更关注系统的**吞吐量**. 可以通过参数来打开自适应调节策略. 虚拟机会根据当前系统的运行情况收集性能监控信息. 动态调整这些参数以提供最合适的停顿时间或最大的吞吐量; 也可以通过参数控制GC的时间不大于多少毫秒或者比例; **新生代复制算法, 老年代标记-压缩**
参数控制: `-XX:+UseParallelGC` 使用Parallel收集器+ 老年代串行

##### Parallel Old收集器(停止-复制算法)
Parallel Old是Parallel Scavenge收集器的老年代版本，使用多线程和“标记－整理”算法。这个收集器是在JDK 1.6中才开始提供, 吞吐量优先, 适合于Parallel Scavenge搭配使用, 运行过程如下图所示
参数控制: `-XX:+UseParallelOldGC`  使用Parallel收集器 + 老年代并行
![paralleloldcollector](../../../images/paralleloldcollector.png)

##### CMS(Concurrent Mark Sweep)收集器（标记-清理算法）
CMS(Concurrent Mark Sweep)收集器是一种以**获取最短回收停顿时间为目标的收集器**. 目前很大一部分的Java应用都集中在互联网站或B/S系统的服务端上, 这类应用尤其重视服务的响应速度, 希望系统停顿时间最短, 以给用户带来较好的体验. 从名字(包含“Mark Sweep”)上就可以看出CMS收集器是基于“标记-清除”算法实现的, 它的运作过程相对于前面几种收集器来说要更复杂一些, 整个过程分为4个步骤，包括: 
　　　　1. **初始标记**, 标记GCRoots能直接关联到的对象, 时间很短.
　　　　2. **并发标记**, 进行GCRoots Tracing(可达性分析)过程, 时间很长. 
　　　　3. **重新标记**, 修正并发标记期间因用户程序继续运作而导致标记产生变动的那一部分对象的标记记录, 时间较长.
　　　　4. **并发清除**, 回收内存空间, 时间很长.
其中初始标记、重新标记这两个步骤仍然需要"Stop The World". 初始标记仅仅只是标记一下GC Roots能直接关联到的对象, 速度很快, 并发标记阶段就是进行GC Roots Tracing的过程, 而重新标记阶段则是为了修正并发标记期间, 因用户程序继续运作而导致标记产生变动的那一部分对象的标记记录, 这个阶段的停顿时间一般会比初始标记阶段稍长一些, 但远比并发标记的时间短. 由于整个过程中耗时最长的并发标记和并发清除过程中, 收集器线程都可以与用户线程一起工作, 所以总体上来说, CMS收集器的内存回收过程是与用户线程一起并发地执行. **老年代收集器**(新生代使用ParNew)
优点:**并发收集**、**低停顿** 
缺点：**产生大量空间碎片**、**并发阶段会降低吞吐量**
参数控制：`-XX:+UseConcMarkSweepGC` 使用CMS收集器, `-XX:+ UseCMSCompactAtFullCollection` Full GC后, 进行一次碎片整理; 整理过程是独占的, 会引起停顿时间变长, `-XX:+CMSFullGCsBeforeCompaction`设置进行几次Full GC后，进行一次碎片整理, `-XX:ParallelCMSThreads` 设定CMS的线程数量(一般情况约等于可用CPU数量)
![cmscollector](../../../images/cmscollector.png)

##### G1(Garbage-First)收集器(标记-整理算法, 停止复制算法)
G1是目前技术发展的最前沿成果之一, **可以在新生代和老年代中只使用G1收集器**. HotSpot开发团队赋予它的使命是未来可以替换掉JDK1.5中发布的CMS收集器. 与CMS收集器相比G1收集器有以下特点：
1. **并行和并发**. 使用多个CPU来缩短Stop The World停顿时间, 与用户线程并发执行. 
2. **分代收集**. 独立管理整个堆, 但是能够采用不同的方式去处理新创建对象和已经存活了一段时间, 熬过多次GC的旧对象, 以获取更好的收集效果. 
3. **空间整合**. 基于标记 - 整理算法, 无内存碎片产生. 
4. **可预测的停顿**. 能简历可预测的停顿时间模型, 能让使用者明确指定在一个长度为M毫秒的时间片段内, 消耗在垃圾收集上的时间不得超过N毫秒. 

上面提到的垃圾收集器, 收集的范围都是整个新生代或者老年代, 而G1不再是这样. 使用G1收集器时, Java堆的内存布局与其他收集器有很大差别, 它将整个Java堆划分为多个大小相等的独立区域(Region), 虽然还保留有新生代和老年代的概念, 但新生代和老年代不再是物理隔阂了, 它们都是一部分(可以不连续)Region的集合. G1收集器中, Region之间的对象引用以及其他收集器的新生代和老年代之间的对象引用, 虚拟机都使用Remembered Set来避免全堆扫描的. 每个Region对应一个Remembered Set, 虚拟机发现程序在对Reference类型的数据进行写操作时, 会产生一个Write Barrier暂时中断写操作, 检查Reference引用的对象是否处于不同的Region之中(在分代的例子中就是检查老年代的对象是否引用了新生代的对象), 如果是, 则通过CardTable把相关引用信息记录到被引用对象所属的Region的Remembered Set之中, 当进行内存回收时, 在GC根节点的枚举范围中加入Remembered Set即可保证不对全堆扫描也不会遗漏.G1收集器具体的运行示意图如下
![g1collector](../../../images/g1collector.png)
对于上述过程我们可以看如下代码加深理解

```java
public class G1 {
    private Object obj;
    
    public init() {
        obj = new Object();
    }
    
    public static void main(String[] args) {
        G1 g1 = new G1();
        g1.init();
    }
}
```
说明: 程序中执行init函数的时候, 会产生一个Write Barrier暂停中断写操作, 此时, 假定程序中G1对象与Object对象被分配在不同的Region当中, 则会把obj的引用信息记录在Object所属的Remembered Set当中. 具体的内存分布图如下
![neicunfenpei1](../../../images/neicunfenpei1.png)
如果不计算维护Remembered Set的操作, G1收集器的运作可以分为如下几步

1. **初始并发**, 标记GCRoots能直接关联到的对象; 修改TAMS(Next Top At Mark Start), 使得下一阶段程序并发时, 能够在可用的Region中创建新对象, 需停顿线程, 耗时很短.

2. **并发标记**, 从GCRoots开始进行可达性分析, 与用户程序并发执行, 耗时很长. 

3. **最终标记**, 修正并发标记期间因用户程序继续运作而导致标记产生变动的那一部分标记记录, 变动的记录将被记录在Remembered Set Logs中, 此阶段会把其整合到Remembered Set中, 需要停顿线程, 与用户程序并行执行, 耗时较短.

4. **筛选回收**, 对各个Region的回收价值和成本进行排序, 根据用户期望的GC时间进行回收, 与用户程序并发执行, 时间用户可控.



##### 常用的垃圾收集器组合
|       | **新生代GC策略**  | **年老代GC策略** | **说明**                                                     |
| ----- | ----------------- | ---------------- | ------------------------------------------------------------ |
| 组合1 | Serial            | Serial Old       | Serial和Serial Old都是单线程进行GC，特点就是GC时暂停所有应用线程。 |
| 组合2 | Serial            | CMS+Serial Old   | CMS（Concurrent Mark Sweep）是并发GC，实现GC线程和应用线程并发工作，不需要暂停所有应用线程。另外，当CMS进行GC失败时，会自动使用Serial Old策略进行GC。 |
| 组合3 | ParNew            | CMS              | 使用-XX:+UseParNewGC选项来开启。ParNew是Serial的并行版本，可以指定GC线程数，默认GC线程数为CPU的数量。可以使用-XX:ParallelGCThreads选项指定GC的线程数。如果指定了选项-XX:+UseConcMarkSweepGC选项，则新生代默认使用ParNew GC策略。 |
| 组合4 | ParNew            | Serial Old       | 使用-XX:+UseParNewGC选项来开启。新生代使用ParNew GC策略，年老代默认使用Serial Old GC策略。 |
| 组合5 | Parallel Scavenge | Serial Old       | Parallel Scavenge策略主要是关注一个可控的吞吐量：应用程序运行时间 / (应用程序运行时间 + GC时间)，可见这会使得CPU的利用率尽可能的高，适用于后台持久运行的应用程序，而不适用于交互较多的应用程序。 |
| 组合6 | Parallel Scavenge | Parallel Old     | Parallel Old是Serial Old的并行版本                           |
| 组合7 | G1GC              | G1GC             | -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC        #开启 -XX:MaxGCPauseMillis =50                  #暂停时间目标 -XX:GCPauseIntervalMillis =200          #暂停间隔目标 -XX:+G1YoungGenSize=512m            #年轻代大小 -XX:SurvivorRatio=6                            #幸存区比例 |



#### Java虚拟机知识总览

![JVMall](../../../images/JVMall.jpg)

ref:
1.[JAVA本地方法详解，什么是JAVA本地方法？](https://www.cnblogs.com/chen-jack/p/7904510.html),   2.[深入理解JVM(一)——JVM内存模型](https://blog.csdn.net/qq_34173549/article/details/79612540),  3. [JVM内存模型详解](https://blog.csdn.net/genius_ge/article/details/76151179),   4.[JVM的内存区域划分](https://www.cnblogs.com/dolphin0520/p/3613043.html),   5.[程序猿的日常——JVM内存模型与垃圾回收](https://www.cnblogs.com/xing901022/p/7725961.html),   6.[JVM内存模型](https://blog.csdn.net/u012152619/article/details/46968883),   7.[JVM堆内存参数优化，让性能飞起来](https://blog.csdn.net/u013381397/article/details/71080535),   8.[java堆内存详解](https://www.cnblogs.com/ITPower/p/7929010.html),   9.[Java内存分配之堆、栈和常量池](https://www.cnblogs.com/SaraMoring/p/5687466.html),   10.[JVM性能调优](https://www.cnblogs.com/chen77716/archive/2010/06/26/2130807.html),   11.[jvm系列(二):JVM内存结构](https://www.cnblogs.com/ityouknow/p/5610232.html),   12.[JVM内存回收机制简述](https://www.cnblogs.com/lzrabbit/p/3826738.html),   13.[【JVM】JVM系列之垃圾回收（二）](https://www.cnblogs.com/leesf456/p/5218594.html),   14.[Minor GC、Major GC和Full GC之间的区别](https://www.cnblogs.com/yang-hao/p/5948207.html),   15.[Java虚拟机(二)——Java堆内存划分](https://blog.csdn.net/ylyg050518/article/details/52244994),   16.[GC详解及Minor GC和Full GC触发条件总结](https://blog.csdn.net/yhyr_ycy/article/details/52566105),   17.[GC日志分析](https://blog.csdn.net/yxc135/article/details/12137663/),   18.[在IDE的后台打印GC日志](https://blog.csdn.net/u011767040/article/details/49180973),   19.[JVM 新生代老年代](https://www.cnblogs.com/E-star/p/5556188.html),   20.[JVM参数配置大全](https://www.cnblogs.com/edwardlauxh/archive/2010/04/25/1918603.html),   21.[JVM系列三:JVM参数设置、分析](https://www.cnblogs.com/redcreen/archive/2011/05/04/2037057.html),   22.[Java GC、新生代、老年代](https://www.cnblogs.com/yydcdut/p/3959711.html),   23.[JVM的内存区域划分以及垃圾回收机制详解](https://www.cnblogs.com/ludashi/p/6694965.html),   24.[JVM参数说明](https://www.cnblogs.com/wenfeng762/archive/2011/08/14/2137810.html),   25.[jvm系列(三):java GC算法 垃圾收集器](https://www.cnblogs.com/ityouknow/p/5614961.html),   26.[jvm系列(八):jvm知识点总览](https://www.cnblogs.com/ityouknow/p/6482464.html),   27.[jvm系列(一):java类的加载机制](https://www.cnblogs.com/ityouknow/p/5603287.html),    28.[jvm系列(四):jvm调优-命令大全（jps jstat jmap jhat jstack jinfo）](https://www.cnblogs.com/ityouknow/p/5714703.html),   29.[jvm系列(七):jvm调优-工具篇](https://www.cnblogs.com/ityouknow/p/6437037.html)