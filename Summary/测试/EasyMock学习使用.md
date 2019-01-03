### EasyMock学习使用

***
##### 原理简介
当我们使用单元测试的时候，我们需要创建对象，但是有时候，我们需要的对象，无法直接创建出来，或者是受限于我们的合作伙伴，他们没有提供具体的方法，但是我们已经定义好了接口，知道了入参和返回值，此时，我们便可以不用直接通过接口方法来获得对象调用方法，我们可以通过mock，来模拟构造假的数据，这样便可以尽可能早的完成开发和调试。**其实，mock就是在我们无法直接拿到对象的情况下，自己创造一个假的对象，其中的方法，方法的返回值，都可以通过我们自己去构造，此时，我们就不会受限于暂时没有实现的接口**，可以加速开发和调试。mock有多种框架，EasyMock只是其中的一种框架，我们完全可以使用其他的框架来代替。通常情况之下，我们都是将Junit和Mock(EasyMock)一起使用，完成单元测试。



##### 基本流程
1. record阶段，记录对若干依赖对象的期望
>o= EasyMock.createMock(MyAdd.class); //创建Mock对象
>EasyMock.expect(o.add(1,1)).andReturn(2); //对mock对象，提出期望

2. Replay阶段，创建测试主对象，并添加依赖对象进去
>EasyMock.replay(o); //期望设置完毕，进入replay阶段
xxx.set(o);//???????????????????????????设置进去???

3. Verify阶段，验证测试结果与交互行为
>assertEquals(2, o.add(1,1));
assertNotNull();//?verfiy和断言的区别?
EasyMock.verify(o); //对mock对象执行验证



##### 设定 Mock 对象的预期行为和输出
在一个完整的测试过程中，一个 Mock 对象将会经历两个状态：Record 状态和 Replay 状态。Mock 对象一经创建，它的状态就被置为 Record。**在 Record 状态，用户可以设定 Mock 对象的预期行为和输出，这些对象行为被录制下来，保存在 Mock 对象中**。添加 Mock 对象行为的过程通常可以分为以下3步：
- 对 Mock 对象的特定方法作出调用；
- 通过 `org.easymock.EasyMock` 提供的静态方法 `expectLastCall` 获取上一次方法调用所对应的 IExpectationSetters 实例；
- 通过 `IExpectationSetters` 实例设定 Mock 对象的预期输出。



##### 将Mock对象切换到Replay状态
在生成 Mock 对象和设定 Mock 对象行为两个阶段，Mock 对象的状态都是 Record 。在这个阶段，Mock 对象会记录用户对预期行为和输出的设定。**在使用 Mock 对象进行实际的测试前，我们需要将 Mock 对象的状态切换为 Replay**。*在 Replay 状态，Mock 对象能够根据设定对特定的方法调用作出预期的响应*。将 Mock 对象切换成 Replay 状态有两种方式，您需要根据 Mock 对象的生成方式进行选择。如果 Mock 对象是通过 `org.easymock.EasyMock` 类提供的静态方法 createMock 生成的（第1节中介绍的第一种 Mock 对象生成方法），那么 `EasyMock`类提供了相应的 replay 方法用于将 Mock 对象切换为 Replay 状态：
```
replay(mockResultSet);
```
如果 Mock 对象是通过 `IMocksControl` 接口提供的 `createMock` 方法生成的（第1节中介绍的第二种Mock对象生成方法），那么您依旧可以通过 `IMocksControl` 接口对它所创建的所有 Mock 对象进行切换：
```
control.replay();
```
以上的语句能将在第1节中生成的 mockConnection、mockStatement 和 mockResultSet 等3个 Mock 对象都切换成 Replay 状态。当前使用的EasyMock版本为3.4，基本上都使用replay的方式来转换到replay状态。



##### 证卷应用
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



