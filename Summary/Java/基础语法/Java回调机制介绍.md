###Java回调机制

***

#####回调机制
在一个应用系统中，无论使用何种语言开发，必然存在模块之间的调用，调用的方式分为几种：
1.**同步调用**
![img](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_tbdy.jpg)

同步调用是最基本并且最简单的一种调用方式，类A的方法a()调用类B的方法b()，一直等待b()方法执行完毕，a()方法继续往下走。**这种调用方式适用于方法b()执行时间不长的情况**，因为b()方法执行时间一长或者直接阻塞的话，a()方法的余下代码是无法执行下去的，这样会造成整个流程的阻塞。

2.**异步调用**
![img](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_ybdy.jpg)

*异步调用是为了解决同步调用可能出现阻塞，导致整个流程卡住而产生的一种调用方式*。**类A的方法方法a()通过新起线程的方式调用类B的方法b()，代码接着直接往下执行**，这样无论方法b()执行时间多久，都不会阻塞住方法a()的执行。但是这种方式，由于方法a()不等待方法b()的执行完成，在方法a()需要方法b()执行结果的情况下（视具体业务而定，有些业务比如启异步线程发个微信通知、刷新一个缓存这种就没必要），必须通过一定的方式对方法b()的执行结果进行监听。在Java中，可以使用Future+Callable的方式做到这一点，具体做法可以参见文章[Java多线程21：多线程下其他组件之CyclicBarrier、Callable、Future和FutureTask](http://www.cnblogs.com/xrq730/p/4872722.html)。

3.**回调**：如下图所示，回调是一种**双向**的调用方式，其实而言，回调也有同步和异步之分，讲解中是同步回调，第二个例子使用的是异步回调
![img](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_hdsx.jpg)
回调的思想是:
- **类A的a()方法调用类B的b()方法**
- **类B的b()方法执行完毕主动调用类A的callback()方法**

通俗而言: 就是A类中调用B类中的某个方法C，然后B类中反过来调用A类中的方法D，D这个方法就叫回调方法，这样子说你是不是有点晕晕的，其实我刚开始也是这样不理解，看了人家说比较经典的回调方式：
- class A实现接口CallBack callback——**背景1**
- class A中包含一个class B的引用b ——**背景2**
- class B有一个参数为callback的方法f(CallBack callback) ——**背景3**
- A的对象a调用B的方法 f(CallBack callback) ——A类调用B类的某个方法 C
- 然后b就可以在f(CallBack callback)方法中调用A的方法 ——B类调用A类的某个方法D



##### 回调的种类
回调分为同步回调和异步回调, 假如以买彩票的场景来模拟, **我买彩票, 调用彩票网,给我返回的结果确定是否中奖**,同步回调就是,我买了彩票之后, 需要等待彩票网给我返回的结果, 这个时候我不能做其他事情, 我必须等待这个结果, 这就叫同步回调, **同步, 就意味着等待, 我不能去做其他事情, 必须等待**,  异步回调就是, 我买了彩票之后, 可以去做其他事情, 然后当彩票网有了结果和消息, 再给我返回消息, 其中最明显的方式就是在得到彩票结果的函数之中, 添加一个其他的方法, 如果我的其他方法可以立即执行, 那么就是异步的(**给出是否中奖需要花费很长的时间**), 而在测试函数之中, 前后两个, 那是发生在测试函数的线程之中的, 肯定是一前一后按照次序的, 在这个地方不是显示同步异步的地点.



#####同步回调
接下来看一下回调的代码示例，代码模拟的是这样一种场景：老师问学生问题，学生思考完毕回答老师。
首先定义一个回调接口，只有一个方法tellAnswer(int answer)，即学生思考完毕告诉老师答案：

```JAVA
1 /**
2  * 回调接口，原文出处http://www.cnblogs.com/xrq730/p/6424471.html
3  */
4 public interface Callback {
5
6     public void tellAnswer(int answer);
7
8 }
```

定义一个老师对象，实现Callback接口：

```JAVA
 1 /**
 2  * 老师对象，原文出处http://www.cnblogs.com/xrq730/p/6424471.html
 3  */
 4 public class Teacher implements Callback {
 5
 6     private Student student;
 7
 8     public Teacher(Student student) {
 9         this.student = student;
10     }
11     /**此处没有多线程, 这说明虽然是回调方式, 但是还是同步的**/
12     public void askQuestion() {
13         student.resolveQuestion(this);
14     }
15
16     @Override
17     public void tellAnswer(int answer) {
18         System.out.println("知道了，你的答案是" + answer);
19     }
20
21 }
```

老师对象有两个public方法：
- 回调接口tellAnswer(int answer)，即学生回答完毕问题之后，老师要做的事情
- 问问题方法askQuestion()，即向学生问问题
接着定义一个学生接口，学生当然是解决问题，但是接收一个Callback参数，这样学生就知道解决完毕问题向谁报告：
```JAVA
1 /**
2  * 学生接口，原文出处http://www.cnblogs.com/xrq730/p/6424471.html
3  */
4 public interface Student {
5
6     public void resolveQuestion(Callback callback);
7
8 }
```
最后定义一个具体的学生叫Ricky：
```java
 1 /**
 2  * 一个名叫Ricky的同学解决老师提出的问题，原文出处http://www.cnblogs.com/xrq730/p/6424471.html
 3  */
 4 public class Ricky implements Student {
 5
 6     @Override
 7     public void resolveQuestion(Callback callback) {
 8         // 模拟解决问题
 9         try {
10             Thread.sleep(3000);
11         } catch (InterruptedException e) {
12
13         }
14
15         // 回调，告诉老师作业写了多久
16         callback.tellAnswer(3);
17     }
18
19 }
```
在解决完毕问题之后，第16行向老师报告答案。测试类如下：
```java
 1 /**
 2  * 回调测试，原文出处http://www.cnblogs.com/xrq730/p/6424471.html
 3  */
 4 public class CallbackTest {
 5
 6     @Test
 7     public void testCallback() {
 8         Student student = new Ricky();
 9         Teacher teacher = new Teacher(student);
10
11         teacher.askQuestion();
12
13     }
14
15 }
```
代码运行结果就一行：
```java
知道了，你的答案是3
```
简单总结、分析一下这个例子就是：
- 老师调用学生接口的方法resolveQuestion，向学生提问
- 学生解决完毕问题之后调用老师的回调方法tellAnswer, **这样一套流程，构成了一种双向调用的关系**



##### 代码分析
1.分析一下上面的代码，上面的代码我这里做了两层的抽象：
-     **将老师进行抽象**: 将老师进行抽象之后，对于学生来说，就不需要关心到底是哪位老师询问我问题，只要我根据询问的问题，得出答案，然后告诉提问的老师就可以了，即使老师换了一茬又一茬，对我学生而言都是没有任何影响的
-     **将学生进行抽象**: 将学生进行抽象之后，对于老师这边来说就非常灵活，因为老师未必对一个学生进行提问，可能同时对Ricky、Jack、Lucy三个学生进行提问，这样就可以将成员变量Student改为List<Student>，这样在提问的时候遍历Student列表进行提问，然后得到每个学生的回答即可

这个例子是一个典型的体现接口作用的例子，总结起来，**回调的核心就是回调方将本身即this传递给调用方**，这样调用方就可以在调用完毕之后告诉回调方它想要知道的信息。回调是一种思想、是一种机制，至于具体如何实现，如何通过代码将回调实现得优雅、实现得可扩展性比较高，一看开发者的个人水平，二看开发者对业务的理解程度。

2.同步回调与异步回调
上面的例子，可能有人会提出这样的疑问：
>这个例子需要用什么回调啊，使用同步调用的方式，学生对象回答完毕问题之后直接把回答的答案返回给老师对象不就好了？

这个问题的提出没有任何问题，可以从两个角度去理解这个问题:
1. 老师不仅仅想要得到学生的答案怎么办？可能这个老师是个更喜欢听学生解题思路的老师，在得到学生的答案之前，老师更想先知道学生姓名和学生的解题思路，当然有些人可以说，那我可以定义一个对象，里面加上学生的姓名和解题思路不就好了。这个说法在我看来有两个问题：
  - 如果老师想要的数据越来越多，那么返回的对象得越来越大，而使用回调则可以进行数据分离，将一批数据放在回调方法中进行处理，至于哪些数据依具体业务而定，如果需要增加返回参数，直接在回调方法中增加即可
  - 无法解决老师希望得到学生姓名、学生解题思路先于学生回答的答案的问题
  
  因此我认为简单的返回某个结果确实没有必要使用回调而可以直接使用同步调用，但是如果**有多种数据需要处理且数据有主次之分**，使用回调会是一种更加合适的选择，优先处理的数据放在回调方法中先处理掉。
2. 一个理解的角度则更加重要，就是标题说的同步回调和**异步回调**了。例子是一个同步回调的例子，意思是老师向Ricky问问题，Ricky给出答案，老师问下一个同学，得到答案之后继续问下一个同学，这是一种正常的场景，但是如果我把场景改一下：
> 老师并不想One-By-One这样提问，而是同时向Ricky、Mike、Lucy、Bruce、Kate五位同学提问，让同学们自己思考，哪位同学思考好了就直接告诉老师答案即可。

这种场景相当于是说，同学思考毕完毕问题要有一个办法告诉老师，有两个解决方案：
  1.  使用Future+Callable的方式，等待异步线程执行结果，这相当于就是同步调用的一种变种，因为其本质还是方法返回一个结果，即学生的回答
  2.  使用异步回调，同学回答完毕问题，调用回调接口方法告诉老师答案即可。由于老师对象被抽象成了Callback接口，因此这种做法的扩展性非常好，就像之前说的，即使老师换了换了一茬又一茬，对于同学来说，只关心的是调用Callback接口回传必要的信息即可



##### 异步回调
使用打电话的例子来讲解回调(异步加回调)，背景：有一天小王遇到一个很难的问题，问题是“1 + 1 = ?”，就打电话问小李，小李一下子也不知道，就跟小王说，等我办完手上的事情，就去想想答案，小王也不会傻傻的拿着电话去等小李的答案吧，于是小王就对小李说，我还要去逛街，你知道了答案就打我电话告诉我，于是挂了电话，自己办自己的事情，过了一个小时，小李打了小王的电话，告诉他答案是2
```java
/**
 * 这是一个回调接口
 * @author xiaanming
 *
 */
public interface CallBack {
    /**
     * 这个是小李知道答案时要调用的函数告诉小王，也就是回调函数
     * @param result 是答案
     */
    public void solve(String result);
}
```

```java
/**
 * 这个是小王
 * @author xiaanming
 * 实现了一个回调接口CallBack，相当于----->背景一
 */
public class Wang implements CallBack {
    /**
     * 小李对象的引用
     * 相当于----->背景二
     */
    private Li li;

    /**
     * 小王的构造方法，持有小李的引用
     * @param li
     */
    public Wang(Li li){
        this.li = li;
    }

    /**
     * 小王通过这个方法去问小李的问题
     * @param question  就是小王要问的问题,1 + 1 = ?
     */
    //此处添加了多线程, 成为异步调用了,
    public void askQuestion(final String question){
        //这里用一个线程就是异步，
        new Thread(new Runnable() {
            @Override
            public void run() {
                /**
                 * 小王调用小李中的方法，在这里注册回调接口
                 * 这就相当于A类调用B的方法C
                 */
                li.executeMessage(Wang.this, question);
            }
        }).start();
        //小网问完问题挂掉电话就去干其他的事情了，诳街去了
        play();
    }

    public void play(){
        System.out.println("我要逛街去了");
    }

    /**
     * 小李知道答案后调用此方法告诉小王，就是所谓的小王的回调方法 
     */
    @Override
    public void solve(String result) {
        System.out.println("小李告诉小王的答案是--->" + result);
    }

}
```

```java
/**
 * 这个就是小李啦
 * @author xiaanming
 *
 */
public class Li {
    /**
     * 相当于B类有参数为CallBack callBack的f()---->背景三
     * @param callBack
     * @param question  小王问的问题
     */
    public void executeMessage(CallBack callBack, String question){
        System.out.println("小王问的问题--->" + question);

        //模拟小李办自己的事情需要很长时间
        for(int i=0; i<10000;i++){

        }

        /**
         * 小李办完自己的事情之后想到了答案是2 
         */
        String result = "答案是2";
        /**
         * 于是就打电话告诉小王，调用小王中的方法
         * 这就相当于B类反过来调用A的方法D
         */
        callBack.solve(result);

    }

}
```

```java
/**
 * 测试类
 * @author xiaanming
 *
 */
public class Test {
    public static void main(String[]args){
        /**
         * new 一个小李
         */
        Li li = new Li();

        /**
         * new 一个小王
         */
        Wang wang = new Wang(li);

        /**
         * 小王问小李问题
         */
        wang.askQuestion("1 + 1 = ?");
    }
}
```



ref:
1.[Java回调机制解读](http://www.cnblogs.com/xrq730/p/6424471.html), 2.[一个经典例子让你彻彻底底理解java回调机制](http://blog.csdn.net/xiaanming/article/details/8703708/), 3.[JAVA回调机制(CallBack)详解](http://www.cnblogs.com/heshuchao/p/5376298.html), 4.[JAVA回调机制(CallBack)详解](http://www.importnew.com/19301.html), 5.[Java多线程21：多线程下的其他组件之CyclicBarrier、Callable、Future和FutureTask](http://www.cnblogs.com/xrq730/p/4872722.html)


