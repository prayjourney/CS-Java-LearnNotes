###  单元测试与JUnit

- - -
1.**单元测试**：
> ==单元测试==是软件之中对于最小的功能模块的的测试，其可以对最基本的软件构成单元来测试。
> 需要注意的是：
>
> >**测试用例是用来达到测试想要的预期结果，而不能测试出程序的逻辑错误**。


2.**JUnit**:
>1.**Junit是基于断言机制的**。是用于编写可复用测试集的简单框架，是xUnit的一个子集。xUnit是一套基于测试驱动开发的测试框架，有PythonUnit、CppUnit、JUnit等。
>2.Junit测试是程序员测试，即所谓白盒测试，因为程序员知道被测试的软件如何（How）完成功能和完成什么样（What）的功能。
>3.多数Java的开发环境都已经集成了JUnit作为单元测试的工具，比如Eclipse，IDEA，如在IDEA之中，使用JunitGenerator可以方便地进行单元测试。

3.**使用测试工具的优点**：
  - 测试框架可以帮助我们对编写的程序进行有目的地测试，帮助我们最大限度地避免代码中的bug，以保证系统的正确性和稳定性。
  - 使用main方法，然后sysout输出控制台观察结果，这样非常枯燥繁琐，不规范。并且**测试方法不能一起运行，测试结果要程序员本人才可以判断程序逻辑是否正确**。
  - JUnit的断言机制，可以直接将我们的预期结果和程序运行的结果进行一个比对，确保对结果的可预知性。

4.**JUnit最佳实践**:
  - ①测试方法上必须使用@Test进行修饰
  - ②测试方法必须使用public void 进行修饰，不能带任何的参数
  - ③源代码与测试代码不在同一目录，即**测试代码和项目业务代码分离**
  - ④测试类所在的包名应该和被测试类所在的包名保持一致
  - ⑤测试单元中的每个方法必须可以独立测试，测试方法间不能有任何的依赖
  - ⑥测试类使用Test作为类名的后缀（不是必须）
  - ⑦测试方法使用test作为方法名的前缀（不是必须）

5.**Junit常用注解**：
  - @Test:将一个普通的方法修饰成为一个测试方法
    - @Test(expected=XX.class)
    - @Test(timeout=毫秒)
  - @BeforeClass：它会在所有的方法运行前被执行，static修饰
  - @AfterClass:它会在所有的方法运行结束后被执行，static修饰
  - @Before：会在每一个测试方法被运行前执行一次
  - @After：会在每一个测试方法运行后被执行一次
  - @Ignore:所修饰的测试方法会被测试运行器忽略
  - @Parameters:参数化测试时，对于测试参数进行配置
  - @RunWith:可以更改测试运行器,==org.junit.runners.JUnit4==是junit4之中默认的运行器，其继承于==org.junit.runners.BlockJUnit4ClassRunner==，常见的运行器有 *@RunWith(Parameterized.class)* 参数化运行器，配合@Parameters使用junit的参数化功能，*@RunWith(Suite.class)
@SuiteClasses({ATest.class,BTest.class,CTest.class})*
测试集运行器配合使用测试集功能*@RunWith(JUnit4.class)*，junit4的默认运行器，*@RunWith(JUnit38ClassRunner.class)*，junit3.8的运行器，还有例如*RunWith(SpringJUnit4ClassRunner.class)*运行器，集成了spring的一些功能。

6.**JUnit测试的类型**：
  - *普通测试*：对于方法使用==@Test==注解标注。
  - *参数化测试*：对于测试类使用==@RunWith (Parameterized.class)==标注，使用==@(Parameter)==来将需要测试的参数，打包到一个集合之中，在后续的测试方法中运行。
  - *套件测试*：当我们需要测试的类很多的时候，如果每个类都独立运行则工作量很大，因此我们可以采用测试套件的方式来测试各个测试类和用例，我们可以使用如下的：
    ==@RunWith(Suite.class)
     @Suite.SuiteClasses({TaskTest1.class,TaskTest2.class,TaskTest3.class})
    public class SuiteTest {
    //此类之中不需要任何的方法

    }[^1]
    ==

- *超时测试*：将@Test之中的(timeout=毫秒)设置一定的值，常用于如IO操作，网络连接等测试。
- *忽略测试*：使用@Ignore注解，将对应的测试类或者测试方法忽略。

7.**JUint断言方法**：

Junit 4 断言方法允许检查测试方法的期望结果值和真实返回值。Junit的org.junit.Assert类提供了各种断言方法来写junit测试。这些方法被用来检查方法的真实结果值和期望值。下列一些有用的断言方法列表：

**Junit 4 Assert Methods**