##### EasyMock的工作流程
record-replay-verify 模型容许记录mock对象上的操作然后重演并验证这些操作。这是目前mock框架领域最常见的模型，几乎所有的mock框架都是用这个模型，有些是现实使用如easymock，有些是隐式使用如jmockit。以easymock为例，典型的easymock使用案例一般如下, 援引上一章中的例子：
```java
public class UserServiceImplTest {
    /**
     * this is a classic test case to use EasyMock.
     */
    @Test
    public void testQuery() {
        User expectedUser = new User();
        expectedUser.setId("1001");
        expectedUser.setAge(30);
        expectedUser.setName("user-1001");
        UserDao userDao  = EasyMock.createMock(UserDao.class);
        EasyMock.expect(userDao.getById("1001")).andReturn(expectedUser);
        EasyMock.replay(userDao);

        UserServiceImpl  service = new UserServiceImpl();
        service.setUserDao(userDao);
        User user = service.query("1001");
        assertNotNull(user);
        assertEquals("1001", user.getId()); 
        assertEquals(30, user.getAge()); 
        assertEquals("user-1001", user.getName()); 

        EasyMock.verify(userDao);
    }
}
```
在这里有两句非常明显的调用语句: Easymock.replay(...)和Easymock.verify(...)。这两个语句将上述代码分成三个部分，分别对应record-replay-verify 3个阶段，其实，如果分的更详细，可以把record部分分成2个部分，在后面可以介绍。
1. record阶段
```java
    User expectedUser = new User();
    expectedUser.setId("1001");
    expectedUser.setAge(30);
    expectedUser.setName("user-1001");
    UserDao userDao  = EasyMock.createMock(UserDao.class);
    EasyMock.expect(userDao.getById("1001")).andReturn(expectedUser);
```

这里我们开始创建mock对象，并期望这个mock对象的方法被调用，同时给出我们希望这个方法返回的结果(可以分为两个部分,创建mock对象+给mock对象赋值)。这就是所谓的"记录mock对象上的操作", 同时我们也会看到"expect"这个关键字。
总结说，**在record阶段，我们需要给出的是我们对mock对象的一系列期望：若干个mock对象被调用，依从我们给定的参数，顺序，次数等，并返回预设好的结果(返回值或者异常)**.
2. replay阶段
```java
    UserServiceImpl  service = new UserServiceImpl();
    service.setUserDao(userDao);
    User user = service.query("1001");
```
在replay阶段，我们关注的主要测试对象将被创建，之前在record阶段创建的相关依赖被关联到主要测试对象，然后执行被测试的方法，以模拟真实运行环境下主要测试对象的行为。
在测试方法执行过程中，主要测试对象的内部代码被执行，同时和相关的依赖进行交互：以一定的参数调用依赖的方法，获取并处理返回。**我们期待这个过程如我们在record阶段设想的交互场景一致，即我们期望在replay阶段所有在record阶段记录的行为都将被完整而准确的重新演绎一遍，从而到达验证主要测试对象行为的目的**。
3. verify阶段
```java
    assertNotNull(user);
    assertEquals("1001", user.getId()); 
    assertEquals(30, user.getAge()); 
    assertEquals("user-1001", user.getName()); 
    EasyMock.verify(userDao);
```
在verify阶段，我们将验证测试的结果和交互行为。通常验证分为两部分，如上所示： 一部分是验证结果，即主要测试对象的测试方法返回的结果(对于异常测试场景则是抛出的异常)是否如预期，通常这个验证过程需要我们自行编码实现。另一部分是验证交互行为，典型如依赖是否被调用，调用的参数，顺序和次数，这部分的验证过程通常是由mock框架来自动完成，我们只需要简单调用即可。在easymock的实现中，verify的部分交互行为验证工作，会提前在replay阶段进行：比如未记录的调用，调用的参数等。如果验证失败，则直接结束replay以致整个测试案例。也可以按照如下的方式来划分, 以一个小例子为例:

```java
@Test
public void test(){
    Calculator calculator = EasyMock.createMock(Calculator.class);
    EasyMock.expect(calculator.add(2,4)).andReturn(5);
    EasyMock.replay(calculator);
    Assert.assertEquals(calculator.add(2,4),5);
}
```
上面的代码刚好反应了easymock的工作流程, 如下: 
1. **创建一个类的mock对象 **
2. **记录mock对象期望的行为**
3. **记录完成，开始重放测试样例, replay.**
4. **mock对象执行验证**
###### easymock运行流程总结
record-replay-verify 模型非常好的满足了大多数测试场景的需要：先指定测试的期望，然后执行测试，再验证期望是否被满足。这个模型简单直接，易于实现，也容易被开发人员理解和接受，因此被各个mock框架广泛使用。



