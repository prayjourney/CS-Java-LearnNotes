### EasyMock学习使用

***

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





##### EasyMock API

// 主要是EasyMock的API的介绍





ref :
1.[EasyMock教程--入门指南](https://www.oschina.net/question/89964_62360),   2.[easymock例子](https://github.com/vraa/SimplePortfolio)

