### 注解Annotation实现原理与自定义注解例子
***

##### 什么是注解？
对于很多初次接触的开发者来说应该都有这个疑问？**Annontation**是Java5开始引入的新特征，中文名称叫**注解**。它提供了一种安全的类似注释的机制，**用来将任何的信息或元数据（metadata）与程序元素（类、方法、成员变量等）进行关联**。为程序的元素（类、方法、成员变量）加上更直观更明了的说明，**这些说明信息是与程序的业务逻辑无关，并且供指定的工具或框架使用**。Annontation像一种修饰符一样，**应用于包、类型、构造方法、方法、成员变量、参数及本地变量的声明语句中**。
Java注解是附加在代码中的一些元信息，用于一些工具在编译、运行时进行解析和使用，起到说明、配置的功能。**注解不会也不能影响代码的实际逻辑，仅仅起到辅助性的作用**。包含在 java.lang.annotation 包中。

 

##### 注解的用处：
1、生成文档。这是最常见的，也是java 最早提供的注解。常用的有@param @return 等
2、跟踪代码依赖性，实现替代配置文件功能。比如Dagger 2依赖注入，未来java开发，将大量注解配置，具有很大用处;
3、在编译时进行格式检查。如@override 放在方法前，如果你这个方法并不是覆盖了超类方法，则编译时就能检查出。

 

##### 注解的原理：
注解本质是一个继承了Annotation的特殊接口，其具体实现类是Java运行时生成的动态代理类。而我们通过反射获取注解时，返回的是Java运行时生成的动态代理对象$Proxy1。通过代理对象调用自定义注解（接口）的方法，会最终调用AnnotationInvocationHandler的invoke方法。该方法会从memberValues这个Map中索引出对应的值。而memberValues的来源是Java常量池。
不管注解定义的怎么好，如果没有注解的解析器，那注解和注释其实没有太大的区别，注解的解释器，采用了反射来做辅助，将字段，构造器，方法，类型等信息或取出来，来完成相关的操作。

 

##### 元注解：
java.lang.annotation提供了四种元注解，专门注解其他的注解（在自定义注解的时候，需要使用到元注解）：
**@Documented** –注解是否将包含在JavaDoc中
**@Retention** –什么时候使用该注解
**@Target** –注解用于什么地方
**@Inherited** – 是否允许子类继承该注解

1.@Retention– 定义该注解的生命周期
  ●   RetentionPolicy.SOURCE : 在编译阶段丢弃。这些注解在编译结束之后就不再有任何意义，所以它们不会写入字节码。@Override, @SuppressWarnings都属于这类注解。
  ●   RetentionPolicy.CLASS : 在类加载的时候丢弃。在字节码文件的处理中有用。注解默认使用这种方式
  ●   **RetentionPolicy.RUNTIME** : *始终不会丢弃，运行期也保留该注解，因此可以使用反射机制读取该注解的信息。我们自定义的注解通常使用这种方式*。

2.Target – 表示该注解用于什么地方。默认值为任何元素，表示该注解用于什么地方。可用的ElementType参数包括
  ● ElementType.CONSTRUCTOR:用于描述构造器
  ● **ElementType.FIELD**:成员变量、对象、属性（包括enum实例）
  ● ElementType.LOCAL_VARIABLE:用于描述局部变量
  ● **ElementType.METHOD**:用于描述方法
  ● ElementType.PACKAGE:用于描述包
  ● **ElementType.PARAMETER**:用于描述参数
  ● ElementType.TYPE:用于描述类、接口(包括注解类型) 或enum声明

3.@Documented–一个简单的Annotations标记注解，表示是否将注解信息添加在java文档中。

4.@Inherited – 定义该注释和子类的关系
@Inherited 元注解是一个标记注解，@Inherited阐述了某个被标注的类型是被继承的。如果一个使用了@Inherited修饰的annotation类型被用于一个class，则这个annotation将被用于该class的子类。

 

##### 常见标准的Annotation：
1.Override
java.lang.Override是一个标记类型注解，它被用作标注方法。它说明了被标注的方法重载了父类的方法，起到了断言的作用。如果我们使用了这种注解在一个没有覆盖父类方法的方法时，java编译器将以一个编译错误来警示。
2.Deprecated
Deprecated也是一种标记类型注解。当一个类型或者类型成员使用@Deprecated修饰的话，编译器将不鼓励使用这个被标注的程序元素。所以使用这种修饰具有一定的“延续性”：如果我们在代码中通过继承或者覆盖的方式使用了这个过时的类型或者成员，虽然继承或者覆盖后的类型或者成员并不是被声明为@Deprecated，但编译器仍然要报警。
3.SuppressWarnings
SuppressWarning不是一个标记类型注解。它有一个类型为String[]的成员，这个成员的值为被禁止的警告名。对于javac编译器来讲，被-Xlint选项有效的警告名也同样对@SuppressWarings有效，同时编译器忽略掉无法识别的警告名。@SuppressWarnings("unchecked")

 

