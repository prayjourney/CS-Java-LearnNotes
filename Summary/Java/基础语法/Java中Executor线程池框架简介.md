### Java中Executor线程池框架简介

***

Java的Executor框架由`java.util.concurrent.Executor`, `java.util.concurrent.ExecutorService`, `java.util.concurrent. Executors`此三个重要类/接口来提供线程池的功能。因为创建和管理线程非常心累，并且操作系统通常对线程数有限制，所以建议使用线程池来并发执行任务，而不是每次请求进来时创建一个线程。使用线程池不仅可以提高应用的响应时间，还可以避免`"java.lang.OutOfMemoryError: unable to create new native thread"` 之类的错误。在 Java 1.5 时，开发者需要关心线程池的创建和管理，但在 Java 1.5 之后 Executor 框架提供了多种内置的线程池,例如：FixedThreadPool(包含固定数目的线程)，CachedThreadPool(可根据需要创建新的线程)等等。

##### Executor
**Executor 是一个抽象层面的核心接口**(大致代码如下)

```java
public interface Executor {
    void execute(Runnable command);
}
```
不同于 `java.lang.Thread` 类将任务和执行耦合在一起， Executor 将任务本身和执行任务分离，可以阅读 [difference between Thread and Executor](http://javarevisited.blogspot.sg/2016/12/difference-between-thread-and-executor.html%E6%9D%A5%E7%9C%8B%E7%9C%8B) 来了解 Thread 和 Executor 间更多的不同。



##### ExecutorService
**ExecutorService 接口 对 Executor 接口进行了扩展，提供了返回 Future 对象，终止，关闭线程池等方法**。当调用 `shutDown` 方法时，线程池会停止接受新的任务，但会完成正在 pending 中的任务。

Future 对象提供了异步执行，这意味着无需等待任务执行的完成，只要提交需要执行的任务，然后在需要时检查 Future 是否已经有了结果，如果任务已经执行完成，就可以通过 Future.get() 方法获得执行结果。需要注意的是，Future.get() 方法是一个阻塞式的方法，如果调用时任务还没有完成，会等待直到任务执行结束。

通过 ExecutorService.submit() 方法返回的 Future 对象，还可以取消任务的执行。Future 提供了 cancel() 方法用来取消执行 pending 中的任务。

ExecutorService 部分代码如下：

```java
public interface ExecutorService extends Executor {
	void shutdown();
	<T> Future<T> submit(Callable<T> task);
	<T> Future<T> submit(Runnable task, T result);
	<T> List<Future<T>> invokeAll(Collection<? extends Callable<T>> tasks, long timeout, TimeUnit unit) throws InterruptedException;
}
```

##### Executors
**Executors 是一个工具类，类似于 Collections。提供工厂方法来创建不同类型的线程池**，比如 FixedThreadPool 或 CachedThreadPool。

Executors 部分代码：

```java
public class Executors {

    public static ExecutorService newFixedThreadPool(int nThreads) {
        return new ThreadPoolExecutor(nThreads, nThreads, 0L, TimeUnit.MILLISECONDS,new LinkedBlockingQueue<Runnable>());
        }

     public static ExecutorService newCachedThreadPool() {
        return new ThreadPoolExecutor(0, Integer.MAX_VALUE, 60L, TimeUnit.SECONDS, new SynchronousQueue<Runnable>());
        }
}
```



##### Executor vs ExecutorService vs Executors三者的区别
正如上面所说，这三者均是 Executor 框架中的一部分。可以通过下图来观察其之间的关系
![executor框架UML图](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_executor%e6%a1%86%e6%9e%b6.png)
简单明了的说，其区别如下

```java
    /**
     * Executor 是一个抽象层面的核心接口,是Executor框架的基础；
     * ExecutorService 接口 对 Executor 接口进行了扩展（子接口），提供了返回 Future 对象，终止，关闭线程池等方法
     * Executors 是一个工具类，类似于 Collections。提供工厂方法来创建不同类型的线程池，比如 FixedThreadPool
     */
```
详细而言，其区别如下
- Executor 和 ExecutorService 这两个接口主要的区别是：ExecutorService 接口继承了 Executor 接口，是 Executor 的子接口
- Executor 和 ExecutorService 第二个区别是：Executor 接口定义了 `execute()`方法用来接收一个`Runnable`接口的对象，而 ExecutorService 接口中的 `submit()`方法可以接受`Runnable`和`Callable`接口的对象。
- Executor 和 ExecutorService 接口第三个区别是 Executor 中的 `execute()` 方法不返回任何结果，而 ExecutorService 中的 `submit()`方法可以通过一个 Future 对象返回运算结果。
- Executor 和 ExecutorService 接口第四个区别是除了允许客户端提交一个任务，ExecutorService 还提供用来控制线程池的方法。比如：调用 `shutDown()` 方法终止线程池。可以通过 《Java Concurrency in Practice》一书了解更多关于关闭线程池和如何处理 pending 的任务的知识。
- Executors 类提供工厂方法用来创建不同类型的线程池。比如: `newSingleThreadExecutor()` 创建一个只有一个线程的线程池，`newFixedThreadPool(int numOfThreads)`来创建固定线程数的线程池，`newCachedThreadPool()`可以根据需要创建新的线程，但如果已有线程是空闲的会重用已有线程。
#####使用

```java
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class UseExecutorPool
{
    /**
     * Executor 是一个抽象层面的核心接口,是Executor框架的基础；
     * ExecutorService 接口 对 Executor 接口进行了扩展（子接口），提供了返回 Future 对象，终止，关闭线程池等方法
     * Executors 是一个工具类，类似于 Collections。提供工厂方法来创建不同类型的线程池，比如 FixedThreadPool
     */
    private static final String TAG = "UseExecutorPool";

    class Singlethread implements Runnable
    {
        @Override
        public void run()
        {
            try
            {
                System.out.println("我在运行之中...");
                Thread.sleep(100);
            } catch (InterruptedException e)
            {
                e.printStackTrace();
            }
        }
    }

    public static void main(String[] args) throws InterruptedException
    {
        //Single Thread
        ExecutorService executorSingle = Executors.newSingleThreadExecutor();
        executorSingle.execute(new UseExecutorPool().new Singlethread());
        Thread.sleep(1000);
        System.out.println("我等待了1秒，要结束了");
        executorSingle.shutdown();//如果使用Executor则没有这个方法

        //Fixed Thad
        ExecutorService executorFixed = Executors.newFixedThreadPool(5);
        for (int i = 0; i < 6; i++)
        {
            //多出来的一个会在一个完成之后补上，在未完成之前，它是等待的状态
            executorFixed.execute(new Thread(new MoreThreads(), "FixedThread:" + i));
        }
        executorFixed.shutdown();

        //Cache Thread
        //如何给线程池里面的线程命名，通过构造函数好像不起作用？
        //https://www.zhihu.com/question/31615390
        ExecutorService executorCached = Executors.newCachedThreadPool();
        for (int i = 7; i < 15; i++)
        {
            Thread thread = new Thread(new MoreThreads(), "CachedThread:" + i);
            executorCached.execute(thread);
        }
        executorCached.shutdown();

        //Scheduled Thread
        ScheduledExecutorService scheduledThreadPool = Executors.newScheduledThreadPool(5);
        scheduledThreadPool.schedule(new Runnable() {
            public void run()
            {
                System.out.println("delay 3 seconds");
            }
        }, 3, TimeUnit.SECONDS);
        scheduledThreadPool.shutdown();
    }
}

class MoreThreads implements Runnable
{
    @Override
    public void run()
    {
        try
        {
            long start = System.currentTimeMillis();
            Thread.sleep((long) (Math.random() * 100));
            long end = System.currentTimeMillis();
            System.out.println(Thread.currentThread().getName() + ": is running, time is:" + (end - start));

        } catch (Exception e)
        {
            e.printStackTrace();
        }


    }
}
```

##### 总结
下表列出了 Executor 和 ExecutorService 的区别：

| Executor                             | ExecutorService                          |
| ------------------------------------ | ---------------------------------------- |
| Executor 是 Java 线程池的核心接口，用来并发执行提交的任务 | ExecutorService 是 Executor 接口的扩展，提供了异步执行和关闭线程池的方法 |
| 提供execute()方法用来提交任务                  | 提供submit()方法用来提交任务                       |
| execute()方法无返回值                      | submit()方法返回Future对象，可用来获取任务执行结果         |
| 不能取消任务                               | 可以通过Future.cancel()取消pending中的任务         |
| 没有提供和关闭线程池有关的方法                      | 提供了关闭线程池的方法                              |

##### 注意
利用 Executors 类提供的工厂方法来创建一个线程池是很方便，但对于需要根据实际情况自定义线程池某些参数的场景，就不太适用了。举个例子：当线程池中的线程均处于工作状态，并且线程数已达线程池允许的最大线程数时，就会采取指定的饱和策略来处理新提交的任务。总共有四种策略：

- AbortPolicy: 直接抛异常
- CallerRunsPolicy: 用调用者的线程来运行任务
- DiscardOldestPolicy: 丢弃线程队列里最近的一个任务，执行新提交的任务
- DiscardPolicy 直接将新任务丢弃

如果使用 Executors 的工厂方法创建的线程池，那么饱和策略都是采用默认的 AbortPolicy，所以如果我们想当线程池已满的情况，使用调用者的线程来运行任务，就要自己创建线程池，指定想要的饱和策略，而不是使用 Executors 了。所以我们可以根据需要创建**ThreadPoolExecutor**(ExecutorService接口的实现类)对象，自定义一些参数，而不是调用 Executors 的工厂方法创建。
当然，在使用 Spring 框架的项目中，也可以使用 Spring 提供的 ThreadPoolTaskExecutor 类来创建线程池。ThreadPoolTaskExecutor 与 ThreadPoolExecutor 类似，也提供了许多参数用来自定义线程池，比如：核心线程池大小，线程池最大数量，饱和策略，线程活动保持时间等等。

ref:
1.[Executor, ExecutorService 和 Executors 间的不同](http://www.importnew.com/24923.html), 2.[Executor, ExecutorService 和 Executors 间的不同](http://www.cnblogs.com/gsonkeno/p/6607460.html), 3.[【译】Executor, ExecutorService 和 Executors 间的不同](https://yemengying.com/2017/03/17/difference-between-executor-executorService/?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io), 4.[Executors API](https://docs.oracle.com/javase/8/docs/api/java/util/concurrent/Executors.html), 5.[Java四种线程池的使用](http://cuisuqiang.iteye.com/blog/2019372), 6.[java 线程池 中获取线程名称？](https://www.zhihu.com/question/31615390)