##### EasyMock 的工作原理
EasyMock 是如何为一个特定的接口动态创建 Mock 对象，并记录 Mock 对象预期行为的呢？其实，EasyMock 后台处理的主要原理是利用 `java.lang.reflect.Proxy`为指定的接口创建一个动态代理，这个动态代理，就是我们在编码中用到的 Mock 对象。EasyMock 还为这个动态代理提供了一个 `InvocationHandler` 接口的实现，这个实现类的主要功能就是将动态代理的预期行为记录在某个映射表中和在实际调用时从这个映射表中取出预期输出。下图是 EasyMock 中主要的功能类：
![easymockclass](../../images/easymockclass.gif)

和开发人员联系最紧密的是 `EasyMock` 类，这个类提供了 `createMock、replay、verify` 等方法以及所有预定义的参数匹配器。我们知道 Mock 对象有两种创建方式：一种是通过 `EasyMock` 类提供的 `createMock`方法创建，另一种是通过 `EasyMock` 类的 `createControl` 方法得到一个 `IMocksControl` 实例，再由这个 `IMocksControl` 实例创建 Mock 对象。其实，无论通过哪种方法获得 Mock 对象，EasyMock 都会生成一个 `IMocksControl` 的实例，只不过第一种方式中的 `IMocksControl` 的实例对开发人员不可见而已。这个 `IMocksControl` 的实例，其实就是 `MocksControl` 类的一个对象。`MocksControl`类提供了 `andReturn、andThrow、times、createMock` 等方法。

`MocksControl` 类中包含了两个重要的成员变量，分别是接口 `IMocksBehavior` 和 `IMocksControlState` 的实例。其中，`IMocksBehavior` 的实现类 `MocksBehavior`是 EasyMock 的核心类，它保存着一个 `ExpectedInvocationAndResult` 对象的一个列表，而 `ExpectedInvocationAndResult` 对象中包含着 Mock 对象方法调用和预期结果的映射。`MocksBehavior` 类提供了 `addExpected` 和 `addActual` 方法用于添加预期行为和实际调用。

`MocksControl` 类中包含的另一个成员变量是 `IMocksControlState` 实例。`IMocksControlState` 拥有两个不同的实现类：`RecordState` 和 `ReplayState`。顾名思义，`RecordState` 是 Mock 对象在 Record 状态时的支持类，它提供了 `invoke`方法在 Record 状态下的实现。此外，它还提供了 `andReturn、andThrow、times`等方法的实现。`ReplayState` 是 Mock 对象在 Replay 状态下的支持类，它提供了 `invoke` 方法在 Replay 状态下的实现。在 ReplayState 中，`andReturn、andThrow、times` 等方法的实现都是抛出IllegalStateException，因为在 Replay 阶段，开发人员不应该再调用这些方法。

当我们调用 `MocksControl` 的 `createMock` 方法时，该方法首先会生成一个 `JavaProxyFactory` 类的对象。`JavaProxyFactory` 是接口 `IProxyFactory` 的实现类，它的主要功能就是通过 `java.lang.reflect.Proxy` 对指定的接口创建动态代理实例，也就是开发人员在外部看到的 Mock 对象。在创建动态代理的同时，应当提供 `InvocationHandler` 的实现类。`MockInvocationHandler` 实现了这个接口，它的 `invoke` 方法主要的功能是根据 Mock 对象状态的不同而分别调用 `RecordState` 的 `invoke` 实现或是 `ReplayState`的 `invoke` 实现。



##### 创建 Mock 对象
下图是创建 Mock 对象的时序图：
![mockcreateobj](../../images/mockcreateobj.gif)

当 `EasyMock` 类的 `createMock` 方法被调用时，它首先创建一个 `MocksControl` 对象，并调用该对象的 `createMock` 方法创建一个 `JavaProxyFactory` 对象和一个 `MockInvocationHandler` 对象。`JavaProxyFactory` 对象将 `MockInvocationHandler` 对象作为参数，通过 `java.lang.reflect.Proxy` 类的 `newProxyInstance` 静态方法创建一个动态代理。



