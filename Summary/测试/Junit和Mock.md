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



#### Mock
##### Stub与Mock
单元测试使我们常用的测试方式, Junit是单元测试xUnit的Java语言的一种实现。Stub和Mock就是两种协助Junit测试的思想或者策略，它们并不是真实存在的对象，却可以模拟真实对象的状态和交互。
###### 相同点
Stub和Mock对象都是用来模拟外部依赖，使我们能控制。如果被测程序、系统或对象，我们称之为A。在测试A的过程中，A需要与程序、系统或对象B进行交互，那么Stub/Mock就是用来模拟B的行为来与A进行交互。

###### 不同点
- Stub，也即“桩”，很早就有这个说法了，主要出现在集成测试的过程中，从上往下的集成时，作为下方程序的替代。作用如其名，就是在需要时，能够发现它存在，即可。就好像点名，“到”即可。
- Mock，主要是指某个程序的傀儡，也即一个虚假的程序，可以按照测试者的意愿做出响应，返回被测对象需要得到的信息。也即是要风得风、要雨得雨、要返回什么值就返回什么值。

总体来说，stub完全是模拟一个外部依赖，用来提供测试时所需要的测试数据。而mock对象用来判断测试是否能通过，也就是用来验证测试中依赖对象间的交互能否达到预期。
![mockandstub](../../images/mockandstub.jpg)
左图中，看到stub作为外部依赖的模拟，只需要模拟返回数据就ok了，我们的测试重点在于自身的逻辑。而右图中，通过Mock，模拟外部依赖的各种的返回值，来验证与外部依赖的交互。



##### Mock和Stub异同总结
**二者都是为同一个目标而出现的，代替依赖部分。mock使用jar包，也就是mock框架，在程序代码中注入“依赖部分”，通过代码可编程的方式模拟函数调用返回的结果。stub是自己写代码代替“依赖部分”一个简化实现，所以总体而言，stub的逻辑和代码量更加复杂**。

