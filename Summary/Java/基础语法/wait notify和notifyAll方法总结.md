### wait,notify和notifyAll方法总结

***

##### 引言
在同步的问题之中，我们的关注点在于**效率和数据安全**，数据的安全比效率重要，我们引入多线程，就是为了提高效率。在实际工作之中，需要线程之间的协作。比如说最经典的生产者-消费者模型：当队列满时，生产者需要等待队列有空间才能继续往里面放入商品，而在等待的期间内，生产者必须**释放**对临界资源（即队列）的占用权。因为生产者如果不释放对临界资源的占用权，那么消费者就无法消费队列中的商品，就不会让队列有空间，那么生产者就会一直无限等待下去。因此，一般情况下，当队列满时，会让生产者交出对临界资源的占用权，并进入挂起状态。然后等待消费者消费了商品，然后消费者通知生产者队列有空间了。同样地，当队列空时，消费者也必须等待，等待生产者通知它队列中有商品了。这种互相通信的过程就是线程间的协作。

##### wait()、notify()和notifyAll()方法

wait()、notify()和notifyAll()是Object类中的方法，这三个方法，都是Java语言提供的实现线程间阻塞(Blocking)和控制进程内调度(inter-process communication)的底层机制，其在JDK中的作用注释如下
```java
/**
 * Wakes up a single thread that is waiting on this object's
 * monitor. If any threads are waiting on this object, one of them
 * is chosen to be awakened. The choice is arbitrary and occurs at
 * the discretion of the implementation. A thread waits on an object's
 * monitor by calling one of the wait methods
 */
public final native void notify();

/**
 * Wakes up all threads that are waiting on this object's monitor. A
 * thread waits on an object's monitor by calling one of the
 * wait methods.
 */
public final native void notifyAll();

/**
 * Causes the current thread to wait until either another thread invokes the
 * {@link java.lang.Object#notify()} method or the
 * {@link java.lang.Object#notifyAll()} method for this object, or a
 * specified amount of time has elapsed.
 * The current thread must own this object's monitor.
 */
public final native void wait(long timeout) throws InterruptedException;

```


1.**Java内任何对象都能可以作为锁(Lock)，但是该锁必须作用在synchrnoized代码块或者方法之内，当其在synchronized方法或者块之外，其没有锁的功能，并且会抛出异常**。操作该锁的众多请求也都可以认为是条件队列(Condition queue)。而这个对象里的wait(), notify()和notifyAll()则是这个条件队列的固有(intrinsic)的方法。

2.锁和线程看似是分离的，但是实际上而言，对象锁，将线程“锁起来”，锁在对象之上，所以调用的对象，在起作用之前，是要么持有(wait())，要么等待(notify())这个锁，在起作用之后，就是要么释放(wait())，要么去争取(notify())这个锁。对于wait()，让当前的线程阻塞，释放锁，在这之前，此线程必须拥有这个对象的锁，否则其无法进入工作，对于notify()，唤醒的是一个正在等待此对象锁的线程，在操作之前，这个对象必须拥有这个对象锁，否则，也无法执行到调用notify()函数这一步骤。当notify()或者notifyAll()调用完，并退出synchronized块，才会释放对象锁后，其余线程才可获得锁

3.wait()、notify()和notifyAll()方法是本地方法，并且为final方法，无法被重写。调用某个对象的**wait()**方法能**让当前线程阻塞**，并且**当前线程必须拥有此对象的monitor（即锁）**，调用某个对象的**notify()**方法能够**唤醒一个正在等待这个对象的monitor的线程**，如果有多个线程都在等待这个对象的monitor，则只能唤醒其中一个线程；调用**notifyAll()**方法能够**唤醒所有正在等待这个对象的monitor的线程**