##### 记录 Mock 对象预期行为
记录 Mock 的预期行为可以分为两个阶段：预期方法的调用和预期输出的设定。在外部程序中获得的 Mock 对象，其实就是由 `JavaProxyFactory` 创建的指定接口的动态代理，所有外部程序对接口方法的调用，都会指向 `InvocationHandler` 实现类的 `invoke` 方法。在 EasyMock 中，这个实现类是 `MockInvocationHandler`。下图是调用预期方法的时序图：
![easymockgetexpectmethod](../../images/easymockgetexpectmethod.gif)

当 `MockInvocationHandler` 的 `invoke` 方法被调用时，它首先通过 `reportLastControl` 静态方法将 Mock 对象对应的 `MocksControl` 对象报告给 `LastControl` 类，`LastControl` 类将该对象保存在一个 ThreadLocal 变量中。接着，`MockInvocationHandler` 将创建一个 Invocation 对象，这个对象将保存预期调用的 Mock 对象、方法和预期参数。

在记录 Mock 对象预期行为时，Mock 对象的状态是 Record 状态，因此 `RecordState` 对象的 `invoke` 方法将被调用。这个方法首先调用 `LastControl` 的 `pullMatchers` 方法获取参数匹配器。如果您还记得自定义参数匹配器的过程，应该能想起参数匹配器被调用时会将实现类的实例报告给 EasyMock，而这个实例最终保存在 `LastControl` 中。如果没有指定参数匹配器，默认的匹配器将会返回给 `RecordState`。根据 `Invocation` 对象和参数匹配器，`RecordState` 将创建一个 `ExpectedInvocation` 对象并保存下来。在对预期方法进行调用之后，我们可以对该方法的预期输出进行设定。我们以

```java
expectLastCall().andReturn(X value).times(int times)
```
为例说明。如果 `times` 方法未被显式的调用，EasyMock 会默认作为 `times(1)` 处理。下图是设定预期输出的时序图：
![easymockinfo](../../images/easymockinfo.gif)

在预期方法被调用时，Mock 对象对应的 `MocksControl` 对象引用已经记录在 `LastControl` 中，`expectLastCall` 方法通过调用 `LastControl` 的 `lastControl` 方法可以获得这个引用。`MocksControl` 对象的 `andReturn` 方法在 Mock 对象 Record 状态下会调用 `RecordState` 的 `andReturn` 方法，将设定的预期输出以 `Result` 对象的形式记录下来，保存在 `RecordState` 的 lastResult 变量中。

当 `MocksControl` 的 `times` 方法被调用时，它会检查 `RecordState` 的 lastResult 变量是否为空。如果不为空，则将 lastResult 和预期方法被调用时创建的 `ExpectedInvocation` 对象一起，作为参数传递给 `MocksBehavior` 的 `addExpected`方法。`MocksBehavior` 的 `addExpected` 方法将这些信息保存在数据列表中。



##### 在 Replay 状态下调用 Mock 对象方法
`EasyMock` 类的 `replay` 方法可以将 Mock 对象切换到 Replay 状态。在 Replay 状态下，Mock 对象将根据之前的设定返回预期输出。下图是 Replay 状态下 Mock 对象方法调用的时序图：
![easymockmethod](../../images/easymockmethod.gif)

在 Replay 状态下，`MockInvocationHandler` 会调用 `ReplayState` 的 `invoke` 方法。该方法会把 Mock 对象通过 `MocksBehavior` 的 `addActual` 方法添加到实际调用列表中，该列表在 `verify` 方法被调用时将被用到。同时，`addActual` 方法会根据实际方法调用与预期方法调用进行匹配，返回对应的 `Result` 对象。调用 `Result` 对象的 `answer` 方法就可以获取该方法调用的输出。




##### EasyMock API

