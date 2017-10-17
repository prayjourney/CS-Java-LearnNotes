### Java中的锁分类
***
在读很多并发文章中，会提及各种各样锁如公平锁，乐观锁等等，这篇文章介绍各种锁的分类。介绍的内容如下：
1.**公平锁/非公平锁**
2.**可重入锁**
3.**独享锁/共享锁**
4.**互斥锁/读写锁**
5.**乐观锁/悲观锁**
6.**分段锁**
7.**偏向锁/轻量级锁/重量级锁**
8.**自旋锁**

上面是很多锁的名词，**这些分类并不是全是指锁的状态，有的指锁的特性，有的指锁的设计**，下面总结的内容是对每个锁的名词进行一定的解释。
***

##### 公平锁/非公平锁

**公平锁是指多个线程按照申请锁的顺序来获取锁**。
**非公平锁是指多个线程获取锁的顺序并不是按照申请锁的顺序，有可能后申请的线程比先申请的线程优先获取锁**。有可能，会造成优先级反转或者饥饿现象。
对于Java `ReentrantLock`而言，通过构造函数指定该锁是否是公平锁，默认是非公平锁。非公平锁的优点在于吞吐量比公平锁大。
对于`Synchronized`而言，也是一种非公平锁。由于其并不像`ReentrantLock`是通过AQS的来实现线程调度，所以并没有任何办法使其变成公平锁。

##### 可重入锁

**可重入锁又名递归锁，是指在同一个线程在外层方法获取锁的时候，在进入内层方法会自动获取锁**。说的有点抽象，下面会有一个代码的示例。
对于Java `ReentrantLock`而言, 他的名字就可以看出是一个可重入锁，其名字是`Reentrant Lock`重新进入锁。
对于`Synchronized`而言,也是一个可重入锁。可重入锁的一个好处是可一定程度避免死锁。

```java
synchronized void setA() throws Exception{
    Thread.sleep(1000);
    setB();
}
synchronized void setB() throws Exception{
    Thread.sleep(1000);
}
```

上面的代码就是一个可重入锁的一个特点，如果不是可重入锁的话，setB可能不会被当前线程执行，可能造成死锁。

##### 独享锁/共享锁
**独享锁是指该锁一次只能被一个线程所持有**。
**共享锁是指该锁可被多个线程所持有**。
对于Java `ReentrantLock`而言，其是独享锁。但是对于Lock的另一个实现类`ReadWriteLock`，其读锁是共享锁，其写锁是独享锁。
读锁的共享锁可保证并发读是非常高效的，读写，写读 ，写写的过程是互斥的。
独享锁与共享锁也是通过AQS来实现的，通过实现不同的方法，来实现独享或者共享。
对于`Synchronized`而言，当然是独享锁。

##### 互斥锁/读写锁
*上面讲的独享锁/共享锁就是一种广义的说法，互斥锁/读写锁就是具体的实现*。
**互斥锁在Java中的具体实现就是`ReentrantLock`**
**读写锁在Java中的具体实现就是`ReadWriteLock`**

##### 乐观锁/悲观锁
**乐观锁与悲观锁不是指具体的什么类型的锁，而是指看待并发同步的角度**。
**悲观锁**++认为对于同一个数据的并发操作，一定是会发生修改的，哪怕没有修改，也会认为修改++。因此对于同一个数据的并发操作，悲观锁采取加锁的形式。悲观的认为，不加锁的并发操作一定会出问题。
**乐观锁**++则认为对于同一个数据的并发操作，是不会发生修改的++。在更新数据的时候，会采用尝试更新，不断重新的方式更新数据。乐观的认为，不加锁的并发操作是没有事情的。

从上面的描述我们可以看出，**悲观锁适合写操作非常多的场景，乐观锁适合读操作非常多的场景**，不加锁会带来大量的性能提升。
**悲观锁在Java中的使用，就是利用各种锁**。
**乐观锁在Java中的使用，是无锁编程，常常采用的是CAS算法，典型的例子就是原子类**，通过CAS自旋实现原子操作的更新。