##### 自定义注解：
自定义注解类编写的一些规则:
1.**Annotation型定义为@interface**, 所有的Annotation会自动继承java.lang.Annotation这一接口,并且不能再去继承别的类或是接口.
2.参数成员只能用public或默认(default)这两个访问权修饰
3.**参数成员只能用基本类型**byte,short,char,int,long,float,double,boolean八种基本数据类型和String、Enum、Class、annotations等数据类型,以及这一些类型的数组.
4.要获取类方法和字段的注解信息，**必须通过Java的反射技术来获取 Annotation对象**,因为你除此之外没有别的获取注解对象的方法
5.注解也可以没有定义成员, 不过这样注解就没啥用了
**PS:自定义注解需要使用到元注解**



##### 自定义注解语法：
```java
@Target(FIELD)//注解起作用的地方
@Retention(RUNTIME)//注解生命周期
@Documented
public @interface FruitName {
    public String name() default "";//相当于一个属性的get方法, 不过 可以设置默认值, 用default来表示. 返回值类型为基本类型和上述之中3中的说明类型
}
//注解就是定义一个方法, 相当于是一个get方法, 一个属性一个方法, 有defaut来定义默认值, 而这个"字段"在注解定义的地方, 写出来
```
**定义完了注解, 然后就需要写注解解析器, 这才是注解起作用的关键, 注解解析器, 主要使用反射来获取信息.**



##### 自定义注解实例：
FruitName.java
```java
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
 
/**
 * 水果名称注解
 */
@Target(FIELD)
@Retention(RUNTIME)
@Documented
public @interface FruitName {
    // 相当于一个get方法, 而这个对应的属性, 是在定义的时候通过 name= "XXX"这种方式定义的
    public String name() default "";
    // 当只有一个元素的时候, 可以通过value来获取值, 在定义的地方可以直接写(xxx), 而不用写(value= xxx)或者(id= xxx)这种
}
//注解就是定义一个方法, 相当于是一个get方法, 一个属性一个方法, 有defaut来定义默认值, 而这个"字段"在注解定义的地方, 写出来
```

FruitColor.java
```java
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;
/*水果颜色注解*/
@Documented
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.FIELD)
public @interface FruitColor {
    /**
     * 颜色枚举类
     */
    public enum Color {
        RED, GREEN, YELLOW
    }

    /**
     * 颜色属性
     *
     * @return
     */
    public Color fruitColor() default Color.YELLOW;
}
```

FruitProvider.java
```java
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * 水果供应者注解
 */
@Target(ElementType.FIELD)
@Retention(RUNTIME)
@Documented
public @interface FruitProvider {
    /**
     * 供应商编号
     *
     * @return
     */
    public int id() default -1;

    /**
     * 供应商名称
     *
     * @return
     */
    public String name() default "";

    /**
     * 供应商地址
     *
     * @return
     */
    public String address() default "";
}
```

FruitInfoUtil.java
```java
import java.lang.reflect.Field;
// 注解处理器才是注解的关键所在
/**
 * 注解处理器
 */
@Slf4j
public class FruitInfoUtil {
    public static void getFruitInfo(Class<?> clazz) {
        String fruitName = "水果名称: ";
        String fruitColor = "水果颜色: ";
        String fruitProvider = "水果供应商: ";

        Field[] fields = clazz.getDeclaredFields();
        for (Field f : fields) {
            if (f.isAnnotationPresent(FruitName.class)) {
                FruitName name = (FruitName) f.getAnnotation(FruitName.class);
                fruitName = fruitName + name.name();
                System.out.println(fruitName);
            } else if (f.isAnnotationPresent(FruitColor.class)) {
                FruitColor color = f.getAnnotation(FruitColor.class);
                fruitColor = fruitColor + color.fruitColor();
                System.out.println(fruitColor);
            } else if (f.isAnnotationPresent(FruitProvider.class)) {
                FruitProvider provider = f.getAnnotation(FruitProvider.class);
                fruitProvider = fruitProvider + "水果供应商的name: " + provider.name() + ", 水果供应商的id: " + provider.id()
                        + ", 水果供应商的地址: " + provider.address();
                System.out.println(fruitProvider);
            } else {
                log.info("没有对应的注解字段");
            }
        }
    }

    public static String getFruitName(Class<?> clazz) {
        String fruitName = "水果名称: ";
        Field[] fields = clazz.getDeclaredFields();
        for (Field f : fields) {
            if (f.isAnnotationPresent(FruitName.class)) {
                FruitName name = (FruitName) f.getAnnotation(FruitName.class);
                fruitName = fruitName + name.name();
            }
        }
        return fruitName;
    }

    public static String getFruitColor(Class<?> clazz) {
        String fruitColor = "水果颜色: ";

        Field[] fields = clazz.getDeclaredFields();
        for (Field f : fields) {
            if (f.isAnnotationPresent(FruitColor.class)) {
                FruitColor color = f.getAnnotation(FruitColor.class);
                fruitColor = fruitColor + color.fruitColor();
            }
        }
        return fruitColor;
    }

    public static String getFruitProvider(Class<?> clazz) {
        String fruitProvider = "水果供应商: ";

        Field[] fields = clazz.getDeclaredFields();
        for (Field f : fields) {
            if (f.isAnnotationPresent(FruitProvider.class)) {
                FruitProvider provider = f.getAnnotation(FruitProvider.class);
                //一个字段, 其实获取了所有的相关的字段信息了
                fruitProvider = fruitProvider + "水果供应商的name: " + provider.name() + ", 水果供应商的id: " + provider.id()
                        + ", 水果供应商的地址: " + provider.address();
            }
        }
        return fruitProvider;
    }
}
```

