### Java可变参数的使用及注意事项
***
在 Java5 中提供了变长参数(var args), 也就是在方法定义中可以使用个数不确定的参数, 对于同一方法可以使用不同个数的参数调用, 例如`print("hello");` `print("hello","lisi");` `print("hello","张三", "alexia");`下面介绍如何定义可变长参数 以及如何使用可变长参数.

##### 可变长参数的定义和调用
使用...表示可变长参数, 例如

```java
print(String... args){
   ...
}
```
在具有可变长参数的方法中可以**把参数当成数组使用**, 例如可以循环输出所有的参数值.
```java
print(String... args){
   for(String temp:args)
      System.out.println(temp);
}
```
**调用可变长参数方法的时候可以给出任意多个参数也可不给参数**, 例如:

```java
print();
print("hello");
print("hello","lisi");
print("hello","张三", "alexia")
```



##### 可变长参数的使用规则
1.在调用方法的时候, **如果能够和固定参数的方法匹配, 也能够与可变长参数的方法匹配,则选择固定参数的方法**. 看下面代码的输出: 

```java
public class VarArgsTest {
    public void print(String... args) {
        for (int i = 0; i < args.length; i++) {
            out.println(args[i]);
        }
    }
    
    public void print(String test) {
        out.println("----------");
    }
    
    public static void main(String[] args) {
        VarArgsTest test = new VarArgsTest();
        test.print("hello");
        test.print("hello", "alexia");
    }
}
```

2.如果要调用的方法可以和两个可变参数匹配, 则出现错误, 例如下面的代码:
```java
public class VarArgsTest1 {

    public void print(String... args) {
        for (int i = 0; i < args.length; i++) {
            out.println(args[i]);
        }
    }
    
    public void print(String test,String...args ){
          out.println("----------");
    }
    
    public static void main(String[] args) {
        VarArgsTest1 test = new VarArgsTest1();
        test.print("hello");
        test.print("hello", "alexia");
    }
}
```
对于上面的代码, main方法中的两个调用都不能编译通过, 因为编译器不知道该选哪个方法调用, 如下所示:

3.**一个方法只能有一个可变长参数, 并且这个可变长参数必须是该方法的最后一个参数**

```java
 // 以下两种方法定义都是错误的。
 public void test(String... strings,ArrayList list){

 }
 public void test(String... strings,ArrayList... list){

 }
```

4.**可变长参数的使用规范**
1. *避免带有可变长参数的方法重载* : 如1中, 编译器虽然知道怎么调用, 但人容易陷入调用的陷阱及误区

2. 别让null值和空值威胁到变长方法, 如2中所示, 为了说明null值的调用, 重新给出一个例子:

```java
public class VarArgsTest1 {
    public void print(String test, Integer... is) {
    }
    
    public void print(String test,String...args ){
    }
    
    public static void main(String[] args) {
        VarArgsTest1 test = new VarArgsTest1();
        test.print("hello");
        test.print("hello", null);
    }
}
```
这时会发现两个调用编译都不通过, 因为两个方法都匹配, 编译器不知道选哪个, 于是报错了, 这里同时还有个非常不好的编码习惯, 即调用者隐藏了实参类型, 这是非常危险的, 不仅仅调用者需要"猜测"该调用哪个方法, 而且被调用者也可能产生内部逻辑混乱的情况. 对于本例来说应该做如下修改: 
```java
// 但是其实这个还是会报java.lang.NullPointerException
public static void main(String[] args) {
    VarArgsTest1 test = new VarArgsTest1();
    String[] strs = null;
    test.print("hello", strs);
}
```

