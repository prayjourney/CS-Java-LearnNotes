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



#### 线程池





