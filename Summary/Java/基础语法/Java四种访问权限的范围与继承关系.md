#### Java四种访问权限的范围与继承关系
***
##### 代码继承和包结构
```shell
packageM
|
|
|- - - A
|- - - B
|- - - E
|- - - F extends E
|- - - packageN
|- - - |
|- - - |- - - C extends A
|- - - |- - - D
```



##### 访问控制情况

图示如下

![](../../../images/4access.png)

表格如下

|               | 同一个类 | 同一个包 | 不同包的子类 | 不同包的非子类 |
| ------------- | -------- | -------- | ------------ | -------------- |
| public        | √        | √        | √            | √              |
| protected     | √        | √        | √            |                |
| 默认(default) | √        | √        |              |                |
| private       | √        |          |              |                |

> Tips：其中private和protected不能修饰一般的类，否则编译就会报“modifier private not allowed here”，如果是内部类就另当别论了）



##### 默认(friendly)权限
1. 类A和类D**不在同一个包**之中, 类A无法访问类D的友好字段和方法, 类A**只能访问**类D的public字段和方法, 反之亦然.
2. 类A和类B在**同一个包**之中, 类A可以访问类B的友好字段和方法,  反之亦然.



##### 继承的几个问题
1. 继承extends与类所在包的层级无关系, 即和包的位置无直接关系, 间接关系见第3条;
2. 继承的子类可以访问父类的public, protected类型的方法, 不可以访问默认(友好), private的方法,
   可以访问public, protected的字段, 不可以访问默认(友好), private的字段;
3. 继承和默认权限之间的重叠点在于**当父类和子类处于同一个包的时候**, *可以访问其友好字段或方法的, 不在同一个包的时候不可以访问友好的字段和方法*.



##### 默认(friendly)权限和继承的关键点
**简言之**:
默认(友好)管到包的级别,只要是同一个包里面的,既可以访问到友好以上级别的方法和字段;
继承管到protected级别,只要是子类继承了父类,子类就可以访问父类protected级别以上的方法和字段.



ref:
1.[Java中四种访问权限总结](https://blog.csdn.net/itachiyang/article/details/43647909),   2.[Java之访问权限控制符以及结合继承体系引发的注意事项](https://www.cnblogs.com/linux007/p/5865958.html),   3.[java访问权限控制符](https://blog.csdn.net/tmj2014/article/details/7787901),   4.[java中4种修饰符访问权限的区别及详解全过程](https://jingyan.baidu.com/article/fedf0737700b3335ac8977ca.html)