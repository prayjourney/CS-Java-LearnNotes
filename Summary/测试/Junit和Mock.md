###  Junit和Mock
***

#### Junit4
此处使用的版本是Junit4

##### 概念
**测试用例**: 一个测试方法就是一个测试用例, 测试用例放在一个类之中, 这个类没有特定的名字, 但是一般而言有习惯命名规则, XXXTest, 每个不同的方法, 使用testXXX()的方式来命名.
**测试类**: 用来存放测试用例的类, 这个类没有什么特别的, 不要和后续的测试套件混淆.
**测试套件**:测试套件可以包含很多的测试类, 让测试类之中的测试用例一次性执行,更加方便快捷.
**断言方法**(Assert Methods): 比较测试的方法执行结果值和期望值,然后即可得出所测试的方法的正确性.



##### 单元测试注解
@Test: 将一个普通方法修饰成一个测试方法
- @Test(excepted=xx.class): xx.class表示异常类, 表示测试的方法抛出此异常时, 认为是正常的测试通过的
- @Test(timeout=毫秒数):测试方法执行时间是否符合预期 

@Ignore: 所修饰的测试方法会被测试运行器忽略
@Before: 会在每一个测试方法被运行前执行一次
@After: 在每一个测试方法运行后被执行一次
@BeforeClass: 会在所有的方法执行前被执行，static方法
@AfterClass: 会在所有的方法执行之后进行执行，static方法
@RunWith: 可以更改测试运行器org.junit.runner.Runner



JUnit4 与 JUnit 5 常用注解对比

| JUnit4       | JUnit5             | 说明                                                         |
| ------------ | ------------------ | ------------------------------------------------------------ |
| @Test        | @Test              | 表示该方法是一个测试方法。JUnit5与JUnit 4的@Test注解不同的是，它没有声明任何属性，因为JUnit Jupiter中的测试扩展是基于它们自己的专用注解来完成的。这样的方法会被继承，除非它们被覆盖 |
| @BeforeClass | @BeforeAll         | 表示使用了该注解的方法应该在当前类中所有使用了@Test @RepeatedTest、@ParameterizedTest或者@TestFactory注解的方法之前 执行； |
| @AfterClass  | @AfterAll          | 表示使用了该注解的方法应该在当前类中所有使用了@Test、@RepeatedTest、@ParameterizedTest或者@TestFactory注解的方法之后执行； |
| @Before      | @BeforeEach        | 表示使用了该注解的方法应该在当前类中每一个使用了@Test、@RepeatedTest、@ParameterizedTest或者@TestFactory注解的方法之前 执行 |
| @After       | @AfterEach         | 表示使用了该注解的方法应该在当前类中每一个使用了@Test、@RepeatedTest、@ParameterizedTest或者@TestFactory注解的方法之后 执行 |
| @Ignore      | @Disabled          | 用于禁用一个测试类或测试方法                                 |
| @Category    | @Tag               | 用于声明过滤测试的tags，该注解可以用在方法或类上；类似于TesgNG的测试组或JUnit 4的分类。 |
| @Parameters  | @ParameterizedTest | 表示该方法是一个参数化测试                                   |
| @RunWith     | @ExtendWith        | @Runwith就是放在测试类名之前，用来确定这个类怎么运行的       |
| @Rule        | @ExtendWith        | Rule是一组实现了TestRule接口的共享类，提供了验证、监视TestCase和外部资源管理等能力 |
| @ClassRule   | @ExtendWith        | @ClassRule用于测试类中的静态变量，必须是TestRule接口的实例，且访问修饰符必须为public。 |



##### 注意事项：
- 测试方法必须使用@Test修饰
- 测试方法必须使用**public void**进行修饰，**不能带参数**
- 测试代码的包应该和被测试代码包结构保持一致
- 测试单元中的每个方法必须可以独立测试，方法间不能有任何依赖
- 测试类一般使用Test作为类名的后缀
- 测试方法使一般用test作为方法名的前缀
- 一般使用单元测试会新建一个test目录存放测试代码，在生产部署的时候只需要将test目录下代码删除即可



##### 测试失败说明：
- Failure：一般是由于测试结果和预期结果不一致引发的，表示测试的这个点发现了问题
- error：是由代码异常引起的，它可以产生于测试代码本身的错误，也可以是被测试代码中隐藏的bug



##### 示例:

