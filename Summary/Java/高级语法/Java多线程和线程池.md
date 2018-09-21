### Java多线程和线程池
***

#### 多线程
Java多线程主要的类是`Thread`和`Runnable`接口, 类只可以单继承, 接口可以多实现, 所以使用`Runnable`接口更加方便, 运行任务时候, 只需要重写run()方法, 就可以了. `Thread`有使用`Runnable`构造线程的构造函数. `Thread`之中的方法有run 和start需要注意, run是运行线程, 但是它只是运行, 也就是简单的执行, 达不到开启多条线程的效果, 而start方法是可以开启多条线程的, 开启多线程, 就需要多条线程同时start.

**多线程买票的例子**
```java
/*Thread买票*/
@Slf4j
public class MyThread extends Thread {
    @Setter
    @Getter
    private static volatile Integer no;// 可以当锁
    @Getter
    @Setter
    private String saleName;
    Object mutex = new Object();// 锁，自己定义的，或者使用实例的锁

    MyThread(String saleName) {
        super();
        this.saleName = saleName;
    }

    @Override
    public void run() {
        // 循环是指线程不停的去卖票
        while (no > 0) {
            try {
                Thread.sleep(1000);
                saleTicket();
            } catch (InterruptedException e) {
                log.error("多个窗口买票出现问题", e);
            }
        }
    }

    // 买一张票的情况
    public void saleTicket() {
        synchronized (no) {//在买票环节有所控制, 而非是run处
            if (no > 0) {
                System.out.println(this.getSaleName() + "卖出去了第" + this.getNo() + "张票");
                no = no - 1;
            } else {
                System.out.println("票已经卖完！");//为何有两个"票已经卖完了!"了的语句?
                return; // 结束线程, break, continue
            }
        }
    }


    public static void main(String[] args) {
        MyThread.setNo(20);//设置一共有100张票
        MyThread mt1 = new MyThread("小明");
        MyThread mt2 = new MyThread("Jack");
        MyThread mt3 = new MyThread("张辽");
        mt1.start();
        mt2.start();
        mt3.start();
    }
}
```

```java
// 使用Runnable来完成多线程的工作
@Slf4j
public class RunnaleThread implements Runnable {
    @Getter
    @Setter
    private static Integer ticket;
    @Getter
    @Setter
    private String sellName;

    RunnaleThread(String sellName) {
        this.sellName = sellName;
    }

    @Override
    public void run() {
        while (getTicket() > 0) {
            try {
                Thread.sleep(1000);
                sellTicket();
            } catch (Exception e) {
                log.error("买票出现问题", e);
            }
        }
}

    public void sellTicket() {
        synchronized (ticket) {//在买票环节有所控制, 而非是run处
            if (ticket > 0) {
                System.out.println(this.getSellName() + "卖出了第" + getTicket() + "票");
                ticket--;
            } else {
                System.out.println("票已经卖完了!");//为何有两个"票已经卖完了!"了的语句?
                return;
            }
        }
    }

    public static void main(String[] args) {
        RunnaleThread.setTicket(20);//设置一共有100张票
        RunnaleThread rt1 = new RunnaleThread("小明");
        RunnaleThread rt2 = new RunnaleThread("Jack");
        RunnaleThread rt3 = new RunnaleThread("张辽");
        Thread mt1 = new Thread(rt1);
        Thread mt2 = new Thread(rt2);
        Thread mt3 = new Thread(rt3);
        mt1.start();
        mt2.start();
        mt3.start();
    }
}
```
**结束线程**

```java
/*结束线程, 不去使用不安全的Thread.stop方法, 使用一个温和的方法停止线程*/
@Slf4j
public class StopThread extends Thread {
    private static Integer count = 30;

    @Override
    public void run() {
        while (count > 0) {
            try {
                Thread.sleep(100);
                synchronized (count) {//获取锁
                    if (count != 15) {
                        System.out.println(currentThread().getName() + ": " + count);
                        count--;
                    } else {
                        System.out.println("结束线程");
                        break;//结束线程的方式, 不用stop
                    }
                }

            } catch (InterruptedException e) {
                log.error("多个窗口买票出现问题", e);
            }
        }
    }

    public static void main(String[] args) {
        StopThread st1=new StopThread();
        StopThread st2=new StopThread();
        st1.start();
        st2.start();
        System.out.println(currentThread().getName() + ": " + count);
    }
}
```



#### 线程池基础
像上面或者类似这种每次来都是用new关键字, 新建一个Thread对象, 来创建一个线程的的方式存在着很多的弊端, 如下面:
- 每次new Thread新建对象性能差; 
- 线程缺乏统一的管理, 可以无限制新建线程, 相互之间竞争, 还可能占用过多系统资源导致死机或者OOM(Out of Memory);
- 缺乏更多的功能, 如定时执行, 定期执行, 线程中断等.