|            Method                           |  Description        |
|---------------------------------------------|---------------------|
|assertNull(java.lang.Object object)	      | 检查对象是否为空       |
|assertNotNull(java.lang.Object object)	      | 检查对象是否不为空     |
|assertEquals(long expected, long actual)     | 检查long类型的值是否相等 |
|assertEquals(double expected, double actual, double delta)	| 检查指定精度的double值是否相等 |
|assertFalse(boolean condition)	      | 检查条件是否为假       |
|assertTrue(boolean condition)	      | 检查条件是否为真       |
|assertSame(java.lang.Object expected, java.lang.Object actual)| 检查两个对象引用是否引用同一对象（即对象是否相等)|
|assertNotSame(java.lang.Object unexpected, java.lang.Object actual) | 检查条件是否为真|
|assertTrue(boolean condition)	      | 检查两个对象引用是否不引用统一对象(即对象不等) |
至于Assert类，其文档之中介绍如下：
>A set of assertion methods useful for writing tests. Only failed assertions are recorded. These methods can be used directly: Assert.assertEquals(...), however, they read better if they are referenced through static import:
> >import static org.junit.Assert.*;
    ...
    assertEquals(...);

>其最重要的是可以直接调用==Assert.assertEquals(...)==。


8**使用案例**:

==*Area.java*==

```java
    package Task;
   /**
    * Created by renjiaxin on 2017/7/25.
    * 长方形面积
    */
    public class Area {
    private double width;
    private double length;

    public Area(double w, double l) {
        this.width = w;
        this.length = l;
    }

    public void setWidth(double width) {
        this.width = width;
    }

    public void setLength(double length) {
        this.length = length;
    }

    public double getWidth() {
        return width;
    }

    public double getLength() {
        return length;
    }

    public double getArea(double width, double length) {
        return width * length;
    }
   }
```

==*Calcuate.java*==
```java
   package Task;
   /**
   * Created by renjiaxin on 2017/7/25.
   * 四则运算
   */
    public class Calcuate {
    private int a;
    private int b;

    public Calcuate(int a, int b) {
        this.a = a;
        this.b = b;
    }

    public void setA(int a) {
        this.a = a;
    }

    public void setB(int b) {
        this.b = b;
    }

    public int getA() {
        return a;
    }

    public int getB() {
        return b;
    }

    public int addition(int a, int b) {
        return a + b;
    }

    public int subtraction(int a, int b) {
        return a - b;
    }

    public int multiplication(int a, int b) {
        return a * b;
    }

    public int division(int a, int b) throws Exception {
        if (b != 0) {
            return a / b;
        } else {
            throw new Exception("Error，b=0!");
        }
    }
   }

```

==*Perimeter.java*==
```java
    package Task;
    /**
    * Created by renjiaxin on 2017/7/25.
    * 周长
    */
    public class Perimeter {
    private double diameter;

    public Perimeter(double diameter) {
        this.diameter = diameter;
    }

    public double getDiameter() {
        return diameter;
    }

    public void setDiameter(double diameter) {
        this.diameter = diameter;
    }

    public double getPerimeter(double diameter) {
        return 2 * Math.PI * diameter;
    }

}
```

==*Tax.java*==
```java
   package Task;
   /**
   * Created by renjiaxin on 2017/7/25.
   * 税收
   */
    public class Tax {
    private double taxrate;
    private double count;

    public double getTaxrate() {
        return taxrate;
    }

    public void setTaxrate(double taxrate) {
        this.taxrate = taxrate;
    }

    public double getCount() {
        return count;
    }

    public void setCount(double count) {
        this.count = count;
    }

    public double getAllTax() {
        return this.count * this.taxrate;
    }
   }
```

==*AreaTest.java*==
```java
    package ASuiteTestForTask;

    import Task.Area;
    import org.junit.*;
   /**
    * Created by renjiaxin on 2017/7/25.
    */
    public class AreaTest {

    @Before
    public void before() throws Exception {
        System.out.println("开始测试.");
    }

    @After
    public void after() throws Exception {
        System.out.println("测试完成.");
    }

    @Test
    public void testSetWidth() throws Exception {
        //double时，需要指出误差，此处的1即为误差，在此范围内，可以通过
        Area area = new Area(9.6, 12.8);
        area.setWidth(16.2);
        Assert.assertEquals(16, area.getWidth(),1);
    }

    @Test
    public void testGetWidth() throws Exception {
        Area area = new Area(9.6, 12.8);
        Assert.assertEquals(9.6, area.getWidth(),0.01);
    }

    @Test(timeout = 200)
    public void testSetLength() throws Exception {
        //timeout 超时测试
        Thread.sleep(100);
        Area area = new Area(9.6, 12.8);
        area.setLength(11.3);
        Assert.assertEquals(11.3, area.getLength(),0.01);
    }

    @Ignore
    public void testGetLength() throws Exception {
        //忽略测试，将护忽略此方法，如果添加到类上面，将整个忽略此类的方法，
        //可以用来跳过某些失败的测试
        Area area = new Area(9.6, 12.8);
        Assert.assertEquals(12.8, area.getLength(),0.01);
    }

    @Test
    public void testGetArea() throws Exception {
        Area area = new Area(9.6, 12.8);
        Assert.assertEquals(9.6 * 12.8, area.getArea(area.getWidth(), area.getLength()),0.01);
    }
   }
```

