### Java枚举类型简介

***

##### 枚举类的创建语法

 创建枚举类型要使用**enum**关键字，**隐含的信息是**所*创建的类型都是 `java.lang.Enum` 类的子类*(`java.lang.Enum` 是一个抽象类)。枚举类型符合通用模式 `Class Enum<E extends Enum<E>>`，而 `E` 表示枚举类型的名称。**枚举类型的每一个值都将映射到 `protected Enum(String name, int ordinal)` 构造函数中**(这解释了为什么在其构造函数可以添加String和int参数)，此处，每个值的名称都被转换成一个字符串，并且序数设置表示了此设置被创建的顺序。

```java
public enum EnumTest {
    MON, TUE, WED, THU, FRI, SAT, SUN;
}
```

上述代码实际上调用了7次 Enum(String name, int ordinal)，相当于如下代码

```java
new Enum<EnumTest>("MON",0);
new Enum<EnumTest>("TUE",1);
new Enum<EnumTest>("WED",2);
......
```



##### enum 对象的常用方法介绍

|                    方法                    |                含义                 |
| :--------------------------------------: | :-------------------------------: |
|          int **compareTo**(E o)          |          比较此枚举与指定对象的顺序。           |
|     Class<E> **getDeclaringClass**()     |    返回与此枚举常量的枚举类型相对应的 Class 对象。    |
|            String **name**()             |     返回此枚举常量的名称，在其枚举声明中对其进行声明。     |
|            int **ordinal**()             | 返回枚举常量的序数（它在枚举声明中的位置，其中初始常量序数为零）。 |
| static  <T extends Enum<T>> T **valueOf**(Class<T> enumType, String name) |        返回枚举常量的名称，它包含在声明中。         |



##### enum的7种用法

用法1: **常量**

在JDK1.5 之前，我们定义常量都是： public static final.... 。现在好了，有了枚举，可以把相关的常量分组到一个枚举类型里，而且枚举提供了比常量更多的方法。

```java
public enum Color {  
  RED, GREEN, BLANK, YELLOW  
} 
```

 

用法2: **switch**

JDK1.6之前的switch语句只支持int, char, enum类型，使用枚举，能让我们的代码可读性更强。

```java
enum Signal {
        GREEN, YELLOW, RED
    }

    public class TrafficLight {
        Signal color = Signal.RED;

        public void change() {
            switch (color) {
            case RED:
                color = Signal.GREEN;
                break;
            case YELLOW:
                color = Signal.RED;
                break;
            case GREEN:
                color = Signal.YELLOW;
                break;
            }
        }
    }
```



用法3: **向枚举中添加新方法**

如果打算自定义自己的方法，那么必须在enum实例序列的最后添加一个分号。而且**Java 要求必须先定义 enum 实例**。

```java
public enum Color {
        RED("红色", 1), GREEN("绿色", 2), BLANK("白色", 3), YELLO("黄色", 4);//;
        // 成员变量
        private String name;
        private int index;

        // 构造方法
        private Color(String name, int index) {
            this.name = name;
            this.index = index;
        }

        // 普通方法
        public static String getName(int index) {
            for (Color c : Color.values()) {
                if (c.getIndex() == index) {
                    return c.name;
                }
            }
            return null;
        }

        // get set 方法
        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getIndex() {
            return index;
        }

        public void setIndex(int index) {
            this.index = index;
        }
    }
```



用法4: **覆盖枚举的方法**

```
public class Test {
    public enum Color {
        RED("红色", 1), GREEN("绿色", 2), BLANK("白色", 3), YELLO("黄色", 4);
        // 成员变量
        private String name;
        private int index;

        // 构造方法
        private Color(String name, int index) {
            this.name = name;
            this.index = index;
        }

        // 覆盖方法
        @Override
        public String toString() {
            return this.index + "_" + this.name;
        }
    }

    public static void main(String[] args) {
        System.out.println(Color.RED.toString());
    }
}
```



用法5: **实现接口**

所有的枚举都继承自`java.lang.Enum`类。由于Java 不支持多继承，所以**枚举对象不能再继承其他类**。