##### 分段锁
**分段锁其实是一种锁的设计，并不是具体的一种锁，对于`ConcurrentHashMap`而言，其并发的实现就是通过分段锁的形式来实现高效的并发操作**。
我们以`ConcurrentHashMap`来说一下分段锁的含义以及设计思想，`ConcurrentHashMap`中的分段锁称为Segment，它即类似于HashMap（JDK7与JDK8中HashMap的实现）的结构，即内部拥有一个Entry数组，数组中的每个元素又是一个链表；同时又是一个ReentrantLock（Segment继承了ReentrantLock)。
当需要put元素的时候，并不是对整个hashmap进行加锁，而是先通过hashcode来知道他要放在那一个分段中，然后对这个分段进行加锁，所以当多线程put的时候，只要不是放在一个分段中，就实现了真正的并行的插入。但是，在统计size的时候，可就是获取hashmap全局信息的时候，就需要获取所有的分段锁才能统计。
**分段锁的设计目的是细化锁的粒度，当操作不需要更新整个数组的时候，就仅仅针对数组中的一项进行加锁操作**。

##### 偏向锁/轻量级锁/重量级锁
这三种锁是指锁的状态，并且是针对**`Synchronized`**。在Java 5通过引入锁升级的机制来实现高效`Synchronized`。这三种锁的状态是通过对象监视器在对象头中的字段来表明的。
**偏向锁**是指一段同步代码一直被一个线程所访问，那么该线程会自动获取锁。降低获取锁的代价。
**轻量级锁**是指当锁是偏向锁的时候，被另一个线程所访问，偏向锁就会升级为轻量级锁，其他线程会通过自旋的形式尝试获取锁，不会阻塞，提高性能。
**重量级锁**是指当锁为轻量级锁的时候，另一个线程虽然是自旋，但自旋不会一直持续下去，当自旋一定次数的时候，还没有获取到锁，就会进入阻塞，该锁膨胀为重量级锁。重量级锁会让其他申请的线程进入阻塞，性能降低。

##### 自旋锁
在Java中，*自旋锁是指尝试获取锁的线程不会立即阻塞，而是采用循环的方式去尝试获取锁*，**这样的好处是减少线程上下文切换的消耗**，++缺点是循环会消耗CPU++。典型的自旋锁实现的例子，可以参考自旋锁的实现[^1]
>自旋锁
自旋锁是采用让当前线程不停地的在循环体内执行实现的，当循环的条件被其他线程改变时 才能进入临界区。如下
```java
public class SpinLock {
  private AtomicReference<Thread> sign =new AtomicReference<>();
  public void lock(){
    Thread current = Thread.currentThread();
    while(!sign .compareAndSet(null, current)){
    }
  }
  public void unlock (){
    Thread current = Thread.currentThread();
    sign .compareAndSet(current, null);
  }
}
```
使用了CAS原子操作，lock函数将owner设置为当前线程，并且预测原来的值为空。unlock函数将owner设置为null，并且预测值为当前线程。
当有第二个线程调用lock操作时由于owner值不为空，导致循环一直被执行，直至第一个线程调用unlock函数将owner设置为null，第二个线程才能进入临界区。
由于自旋锁只是将当前线程不停地执行循环体，不进行线程状态的改变，所以响应速度更快。但当线程数不停增加时，性能下降明显，因为每个线程都需要执行，占用CPU时间。如果线程竞争不激烈，并且保持锁的时间段。适合使用自旋锁。注：该例子为非公平锁，获得锁的先后顺序，不会按照进入lock的先后顺序进行。


##### 类锁/对象锁
**类锁**：synchronized加到**static静态方法**前面是给class加锁，即类锁
**对象锁**：而synchronized加到**non-static非静态方法**前面是给对象上锁，即对象锁
**对象锁和类锁是不同的锁，所以多个线程同时执行这2个不同锁的方法时，是异步的**。在Task2 中定义三个方法 doLongTimeTaskA和doLongTimeTaskB是类锁，而doLongTimeTaskC是对象锁。
```java
public class Task2 {
    public synchronized static void doLongTimeTaskA() {
        System.out.println("name = " + Thread.currentThread().getName() + ", begain");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("name = " + Thread.currentThread().getName() + ", end");
    }

    public synchronized static void doLongTimeTaskB() {
        System.out.println("name = " + Thread.currentThread().getName() + ", begain");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("name = " + Thread.currentThread().getName() + ", end");
    }

    public synchronized void doLongTimeTaskC() {

        System.out.println("name = " + Thread.currentThread().getName() + ", begain");
        try {
            Thread.sleep(1000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("name = " + Thread.currentThread().getName() + ", end");
    }
```
三个线程的代码如下：
```java
class ThreadA extends Thread{

    private Task2 mTask2;

    public ThreadA(Task2 tk){
        mTask2 = tk;
    }
    public void run() {
        mTask2.doLongTimeTaskA();
    }
}

class ThreadB extends Thread{

    private Task2 mTask2;

    public ThreadB(Task2 tk){
        mTask2 = tk;
    }
    public void run() {
        mTask2.doLongTimeTaskB();
    }
}

class ThreadC extends Thread{

    private Task2 mTask2;

    public ThreadC(Task2 tk){
        mTask2 = tk;
    }
    public void run() {
        mTask2.doLongTimeTaskC();
    }
}
```
main函数中执行代码如下：
```java
    Task2 mTask2 = new Task2();
    ThreadA ta = new ThreadA(mTask2);
    ThreadB tb = new ThreadB(mTask2);
    ThreadC tc = new ThreadC(mTask2);

    ta.setName("A");
    tb.setName("B");
    tc.setName("C");

    ta.start();
    tb.start();
    tc.start();
```
执行的结果如下：
name = A, begain, time = 1487311199783
name = C, begain, time = 1487311199783
name = C, end, time = 1487311200784
name = A, end, time = 1487311200784
name = B, begain, time = 1487311200784
name = B, end, time = 1487311201784