Mock和Stub都是虚拟对象，更准确地说，mock对象可以使用最少的方法来模拟真实的对象。而stub方式创建测试的情形需要我们更多的关注细节。**Stub对象以及返回的结果和验证的逻辑大多数是由我们程序员自己创建的**。Stub还可以验证方法的内部状态。而**Mock对象一般是由框架来帮我们创建的**。*Mock对象可以验证方法之间的交互是否符合自己期望的*。**最主要的区别就是：Stub是基于状态的对象，而Mock是基于交互的对象**。更为详细的区别请参考：[Mocks Aren't Stubs](http://martinfowler.com/articles/mocksArentStubs.html)。



##### Mock的流程
stub是基于状态，mock是基于行为。 mock通常通过一些成熟的框架对类或方法进行模拟。通常的流程是：
>创建指定类的mock，指定输入返回对应的响应内容。 
>当被测函数调用到该mock时针对输入进行预期返回。 
>最后验证该mock是否被调用。

而使用stub时针对每个状态，返回指定的响应。



#### Junit和Mock的区别以及关系
在做单元测试的时候，我们会发现我们要测试的方法会引用很多外部依赖的对象，比如：（发送邮件，网络通讯，记录Log, 文件系统 之类的）。 而我们没法控制这些外部依赖的对象。  为了解决这个问题，我们**需要用到Stub和Mock来模拟这些外部依赖的对象，从而控制它们**。
JUnit是单元测试框架，**可以轻松的完成关联依赖关系少或者比较简单的类的单元测试**，但是对于关联到其它比较复杂的类或对运行环境有要求的类的单元测试，模拟环境或者配置环境会非常耗时，实施单元测试比较困难。而这些**mock框架**（如**Mockito 、jmock 、 powermock、EasyMock**），可以通过mock框架模拟一个对象的行为，从而隔离开我们不关心的其他对象，使得测试变得简单。（例如service调用dao，即service依赖dao，我们可以通过mock dao来模拟真实的dao调用，从而能达到测试service的目的。）模拟对象（Mock Object）可以取代真实对象的位置，用于测试一些与真实对象进行交互或依赖于真实对象的功能，模拟对象的背后目的就是创建一个轻量级的、可控制的对象来代替测试中需要的真实对象，模拟真实对象的行为和功能。 由以上的介绍, 简而言之有:
> Junit和Mock 是相互协作的关系, 而不是取代的关系, 我们使用单元测试的时候, 还是需要使用Junit或者TestNg等框架, 但是, 由于单元测试需要使用带外部的依赖对象, 而这些对象是我们无法直接或者无法控制的, 所以,我们需要有其他的方式方法, 来帮我们构造这些对象, **Mock的目的就是为了构造对象!!!然后让对象在Junit框架或者其他框架之中发挥作用!!!**  由此就诞生了Mock和Stub来模拟我们需要的对象的方式。这就是Junit和Mock之间的关系。



#### Junit的优缺点
###### 优点
比在代码中写main 方法测试的好处有如下:
1. 可以书写一系列的 测试方法，对项目所有的 接口或者方法进行单元测试。 
2. 启动后，自动化测试，并判断执行结果, 不需要人为的干预。 
3. 只需要查看最后结果，就知道整个项目的方法接口是否通畅。
4. 每个单元测试用例相对独立， 由Junit 启动，自动调用。 不需要添加额外的调用语句。
5. 添加，删除，屏蔽测试方法，不影响其他的测试方法。 开源框架都对JUnit 有相应的支持。

###### 缺点
1. 参数化测试是类级别的
2. 不能依赖测试
3. 配置控制欠佳（安装/拆卸）
4. 侵入性（强制扩展类，并以某种方式命名方法）
5. 静态编程模型（不必要的重新编译）
6. 不同的适合管理复杂项目中的测试可以是非常棘手



#### Junit配合Mock使用的例子
###### 证卷应用
我们的证券应用非常简单。有一个 **Stock** 类来存储股票名和数量，**Portfolio** 类来保存股票列表。**Portfolio** 类有一个方法用来计算证券的总价格。我们的类用 **StockMarket** 对象来检索股票价格。当测试我们的代码时，我们将使用 EasyMock 来模拟StockMarket。
**Stock.java**
```java
package com.cqu.rjx.tool.easymock;

public class Stock {

	private String name;
	private int quantity;

	public Stock(String name, int quantity) {
		this.name = name;
		this.quantity = quantity;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

}
```
**StockMarket.java** 
用来模拟股票市场服务的接口。它包含一个通过给定股票名返回价格的方法。
```java
package com.cqu.rjx.tool.easymock;

public interface StockMarket {
	public Double getPrice(String stockName);
}
```
**Portfolio.java**
该对象包含了 Stock 对象列表和一个计算证券总价格的方法。它使用 StockMarket 对象来检索股票价格。但是硬编码依赖不是好的实践，我们不应该在此就初始化 stockMarket 对象，我们应该在使用测试代码的时候注入进来。
```java
package com.cqu.rjx.tool.easymock;

import java.util.ArrayList;
import java.util.List;

public class Portfolio {

	private String name;
	private StockMarket stockMarket;

	private List<Stock> stocks = new ArrayList<Stock>();

	/*
	 * this method gets the market value for each stock, sums it up and returns
	 * the total value of the portfolio.
	 */
	public Double getTotalValue() {
		Double value = 0.0;
		for (Stock stock : this.stocks) {
			value += (stockMarket.getPrice(stock.getName()) * stock
					.getQuantity());
		}
		return value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Stock> getStocks() {
		return stocks;
	}

	public void setStocks(List<Stock> stocks) {
		this.stocks = stocks;
	}

	public void addStock(Stock stock) {
		stocks.add(stock);
	}

	public StockMarket getStockMarket() {
		return stockMarket;
	}

	public void setStockMarket(StockMarket stockMarket) {
		this.stockMarket = stockMarket;
	}
}
```
至此，我们便完成了整个应用的编码，接下来我们将测试 **Portfolio.getTotalValue()** 方法，因为那是我们的业务逻辑所在。

###### 用 JUnit 与 EasyMock 测试 Portfolio 应用
**PortfolioTest.java**
```java
package com.cqu.rjx.tool.easymock.beginmock;

import com.cqu.rjx.tool.easymock.Portfolio;
import com.cqu.rjx.tool.easymock.Stock;
import com.cqu.rjx.tool.easymock.StockMarket;
import org.easymock.EasyMock;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static junit.framework.Assert.assertEquals;

public class PortfolioTest {
    private Portfolio portfolio;
    private StockMarket stockMarket;

    @Before
    public void setUp() {
        portfolio = new Portfolio();
        portfolio.setName("Veera's portfolio.");
        // 创建mock对象
        stockMarket = EasyMock.createMock(StockMarket.class);
        portfolio.setStockMarket(stockMarket);
    }

    @Test
    public void testGetTotalValue(){
        // mock对象，使用我们期望的值
        EasyMock.expect(stockMarket.getPrice("EBAY")).andReturn(42.00);
        EasyMock.replay(stockMarket);

        // 开始测试
        Stock ebayStock= new Stock("EBAY",2);
        portfolio.addStock(ebayStock);
        assertEquals(84.00,portfolio.getTotalValue());
    }

    @After
    public void tearDown(){
        System.out.println("不管测试是否成功,测试完后都会执行@After注解的函数");
    }
}
```

正如你所看到的，在 **setUp()** 调用时我们创建新的 **Portfolio** 对象。然后我们调用 **EasyMock** 要求为 **StockMarket** 接口创建一个模拟对象。然后我们使用 **Portfolio.setStockMarket()** 方法将这个对象注入到 **Portfolio** 对象。

在 **@Test**方法，我们使用以下代码定义模拟对象的行为：
```java
EasyMock.expect(marketMock.getPrice("EBAY")).andReturn(42.00);
EasyMock.replay(marketMock);
```
这样一来，当 **getPrice()** 方法带有 **“EBAY”** 的参数被调用的时候，将会返回42.00。然后我们创建了一个数量为2的 ebayStock 股票，并将其添加到我们的 Portfolio 中。将我们设置 EBAY 价格为 42.00 时，我们便知道股票的总价格为 84.00（2*42.00）。在最后一行，我们使用 **assertEquals()** 进行了同样的声明。如果 **getTotalValue()** 中代码不出错的话，以上测试应该会成功，否则测试将会失败。

**结论** 
以上便是如果使用 EasyMock 库模拟外部服务/对象以及在测试代码中使用的示例，EasyMock 能做的远不止我在上面展示的，[点击这里](http://www.oschina.net/p/easymock)了解更多关于 EasyMock 的信息。



ref:
1.[Unit4 与 JUnit 5 常用注解对比](https://blog.csdn.net/winteroak/article/details/80591598),   2.[JUnit学习笔记](https://www.cnblogs.com/Peiyuan/articles/511494.html),   3.[Java单元测试初体验(JUnit4)](https://www.cnblogs.com/ysw-go/p/5447056.html),   4.[Junit4单元测试的基本用法](https://www.cnblogs.com/qiyexue/p/6822791.html),   5.[Junit 4 Tutorials(Junit 4 教程) 五、测试套件](https://blog.csdn.net/luanlouis/article/details/37564355),   6.[Junit 4 Tutorials(Junit 4 教程) 四、Junit4 参数化测试](https://blog.csdn.net/luanlouis/article/details/37563265),   7.[Junit 4 Tutorials(Junit 4 教程) 六、忽略测试](https://blog.csdn.net/luanlouis/article/details/37565017),   8.[Junit的基本使用（详解）](https://blog.csdn.net/fulishafulisha/article/details/80158392),   9.[浅谈mock和stub](http://www.blogjava.net/aoxj/archive/2010/08/26/329975.html),   10.[软件测试中Mock和Stub](https://blog.csdn.net/yi412/article/details/80884106),   12.[Mock 和Stub之间的区别](https://blog.csdn.net/carolzhang8406/article/details/54693203),   13.[[Junit]stub和mock的区别](https://blog.csdn.net/londy_2000/article/details/79485769),   14.[Mock和Stub的初步理解](https://blog.csdn.net/CHS007chs/article/details/54345543),   15.[stub与mock的理解](https://blog.csdn.net/duanyu117/article/details/80258429),   16.[mock大法好](https://segmentfault.com/a/1190000010211622),   17.[Mock的应用场景、原则和工具总结](https://baijiahao.baidu.com/s?id=1572237477611353&wfr=spider&for=pc),   18.[testng和junit有什么优缺点，该如何选择？](https://www.zhihu.com/question/26026007),   19.[testng 与 junit 4对比](https://blog.csdn.net/huazhongkejidaxuezpp/article/details/48650793),   20.[Java测试框架比较：TestNG VS JUnit 4](https://blog.csdn.net/jmyue/article/details/9041357),   21.[原！！关于java 单元测试Junit4和Mock的一些总结](https://www.cnblogs.com/wuyun-blog/p/7081548.html),   22.[JUnit的好处](https://blog.csdn.net/xuchuangqi/article/details/49669109),   23.[Junit测试工具](https://blog.csdn.net/sun_wangdong/article/details/51907305),   24.[EasyMock教程--入门指南](https://www.oschina.net/question/89964_62360),   25.[easymock例子](https://github.com/vraa/SimplePortfolio)