```java
public interface Behaviour {
        void print();

        String getInfo();
    }

    public enum Color implements Behaviour {
        RED("红色", 1), GREEN("绿色", 2), BLANK("白色", 3), YELLO("黄色", 4);
        // 成员变量
        private String name;
        private int index;

        // 构造方法
        private Color(String name, int index) {
            this.name = name;
            this.index = index;
        }

        // 接口方法

        @Override
        public String getInfo() {
            return this.name;
        }

        // 接口方法
        @Override
        public void print() {
            System.out.println(this.index + ":" + this.name);
        }
    }
```



用法6:  **使用接口组织枚举**



```java
public interface Food {
        enum Coffee implements Food {
            BLACK_COFFEE, DECAF_COFFEE, LATTE, CAPPUCCINO
        }

        enum Dessert implements Food {
            FRUIT, CAKE, GELATO
        }
    }
```



用法7：**关于枚举集合的使用**

`java.util.EnumSet`和`java.util.EnumMap`是两个枚举集合。`EnumSet`保证集合中的元素不重复; `EnumMap`中的 key是enum类型，而value则可以是任意类型。具体可以参考JDK文档



##### 枚举和常量定义的区别

- **通常定义常量方法**，我们通常利用public final static方法定义的代码如下，分别用1表示红灯，3表示绿灯，2表示黄灯。

```java
public class Light {
        /* 红灯 */
        public final static int RED = 1;

        /* 绿灯 */
        public final static int GREEN = 3;

        /* 黄灯 */
        public final static int YELLOW = 2;
    }
```



- 枚举类型定义常量方法**，枚举类型的简单定义方法如下，我们似乎没办法定义每个枚举类型的值。比如我们定义红灯、绿灯和黄灯的代码可能如下：

```java
public enum Light {
        RED, GREEN, YELLOW;
    }
```

*我们只能够表示出红灯、绿灯和黄灯，但是具体的值我们没办法表示出来*。但是，**既然枚举类型提供了构造函数，我们可以通过构造函数和覆写toString()方法来实现**。首先给Light枚举类型增加构造方法，然后每个枚举类型的值通过构造函数传入对应的参数，同时覆写toString()方法，在该方法中返回从构造函数中传入的参数，改造后的代码如下：

```java
public enum Light {

    // 利用构造函数传参
    RED(1), GREEN(3), YELLOW(2);

    // 定义私有变量
    private int nCode;

    // 构造函数，枚举类型只能为私有
    private Light(int _nCode) {

        this.nCode = _nCode;
    }

    @Override
    public String toString() {

        return String.valueOf(this.nCode);
    }
}
```



##### 完整示例

```java
public class LightTest {

    // 1.定义枚举类型
    public enum Light {
        // 利用构造函数传参
        RED(1), GREEN(3), YELLOW(2);
      
        // 定义私有变量
        private int nCode;
        // 构造函数，枚举类型只能为私有
        private Light(int _nCode) {
            this.nCode = _nCode;
        }

        @Override
        public String toString() {
            return String.valueOf(this.nCode);
        }
    }

    public static void main(String[] args) {

        // 1.遍历枚举类型
        System.out.println("演示枚举类型的遍历 ......");
        testTraversalEnum();

        // 2.演示EnumMap对象的使用
        System.out.println("演示EnmuMap对象的使用和遍历.....");
        testEnumMap();

        // 3.演示EnmuSet的使用
        System.out.println("演示EnmuSet对象的使用和遍历.....");
        testEnumSet();
    }

    /**
     * 演示枚举类型的遍历
     */

    private static void testTraversalEnum() {
        Light[] allLight = Light.values();
        for (Light aLight : allLight) {
            System.out.println("当前灯name：" + aLight.name());
            System.out.println("当前灯ordinal：" + aLight.ordinal());
            System.out.println("当前灯：" + aLight);
        }
    }

    /**
     * 演示EnumMap的使用，EnumMap跟HashMap的使用差不多，只不过key要是枚举类型
     */

    private static void testEnumMap() {

        // 1.演示定义EnumMap对象，EnumMap对象的构造函数需要参数传入,默认是key的类的类型
        EnumMap<Light, String> currEnumMap = new EnumMap<Light, String>(Light.class);
        currEnumMap.put(Light.RED, "红灯");
        currEnumMap.put(Light.GREEN, "绿灯");
        currEnumMap.put(Light.YELLOW, "黄灯");
      
        // 2.遍历对象
        for (Light aLight : Light.values()) {
          System.out.println("[key=" + aLight.name() + ",value="+ 
                             currEnumMap.get(aLight) + "]");
        }
    }

    /**
     * 演示EnumSet如何使用，EnumSet是一个抽象类，获取一个类型的枚举类型内容
     * 可以使用allOf方法
     */
    private static void testEnumSet() {
        EnumSet<Light> currEnumSet = EnumSet.allOf(Light.class);
        for (Light aLightSetElement : currEnumSet) {
            System.out.println("当前EnumSet中数据为：" + aLightSetElement);
        }
    }
}
```

