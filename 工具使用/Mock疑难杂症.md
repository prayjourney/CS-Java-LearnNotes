### Mock疑难杂症

---

##### Mock私有方法
先要部分mock, mock一个对象, 然后 mock该私有方法, 在后面replay, verify 
```java
DeleteNativeLunSubProcessor subProcessor = PowerMock.createPartialMock(DeleteNativeLunSubProcessor.class, "deleteNativeLun");
PowerMock.expectPrivate(subProcessor, "deleteNativeLun");
```



##### Mock静态方法
```java
PowerMock.mockStatic(ServiceLocator.class);
```


##### Mock接口
```java
ISiteService siteSerivice = EasyMock.createMock(ISiteService.class);
SiteService siteSerivice2 = PowerMock.createMock(ISiteService.class);
```



##### Mock Exception
```java
// 第一种方式
// 在@Test上面添加
@Test(expected = NullPointerException.class)
// 调用然后抛出异常
LegoCheckedException exception =null;
try{
    UpdatePolicyTemplateTransaction  utt = new   
        UpdatePolicyTemplateTransaction(pci,pg,ptl,ptlOld);
        TransactionStatus ts =new SimpleTransactionStatus(true);
        utt.doInTransaction(ts);
    }catch (LegoCheckedException lego){
        exception =lego;
    }
assertNotNull(exception);
assertEquals(exception.getErrorCode(), IsmErrorCodeConstant.ERR_PARAM);

// 第二种方式:声明异常
// 首先在一开始就声明:
@Rule
public ExpectedException expectEx = ExpectedException.none();
// 然后在后续的测试之中, 使用如下来完成异常的测试.
expectEx.expect(LegoCheckedException.class);
```



---
ref:
1.[powermock模拟私有方法](https://zk1878.iteye.com/blog/1287251),   2.[PowerMock用法](https://stantsang.iteye.com/blog/1357757),   3.[Powermock学习之基本用法](https://blog.csdn.net/weixin_39471249/article/details/80398212),   4.[单元测试中PowerMock常用方法](https://blog.csdn.net/dfqin/article/details/6604610)