### EasyMock学习使用

***
##### 原理简介
当我们使用单元测试的时候，我们需要创建对象，但是有时候，我们需要的对象，无法直接创建出来，或者是受限于我们的合作伙伴，他们没有提供具体的方法，但是我们已经定义好了接口，知道了入参和返回值，此时，我们便可以不用直接通过接口方法来获得对象调用方法，我们可以通过mock，来模拟构造假的数据，这样便可以尽可能早的完成开发和调试。**其实，mock就是在我们无法直接拿到对象的情况下，自己创造一个假的对象，其中的方法，方法的返回值，都可以通过我们自己去构造，此时，我们就不会受限于暂时没有实现的接口**，可以加速开发和调试。mock有多种框架，EasyMock只是其中的一种框架，我们完全可以使用其他的框架来代替。通常情况之下，我们都是将Junit和Mock(EasyMock)一起使用，完成单元测试。



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



##### EasyMock API
// 主要是EasyMock的API的介绍





ref :
1.[EasyMock教程--入门指南](https://www.oschina.net/question/89964_62360),   2.[easymock例子](https://github.com/vraa/SimplePortfolio),   3.[初识stub和mock--junit的两种测试策略](https://blog.csdn.net/yingxySuc/article/details/39677625),   4.[dbunit测试](https://github.com/YoYing/csdn),   5.[使用 EasyMock 更轻松地进行测试](https://www.ibm.com/developerworks/cn/java/j-easymock.html),   6.[EasyMock 使用方法与原理剖析](https://www.ibm.com/developerworks/cn/opensource/os-cn-easymock/),   7.[Mock的应用场景、原则和工具总结](https://baijiahao.baidu.com/s?id=1572237477611353&wfr=spider&for=pc),   8.[原！！关于java 单元测试Junit4和Mock的一些总结](https://www.cnblogs.com/wuyun-blog/p/7081548.html),   9.[JUnit4 与 JMock 之双剑合璧](https://www.cnblogs.com/wangtj-19/p/5822211.html),   10.[easymock教程-record-replay-verify模型](http://skydream.iteye.com/blog/829338),   11.[easymock教程-easymock的典型使用](https://blog.csdn.net/hikvision_java_gyh/article/details/11745767),   12.[写给精明Java开发者的测试技巧](http://www.importnew.com/16392.html)，   13.[如何使用EasyMock?](https://blog.csdn.net/bradmatt/article/details/80811072),   14.[mock大法好](https://segmentfault.com/a/1190000010211622),   15.[单元测试及框架简介 --junit、jmock、mockito、powermock的简单使用](https://blog.csdn.net/luvinahlc/article/details/10442743),   16.[EasyMock jUnit单元测试教程](http://outofmemory.cn/code-snippet/2693/EasyMock-jUnit-unit-test-course),   17.[JUnit + Mockito 单元测试（二）](https://blog.csdn.net/zhangxin09/article/details/42422643),   18.[比较完整的junit单元测试之-----mock模拟测试](https://blog.csdn.net/zhanganbo/article/details/52288080),   19.[Maven环境下easymock开发入门实例](https://blog.csdn.net/tianjun2012/article/details/50571848),   20.