| 方法名                                                  | 作用                                                         | 注意 |
| ------------------------------------------------------- | ------------------------------------------------------------ | ---- |
| `static int and(int first, int second)`                 | Expects an int that matches both given expectations.         |      |
| `static double anyDouble()`                             | Expects any double argument.                                 |      |
| `static <T> T anyObject()`                              | Expects any Object argument.                                 |      |
| `static <T> T anyObject(Class<T> clazz)`                | Expects any Object argument.                                 |      |
| `static double captureDouble(Capture<Double> captured)` | Expect any double but captures it for later use.             |      |
| `static String contains(String substring)`              | Expects a string that contains the given substring.          |      |
| `static IMocksControl createControl()`                  | Creates a control, order checking is disabled by default.    |      |
| `static <T> T  createMock(Class<?> toMock)`             | Creates a mock object that implements the given interface, order checking is disabled by default. |      |
| `static <T> T createStrictMock(Class<?> toMock)`        | Creates a mock object that implements the given interface, order checking is enabled by default. |      |
| `static float eq(float value)`                          | Expects a float that is equal to the given value.            |      |
| `static <T> T createNiceMock(Class<?> toMock)`          | Creates a mock object that implements the given interface, order checking is disabled by default, and the mock object will return `0`, `null` or `false` for unexpected invocations. |      |
| `static <T> T isA(Class<T> clazz)`                      | Expects an object implementing the given class.              |      |
| `static <T> T isNull(Class<T> clazz)`                   | Expects null.                                                |      |
| `static <T> T same(T value)`                            | Expects an Object that is the same as the given value.       |      |
| `static void  verify(Object... mocks)`                  | Verifies that all expectations were met and that no unexpected call was performed on the mock objects. |      |
| `static <T> T strictMock(Class<?> toMock)`              | Creates a mock object that implements the given interface, order checking is enabled by default. |      |
| `static void reset(Object... mocks)`                    | Resets the given mock objects (more exactly: the controls of the mock objects). |      |
| `static <T> T niceMock(Class<?> toMock)`                | Creates a mock object that implements the given interface, order checking is disabled by default, and the mock object will return `0`, `null` or `false` for unexpected invocations. |      |
| `static <T> T mock(Class<?> toMock)`                    | Creates a mock object that implements the given interface, order checking is disabled by default. |      |
| `static <T> T not(T first)`                             | Expects an Object that does not match the given expectation. |      |
| `static void replay(Object... mocks)`                   | Switches the given mock objects (more exactly: the controls of the mock objects) to replay mode. |      |