4.**调用wait()、notify()和notifyAll()，必须位于synchronized块或者synchronized方法之中**。调用某个对象的wait()方法，**当前线程必须拥有这个对象的monitor（即锁）**，调用某个对象的notify()方法，**当前线程也必须拥有这个对象的monitor（即锁）**。*++调用某个对象的wait()方法，相当于让当前线程交出此对象的monitor，然后进入等待状态++*，等待后续再次获得此对象的锁，需要说明的是Thread类中的sleep()方法使当前线程暂停执行一段时间，**从而让其他线程有机会以得到CPU时间片的方式而继续执行**，并不是以释放对象锁的方式让其他的线程执行，而wait()方法会释放对象锁。notify()和nofityAll()方法能够唤醒一个或者全部**正在等待该对象的monitor的线程**，当有多个线程都在等待该对象的monitor的话，则只能唤醒其中一个线程，具体唤醒哪个线程则不得而知，其是由JVM所决定的，另外要说明的是，这是一个“随机”的过程，并不是线程优先级越高，就一定会被唤醒。尤其要注意一点，**一个线程被唤醒不代表立即获取了对象的monitor，只有等调用完notify()或者notifyAll()并退出synchronized块，释放对象锁后**，其余线程才可获得锁执行(此处认为其他资源都已就绪，只有锁需要竞争)。
>举个简单的例子：假如有三个线程Thread1、Thread2和Thread3都在等待对象objectA的monitor，此时Thread4拥有对象objectA的monitor，当在Thread4中调用objectA.notify()方法之后，Thread1、Thread2和Thread3只有一个能被唤醒。注意，被唤醒不等于立刻就获取了objectA的monitor。假若在Thread4中调用objectA.notifyAll()方法，则Thread1、Thread2和Thread3三个线程都会被唤醒，至于哪个线程接下来能够获取到objectA的monitor就具体依赖于操作系统的调度了。

5.每个对象都拥有monitor（即锁），所以让当前线程等待某个对象的锁，当然应该通过这个对象来操作了。而不是用当前线程来操作，因为当前线程可能会等待多个线程的锁，如果通过线程来操作，则非常复杂，而且，由于Thread类继承了Object类，所以Thread类生成的对象也可以调用这三个方，因此，wait()、notify()和notifyAll()定义在Object之上

##### 普通案例
wait(),notify()的例子
```java
public class OutputThread implements Runnable {

    private int num;
    private Object lock;

    public OutputThread(int num, Object lock) {
        super();
        this.num = num;
        this.lock = lock;
    }

    public void run() {
        try {
            while(true){
                synchronized(lock){
                    lock.notifyAll();
                    lock.wait();
                    System.out.println(num);
                }
            }
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

    }

    public static void main(String[] args){
        final Object lock = new Object();

        Thread thread1 = new Thread(new OutputThread(1,lock));
        Thread thread2 = new Thread(new OutputThread(2, lock));

        thread1.start();
        thread2.start();
    }

}
```

```java
public class test4 {
    public static Object object = new Object();
    public static void main(String[] args) {
        Thread1 thread1 = new Thread1();
        Thread2 thread2 = new Thread2();

        thread1.start();

        try {
            Thread.sleep(200);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        thread2.start();
    }

    static class Thread1 extends Thread{
        @Override
        public void run() {
            synchronized (object) {
                try {
                    object.wait();
                } catch (InterruptedException e) {
                }
                System.out.println("线程"+Thread.currentThread().getName()+"获取到了锁");
            }
        }
    }

    static class Thread2 extends Thread{
        @Override
        public void run() {
            synchronized (object) {
                object.notify();
                System.out.println("线程"+Thread.currentThread().getName()+"调用了object.notify()");
            }
            System.out.println("线程"+Thread.currentThread().getName()+"释放了锁");
        }
    }
}
```

