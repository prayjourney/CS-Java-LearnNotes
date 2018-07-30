###  Java编程规范整理
***
####  基本命名规范

##### 包命名
包名按照域名的范围从大到小逐步列出，恰好和Internet上的域名命名规则相反。
由一组以“.”连接的标识符构成，通常第一个标识符为符合网络域名的两个或者三个英文小写字母。
```java
People
TestPage
XMLExample
```



##### 类, 接口命名
类的名字必须由大写字母开头而单词中的其他字母均为小写；如果类名称由多个单词组成，则每个单词的首字母均应为大写例如TestPage；如果类名称中包含单词缩写，则这个所写词的每个字母均应大写，如：XMLExample,还有一点命名技巧就是由于类是设计用来代表对象的，**所以在命名类时应尽量选择名词**。
```java
People
TestPage
XMLExample
```

##### 方法名
方法的名字的第一个单词应以小写字母作为开头，后面的单词则用大写字母开头。**可以为动词或动词+名词组合**。
*设置/获取某个值的Method，应该遵循setV/getV规范;*
*返回长度的Method，应该命名为length;*
*测试某个布尔值的Method，应该命名为isV;*
*将对象转换为某个特定类型的Mehod应该命名为toF;*
```java
getDate();
length();
isReady();
toOracleFormat();
```



##### 变量名
1. 普通变量命名应该采用首字母小写，其他字母首字母大写的方式。
2. final static变量的名字应该都大写，并且指出完整含义。如果一个常量名称由多个单词组成，则应该用下划线来分割这些单词如。
```java
NUM_DAYS_IN_WEEK
MAX_VALU
```
3. 如果需要对变量名进行缩写时，一定要注意整个代码中缩写规则的一致性
```java
context=ctx
message=msg
```
4. 通过在结尾处放置一个量词，就可创建更加统一的变量
```java
First（一组变量中的第一个）
Last（一组变量中的最后一个）
Next（一组变量中的下一个变量）
Prev（一组变量中的上一个）
Cur（一组变量中的当前变量）
```
5. 无论什么时候，均提倡应用常量取代数字、固定字符串。也就是说，程序中除0，1以外，尽量不应该出现其他数字。
6. 索引变量：i、j、k等只作为小型循环的循环索引变量。
7. 逻辑变量：避免用flag来命名状态变量，用is来命名逻辑变量。
```java
if(isClosed){
    dosomeworks;
    return;
}
```



#####  数组
总是使用以下方式定义数组：
```java
int[] arr = new int[10];
```
禁止使用C语言的是形式:
```java
禁止
int arr[] = new int[10];
```



#### 集合
**数组或者容器推荐命名方式为名词+s的方式**，例如：
```java
List<Person> persons = getPerson();
for(Person person : persons){
    dosomeworks;
}
```



#### 泛型
应该尽量简明扼要（最好是一个字母），以利于与普通的class或interface区分
Container中的Element应该用E表示；Map里的key用K表示，value用V；Type用T表示；异常用X表示
如果需要接收多个Type类型的参数，应该用邻接T的大写字母——例如S——来依次表示，当然也可以用T1, T2这样的方式
```java
public
class HashSet<E> extends AbstractSet<E> {…}

public
class HashMap<K, V> extends AbstractMap<K, V> {…}

public
class ThreadLocal<T> {…}

public
interface Functor<T, X extends Throwable> {

    T val() throws X;

}
```



#### 推荐的命名
1. 当要区别接口和实现类的时候，可以在类的后面加上“Impl”。
2. Exception类最好能用“Exception”做为类命名的结尾
3. 抽象类最好能用“Abstract”做为类命名的开头
4. Test类最好能用“Test”做为类命名的结尾
5. 简称与缩写（不推荐使用）

除非是在循环中，否则一般不推荐使用单个字母作为变量名，不过也有例外，即约定俗成的单个字母




#### 代码风格
##### 花括号
花括号统一采用以下格式：
```java
if(bool experssion){
    dosomework;
}
```
除非花括号中为空，不然任何情况下不能省略花括号，并且花括号必须换行，例如：
```java
if(i==0){
    return;
}
while(true)    {}
```
以下写法禁止出现：
```java
禁止
if(i != 0)  return;
禁止
if(i !=0)    {return;}
```



##### 括号
括号的前，后一个字符不需要空格，例如：
```java
Person p = new Person(“Jack”, 17);
```



##### 空格
1. 逗号之后紧跟一个空格。
```java
Person p = new Person(“Jack”, 16, “China”);
```
2.　二元操作符前后跟空格。
```java
int i = a + b – c * d;
```
3. 一元操作符不需要空格,for语句分号后有空格。
```java
for(int i = 0; I < 10; i++){
    dosomework;
}
```
4. 括号前后不需要空格



#### 类
1. 类的定义结构按照顺序为：
:one:   常量
:two:   成员变量
:three:   构造函数
:four:   成员函数
:five:   get和set方法
**各个部分之间留出一个空行**。
```java
//规范类模板：
class Person{
    private final static int MAX_AGE = 100;

    private String firstname = “Jack”;

    public Person(){}
    public Person(String firstname){
        this.firstname = firstname;
    }

    public void doExercise(){
        dosomeworks;
        run();
    }
    private void run(){
        dosomeworks;
    }

    public getFirstname(){
        return firstname;
    }
    public setFirstname(String firstname){
        this.firstname = firstname;
    }
}
```

2. 构造函数
:one:   参数为空的构造函数出现在最上方
:two:   有调用关系的构造函数相邻
:three:   参数尽量由少到多从上至下排序

3. 使用成员变量
在类的方法内引用成员变量了命名冲突以外，不使用this。非特殊情况在类的方法内都不使用get和set方法存取成员变量。

4. 方法
有调用关系的方法尽量放在相邻的位置，public和private方法可以交叉放置。

5. get和set方法，所有需要公开的成员变量都要符合良好的javabean规范，提供get和set方法，尽量使用IDE工具自动生成。



#### Javadoc注释
在每个程序的最开始部分，一般都用Javadoc注释对程序的总体描述以及版权信息，之后在主程序中可以为每个类、接口、方法、字段添加 Javadoc注释，每个注释的开头部分先用一句话概括该类、接口、方法、字段所完成的功能，这句话应单独占据一行以突出其概括作用，在这句话后面可以跟随更加详细的描述段落。在描述性段落之后还可以跟随一些以Javadoc注释标签开头的特殊段落，例如上面例子中的@auther和@version，这些段落将在生成文档中以特定方式显示



ref:
1.[Java编程规范整理](https://www.cnblogs.com/coolhwm/archive/2012/03/22/2411811.html),   2.[Google Java编程风格指南](http://www.hawstein.com/posts/google-java-style.html)