##### 注意点
1.verfiy的作用是:
Verifies that all expectations were met and that no unexpected call was performed on the mock objects. Or more precisely, verifies the underlying`IMocksControl`, linked to the mock objects. This method as same effect as calling [`verifyRecording(Object...)`](http://easymock.org/api/org/easymock/EasyMock.html#verifyRecording-java.lang.Object...-) followed by [`verifyUnexpectedCalls(Object...)`](http://easymock.org/api/org/easymock/EasyMock.html#verifyUnexpectedCalls-java.lang.Object...-). 相当于验证了整个模拟是否满足期待.

2.createNiceObject等区别:
在easymock的使用过程中，当创建mock对象时，我们会遇到 strict mock和nice mock的概念。比如创建mock对象我们通常使用EasyMock.createMock()，但是我们会发现easymock同时提供了两个类似的方法：

```java
EasyMock.createNiceMock()
EasyMock.createStrictMock()
```
类似的在创建MocksControl时，除了通常的EasyMock.createControl() 外，easymock也同时提供两个类似的方法：
```java
EasyMock.createNiceControl() 
EasyMock.createStrictControl() 
```
我们来看看strict和nice有什么作用。参考easymock的javadoc，我们对比createMock()和createStrictMock()：
```java
EasyMock.createMock()：      
//Creates a mock object that implements the given interface, order checking is disabled by default.
EasyMock.createNiceMock();
//Creates a mock object that implements the given interface, order checking is enabled by default.
```
**发现strict mock方式下默认是开启调用顺序检测的，而普通的mock方式则默认不开启调用顺序检测**。再看一下createNiceMock()：
> Creates a mock object that implements the given interface, order checking is disabled by default, and the mock object will return 0, null or false for unexpected invocations.

**createNiceMock()和createMock()相同的是默认不开启调用顺序检测，另外有一个非常有用的功能就是对于意料之外的调用将返回0,null 或者false**。之所以说有用，是因为在我们的实际开发过程中，有时候会有这样的需求：对于某个mock对象的调用(可以是部分，也可以是全部)，我们完全不介意调用细节，包括是否调用和调用顺序，参数，返回值，我们只要求mock对象容许程序可以继续而不是抛出异常报告说 unexpected invocations 。nice mock在这种情况下可以为我们节省大量的工作量，非常方便。

3.record和replay的异同:
record是**录制**mock对象的状态，而replay是**回放**mock对象的状态，当记录好了之后，就可以去回放了（也可以理解为调用）。



##### 小结
如果您需要在单元测试中构建 Mock 对象来模拟协同模块或一些复杂对象，EasyMock 是一个可以选用的优秀框架。EasyMock 提供了简便的方法创建 Mock 对象：通过定义 Mock 对象的预期行为和输出，你可以设定该 Mock 对象在实际测试中被调用方法的返回值、异常抛出和被调用次数。通过创建一个可以替代现有对象的 Mock 对象，EasyMock 使得开发人员在测试时无需编写自定义的 Mock 对象，从而避免了额外的编码工作和因此引入错误的机会。



##### 使用之中注意的点
心得体会: 我们在使用easymock的时候, 还是要把重点放在junit之上, mock只是为了模拟一些比较难构建的对象, 而对象构建出来, 就得**测试逻辑**, 这才是我们进行junit的关键, 而不是说只是为了构建mock对象, 如果仅仅是去构建一个对象, 然后调用它的功能, 这样是毫无意义的, 比如有如下的代码示例, 我们真正想做的就是去测试**ServiceInstance类之中的doWork()方法是否有效果, 是否满足了我们的要求**, 而不是像下面一样只是模拟, 这样一切都是模拟的, 就达不到测试的效果了, 而且, 我们在下面的例子之中, 实际上模拟了我们不该模拟的内容, 因为这正是我们需要测试的。

```java
ServiceInstance service = new ServiceInstance();
ServiceInstance service2 = EasyMock.createMock(ServiceInstance.class);
EasyMock.expect(service2.doWork()).andReturn("OKAY");//此处定义了该类方法的返回值
EasyMock.replay(service2);

service2.doWork();//此处去调用此方法, 这样是毫无意义的, 因为一切都是模拟, 没有走到逻辑之中去!
```
我们真正需要模拟的是构造ServiceInstance的元素， 如一个其他的类或者接口的对象， 这个对象很难构造， 此时我们需要模拟这个对象， 如下：
```java
// ServiceInstance(AbstractInstanceProxy proxy, String name, int id);
// 其中的AbstractInstanceProxy是需要在正式的网络环境之中获取, 但是很难获取,所以我们可以模拟
AbstractInstanceProxy proxy =EasyMock.createMock(AbstractInstanceProxy.class);
EasyMock.expect(proxy.init(EasyMock.anyString)).andReturn(proxy).anyTimes();
Service service = (proxy, "test", 123);
EasyMock.replay(proxy);

// 此处测试的是真实的逻辑, 而不是我们构造的虚假逻辑
service.doWork();
```



```java
@Test
public void queryInstanceSynProgressTest1(){
    // 返回一个LegoCheckedException异常
    expectEx.expect(LegoCheckedException.class);
    ServiceInstanceServiceImpl service 
        = EasyMock.createMock(ServiceInstanceServiceImpl.class);
    EasyMock.expect(service.queryServiceInstance(EasyMock.anyString()))
        .andReturn(null).anyTimes();
    SynProgressInfo info = new SynProgressInfo();
    info.setProgress("95");
    info.setRemainingTime(100l);
    EasyMock.expect(service.queryInstanceSynProgress(EasyMock
                .anyString(),EasyMock.anyString()))
                .andThrow(new LegoCheckedException(ErrorCodeConstant.OBJECT_NOT_EXIST,
                "instance(" + "123"+ ") is not found."));
    EasyMock.replay(service);
    // 在模拟好对象之后，只是将某一个方法调用一次或者多次
    // service.queryInstanceSynProgress("projectId", "instanceId");
    // 和上述方法相比，此种是在调用的同时，还验证结果和预期是否相同，一般用来验证测试和期望的结果是否相同， 异常不进行如此操作
    Assert.assertEquals(new LegoCheckedException("123"), service.
                        queryInstanceSynProgress(EasyMock.anyString(),
                                                 EasyMock.anyString()));
}

// 可以构造异常, 测试异常
@Test(expected = LegoCheckedException.class)
public void queryInstanceSynProgressTest2(){
    // @Test(expected = LegoCheckedException.class)与下列语句作用相同
    // expectEx.expect(LegoCheckedException.class);
    ServiceInstanceServiceImpl 
        service = EasyMock.createMock(ServiceInstanceServiceImpl.class);
    // PowerMock可以模拟static的
    PowerMock.mockStatic(ServiceLocator.class);
    ServiceLocator locator = PowerMock.createMock(ServiceLocator.class);
    ServiceInstance instance = new ServiceInstance();
    instance.setProjectId("project1");
    EasyMock.expect(ServiceLocator.getInstance()).andReturn(locator).anyTimes();

    IProtectGroupService iProtectGroupService = EasyMock.
                  createMock(IProtectGroupService.class);
    EasyMock.expect(iProtectGroupService.getProtectGroupBasicInfo(EasyMock.anyString(),
    EasyMock.anyBoolean())).andReturn(null).anyTimes();
    EasyMock.expect(service.queryInstanceSynProgress(EasyMock
                .anyString(),EasyMock.anyString()))
                .andThrow(new LegoCheckedException("protect group is null, 
                +" the projectId: project1"));
    // record all object
    EasyMock.replay(service, locator, iProtectGroupService);
    // pg为空，抛出一个异常，和expected匹配，则通过Test
    service.queryInstanceSynProgress(EasyMock.anyString(), EasyMock.anyString());
    // 验证是否满足所有期望，并且未对模拟对象执行任何意外调用
    EasyMock.verify(service, locator, iProtectGroupService);
}
```

>https://blog.csdn.net/sunnyplain/article/details/48574927
>https://blog.csdn.net/andywangcn/article/details/21030473
>http://www.cnblogs.com/sequence/archive/2011/07/28/2119657.html
>https://blog.csdn.net/sinat_26935081/article/details/49669619
>https://www.yiibai.com/easymock/easymock_exception_handling.html
>https://blog.csdn.net/u010860412/article/details/50676092



##### EasyMock问题总结
1.incompatible return value type

maybe: 有部分的类或者接口没有被模拟，有一些模拟到了，但是只有部分模拟到，其他的没有被模拟到。

2.unexpected method call

maybe: 调用到了我们没有模拟的方法，需要找出来去模拟一下。

3.no last call on a mock available

maybe: 我们模拟了一大串的方法和返回值，没有被调用，可能是某些类没有被模拟到，需要去模拟一下。

4.0 matchers expected, 1 recorded. 

5. > java.lang.IllegalStateException: missing behavior definition for the preceding method call getBidwordSequence()  

出现这样的错误请仔细检查getBidwordSequence()是void方法，还是有返回值，返回值的类型是不是写对了。

6. >java.lang.IllegalStateException: 0 matchers expected, 1 recorded.  
  >This exception usually occurs when matchers are mixed with raw values when recording a method:  
  >foo(5, eq(6));  // wrong  
  >You need to use no matcher at all or a matcher for every single param:  
  >foo(eq(5), eq(6));  // right  
  >foo(5, 6);  // also right  

这个错误是要检查出错方法的前面方法是否多添加了匹配器（anyObject），尤其注意andReturn();easymock在andReturn()这个方法中入参不能是anyObject的。必须要给出方法的入参。

7.  >EasyMock.expect(subwayService.auditActivityRejected((EasyMock.anyObject(List.class))).andReturn(1); 
EasyMock.expect(subwayService.auditActivityVerified.(EasyMock.anyObject(List.class))).andReturn(1);  

如果你原本希望录制脚本1，结果由于copy代码录制成了脚本2，这样你期待方法返回结果0，结果方法始终返回默认的0，而且由于你可能对于返回结果是0的抛出了自定义的异常，可怕的后果是verify就验证不了该方法，直接会显示你抛出的异常，如果不细心，这个错误还是很隐蔽的。所以录制的脚本一定要和调用的方法一致。

8. >notifyFacade.addGroup( isA(List.class));  
  >//如果addGroup是空的，  
  >java.lang.AssertionError:   
  >Unexpected method call addADGroup(null):  
  >addADGroup(isA(java.util.List)): expected: 1, actual: 0  
  >org.easymock.internal.MockInvocationHandler.invoke(MockInvocationHandler.java:45)  

isA和anyObject的区别 ：如果出现了上述的错误，请看下你的方法传递参数的时候使用的isA(List.class),还是anyObject(List.class)的方法，这两个方法区别在于isA会调用instance of 方法，判断except时候的入参类型和实际是否相同，null instance of List 返回false，导致验证的失败，而使用anyObject则不会出现类似的问题。所以正确的写法如下
  > notifyFacade.addADGroup( anyObject(List.class))  



##### EasyMock进阶
1.mock 私有方法
2.mock 静态方法
3.powermock的基本使用



ref :
1.[EasyMock教程--入门指南](https://www.oschina.net/question/89964_62360),   2.[easymock例子](https://github.com/vraa/SimplePortfolio),   3.[初识stub和mock--junit的两种测试策略](https://blog.csdn.net/yingxySuc/article/details/39677625),   4.[dbunit测试](https://github.com/YoYing/csdn),   5.[使用 EasyMock 更轻松地进行测试](https://www.ibm.com/developerworks/cn/java/j-easymock.html),   6.[EasyMock 使用方法与原理剖析](https://www.ibm.com/developerworks/cn/opensource/os-cn-easymock/),   7.[Mock的应用场景、原则和工具总结](https://baijiahao.baidu.com/s?id=1572237477611353&wfr=spider&for=pc),   8.[原！！关于java 单元测试Junit4和Mock的一些总结](https://www.cnblogs.com/wuyun-blog/p/7081548.html),   9.[JUnit4 与 JMock 之双剑合璧](https://www.cnblogs.com/wangtj-19/p/5822211.html),   10.[easymock教程-record-replay-verify模型](http://skydream.iteye.com/blog/829338),   11.[easymock教程-easymock的典型使用](https://blog.csdn.net/hikvision_java_gyh/article/details/11745767),   12.[写给精明Java开发者的测试技巧](http://www.importnew.com/16392.html)，   13.[如何使用EasyMock?](https://blog.csdn.net/bradmatt/article/details/80811072),   14.[mock大法好](https://segmentfault.com/a/1190000010211622),   15.[单元测试及框架简介 --junit、jmock、mockito、powermock的简单使用](https://blog.csdn.net/luvinahlc/article/details/10442743),   16.[EasyMock jUnit单元测试教程](http://outofmemory.cn/code-snippet/2693/EasyMock-jUnit-unit-test-course),   17.[JUnit + Mockito 单元测试（二）](https://blog.csdn.net/zhangxin09/article/details/42422643),   18.[比较完整的junit单元测试之-----mock模拟测试](https://blog.csdn.net/zhanganbo/article/details/52288080),   19.[Maven环境下easymock开发入门实例](https://blog.csdn.net/tianjun2012/article/details/50571848),   20.[【JUnit】EasyMock用法总结](https://blog.csdn.net/vking_wang/article/details/9170979),   21.[EasyMock经验](https://www.cnblogs.com/alipayhutu/archive/2012/05/21/2512363.html)，   22.[easymock-api](http://easymock.org/api/),   23.[EasyMock calcService.serviceUsed（）调用两次示例](https://www.yiibai.com/easymock/easymock_times_call_twice.html),   24.[EasyMock 的简单使用](https://blog.csdn.net/xrymibz/article/details/70196999),   25.[EasyMock jUnit单元测试教程](http://outofmemory.cn/code-snippet/2693/EasyMock-jUnit-unit-test-course),   26.[easyMock原理简述](https://blog.csdn.net/u010632868/article/details/52145823),   27.[easymock教程-strict和nice](http://skydream.iteye.com/blog/829333),   28.[EasyMock问题总结](https://www.cnblogs.com/heidsoft/p/3832238.html),   29.[EasyMock问题总结](https://gigi-112.iteye.com/blog/1066243)