##### 生产者消费者
主要的点就是，生产者生产，消费者消费，当缓存满了之后，生产者就要挂起，释放它所占有的锁，而当缓存容量为0的时候，消费者要提醒生产者，开始生产。
普通的实现
```java
public class QueueBuffer {
    int n;
    boolean valueSet = false;

    synchronized int get() {
        if (!valueSet)
            try {
                wait();
            } catch (InterruptedException e) {
                System.out.println("InterruptedException caught");
            }
        System.out.println("Got: " + n);
        valueSet = false;
        notify();
        return n;
    }

    synchronized void put(int n) {
        if (valueSet)
            try {
                wait();
            } catch (InterruptedException e) {
                System.out.println("InterruptedException caught");
            }
        this.n = n;
        valueSet = true;
        System.out.println("Put: " + n);
        notify();
    }
}

public class Producer implements Runnable {

    private QueueBuffer q;

    Producer(QueueBuffer q) {
        this.q = q;
        new Thread(this, "Producer").start();
    }

    public void run() {
        int i = 0;
        while (true) {
            q.put(i++);
        }
    }

}

public class Consumer implements Runnable {

    private QueueBuffer q;

    Consumer(QueueBuffer q) {
        this.q = q;
        new Thread(this, "Consumer").start();
    }

    public void run() {
        while (true) {
            q.get();
        }
    }

}

public class Main {

    public static void main(String[] args) {
        QueueBuffer q = new QueueBuffer(); 
        new Producer(q); 
        new Consumer(q); 
        System.out.println("Press Control-C to stop."); 
    }

}
```
使用优先队列的实现
```java
import java.util.PriorityQueue;

public class PCByObject {

    private PriorityQueue<Integer> queue=new PriorityQueue<>(10);
    public static void main(String[] args) {
        // TODO Auto-generated method stub
        PCByObject object=new PCByObject();
        Producer producer=object.new Producer();
        Consumer consumer=object.new Consumer();
        producer.start();
        consumer.start();
    }

   class Consumer extends Thread
   {
       @Override
       public void run()
       {
           consume();
       }
       private void consume()
       {
           while(true)
           {
               synchronized (queue) {
                   while(queue.size()==0)
                   {
                       try {
                        System.out.println("队列为空");
                        queue.wait();
                    } catch (Exception e) {
                        // TODO: handle exception
                        e.printStackTrace();
                        queue.notify();
                    }
                   }
                   queue.poll();
                   queue.notify();
                   System.out.println("取走一个元素,还有："+queue.size());
            }
           }
       }
   }

    class Producer extends Thread
    {
        @Override
        public void run()
        {
            produce();
        }
        private void produce()
        {
            while(true)
            {
                synchronized (queue) {
                    while(queue.size()==10)
                    {

                        try {
                            System.out.println("队列已经满了");
                            queue.wait();
                        } catch (InterruptedException e) {
                            // TODO Auto-generated catch block
                            e.printStackTrace();
                        }
                    }
                    queue.offer(1);
                    queue.notify();
                    System.out.println("向队列中插入一个元素，长度为"+queue.size());
                }
            }
        }
    }
}
```
##### 小结

1.一个对象的固有锁和它的固有条件队列是相关的，为了调用对象X内条件队列的方法，你必须获得对象X的锁。这是因为等待状态条件的机制和保证状态连续性的机制是紧密的结合在一起的(An object's intrinsic lock and its intrinsic condition queue are related: in order to call any of the condition queue methods on object X, you must hold the lock on X. This is because the mechanism for waiting for state-based conditions is necessarily tightly bound to the mechanism fo preserving state consistency)
2.根据上述两点，在调用wait(), notify()或notifyAll()的时候，必须先获得锁，且状态变量须由该锁保护，而固有锁对象与固有条件队列对象又是同一个对象。也就是说，要在某个对象上执行wait，notify，先必须锁定该对象，而对应的状态变量也是由该对象锁保护的。


ref:
1.[Java的wait(), notify()和notifyAll()使用小结](http://www.cnblogs.com/techyc/p/3272321.html), 2.[java并发－Condition与Object.wait()、Object.notify()](http://www.cnblogs.com/csuwater/p/5411693.html), 3.[Java多线程系列--“基础篇”05之 线程等待与唤醒](http://www.cnblogs.com/skywang12345/p/3479224.html)