==*CalcuateTest.java*==
```java
    package ASuiteTestForTask;

    import Task.Calcuate;
    import org.junit.*;

   /**
    * Created by renjiaxin on 2017/7/25.
    */
    public class CalcuateTest {

    @BeforeClass
    public static void before() throws Exception {
        System.out.println("开始测试.");
    }

    @AfterClass
    public static void after() throws Exception {
        System.out.println("测试完成.");
    }

    @Test
    public void testAddition() throws Exception {
        Calcuate calcuate=new Calcuate(12,10);
        Assert.assertEquals("加法有问题！",22,calcuate.addition(calcuate.getA(),calcuate.getB()));
    }

    @Test
    public void testSubtraction() throws Exception {
        Calcuate calcuate=new Calcuate(12,10);
        Assert.assertEquals("减法有问题！",2,calcuate.subtraction(calcuate.getA(),calcuate.getB()));
    }

    @Test
    public void testMultiplication() throws Exception {
        Calcuate calcuate=new Calcuate(12,10);
        Assert.assertEquals("乘法有问题！",120,calcuate.multiplication(calcuate.getA(), calcuate.getB()));
    }

    @Test(expected = Exception.class)
    public void testDivision() throws Exception {
        Calcuate calcuate1=new Calcuate(12,10);
        Assert.assertEquals("除法有问题！",1,calcuate1.division(calcuate1.getA(), calcuate1.getB()));
        //通过expected来指出可能的错误，如果合适，就可通过测试。
        Calcuate calcuate2=new Calcuate(12,0);
        Assert.assertEquals("除法有问题！",120,calcuate2.division(calcuate2.getA(), calcuate2.getB()));
    }
   }
```

==*PerimeterTest.java*==
```java
    package ASuiteTestForTask;

    import Task.Perimeter;
    import org.junit.Assert;
    import org.junit.Test;
    import org.junit.Before;
    import org.junit.After;

   /**
    * Created by renjiaxin on 2017/7/25.
    */
    public class PerimeterTest {

    Perimeter perimeter;

    @Test
    public void testSetDiameter() throws Exception {
        perimeter=new Perimeter(12);
        perimeter.setDiameter(16);
        Assert.assertEquals(16,perimeter.getDiameter(),0.001);
    }

    @Test
    public void testGetDiameter() throws Exception {
        perimeter=new Perimeter(12);
        Assert.assertEquals(12,perimeter.getDiameter(),0.001);
    }

    @Test
    public void testGetPerimeter() throws Exception {
        perimeter=new Perimeter(12);
        Assert.assertEquals(24*Math.PI,perimeter.getPerimeter(perimeter.getDiameter()),0.001);
    }
   }

```

==*TaxTest.java*==
```java
    package ASuiteTestForTask;

    import Task.Tax;
    import junit.framework.Assert;
    import org.junit.Test;
    import org.junit.Before;
    import org.junit.After;


    public class TaxTest {
    Tax tax=new Tax();

    @Test
    public void testgetTaxrate() {
        tax.setTaxrate(0.2);
        Assert.assertEquals(0.2,tax.getTaxrate(),0.01);
    }

    @Test
    public void testSetTaxrate() {
        tax.setTaxrate(0.2);
        Assert.assertEquals(0.2,tax.getTaxrate(),0.01);
    }

    @Test
    public void testSetCount() {
        tax.setCount(20000);
        Assert.assertEquals(20000,tax.getCount(),1);
    }

    @Test
    public void testGetCount() {
        tax.setCount(20000);
        Assert.assertEquals(19999,tax.getCount(),1);
    }

    @Test
    public void testGetAllTax() {
        tax.setCount(20000);
        tax.setTaxrate(0.17);
        Assert.assertEquals(3500,tax.getAllTax(),199);
    }
   }
```

