### Mock和Stub的区别

***
#### Mock和Stub异同总结

**二者都是为同一个目标而出现的，代替依赖部分。mock使用jar包，也就是mock框架，在程序代码中注入“依赖部分”，通过代码可编程的方式模拟函数调用返回的结果。stub是自己写代码代替“依赖部分”一个简化实现，所以总体而言，stub的逻辑和代码量更加复杂**。

Mock和Stub都是虚拟对象，更准确地说，mock对象可以使用最少的方法来模拟真实的对象。而stub方式创建测试的情形需要我们更多的关注细节。**Stub对象以及返回的结果和验证的逻辑大多数是由我们程序员自己创建的**。Stub还可以验证方法的内部状态。而**Mock对象一般是由框架来帮我们创建的**。*Mock对象可以验证方法之间的交互是否符合自己期望的*。**最主要的区别就是：Stub是基于状态的对象，而Mock是基于交互的对象**。更为详细的区别请参考：[Mocks Aren't Stubs](http://martinfowler.com/articles/mocksArentStubs.html)。



#### Mock和stub整体上的异同点
##### 相同点
先看看两者的相同点吧，非常明确的是，mock和stub都可以用来对系统(或者将粒度放小为模块，单元)进行隔离。
在测试，尤其是单元测试中，我们通常关注的是主要测试对象的功能和行为，对于主要测试对象涉及到的次要对象尤其是一些依赖，我们仅仅关注主要测试对象和次要测试对象的交互，比如是否调用，何时调用，调用的参数，调用的次数和顺序等，以及返回的结果或发生的异常。但次要对象是如何执行这次调用的具体细节，我们并不关注，因此常见的技巧就是用mock对象或者stub对象来替代真实的次要对象，模拟真实场景来进行对主要测试对象的测试工作。
因此**从实现上看，mock和stub都是通过创建自己的对象来替代次要测试对象，然后按照测试的需要控制这个对象的行为**。



##### 不同点
###### 类实现的方式
从类的实现方式上看，**stub有一个显式的类实现**，按照stub类的复用层次可以实现为普通类(被多个测试案例复用)，内部类(被同一个测试案例的多个测试方法复用)乃至内部匿名类(只用于当前测试方法)。对于stub的方法也会有具体的实现，哪怕简单到只有一个简单的return语句。
而mock则不同，**mock的实现类通常是有mock的工具包如easymock, jmock来隐式实现**，具体mock的方法的行为则通过record方式来指定。
就是说，**stub是有具体的方法和实现的，需要自己写代码，而mock 则是通过工具包来实现的**.
以stub和mock一个UserService, UserDao为例，只有一个查询方法，使用情况如下：

```java
	public interface UserService {
		User query(String userId);
	}

	public class UserServiceImpl implements UserService {
		private UserDao userDao; 
        public User query(String userId) {
			return userDao.getById(userId);
		}
		//setter for userDao
	}
	public interface UserDao {
		User getById(String userId);
		}
```
stub的标准实现，需要自己实现一个类并实现方法:
```java
	// stub 需要自己实现一个类
	public class UserDaoStub implements UserDao {
		public User getById(String id) {
			User user = new User();
			user.set.....
			return user;
			}
		}

	// stub方式的测试
	@Test
	public void testGetById() {
		UserServiceImpl service = new UserServiceImpl();
		UserDao userDao  = new UserDaoStub();
		service.setUserDao(userDao);
		User user = service.query("1001");
		...
	}
```
mock的实现，以easymock为例，只要指定mock的类并record期望的行为，并没有显式的构造新类:

```java
    // 使用mock的方式来测试
	@Test
    public void testGetById() {
        UserDao dao = Easymock.createMock(UserDao.class);
        User user = new User();
        user.set.....
        
        Easymock.expect(dao.getById("1001")).andReturn(user);
        Easymock.reply(dao);

        UserServiceImpl service = new UserServiceImpl();
        service.setUserDao(userDao);

        User user = service.query("1001");
        ...
        Easymock.verify(dao)；
    }
```
对比可以看出，mock编写相对简单，只需要关注被使用的函数，所谓"just enough"。stub要复杂一些，需要实现逻辑，即使是不需要关注的方法也至少要给出空实现。



#### 测试逻辑的可读性
从上面的代码可以看出，在形式上，**mock通常是在测试代码中直接mock类和定义mock方法的行为，测试代码和mock的代码通常是放在一起的**，因此测试代码的逻辑也容易从测试案例的代码上看出来。Easymock.expect(dao.getById("1001")).andReturn(user); 直截了当的指明了当前测试案例对UserDao这个依赖的预期: getById需要被调用，调用的参数应该是"1001"，调用次数为1(不明确指定调用次数时easymock默认为1)。
**而stub的测试案例的代码中只有简单的UserDao userDao  = new UserDaoStub ();构造语句和service.setUserDao(userDao);设置语句，我们无法直接从测试案例的代码中看出对依赖的预期，只能进入具体的UserServiceImpl类的query()方法，看到具体的实现是调用userDao.getById(userId)，这个时候才能明白完整的测试逻辑**。因此当测试逻辑复杂，stub数量多并且某些stub需要传入一些标记比如true，false之类的来制定不同的行为时，测试逻辑的可读性就会下降。



#### 可复用性
**Mock通常很少考虑复用，每个mock对象通过都是遵循"just enough"原则，一般只适用于当前测试方法**。因此每个测试方法都必须实现自己的mock逻辑，当然在同一个测试类中还是可以有一些简单的初始化逻辑可以复用。
stub则通常比较方便复用，尤其是一些通用的stub，比如jdbc连接之类。spring框架就为此提供了大量的stub来方便测试，不过很遗憾的是，它的名字用错了：spring-mock！



#### 设计和使用
接着我们从mock和stub的设计和使用上来比较两者，这里需要引入两个概念：interaction-based和state-based。
具体关于interaction-based和state-based，不再本文阐述，强烈推荐Martin Fowler 的一篇文章，"Mocks Aren't Stubs"。地址为http://martinfowler.com/articles/mocksArentStubs.html(PS：当在google中输入mock stub两个关键字做搜索时，出来结果的第一条就是此文，向Martin Fowler致敬，向google致敬)，英文不好的同学，可以参考这里的一份中文翻译：http://www.cnblogs.com/anf/archive/2006/03/27/360248.html。
总结来说，stub是state-based，关注的是输入和输出。mock是interaction-based，关注的是交互过程。



#### expectiation/期望
这个才是mock和stub的最重要的区别：expectiation/期望。
对于mock来说，exception是重中之重：我们期待方法有没有被调用，期待适当的参数，期待调用的次数，甚至期待多个mock之间的调用顺序。所有的一切期待都是事先准备好，在测试过程中和测试结束后验证是否和预期的一致。
而对于stub，通常都不会关注exception，就像上面给出的UserDaoStub的例子，没有任何代码来帮助判断这个stub类是否被调用。虽然理论上某些stub实现也可以通过自己编码的方式增加对expectiation的内容，比如增加一个计数器，每次调用+1之类，但是实际上极少这样做。 



#### 总结
关于mock和stub的不同，在Martin Fowler的"Mocks Aren't Stubs"一文中，有以下结束，我将它列出来作为总结：
- Dummy 
 对象被四处传递，但是从不被真正使用。通常他们只是用来填充参数列表。
- Fake 
 有实际可工作的实现，但是通常有一些缺点导致不适合用于产品(基于内存的数据库就是一个好例子)。
- Stubs 
 在测试过程中产生的调用提供预备好的应答，通常不应答计划之外的任何事。stubs可能记录关于调用的信息，比如 邮件网关的stub 会记录它发送的消息，或者可能仅仅是发送了多少信息。
- Mocks 
 如我们在这里说的那样：预先计划好的对象，带有各种期待，他们组成了一个关于他们期待接受的调用的详细说明。
- 退化和转化
在实际的开发测试过程中，我们会发现其实mock和stub的界限有时候很模糊，并没有严格的划分方式，从而造成我们理解上的含糊和困惑。
主要的原因在于现实使用中，我们经常将mock做不同程度的退化，从而使得mock对象在某些程度上如stub一样工作。以easymock为例，我们可以通过anyObject(), isA(Class)等方式放宽对参数的检测，以atLeatOnce(),anytimes()来放松对调用次数的检测，我们可以使用Easymock.createControl()而不是Easymock.createStrictControl()来放宽对调用顺序的检测(或者调用checkOrder(false))，我们甚至可以通过createNiceControl(), createNiceMock()来创建完全不限制调用方式而且自动返回简单值的mock，这和stub就几乎没有本质区别了。
目前大多数的mock工具都提供mock退化为stub的支持，比如easyock中，除了上面列出的any\*\*\*,NiceMock之外，还提供诸如andStubAnswer() ,andStubDelegateTo() ,andStubReturn() ,andStubThrow() 和asStub()。
上面也谈到过stub也是可以通过增加代码来实现一些expectiation的特性，stub理论上也是可以向mock的方向做转化，而从使得两者的界限更加的模糊。



ref:
1.[浅谈mock和stub](http://www.blogjava.net/aoxj/archive/2010/08/26/329975.html),   2.[[Junit]stub和mock的区别](https://blog.csdn.net/londy_2000/article/details/79485769),   3.[Mock和Stub的初步理解](https://blog.csdn.net/CHS007chs/article/details/54345543)