为了解决如上的问题, 在jdk1.5之中引入了`java.util.concurrent`包, 此处主要介绍关于线程池的部分内容, 关于锁, 重入锁, 无锁化操作等内容在关于JUC的文章之中说明. **线程池是基于二级调度的架构**,  所有的线程, 提交到线程池里面, 然后通过线程池进行提交运行. 关系可以通过下图来表示.
![executor1](../../../images/executor1.png)
线程池的架构情况如上图, 之间的类和接口的关系如下图
![javaexecutor](../../../images/javaexecutor.gif)



##### 线程池作用
根据系统的环境情况, 可以自动或手动设置线程数量, 达到运行的最佳效果; 少了浪费了系统资源, 多了造成系统拥挤效率不高. 用线程池控制线程数量, 其他线程排队等候. 一个任务执行完毕, 再从队列的中取最前面的任务开始执行. 若队列中没有等待进程, 线程池的这一资源处于等待. 当一个新任务需要运行时, 如果线程池中有等待的工作线程, 就可以开始运行了, 否则进入等待队列. 



##### 为什么要用线程池
- 重用存在的线程, 减少对象创建, 消亡的开销, 提升性能
- 可有效控制最大并发线程数, 提高系统资源的使用率, 同时避免过多资源竞争, 避免堵塞
- 提供定时执行, 定期执行, 单线程, 并发数控制等功能
- 可以根据系统的承受能力, 调整线程池中工作线线程的数目, 防止因为消耗过多的内存, 而把服务器累趴下(每个线程需要大约1MB内存, 线程开的越多, 消耗的内存也就越大, 最后死机)



##### 主要的类
Java里面线程池的顶级接口是`Executor`, 但是严格意义上讲`Executor`并不是一个线程池, 而只是一个执行线程的工具. 真正的线程池接口是`ExecutorService`和`ScheduledExecutorService`,`ScheduledExecutorService`继承自`ExecutorService`,周期性任务的线程池的接口, `ExecutorService`是一个较为普遍的线程池接口.

| 类或接口                      | 作用                                                         |
| ----------------------------- | ------------------------------------------------------------ |
| `Executor`                    | 线程池的**接口**, 其中只有一个`execute(Runnable command)`方法 |
| `Executors`                   | 线程池的**工厂类**,  通过工厂调用工厂方法, 返回我们想要创建的线程池对象 |
| `ExecutorService`             | 真正的线程池接口, 继承自`Executor`, 其中包含了线程池实际操作的各种方法, 如`shutdown`, `shutdowmNow`, `isShutdown`,`isTerminated`,`submit`等 |
| `ScheduledExecutorService`    | 和`Timer/TimerTask`类似, 解决那些需要任务重复执行的问题.     |
| `ThreadPoolExecutor`          | `ExecutorService`的默认实现. **第一种线程池类**              |
| `ScheduledThreadPoolExecutor` | 继承自`ThreadPoolExecutor`的`ScheduledExecutorService`接口实现, 周期性任务调度的类实现. **第二种线程池类** |
![img](../../../images/xianchengchi.png)
要配置一个线程池是比较复杂的, 尤其是对于线程池的原理不是很清楚的情况下, 很有可能配置的线程池不是较优的, 因此在Executors类里面提供了一些静态工厂, 生成一些常用的线程池, *我们自定义的线程池, 通常使用`ThreadPoolExecutor`来完成*. 如下的5种线程池, 是jdk默认配置好的, 前面的4种是我们常用的线程池.

**ThreadPoolExecutor创建的3种常见线程池**:

1. **newSingleThreadExecutor**(结尾不是pool, 就是Exector)
创建一个**单线程**的线程池. **这个线程池只有一个线程在工作**, 也就是相当于单线程串行执行所有任务. 如果这个唯一的线程因为异常结束, 那么会有一个新的线程来替代它. 此线程池保证所有任务的执行顺序按照任务的提交顺序执行.
2. **newFixedThreadPool**
创建**固定大小**的线程池. 每次提交一个任务就创建一个线程, 直到线程达到线程池的最大大小. 线**程池的大小一旦达到最大值就会保持不变**.如果某个线程因为执行异常而结束, 那么线程池会补充一个新线程.
3. **newCachedThreadPool**
创建一个**可缓存**的线程池. 如果线程池的大小超过了处理任务所需要的线程, 那么就会回收部分空闲(60秒不执行任务)的线程，当任务数增加时, 此线程池又可以智能的添加新线程来处理任务. **此线程池不会对线程池大小做限制**, 线程池大小完全依赖于操作系统(或者说JVM)能够创建的最大线程大小.

**ScheduleThreadPoolExecutor创建的2种常见线程池:**
1. **newScheduledThreadPool**
创建一个**大小无限**的线程池. 此线程池支持**定时以及周期性执行任务**的需求.
2. **SingleThreadScheduleExecutor**:
这个是单个线程, 不是常用的4种线程池之中的一种, 相当于单线程的周期性任务执行方式.