==*TaskTestSuite.java*== 测试套件
```java
    package ASuiteTestForTask;

    import org.junit.runner.RunWith;
    import org.junit.runners.Suite;

    /**
     * Created by renjiaxin on 2017/7/25.
     * 测试套件，同时可以运行多个测试类
     */
    /*当类被@RunWith注解修饰，或者类继承了一个被该注解修饰的类，
     * JUnit将会使用这个注解所指明的运行器（runner）来运行测试，
     * 而不是JUnit默认的运行器。
     **/
     @RunWith(Suite.class)
     @Suite.SuiteClasses({AreaTest.class, CalcuateTest.class, PerimeterTest.class, TaxTest.class})
     public class TaskTestSuite {
    /*
     * 测试套件就是组织测试类一起运行的
     * 写一个作为测试套件的入口类，这个类里不包含其他的方法
     * 更改测试运行器Suite.class
     * 将要测试的类作为数组传入到Suite.SuiteClasses（{}）
     */
   }
```

==*AreaParameterizedTest.java*== :参数化测试
```java
   package ASuiteTestForTask;

   import Task.Area;
   import org.junit.Assert;
   import org.junit.Test;
   import org.junit.runner.RunWith;
   import org.junit.runners.Parameterized;
   import java.util.Arrays;
   import java.util.Collection;

   /**
    * Created by renjiaxin on 2017/7/25.
    * 参数化测试 Parameterized Test
    */
    // Step 1
    @RunWith(Parameterized.class)
    public class AreaParameterizedTest {
    /*
     * 1.测试类必须由Parameterized测试运行器修饰
     * 2.准备测试所需的数据
     * 3.构造此类的参数化构造器
     * 4.准备需要测试的数据，将其放置在Collection之中
     * 5.创建测试方法
     **/
    // Step 2: variables to be used in test method of Step 5
    private double width;
    private double length;
    private double expected;

    // Step 3: parameterized constructor
    public AreaParameterizedTest(double width, double length, double expected) {
        this.width = width;
        this.length = length;
        this.expected = expected;
    }

    // Step 4: data set of variable values
    @Parameterized.Parameters
    public static Collection preparedData() {
        Object[][] object = {{1, 2, 2}, {4, 6, 24}, {3, 9, 27}, {4, 9, 36}, {2.5, 4, 10}, {12, 1.8, 21.6}};
        return Arrays.asList(object);
    }

    // Step 5: use variables in test code
    @Test
    public void testGetSArea() {
        Area area = new Area(width, length);
        double result = area.getArea(width, length);
        Assert.assertEquals(expected, result, 0.1);
    }
   }
```




Ref:
[junit常用注解详细说明](http://www.cnblogs.com/tobey/p/4837495.html),
[Java单元测试工具：JUnit4（一）——概述及简单例子](http://blog.csdn.net/Zen99T/article/details/50561136),
[Java单元测试工具：JUnit4（二）——JUnit使用详解](http://blog.csdn.net/zen99t/article/details/50603847),
[ Java单元测试工具：JUnit4（三）——JUnit详解之运行流程及常用注解](http://blog.csdn.net/Zen99T/article/details/50569297),
[Java单元测试工具：JUnit4（四）——JUnit测试套件使用及参数化设置](http://blog.csdn.net/Zen99T/article/details/50572373)
[Junit 4 Tutorials(Junit 4 教程) 一、Junit简介及Junit Eclipse 教程](http://blog.csdn.net/luanlouis/article/details/37562165),
[Junit 4 Tutorials(Junit 4 教程) 二、Junit4 注解](http://blog.csdn.net/luanlouis/article/details/37562289),
[Junit 4 Tutorials(Junit 4 教程) 三、Junit4 断言方法](http://blog.csdn.net/luanlouis/article/details/37562777),
[Junit 4 Tutorials(Junit 4 教程) 四、Junit4 参数化测试](http://blog.csdn.net/luanlouis/article/details/37563265),
[Junit 4 Tutorials(Junit 4 教程) 五、测试套件](http://blog.csdn.net/luanlouis/article/details/37564355),
[Junit 4 Tutorials(Junit 4 教程) 六、忽略测试](http://blog.csdn.net/luanlouis/article/details/37565017),
[Junit 4 Tutorials(Junit 4 教程) Junit4 七、超时测试](http://blog.csdn.net/luanlouis/article/details/37565709),

ReadMe[^2]

[^1]:测试套件就是组织测试类一起运行的,写一个作为测试套件的入口类，这个类里不包含其他的方法,更改测试运行器Suite.class ,将要测试的类作为数组传入到Suite.SuiteClasses({}),此处的类命可以随意命名，TaskTestX.class是需要测试的类。
[^2]:本文档和文档之中的代码，都基于JUnit4.