3. 覆写变长方法也要循规蹈矩, 查看如下例子
```java
public class VarArgsTest2 {
    public static void main(String[] args) {
        // 向上转型
        Base base = new Sub();
        base.print("hello");
        
        // 不转型
        Sub sub = new Sub();
        sub.print("hello");
    }
}

// 基类
class Base {
    void print(String... args) {
        System.out.println("Base......test");
    }
}

// 子类，覆写父类方法
class Sub extends Base {
    @Override
    void print(String[] args) {
        System.out.println("Sub......test");
    }
}
```
**第一个能编译通过, 第二个编译无法通过**, 这是为什么呢? 事实上，base对象把子类对象sub做了向上转型, 形参列表是由父类决定的, 当然能通过. 而看看子类直接调用的情况, 这时编译器看到子类覆写了父类的print方法, 因此肯定使用子类重新定义的print方法, 尽管参数列表不匹配也不会跑到父类再去匹配下, 因为找到了就不再找了, 因此有了类型不匹配的错误. *这是个特例, 覆写的方法参数列表竟然可以与父类不相同, 这违背了覆写的定义, 并且会引发莫名其妙的错误.* **覆写的时候,子类覆写方法的签名(名称和参数列表)与父类方法的签名保持一致**.
>这里，总结下覆写必须满足的条件:
>  1.重写方法不能缩小访问权限;
>  2.参数列表必须与被重写方法相同(包括显示形式);
>  3.返回类型必须与被重写方法的相同或是其子类;
>  4.重写方法不能抛出新的异常, 或者超过了父类范围的异常, 但是可以抛出更少,更有限的异常,或者不抛出异常.

5.**不仅可以定义可变参数的方法, 还可以定义可变参数的构造函数,**
**不仅可以定义可变参数的方法, 还可以定义可变参数的构造函数,  构造函数中的可变参数, 就使用包装它的参数的容器---"数组", 来承接所有的可变参数, 使用如下**:
```java
/*方法名称相同, 参数列表不同, 可变参数和非可变参数的方法*/
public class VarParam {
    @Getter
    @Setter
    private String girl;
    @Getter
    @Setter
    private String[] args;

    VarParam() {
    }

    VarParam(String girl) {
        this.girl = girl;
    }

    // 可变参数在构造器之中的使用
    VarParam(String girl, String... args) {
        this.girl = girl;
        this.args = args;
    }

    public static void main(String[] args) {
        //当有多个同名的函数, 其中一个是可变参数的函数, 首选固定参数的函数
        VarParam vp = new VarParam();
        vp.test("张三!");
        vp.test("李四");
        vp.test("李四", "张三!");

        //一个函数只能有一个可变参数, 而且必须放在最后一个位置
        VarParam magicQ = new VarParam("magicQ");
        magicQ.getGirlInfo(36, "35C", "174CM", "越南胡志明");

        //测试可变参数为null的情况, 返回java.lang.NullPointerException
        //VarParam testNull = new VarParam("faker beauty");
        //testNull.getGirlInfo(36, null);
        //String[] strs = null;
        //testNull.getGirlInfo(36, strs);


        //构造函数可变参数
        VarParam milkTea = new VarParam("奶茶妹妹", "20A", "165cm", "江苏南京", "京东");
        milkTea.printGirlInfo();
    }

    public void test(String name) {
        System.out.println(name);
        System.out.println("----------");
    }

    public void test(String... names) {
        StringBuilder sb = new StringBuilder();
        for (String s : names) {
            sb.append(s + ", ");
        }
        System.out.println(sb.toString().substring(0, sb.length() - 2));
    }


    public void getGirlInfo(Integer girlAge, String... args) {
        System.out.print("\ngirl' name is: " + this.getGirl() + ", ");
        System.out.print("girl' age is: " + girlAge + ", ");
        StringBuilder sb = new StringBuilder();
        for (String s : args) {
            sb.append(s + ", ");
        }
        System.out.println("girl's other info :" + sb.toString().substring(0, sb.length() - 2));
    }

    // 一个函数只能有一个可变参数, 而且必须放在最后一个位置, 如下的写法是错误的
    // public void getGirlInfo2(String girl, String... args, Integer... others) {
    //
    // }

    public void printGirlInfo() {
        System.out.println("\ngirl' name is: " + this.getGirl() + ", girl's other info :" + Arrays.deepToString(this.getArgs()));
    }
}
```

最后, 给出一个有陷阱的例子, 大家应该知道输出结果:
```java
public class VarArgsTest {
    public static void m1(String s, String... ss) {
        for (int i = 0; i < ss.length; i++) {
            System.out.println(ss[i]);
        }
    }

    public static void main(String[] args) {
        m1("");
        m1("aaa");
        m1("aaa", "bbb");
    }
}
```



ref:
1.[Java中可变长参数的使用及注意事项](https://www.cnblogs.com/lanxuezaipiao/p/3190673.html),   2.[深入了解JAVA可变长度的参数(Varargs)](https://www.cnblogs.com/uptownBoy/articles/1698335.html)