**可以看出由于 doLongTimeTaskA和doLongTimeTaskB都是类锁，即同一个锁，所以 A和B是按顺序执行，即同步的。而C是对象锁，和A/B不是同一种锁，所以C和A、B是 异步执行的。（A、B、C代指上面的3中方法）**。

*我们知道对象锁要想保持同步执行，那么锁住的必须是同一个对象*。下面就修改下上面的来证明：
Task2.java不变，修改ThreadA 和 ThreadB 如下：
```java
class ThreadA extends Thread{

    private Task2 mTask2;

    public ThreadA(Task2 tk){
        mTask2 = tk;
    }
    public void run() {
        mTask2.doLongTimeTaskC();
    }
}

class ThreadB extends Thread{

    private Task2 mTask2;

    public ThreadB(Task2 tk){
        mTask2 = tk;
    }
    public void run() {
        mTask2.doLongTimeTaskC();
    }
}
```

main方法如下：
```java
    Task2 mTaska = new Task2();
    Task2 mTaskb = new Task2();
    ThreadA ta = new ThreadA(mTaska );
    ThreadB tb = new ThreadB(mTaskb );

    ta.setName("A");
    tb.setName("B");

    ta.start();
    tb.start();
```
结果如下：

name = A, begain, time = 1487311905775
name = B, begain, time = 1487311905775
name = B, end, time = 1487311906775
name = A, end, time = 1487311906775

从结果看来，对象锁锁的对象不一样，分别是mTaska ， mTaskb，所以线程A和线程B调用 doLongTimeTaskC 是异步执行的。

但是，**类锁可以对类的所有对象的实例起作用**。只需修改ThradA和 ThreadB，main 方法不做改变，修改如下：
```java
class ThreadA extends Thread{

    private Task2 mTask2;

    public ThreadA(Task2 tk){
        mTask2 = tk;
    }
    public void run() {
        //mTask2.doLongTimeTaskC();
        mTask2.doLongTimeTaskA();
    }
}

class ThreadB extends Thread{

    private Task2 mTask2;

    public ThreadB(Task2 tk){
        mTask2 = tk;
    }
    public void run() {
       //mTask2.doLongTimeTaskC();
        mTask2.doLongTimeTaskA();
    }
}
```
结果如下：

name = A, begain, time = 1487312239674
name = A, end, time = 1487312240674
name = B, begain, time = 1487312240674
name = B, end, time = 1487312241674

可以看出 在线程A执行完doLongTimeTaskA方法后，线程B才会获得该类锁接着去执行doLongTimeTaskA。也就是说，类锁对所有的该类对象都能起作用。
>总结：
1. 如果多线程同时访问同一类的 类锁（synchronized 修饰的静态方法）以及对象锁（synchronized 修饰的非静态方法）这两个方法执行是异步的，原因：类锁和对象锁是2中不同的锁。
2. 类锁对该类的所有对象都能起作用，而对象锁不能。


ref:
1.[Java中的锁分类](http://www.cnblogs.com/qifengshi/p/6831055.html)
2.[自旋锁的实现](http://ifeve.com/java_lock_see1/)
3.[透彻理解 Java synchronized 对象锁和类锁的区别](http://blog.csdn.net/zhujiangtaotaise/article/details/55509939)

[^1]:[自旋锁的实现](http://ifeve.com/java_lock_see1/)
