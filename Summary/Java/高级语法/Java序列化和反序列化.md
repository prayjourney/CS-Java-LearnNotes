### Java序列化和反序列化
***

##### 序列化和反序列化的概念
序列化：**把对象转换为字节序列的过程称为对象的序列化**。
反序列化：**把字节序列恢复为对象的过程称为对象的反序列化**。
对象的序列化主要有两种用途：
1.**把对象的字节序列永久地保存到硬盘上，通常存放在一个文件中**
2.**在网络上传送对象的字节序列**
在很多应用中，需要对某些对象进行序列化，让它们离开内存空间，入住物理硬盘，以便长期保存。比如最常见的是Web服务器中的Session对象，当有 10万用户并发访问，就有可能出现10万个Session对象，内存可能吃不消，于是Web容器就会把一些seesion先序列化到硬盘中，等要用了，再把保存在硬盘中的对象还原到内存中。当两个进程在进行远程通信时，彼此可以发送各种类型的数据。无论是何种类型的数据，都会以二进制序列的形式在网络上传送。发送方需要把这个Java对象转换为字节序列，才能在网络上传送；接收方则需要把字节序列再恢复为Java对象。

##### JDK类库中的序列化API
**序列化API**
`java.io.ObjectOutputStream`代表对象输出流，它的writeObject(Object obj)方法可对参数指定的obj对象进行序列化，把得到的字节序列写到一个目标输出流中。
`java.io.ObjectInputStream`代表对象输入流，它的readObject()方法从一个源输入流中读取字节序列，再把它们反序列化为一个对象，并将其返回。
只有实现了**Serializable**和**Externalizable**接口的类的对象才能被序列化。*Externalizable接口继承自 Serializable接口*，++实现Externalizable接口的类完全由自身来控制序列化的行为，而仅实现Serializable接口的类可以 采用默认的序列化方式+。
**对象(反)序列化步骤**
>对象序列化包括如下步骤：
>1.创建一个对象输出流，它可以包装一个其他类型的目标输出流，如文件输出流；
>2.通过对象输出流的writeObject()方法写对象。

>对象反序列化的步骤如下：
>1.创建一个对象输入流，它可以包装一个其他类型的源输入流，如文件输入流；
>2.通过对象输入流的readObject()方法读取对象。

**对象序列化和反序列范例：**
定义一个Person类，实现Serializable接口
```java
import java.io.Serializable;
/**
 * <p>ClassName: Person<p>
 * <p>Description:测试对象序列化和反序列化<p>
 * @author xudp
 * @version 1.0 V
 * @createTime 2014-6-9 下午02:33:25
 */
public class Person implements Serializable {

    /**
     * 序列化ID
     */
    private static final long serialVersionUID = -5809782578272943999L;
    private int age;
    private String name;
    private String sex;

    public int getAge() {
        return age;
    }

    public String getName() {
        return name;
    }

    public String getSex() {
        return sex;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }
}
```

**序列化和反序列化Person类对象**

```java
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.text.MessageFormat;

/**
 * <p>ClassName: TestObjSerializeAndDeserialize<p>
 * <p>Description: 测试对象的序列化和反序列<p>
 * @author xudp
 * @version 1.0 V
 * @createTime 2014-6-9 下午03:17:25
 */
public class TestObjSerializeAndDeserialize {

    public static void main(String[] args) throws Exception {
        SerializePerson();//序列化Person对象
        Person p = DeserializePerson();//反序列Perons对象
        System.out.println(MessageFormat.format("name={0},age={1},sex={2}",
                                                 p.getName(), p.getAge(), p.getSex()));
    }

    /**
     * MethodName: SerializePerson
     * Description: 序列化Person对象
     * @author xudp
     * @throws FileNotFoundException
     * @throws IOException
     */
    private static void SerializePerson() throws FileNotFoundException,
            IOException {
        Person person = new Person();
        person.setName("gacl");
        person.setAge(25);
        person.setSex("男");
        // ObjectOutputStream 对象输出流，将Person对象存储到E盘的Person.txt文件中，完成对Person对象的序列化操作
        ObjectOutputStream oo = new ObjectOutputStream(new FileOutputStream(
                new File("E:/Person.txt")));
        oo.writeObject(person);
        System.out.println("Person对象序列化成功！");
        oo.close();
    }

    /**
     * MethodName: DeserializePerson 
     * Description: 反序列Perons对象
     * @author xudp
     * @return
     * @throws Exception
     * @throws IOException
     */
    private static Person DeserializePerson() throws Exception, IOException {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(
                new File("E:/Person.txt")));
        Person person = (Person) ois.readObject();
        System.out.println("Person对象反序列化成功！");
        return person;
    }

}
```