##### 基本线程池的使用实例
```java
public class TaskRun implements Runnable {
    @Getter
    @Setter
    private String name;

    TaskRun(String name) {
        this.name = name;
    }

    @Override
    public void run() {
        int no = 0;
        System.out.println(Thread.currentThread().getName()+"====="+this.getName() + "线程正在运行...");
        while (no < 10000000) {
            no++;
        }
        if (no >=10000000) {//判断条件
            System.out.println(this.getName() + "线程结束运行");
            return;
        }
    }
}
```
1.**newCachedThreadPool**
创建一个可缓存线程池, 如果线程池长度超过处理需要, 可灵活回收空闲线程, 若无可回收, 则新建线程. 示例代码如下:
```java
@Slf4j
public class MyThreadCachePool {
    public static void main(String[] args) {
        ExecutorService cachedThreadPool = Executors.newCachedThreadPool();//创建一个可调整大小的线程缓存池
        for (int i = 0; i < 10; i++) {
//            try {
            cachedThreadPool.execute(new TaskRun(String.valueOf(i)));
//                Thread.sleep(100);//停止主线程
//            } catch (InterruptedException e) {
//                log.error("线程运行出现问题", e);
//            }
//        }
        }
    }
}
```
线程池为无限大, 当执行第二个任务时第一个任务已经完成, 会复用执行第一个任务的线程, 而不用每次新建线程.

2.**newFixedThreadPool**
创建一个定长线程池, 可控制线程最大并发数, 超出的线程会在队列中等待. 示例代码如下:
```java
public class MyThreadFixedPool {
    public static void main(String[] args) {
        ExecutorService fix = Executors.newFixedThreadPool(10);//创建固定为10个线程大小的线程池
        TaskRun tr1 = new TaskRun("xc1");
        TaskRun tr2 = new TaskRun("xc2");
        TaskRun tr3 = new TaskRun("xc3");
        TaskRun tr4 = new TaskRun("xc4");
        TaskRun tr5 = new TaskRun("xc5");
        fix.execute(tr1);
        fix.execute(tr2);
        fix.execute(tr3);
        fix.execute(tr4);
        fix.execute(tr5);
        if (!fix.isShutdown()) {
            fix.shutdown();
            System.out.println("fix线程池停止了");
        }
    }
}
```
定长线程池的大小最好根据系统资源进行设置. 如`Runtime.getRuntime().availableProcessors()`

3.**newScheduledThreadPool**
创建一个定长线程池，支持定时及周期性任务执行。每次根据循环的次数, 时间成倍的增加, 代码如下:

```java
public class MyThreadScheduledPool {
    public static void main(String[] args) {
        // ScheduledExecutorService继承自ExecutorService,  两种ExecutorService都可以创建newScheduledThreadPool的线程池,
        // 但是, 只使用ExecutorService创建的线程池, 没有定时功能
        ScheduledExecutorService schedule = Executors.newScheduledThreadPool(3);//容量为3的规划线程池
        for (int i = 0; i < 10; i++) {
            TaskRun tr = new TaskRun("第" + i + "条线程");
            schedule.schedule(tr, 1000 * i, TimeUnit.MILLISECONDS);
        }
    }
}
```

4.**newSingleThreadExecutor**
创建一个单线程化的线程池, 它只会用唯一的工作线程来执行任务, 保证所有任务按照指定顺序(FIFO, LIFO, 优先级)执行. 示例代码如下:
```java
public class MyThreadSinglePool {
    public static void main(String[] args) {
        ExecutorService single = Executors.newSingleThreadExecutor();//只有一个线程的线程池
        TaskRun tr1 = new TaskRun("xc1");
        TaskRun tr2 = new TaskRun("xc2");
        TaskRun tr3 = new TaskRun("xc3");
        single.execute(tr1);//只有一个线程, execute执行之后没有返回的结果, 需要结果需要用到submit, 配合callable接口
        single.execute(tr1);
        single.execute(tr1);

    }
}
```
结果依次输出, 相当于顺序执行各个任务.
**注意**: 以上的execute()方法可以替换为submit()方法, 执行的结果是一样的.



##### submit() 和execute()的区别
JDK5往后, 任务分两类: 一类是实现了Runnable接口的类, 一类是实现了Callable接口的类. 两者都可以被`ExecutorService`执行, 但是他们之间还是有差异的, 区别如下, 可用下图形象描述之间的关系:
1. `execute(Runnable x) `: **没有返回值**. 可以执行任务, 但**无法判断任务是否成功完成**. ------实现Runnable接口
2. `submit(Runnable x) `:**返回一个future**. 可以用这个future来判断任务是否成功完成.------实现Callable接口

![executorcallrun](../../../images/executorcallrun.png)
方法原型如下:

```java
   void execute(Runnable command);//execute
   <T> Future<T> submit(Runnable task, T result);//submit
   <T> Future<T> submit(Callable<T> task);//submit
```







ref:
1.[java 线程池——异步任务](https://www.cnblogs.com/0201zcr/p/6060068.html),   2.[Executor框架的使用简介](https://blog.csdn.net/qq_16811963/article/details/52161713),   3.[Java并发编程系列之十五：Executor框架](https://blog.csdn.net/u011116672/article/details/51057585)