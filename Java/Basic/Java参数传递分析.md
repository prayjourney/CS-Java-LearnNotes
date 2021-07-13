#### Java之中的参数传递，只有按值传递！！！


#### 传递类型

按值传递：就是把原来的参数的值，拷贝一份，将这个拷贝的值修改，而原来的旧的值不会修改。
引用传递：就是将参数的地址拿来使用，不去拷贝，直接在这个地址上操作，这样的话，就会把原来的值也修改了。


#### Java参数传递是值传递还是引用传递？

当一个对象被当作参数传递到一个方法后，在此方法内可以改变这个对象的属性，那么这里到底是值传递还是引用传递?
答：是值传递。Java 语言的参数传递只有值传递。当一个实例对象作为参数被传递到方法中时，参数的值就是该对象的引用的一个副本。指向同一个对象，对象的内容可以在被调用的方法内改变，但对象的引用(不是引用的副本) 是永远不会改变的。


#### 值传递的证明

如果是引用传递，那么我们修改操作的时候，直接是对地址进行操作，意味着我们的操作，都是直接对这个地址上的内容进行修改，所以这个修改是必然生效的，而如果是值传递，那么意味着，我传过去的参数，只是一个值，我们知道，一个对象是分配在内存地址上的，而如果只是传了一个参数的话，这就意味着，我们的参数原先的位置等信息，没有传递过去，而只是传了一个拷贝的值，这个拷贝的值，是在一个新的地址上，我们对一个对象进行更新操作，这必然意味着我们直接对这个地址上所承载和分配的内容进行了修改，而如果只是值传递，那么就是将我们的参数的值，进行了一个拷贝，而对原来的值，没有改动，没有改动原来地址上的内容。所以按照这个而言，值传递，不会修改参数的原来的内容。那么是不是这样呢？

```java
/**
 * @Author zgy
 * @Date 2020/6/15
 * @Description 总的结论： Java是按照值传递的，而不是按照引用，
 * 按值传递：  就是把原来的参数的值，拷贝一份，将这个拷贝的值修改，而原来的旧的值不会修改
 * 引用传递：就是将参数的地址拿来使用，不去拷贝，直接在这个地址上操作，这样的话，就会把原来的值也修改了
 */
public class TransferParam {

    public static void main(String[] args) {
        // 基本类型的值传递
        System.out.println("===========基本类型的值传递============");
        int age = 22;
        System.out.println("调用changeData(int data)方法前: " + age);
        changeDataBasic(age);
        System.out.println("调用changeData(int data)方法后: " + age + "\n");

        // 基本类型的值传递, String
        System.out.println("===========基本类型的值传递:String============");
        String name = "张三";
        System.out.println("调用changeString(String str)方法前: " + name);
        changeString(name);
        System.out.println("调用changeString(String str)方法后: " + name + "\n\n");

        // 对象类型的值传递
        System.out.println("+++++++++++对象类型的值传递++++++++++++++");
        Map<String, String > map = new HashMap<>();
        map.put("name", "李小龙");
        System.out.println("调用changeDataObject(Map<String, String> map)方法前: " + map);
        changeDataObject(map);
        System.out.println("调用changeDataObject(Map<String, String> map)方法后: " + map + "\n");

        // 对象类型的值传递, 普通的对象
        System.out.println("+++++++++++对象类型的值传递:People++++++++++++++");
        Map<String, String> info = new HashMap<>();
        info.put("address", "北京朝阳");
        info.put("home", "四川成都");
        People people = People.builder().age(22).name("lee").info(info).build();
        System.out.println("调用changePeople(People people)方法前: " + people);
        changePeople(people);
        System.out.println("调用changePeople(People people)方法后: " + people);


    }

    public static void changeDataBasic(int data) {
        data = 100;
        System.out.println("方法中： " + data);
    }

    public static void changeDataObject(Map<String, String> map){
        Map<String, String > testMap = new HashMap<>();
        testMap.put("name", "zhangsan");
        map = testMap;
        System.out.println("方法中： " + map);
    }

    public static void changeString(String str){
        str ="Hello world!";
        System.out.println("方法中： " + str);
    }

    public static void changePeople(People people){
        Map<String, String> info2 = new HashMap<>();
        info2.put("address", "北京");
        info2.put("home", "四川雅安");
        People people2 = People.builder().age(22).name("lee").info(info2).build();
        people = people2;
        System.out.println("方法中： " + people2);
    }
}

@Data
@Builder
class People {
    private String name;
    private Integer age;
    private Map<String, String> info;
}
```