Apple.java
```java
import test.FruitColor.Color;

/**
 * 注解使用
 */
public class Apple {
    
    @FruitName("Apple")
    private String appleName;
    
    @FruitColor(fruitColor=Color.RED)
    private String appleColor;
     
    @FruitProvider(id=1,name="陕西红富士集团",address="陕西省西安市延安路89号红富士大厦")
    private String appleProvider;
    
    public void setAppleColor(String appleColor) {
        this.appleColor = appleColor;
    }
    public String getAppleColor() {
       return appleColor;
    }
    
    public void setAppleName(String appleName) {
        this.appleName = appleName;
    }
    public String getAppleName() {
        return appleName;
    }
    
    public void setAppleProvider(String appleProvider) {
        this.appleProvider = appleProvider;
    }
    public String getAppleProvider() {
        return appleProvider;
    }
    
    public void displayName(){
        System.out.println("水果的名字是：苹果");
    }
}
```

FruitRun.java
```java
/**
 * 输出结果
 */
public class FruitRun {
    public static void main(String[] args) {
        FruitInfoUtil.getFruitInfo(Apple.class);
    }
}
```

运行结果是：
>  水果名称：Apple
>  水果颜色：RED
>  供应商编号：1 供应商名称：陕西红富士集团 供应商地址：陕西省西安市延安路89号红富士大厦



##### 注解图解
![annotationnotes](../../../images/annotationnotes.jpg)



ref:
1.[注解Annotation实现原理与自定义注解例子](https://www.cnblogs.com/acm-bingzi/p/javaAnnotation.html),   2.[Java注解（Annotation）原理详解](https://blog.csdn.net/lylwo317/article/details/52163304),   3.[Java学习之注解Annotation实现原理](https://www.cnblogs.com/whoislcj/p/5671622.html),   4.[深入理解Java：注解（Annotation）--注解处理器](https://www.cnblogs.com/peida/archive/2013/04/26/3038503.html),   5.[深入理解Java：注解（Annotation）自定义注解入门](https://www.cnblogs.com/peida/archive/2013/04/24/3036689.html),   6.[Java注解(Annotation)详解](https://juejin.im/post/5af415ba6fb9a07ac76ed820),   7.[Java Annotation认知(包括框架图、详细介绍、示例说明)](https://www.cnblogs.com/skywang12345/p/3344137.html),   8.[Java基础之理解Annotation](https://www.cnblogs.com/mandroid/archive/2011/07/18/2109829.html),   9.[秒懂，Java 注解 （Annotation）你可以这样学](https://blog.csdn.net/briblue/article/details/73824058),   10.[java 注解的几大作用及使用方法详解（完）](https://blog.csdn.net/tigerdsh/article/details/8848890),   11.[Java注解处理器使用详解](https://blog.csdn.net/albertfly/article/details/52402684),   12.[深入理解Java注解类型(@Annotation)](https://blog.csdn.net/javazejian/article/details/71860633),   12.[史上最全的 Java 新手问题汇总](http://www.codeceo.com/article/java-newer-problems.html),   13.[Java 泛型详解](http://www.importnew.com/26387.html),   14.[框架基础——全面解析Java注解](http://www.cnblogs.com/Qian123/p/5256084.html),   15.[Java注解入门](http://www.cnblogs.com/linjiqin/p/4441691.html),   16.[Java 注解简介](http://www.cnblogs.com/xuningchuanblogs/p/7763225.html),   17.[框架开发之Java注解的妙用](http://www.importnew.com/23564.html),   18.[java注解框架](http://www.cnblogs.com/deman/p/5519901.html),   19.[Java注解入门介绍](http://blog.csdn.net/lb850747906/article/details/52145346),    20.[Java注解全面解析](http://www.cnblogs.com/longshiyVip/p/5189525.html),   21.[java 注解](http://www.cnblogs.com/xiaomoxian/p/5199601.html)