**代码运行结果如下：**
![data1](../../../images/o_data1.jpg)
序列化Person成功后在E盘生成了一个Person.txt文件，而反序列化Person是读取E盘的Person.txt后生成了一个Person对象

##### serialVersionUID的作用
**serialVersionUID**: 字面意思上是序列化的版本号，凡是实现Serializable接口的类都有一个表示序列化版本标识符的静态变量
`private static final long serialVersionUID`，实现Serializable接口的类如果类中没有添加serialVersionUID，那么就会出现如下的警告提示
![data2](../../../images/o_data2.jpg)
**serialVersionUID有两种生成方式**

- 默认生成
```java
private static final long serialVersionUID = 1L;
```
- 根据类名，接口名，方法和属性等来生成
```java
private static final long serialVersionUID = 4603642343377807741L;
```

添加了之后就不会出现那个警告提示了，如下所示：
![data3](../../../images/o_data3.jpg)

**serialVersionUID(序列化版本号)作用**
上面说了很多，那么serialVersionUID(序列化版本号)到底有什么用呢，我们用如下的例子来说明一下serialVersionUID的作用，看下面的代码：

```java
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public class TestSerialversionUID {

    public static void main(String[] args) throws Exception {
        SerializeCustomer();// 序列化Customer对象
        Customer customer = DeserializeCustomer();// 反序列Customer对象
        System.out.println(customer);
    }

    /**
     * MethodName: SerializeCustomer 
     * Description: 序列化Customer对象
     * @author xudp
     * @throws FileNotFoundException
     * @throws IOException
     */
    private static void SerializeCustomer() throws FileNotFoundException,
            IOException {
        Customer customer = new Customer("gacl",25);
        // ObjectOutputStream 对象输出流
        ObjectOutputStream oo = new ObjectOutputStream(new FileOutputStream(
                new File("E:/Customer.txt")));
        oo.writeObject(customer);
        System.out.println("Customer对象序列化成功！");
        oo.close();
    }

    /**
     * MethodName: DeserializeCustomer
     * Description: 反序列Customer对象
     * @author xudp
     * @return
     * @throws Exception
     * @throws IOException
     */
    private static Customer DeserializeCustomer() throws Exception, IOException {
        ObjectInputStream ois = new ObjectInputStream(new FileInputStream(
                new File("E:/Customer.txt")));
        Customer customer = (Customer) ois.readObject();
        System.out.println("Customer对象反序列化成功！");
        return customer;
    }
}

/**
 * <p>ClassName: Customer<p>
 * <p>Description: Customer实现了Serializable接口，可以被序列化<p>
 * @author xudp
 * @version 1.0 V
 * @createTime 2014-6-9 下午04:20:17
 */
class Customer implements Serializable {
    //Customer类中没有定义serialVersionUID
    private String name;
    private int age;

    public Customer(String name, int age) {
        this.name = name;
        this.age = age;
    }

    /*
     * @MethodName toString
     * @Description 重写Object类的toString()方法
     * @author xudp
     * @return string
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "name=" + name + ", age=" + age;
    }
}
```

运行结果显示序列化和反序列化都成功了

![data4](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_data4.jpg)

下面我们修改一下Customer类，添加多一个sex属性，如下：

```java
class Customer implements Serializable {
    //Customer类中没有定义serialVersionUID
    private String name;
    private int age;

    //新添加的sex属性
    private String sex;

    public Customer(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public Customer(String name, int age,String sex) {
        this.name = name;
        this.age = age;
        this.sex = sex;
    }

    /*
     * @MethodName toString
     * @Description 重写Object类的toString()方法
     * @author xudp
     * @return string
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "name=" + name + ", age=" + age;
    }
}
```

然后执行反序列操作，此时就会抛出如下的异常信息：

```java
1 Exception in thread "main" java.io.InvalidClassException: Customer;
2 local class incompatible:
3 stream classdesc serialVersionUID = -88175599799432325,
4 local class serialVersionUID = -5182532647273106745
```