我们分别对普通的基本类型，String对象，Map对象和自定义的People对象，进行了测试，都证明了是值的传递，而非引用传递，输出的结果如下：

```ini
===========基本类型的值传递============
调用changeData(int data)方法前: 22
方法中： 100
调用changeData(int data)方法后: 22

===========基本类型的值传递:String============
调用changeString(String str)方法前: 张三
方法中： Hello world!
调用changeString(String str)方法后: 张三


+++++++++++对象类型的值传递++++++++++++++
调用changeDataObject(Map<String, String> map)方法前: {name=李小龙}
方法中： {name=zhangsan}
调用changeDataObject(Map<String, String> map)方法后: {name=李小龙}

+++++++++++对象类型的值传递:People++++++++++++++
调用changePeople(People people)方法前: People(name=lee, age=22, info={address=北京朝阳, home=四川成都})
方法中： People(name=lee, age=22, info={address=北京, home=四川雅安})
调用changePeople(People people)方法后: People(name=lee, age=22, info={address=北京朝阳, home=四川成都})
```


#### 值传递的分析

如下作为分析，在我们对基本类型操作的时候，比如如下的age=22，在调用changeDataBasic方法的前后，其实就相当于在内存中把age复制了一份，在调用之中，传递的是拷贝的一份，这拷贝的一份，我们可以在changeDataBasic方法之中，随意操作，但是它影响不了外面的age的值，因为这已经是两份对象。

```java
    public static void main(String[] args) {
        System.out.println("===========基本类型的值传递============");
        int age = 22;
        System.out.println("调用changeData(int data)方法前: " + age);
        changeDataBasic(age);
        System.out.println("调用changeData(int data)方法后: " + age + "\n");
    }

    public static void changeDataBasic(int data) {
        data = 100;
        System.out.println("方法中： " + data);
    }
```