执行结果如下：

```java
演示枚举类型的遍历 ......

当前灯name：RED

当前灯ordinal：0

当前灯：1

当前灯name：GREEN

当前灯ordinal：1

当前灯：3

当前灯name：YELLOW

当前灯ordinal：2

当前灯：2

演示EnmuMap对象的使用和遍历.....

[key=RED,value=红灯]

[key=GREEN,value=绿灯]

[key=YELLOW,value=黄灯]

演示EnmuSet对象的使用和遍历.....

当前EnumSet中数据为：1

当前EnumSet中数据为：3

当前EnumSet中数据为：2
```



##### enum与class的关系

**可以把 enum 看成是一个普通的 class**，它们都可以定义一些属性和方法，不同之处是：**enum 不能使用 extends 关键字继承其他类**，*因为 enum 已经继承了 java.lang.Enum（java是单一继承）*，其可以添加其他方法，也可覆盖它本身的方法，**enum 的语法结构尽管和 class 的语法不一样，但是经过编译器编译之后产生的是一个class文件**。该class文件经过反编译可以看到实际上是生成了一个类，该类继承了java.lang.Enum<E>。将一开始的EnumTest文件经过反编译(*javap EnumTest* 命令)之后得到的内容如下：

```java
public class EnumTest extends java.lang.Enum{
    public static final EnumTest MON;
    public static final EnumTest TUE;
    public static final EnumTest WED;
    public static final EnumTest THU;
    public static final EnumTest FRI;
    public static final EnumTest SAT;
    public static final EnumTest SUN;
    static {};
    public int getValue();
    public boolean isRest();
    public static EnumTest[] values();
    public static EnumTest valueOf(java.lang.String);
    EnumTest(java.lang.String, int, int, EnumTest);
}
```

所以，实际上 enum 就是一个 class，只不过 java 编译器帮我们做了语法的解析和编译而已。



##### 总结

如下代码，大家都这样用了很长时间了，以为没什么问题，但实际上，**它不是类型安全的**，必须确保是int，

**还要确保它的范围是0和1**，**打印出来的数据只有1和0，意义不明** 

```java
public class State {
public static final int ON = 1;
public static final Int OFF= 0;
}
```

values()方法是编译器插入到enum定义中的static方法，所以，当你将enum实例向上转型为父类Enum时候，values()就不可访问了。解决办法为**在Class中有一个getEnumConstants()方法**，所以即便Enum接口中没有values()方法，我们仍然可以通过Class对象取得所有的enum实例。无法从enum继承子类，如果需要扩展enum中的元素，在一个接口的内部，创建实现该接口的枚举，以此将元素进行分组。达到将枚举元素进行分组。使用EnumSet代替标志。enum要求其成员都是唯一的，但是enum中不能删除添加元素，EnumMap的key是enum，value是任何其他Object对象，enum允许程序员为eunm实例编写方法。所以可以为每个enum实例赋予各自不同的行为。



ref:

1.[Java enum的用法详解](http://www.cnblogs.com/happyPawpaw/archive/2013/04/09/3009553.html), 2.[java enum(枚举)使用详解 + 总结](http://www.cnblogs.com/hyl8218/p/5088287.html), 3.[Java中的Enum的使用与分析](http://www.cnblogs.com/frankliiu-java/archive/2010/12/07/1898721.html), 4.[Java 枚举(enum) 详解7种常见的用法](http://blog.csdn.net/qq_27093465/article/details/52180865)