### idea多线程Debug
---

多线程的开发，就需要多线程调试， 如何进行多线程调试呢？以下是一个小Demo来演示多线程的Debug调试：
```java
public class LockDemoReetrantLock{
     private int i=0;
     private ReentrantLock reentrantLock=new ReentrantLock();
     public void inCreate(){
     // 断点   
         reentrantLock.lock();
         try{
             i++;
     }finally {
            //注意：一般的释放锁的操作都放到finally中，
            // 多线程可能会出错而停止运行，如果不释放锁其他线程都不会拿到该锁
            reentrantLock.unlock();
        }
    }
    public static void main(String[] args){
        ReentrantLock lock = new ReentrantLock();
        lock.lock();
        LockDemoReetrantLock lockDemoReetrantLock = new LockDemoReetrantLock();
        for(int i=0;i<3;i++){
            new Thread(()->{
                    lockDemoReetrantLock.inCreate();
                }).start();
        }
    }
}
```



#### 普通的调试
<img src="../../images/ideadebug01.png" alt="img" style="zoom:150%;" />

开始刚一执行此时，i=2

<img src="../../images/ideadebug02.png" alt="img" style="zoom:150%;" />

接着下一步下一步，程序直接跳出 看不到ReentrantLock的排队操作，再次运行，在进行一次调试此时i=1

<img src="../../images/ideadebug03.png" alt="img" style="zoom:150%;" />

同样看不到排队操作，不是我们想要的结果！！达不到想要的效果！！！



#### 多线程调试
**关键关键关键来了！**我们需要将断点阻塞设置成针对线程的, 而非全局的, 有两种方式可以设置, 推荐第**②**种，更加方便！
##### ①.运行Debug, 其它两个线程就已经启动了，其中有一个线程能够停止到这个断点，选择Debug栏的所有断点，选择到我们需要设置的断点， 然后将将suspend从All修改成Thread， 然后点Done，此时就Ok了。

![img](../../images/ideadebug04.png)

##### ②.我们在代码侧边栏，设置断点，然后打上断点，右键红色小断点，然后将suspend从All修改成Thread， 然后点Done，可以设置成全局都是Thread， 否则相关的代码断点可能会跳过，因此就需要重新去设置。点击Done后就完成了设置。***推荐使用这种方式，简单明了，一目了然。***

![img](../../images/ideadebug05.png)


**注意**：我们开启程序后，进入到相关的线程，就会在断点上打到，如果现在运行的不是这个线程，那么久不会在这个断点上面打钩， 只有运行到上面，才会打钩。

![img](../../images/ideadebug06.png)

![img](../../images/ideadebug07.png)

开始单步调试执行，会有如下提示查看Frames：

![img](../../images/ideadebug08.png)

查看Frames, 选择我们想要调试的线程：

![img](../../images/ideadebug09.png)

此时效果如下，我们就可以开始多线程的调试了：

![img](../../images/ideadebug10.png)



#### 多线程调试案例
<img src="../../images/ideadebug11.png" alt="img" style="zoom:150%;" />

开始调试， 单步执行

![img](../../images/ideadebug12.png)

<img src="../../images/ideadebug13.png" alt="img" style="zoom:150%;" />

接下来我们看第二个线程是否获得锁，点入该线程(012线程顺序是随机的)

<img src="../../images/ideadebug14.png" alt="img" style="zoom:150%;" />

F8显示未挂起的线程不可用 该线程没能获取到该锁（同理Thread2也不能获取该锁）

<img src="../../images/ideadebug15.png" alt="img" style="zoom:150%;" />

线程1和2 wait 线程0和主线程running，线程1和2都在等待资源

<img src="../../images/ideadebug16.png" alt="img" style="zoom: 200%;" />

接下来看ReetrantLock 的执行过程，重新启动

<img src="../../images/ideadebug17.png" alt="img" style="zoom:200%;" />

此时3个线程都停留在这

![img](../../images/ideadebug18.png)

此时跳入inCreat方法

![img](../../images/ideadebug19.png)

再跳进到lock方法中去  进入到非公平锁的实现

![img](../../images/ideadebug20.png)

F8首先执行CAS

![img](../../images/ideadebug21.png)

其他线程就不会执行

![img](../../images/ideadebug22.png)

![img](../../images/ideadebug23.png)

此时由于是线程0先执行的，我们再开一下线程1（012执行顺序是随机的这里假定0先执行），接下来看线程1

![img](../../images/ideadebug24.png)

![img](../../images/ideadebug25.png)

![img](../../images/ideadebug26.png)

![img](../../images/ideadebug27.png)

之后执行acquire方法

![img](../../images/ideadebug28.png)

![img](../../images/ideadebug29.png)

再跳

![img](../../images/ideadebug30.png)

![img](../../images/ideadebug31.png)

![img](../../images/ideadebug32.png)

![img](../../images/ideadebug33.png)

![img](../../images/ideadebug34.png)

跳进去

![img](../../images/ideadebug35.png)

![img](../../images/ideadebug36.png)

![img](../../images/ideadebug37.png)

此时addWaiter执行完毕

<img src="../../images/ideadebug38.png" alt="img" style="zoom: 200%;" />

接着执行acquireQueued方法

![img](../../images/ideadebug39.png)

<img src="../../images/ideadebug40.png" alt="img" style="zoom:200%;" />

![img](../../images/ideadebug41.png)

![img](../../images/ideadebug42.png)

![img](../../images/ideadebug43.png)

![img](../../images/ideadebug44.png)

同理线程2也这样

![img](../../images/ideadebug45.png)

<img src="../../images/ideadebug46.png" alt="img" style="zoom:200%;" />

执行tryRelease方法

<img src="../../images/ideadebug47.png" alt="img" style="zoom:200%;" />

![img](../../images/ideadebug48.png)

![img](../../images/ideadebug49.png)

tryRelease方法执行成功

![img](../../images/ideadebug50.png)

执行完成之后就会唤醒其他线程

![img](../../images/ideadebug51.png)

![img](../../images/ideadebug52.png)

![img](../../images/ideadebug53.png)

该线程执行完毕。接着查看其他线程（1，2）

![img](../../images/ideadebug54.png)



---
ref:
1.[多线程——多线程debug调试](https://blog.csdn.net/qq_29235677/article/details/88186308)