意思就是说，文件流中的class和classpath中的class，也就是修改过后的class，不兼容了，处于安全机制考虑，程序抛出了错误，并且拒绝载入。那么如果我们真的有需求要在序列化后添加一个字段或者方法呢？应该怎么办？那就是自己去指定serialVersionUID。在TestSerialversionUID例子中，没有指定Customer类的serialVersionUID的，那么java编译器会自动给这个class进行一个摘要算法，类似于指纹算法，只要这个文件 多一个空格，得到的UID就会截然不同的，可以保证在这么多类中，这个编号是唯一的。所以，添加了一个字段后，由于没有显指定 serialVersionUID，编译器又为我们生成了一个UID，当然和前面保存在文件中的那个不会一样了，于是就出现了2个序列化版本号不一致的错误。因此，只要我们自己指定了serialVersionUID，就可以在序列化后，去添加一个字段，或者方法，而不会影响到后期的还原，还原后的对象照样可以使用，而且还多了方法或者属性可以用。

下面继续修改Customer类，给Customer指定一个serialVersionUID，修改后的代码如下：
```java
class Customer implements Serializable {
    /**
     * Customer类中定义的serialVersionUID(序列化版本号)
     */
    private static final long serialVersionUID = -5182532647273106745L;
    private String name;
    private int age;

    //新添加的sex属性
    //private String sex;

    public Customer(String name, int age) {
        this.name = name;
        this.age = age;
    }

    /*public Customer(String name, int age,String sex) {
        this.name = name;
        this.age = age;
        this.sex = sex;
    }*/

    /*
     * @MethodName toString
     * @Description 重写Object类的toString()方法
     * @author xudp
     * @return string
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "name=" + name + ", age=" + age;
    }
}
```

重新执行序列化操作，将Customer对象序列化到本地硬盘的Customer.txt文件存储，然后修改Customer类，添加sex属性，修改后的Customer类代码如下：

```java
 class Customer implements Serializable {
    /**
     * Customer类中定义的serialVersionUID(序列化版本号)
     */
    private static final long serialVersionUID = -5182532647273106745L;
    private String name;
    private int age;

    //新添加的sex属性
    private String sex;

    public Customer(String name, int age) {
        this.name = name;
        this.age = age;
    }

    public Customer(String name, int age,String sex) {
        this.name = name;
        this.age = age;
        this.sex = sex;
    }

    /*
     * @MethodName toString
     * @Description 重写Object类的toString()方法
     * @author xudp
     * @return string
     * @see java.lang.Object#toString()
     */
    @Override
    public String toString() {
        return "name=" + name + ", age=" + age;
    }
}
```
执行反序列操作，这次就可以反序列成功了，如下所示：
![data5](http://images.cnblogs.com/cnblogs_com/prayjourney/1041349/o_data5.jpg)



##### serialVersionUID的取值
serialVersionUID的取值是Java运行时环境根据类的内部细节自动生成的。如果对类的源代码作了修改，再重新编译，新生成的类文件的serialVersionUID的取值有可能也会发生变化。
类的serialVersionUID的默认值完全依赖于Java编译器的实现，对于同一个类，用不同的Java编译器编译，有可能会导致不同的 serialVersionUID，也有可能相同。**为了提高serialVersionUID的独立性和确定性，强烈建议在一个可序列化类中显示的定义serialVersionUID，为它赋予明确的值**。

>显式地定义serialVersionUID有两种用途：
>1.在某些场合，希望类的不同版本对序列化兼容，因此需要确保类的不同版本具有相同的serialVersionUID
>2.在某些场合，不希望类的不同版本对序列化兼容，因此需要确保类的不同版本具有不同的serialVersionUID

ref:

1.[Java基础学习总结——Java对象的序列化和反序列化](http://www.cnblogs.com/xdp-gacl/p/3777987.html), 2.[序列化和反序列化](http://kb.cnblogs.com/page/515982/), 3.[序列化与反序列化总结(Serializable和Parcelable)](http://www.cnblogs.com/wufeng0927/p/5281884.html), 4.[java基础---->Serializable的使用](http://www.cnblogs.com/huhx/p/serializable.html), 5.[java高级---->Serializable的过程分析](http://www.cnblogs.com/huhx/p/sSerializableTheory.html)