下面除了没有演示参数化测试之外, 基本都覆盖到了.

```java
/**
 * 用来测试的类
 */
public class Cal4Junit {
    public int add(int a, int b){
        return a+b;
    }
    public int sub(int a ,int b){
        return a-b;
    }
    public int mul(int a, int b){
        return a*b;
    }
    public float div(float a, float b){
        return  a/b;
    }
    public int throwException(int a) throws Exception {
        if (a==1){
            throw new Exception("我是一个测试异常");
        }
        else{
            return 0;
        }
    }
}
```

```java
/**
 * 测试类之中的每个测试用例, 用@Test标注, 最基本的用法.
 */
import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class Cal4JunitTest {
    Cal4Junit cl=new Cal4Junit();

    @Test
    public void testAdd() {
        int ans1=cl.add(5,6);
        assertEquals(11,ans1);
    }

    @Test
    public void testSub(){
        int ans2=cl.sub(22,13);
        assertEquals(9,ans2);
    }

    @Test
    public void testMul(){
        int ans3=cl.mul(6,7);
        assertEquals(42,ans3);
    }

    @Test
    public void testDiv(){
        float ans4=cl.div(4f,2f);
        assertEquals(2f,ans4);
    }
    // java.lang.AssertionError: Use assertEquals(expected, actual, delta) to compare floating-point numbers
    // 貌似不支持double的运算和float的运算?
}
```

```java
/**
 * 使用了测试的注解
 */
import org.junit.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class Cal4JunitAnnotationTest {
    Cal4Junit cl=new Cal4Junit();
    @Before
    public void before123(){
        System.out.println("每一个方法运行之前会运行before123()方法,方法名后加123,是为了显示区别作用!");
    }
    @After
    public void after123(){
        System.out.println("每一个方法运行之后会运行after123()方法,方法名后加123,是为了显示区别作用!");
    }

    @BeforeClass
    public static void beforeClass123(){
        System.out.println("BeforeClass注解, 需要是一个static的方法，在所有测试之前运行");
    }

    @AfterClass
    public static void afterClass123(){
        System.out.println("AfterClass注解, 需要是一个static的方法，在所有测试之后运行");
    }

    @Test(expected = Exception.class)
    public void testThrowException() throws Exception {
        //测试throwException方法是否会出现异常
        int ans1=cl.throwException(1);
        assertEquals(-1,ans1);
    }

    @Test(timeout = 100)
    public void testAdd(){
        //测试Add方法是否能在100ms内完成
        int ans2=cl.add(1,2);
        assertNotNull(ans2);
    }
    @Test(timeout = 100,expected = Exception.class)
    @Ignore
    public void testDiv(){
        //测试Add方法是否能在100ms内完成
        float ans3=cl.div(1f,2f);
        assertNotNull(ans3);
    }
}
```

```java
/**
 * 使用了测试的注解
 * 使用了测试套件
 */
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({Cal4JunitTest.class,Cal4JunitAnnotationTest.class})
public class Cal4JunitTestSuite {
    // 这是一个测试套件, 为了将多个test case组织起来, 不用我们写什么, 只需要按照如上的方式,即可
    /**
     * @RunWith(Suite.class)
     * @Suite.SuiteClasses({ClassA.class, ClassB.class, ClassC.class})
     */
    // 单个的测试类, 叫做一个测试用例
}
```





ref:
1.[Unit4 与 JUnit 5 常用注解对比](https://blog.csdn.net/winteroak/article/details/80591598),   2.[JUnit学习笔记](https://www.cnblogs.com/Peiyuan/articles/511494.html),   3.[Java单元测试初体验(JUnit4)](https://www.cnblogs.com/ysw-go/p/5447056.html),   4.[Junit4单元测试的基本用法](https://www.cnblogs.com/qiyexue/p/6822791.html),   5.[Junit 4 Tutorials(Junit 4 教程) 五、测试套件](https://blog.csdn.net/luanlouis/article/details/37564355),   6.[Junit 4 Tutorials(Junit 4 教程) 四、Junit4 参数化测试](https://blog.csdn.net/luanlouis/article/details/37563265),   7.[Junit 4 Tutorials(Junit 4 教程) 六、忽略测试](https://blog.csdn.net/luanlouis/article/details/37565017),   8.[Junit的基本使用（详解）](https://blog.csdn.net/fulishafulisha/article/details/80158392),   9.




