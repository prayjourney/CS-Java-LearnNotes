### Java多线程和JUC框架

#### 多线程wait(), notify(), notifyAll()方法详解
在多线程的情况下, 由于同一进程的多个线程共享同一片存储空间, 在带来方便的同时, 也带来了访问冲突这个严重的问题. Java语言提供了专门机制以解决这种冲突, 有效避免了同一个数据对象被多个线程同时访问.
**wait与notify是java同步机制中重要的组成部分. 结合与synchronized关键字使用**, 可以建立很多优秀的同步模型.
**synchronized(this){ }等价于publicsynchronized void method(){.....}**
**同步分为类级别和对象级别, 分别对应着类锁和对象锁**. 类锁是每个类只有一个, 如果static的方法被synchronized关键字修饰, 则在这个方法被执行前必须获得类锁; 对象锁类同.
首先, 调用一个Object的wait与notify/notifyAll的时候, 必须保证调用代码对该Object是同步的, 也就是说必须在作用等同于synchronized(obj){......}的内部才能够去调用obj的wait与notify/notifyAll三个方法, 否则就会报错:`  java.lang.IllegalMonitorStateException:current thread not owner`
***在调用wait的时候, 线程自动释放其占有的对象锁, 同时不会去申请对象锁.当线程被唤醒的时候，它才再次获得了去获得对象锁的权利***.
所以, notify与notifyAll没有太多的区别, 只是notify仅唤醒一个线程并允许它去获得锁, notifyAll是唤醒所有等待这个对象的线程并允许它们去获得对象锁, 只要是在synchronied块中的代码, 没有对象锁是寸步难行的. 其实唤醒一个线程就是重新允许这个线程去获得对象锁并向下运行.
notifyAll, 虽然是对每个wait的对象都调用一次notify, 但是这个还是有顺序的, 每个对象都保存这一个等待对象链, 调用的顺序就是这个链的顺序. 其实启动等待对象链中各个线程的也是一个线程, 在具体应用的时候, 需要注意一下.
**wait(), notify(), notifyAll()不属于Thread类, 而是属于Object基础类, 也就是说每个对像都有wait(), notify(), notifyAll()的功能. 因为都个对像都有锁, 锁是每个对像的基础, 当然操作锁的方法也是最基础了**.

>**wait():**
等待对象的同步锁, 需要获得该对象的同步锁才可以调用这个方法, 否则编译可以通过, 但运行时会收到一个异常: IllegalMonitorStateException.
调用任意对象的 wait() 方法导致该线程阻塞, 该线程不可继续执行, 并且该对象上的锁被释放.
**notify():**
唤醒在等待该对象同步锁的线程(只唤醒一个, 如果有多个在等待), 注意的是在调用此方法的时候, 并不能确切的唤醒某一个等待状态的线程, 而是由JVM确定唤醒哪个线程, 而且不是按优先级.
调用任意对象的notify()方法则导致因调用该对象的 wait()方法而阻塞的线程中随机选择的一个解除阻塞(但要等到获得锁后才真正可执行).
**notifyAll():**
唤醒所有等待的线程, 注意唤醒的是notify之前wait的线程, 对于notify之后的wait线程是没有效果的.

通常, 多线程之间需要协调工作: 如果条件不满足, 则等待; 当条件满足时, 等待该条件的线程将被唤醒. 在Java中, 这个机制的实现依赖于wait/notify. 等待机制与锁机制是密切关联的.例如:
```java
　　synchronized(obj) {
　　　　while(!condition) {
　　　　    obj.wait();
　　       }
　　       obj.doSomething();
　　}
```
当线程A获得了obj锁后, 发现条件condition不满足, 无法继续下一处理, 于是线程A就wait(). 在另一线程B中, 如果B更改了某些条件, 使得线程A的condition条件满足了, 就可以唤醒线程A:
```java
　　synchronized(obj) {
　　    condition = true;
　　    obj.notify();
　　}
```
需要注意的概念是:
**1. 调用obj的wait(), notify()方法前, 必须获得obj锁, 也就是必须写在synchronized(obj){...} 代码段内**.
**2. 调用obj.wait()后, 线程A就释放了obj的锁, 否则线程B无法获得obj锁, 也就无法在synchronized(obj){...} 代码段内唤醒A**.
**3. 当obj.wait()方法返回后, 线程A需要再次获得obj锁, 才能继续执行**.
**4. 如果A1, A2, A3都在obj.wait(), 则B调用obj.notify()只能唤醒A1, A2, A3中的一个(具体哪一个由JVM决定)**.
**5. obj.notifyAll()则能全部唤醒A1, A2, A3, 但是要继续执行obj.wait()的下一条语句, 必须获得obj锁, 因此, A1,A2,A3只有一个有机会获得锁继续执行, 例如A1, 其余的需要等待A1释放obj锁之后才能继续执行**.
**6. 当B调用obj.notify/notifyAll的时候, B正持有obj锁, 因此, A1, A2, A3虽被唤醒, 但是仍无法获得obj锁. 直到B退出synchronized块, 释放obj锁后, A1, A2, A3中的一个才有机会获得锁继续执行**.


##### 谈一下synchronized和wait()、notify()等的关系:
1. 有synchronized的地方不一定有wait, notify
2. 有wait, notify的地方必有synchronized. 这是因为wait和notify不是属于线程类, 而是每一个对象都具有的方法, 而且, 这两个方法都和对象锁有关, 有锁的地方, 必有synchronized.
另外, 注意一点: 如果要把notify和wait方法放在一起用的话, 必须先调用notify后调用wait, 因为如果调用完wait, 该线程就已经不是currentthread了.



#### 多线程JUC框架
待续...



---
ref:
1.[Java多线程之wait(),notify(),notifyAll()](https://blog.csdn.net/oracle_microsoft/article/details/6863662),   2.[java wait用法详解](https://blog.csdn.net/superjunenaruto/article/details/58315357),   3.[Java 线程的6种状态](https://blog.csdn.net/sinat_36265222/article/details/78249503),   4.[**Java线程的6种状态及切换(透彻讲解)**](https://blog.csdn.net/pange1991/article/details/53860651),   5.[**Java中的多线程你只要看这一篇就够了**](https://www.cnblogs.com/wxd0108/p/5479442.html),   6.[JAVA多线程及线程状态转换](https://www.cnblogs.com/nwnu-daizh/p/8036156.html),   7.[**Java多线程学习之wait、notify/notifyAll 详解**](https://www.cnblogs.com/moongeek/p/7631447.html),   8.[Java wait() notify()方法使用实例讲解](https://blog.csdn.net/zhaoheng2017/article/details/78409404),   9.[**Java多线程之wait(),notify(),notifyAll()**](https://blog.csdn.net/oracle_microsoft/article/details/6863662),   10.[**java wait用法详解**](https://blog.csdn.net/superjunenaruto/article/details/58315357)