![java值传递分析](https://img2020.cnblogs.com/blog/637525/202006/637525-20200615175335502-948753140.png)


#### 等号"="的操作含义

对于基本数据类型来说 “=”赋值操作是直接改变内存地址(存储单元)上的值。
对于引用类型来说 “=” 赋值操作是改变引用变量所指向的内存地址(上文中存储单元)。


#### 容易导致混淆的赋值

```java
/**
 * @Author zgy
 * @Date 2020/6/15
 * @Description 总的结论： Java是按照值传递的，而不是按照引用，
 * 按值传递：  就是把原来的参数的值，拷贝一份，将这个拷贝的值修改，而原来的旧的值不会修改
 * 引用传递：就是将参数的地址拿来使用，不去拷贝，直接在这个地址上操作，这样的话，就会把原来的值也修改了
 * <p>
 * 虽然值传递和引用传递尘埃落定，在Java之中只有值传递，但是有个操作很容易造成迷惑，就是赋值，以如下基本类型和Map对象来演示
 */
public class TransferParam2 {
    public static void main(String[] args) {
        // 基本类型的值传递
        System.out.println("===========基本类型的值传递============");
        int age = 22;
        System.out.println("调用changeData(int data)方法前: " + age);
        changeDataBasic(age);
        System.out.println("调用changeData(int data)方法后: " + age + "\n");

        // 对象类型的值传递
        System.out.println("===========对象类型的值传递============");
        Map<String, String> map = new HashMap<>();
        map.put("name", "李小龙");
        System.out.println("调用changeDataObject(Map<String, String> map)方法前: " + map);
        changeDataObject(map);
        System.out.println("调用changeDataObject(Map<String, String> map)方法后: " + map + "\n\n");

        // 基本类型的值传递, 但是赋值行为改变了作用范围
        System.out.println("++++++++++++基本类型的值传递: 返回值赋值修改了值+++++++++++++");
        int age2 = 22;
        System.out.println("调用changeDataReturn(int data)方法前: " + age2);
        // 赋值行为修改了原先的值
        age2 = changeDataBasicReturn(age);
        System.out.println("调用changeDataReturn(int data)方法后: " + age2 + "\n");

        // 对象类型的值传递, 但是赋值行为改变了作用范围
        System.out.println("++++++++++++对象类型的值传递: 返回值赋值修改了值++++++++++++++");
        Map<String, String> map2 = new HashMap<>();
        map2.put("name", "陈真");
        System.out.println("调用changeDataObjectReturn(Map<String, String> map)方法前: " + map2);
        // 赋值行为修改了原先的值
        map2 = changeDataObjectReturn(map2);
        System.out.println("调用changeDataObjectReturn(Map<String, String> map)方法后: " + map2 + "\n\n");
    }

    // 这是空方法, 没有赋值行为, 对拷贝内容的修改, 仅仅局限于方法内, 返回是void, 对外不造成影响
    public static void changeDataBasic(int data) {
        data = 100;
        System.out.println("方法中： " + data);
    }

    public static void changeDataObject(Map<String, String> map) {
        Map<String, String> testMap = new HashMap<>();
        testMap.put("name", "zhangsan");
        map = testMap;
        System.out.println("方法中： " + map);
    }

    // 该方法有返回值, 值传递中拷贝的内容, 在修改之后, 可以通过该方法进行赋值, 所以会对外造成影响
    public static int changeDataBasicReturn(int data) {
        data = 100;
        System.out.println("方法中： " + data);
        return data;
    }

    public static Map<String, String> changeDataObjectReturn(Map<String, String> map) {
        Map<String, String> testMap = new HashMap<>();
        testMap.put("name", "zhangsan");
        map = testMap;
        System.out.println("方法中： " + map);
        return map;
    }
}
```

输出的结果如下

```ini
===========基本类型的值传递============
调用changeData(int data)方法前: 22
方法中： 100
调用changeData(int data)方法后: 22

===========对象类型的值传递============
调用changeDataObject(Map<String, String> map)方法前: {name=李小龙}
方法中： {name=zhangsan}
调用changeDataObject(Map<String, String> map)方法后: {name=李小龙}


++++++++++++基本类型的值传递: 返回值赋值修改了值+++++++++++++
调用changeDataReturn(int data)方法前: 22
方法中： 100
调用changeDataReturn(int data)方法后: 100

++++++++++++对象类型的值传递: 返回值赋值修改了值++++++++++++++
调用changeDataObjectReturn(Map<String, String> map)方法前: {name=陈真}
方法中： {name=zhangsan}
调用changeDataObjectReturn(Map<String, String> map)方法后: {name=zhangsan}
```

如果单纯从上述的代码之中看，那我们很可能就会认为是引用传递起了作用，但是我们要知道，引用传递起作用是发生在一个整体的同一个步骤之中，而不像此处，先传值，然后再去通过方法的返回值，去赋值，这样就是两个步骤了，这种操作，会让人一下子有点迷惑，但是其实还是很好理解的，就是说，一步到位的就一定是引用传递，而我们只需记住，Java之中只有按值传递，所有的参数传递操作，都是传递了值的拷贝，也就是值的内容，而非对象的地址。

#### 参考：

>辨析Java方法参数中的值传递和引用传递：https://www.cnblogs.com/lingyejun/p/11028808.html
>java参数传递（到底是值传递还是引用传递？）：https://www.cnblogs.com/hpyg/p/8005599.html
>Java参数传递是值传递还是引用传递？：https://www.cnblogs.com/9513-/p/8484071.html
>java基础——方法参数（值传递和引用传递）：https://blog.csdn.net/a303015136/article/details/95070819
>Java 到底是值传递还是引用传递？：https://www.zhihu.com/question/31203609?sort=created
