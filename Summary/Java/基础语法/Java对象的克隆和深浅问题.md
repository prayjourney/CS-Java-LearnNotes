### Java对象的克隆和深浅问题

***

#####  Java实现克隆的方式
Java实现克隆的方式有如下两种, 推荐采用实现`Cloneable`接口的方式
- 实现`Cloneable`接口, 重写clone方法, 调用父类的clone方法
- 还有另一种方法, 不实现`Cloneable`接口, 但是重写了clone方法, 调用了父类clone方法, 也可以实现克隆能力
`Cloneable`接口和`Serializable`接口一样, 是一个声明式接口, 无需重写其中的方法, 当某个类实现了此类接口时, 标明具备了某种能力, 如序列化和可克隆性.



##### Object的clone和重写
在根类`Object`之中, 已经有了clone()方法 , 但是我们自己创建的类, 一般而言, 都是没有clone能力的, 因为默认是关闭了克隆能力的, 为何呢? 因为Java原本是设计用来控制硬件的语言, 但是当网络发展后, 安全性的问题开始出现, 而我们不可能允许一些敏感信息被随意clone, 但是原本的`Object`之中已经具备了" 克隆"方法和能力, 所以在Java后续的发展之中, 采用的是补丁式的解决方式, 首先将`Object`之中原来的`public Object clone()`改写为`protected Object clone()`, 然后规定每个类要实现克隆能力的话, 必须定义自己的`clone()`方法, 随着发展, 又出现了`Cloneable`接口, 作为一种声明式接口, 标明实现了`Cloneable`接口的方法都具备克隆的能力, 当然也需要重写自己的clone()方法. 当我们不去对一个类做任何操作, 而去clone的时候, 会返回如下的错误, 表示此类没有开启克隆的能力, 所以必须重写自己的clone方法
```java
java.lang.CloneNotSupportedException: com.cqu.zgy.syntax.clone.ClassForClone
```



##### 克隆能力的开启关闭方式
**默认情况下, 类的克隆能力是关闭的**, 我们可以根据需要, 开启或者关闭, 开启和关闭的方法如下

- 开启class克隆能力的方式:
  -  实现`Cloneable`接口,重写clone方法,调用父类的clone方法
  -  还有另一种方法, 不实现`Cloneable`接口, 但是重写了clone方法, 调用了父类clone方法, 也可以实现克隆能力

- 关闭class克隆能力的方式:
  - 直接不管(默认是关闭的)
  - 设置类为final
  - 不去实现`Cloneable`接口
  - 实现了`Cloneable`接口, 但是不去重写clone方法
  - 实现了`Cloneable`接口, 然后在重写了的clone方法之中直接抛出异常



##### 克隆的层次性
类的克隆能力是无法继承的, 所有的类, 当默认情况下, 都是默认关闭克隆能力的, 我们需要按照以上开启克隆能力的方式, 通过显式操作, 开启克隆能力, 此外, **如果子类继承自父类, 其克隆的能力也是要自行开启, 而无法通过继承实现**. 父类可以clone, 子类不可clone, 子类不继承父类的克隆能力, 实现例子如下:
```java
/*层次化的实现克隆, 在某一层开始具备克隆能力, 下面的都具有, 或者实现某一层停止克隆能力*/
/*继承关系之中, 继承的能力不可以继承, 某个类如果想要有『克隆』的能力, 就需要此类直接实现Cloneable, 重写clone, 调用父类clone*/
@Slf4j
public class LayeringClone {
    public static void main(String[] args) {
        School sc = new School("中央大学");
        College co = new College("日本语");
        Department de1 = new Department("商务日语", 1);
        Department de2 = new Department("日本文学", 2);
        SClass sc1 = new SClass("商务1班", 1, 40);

        //School不可克隆
        //School scClone=sc.clone();

        //College可以克隆
        try {
            College coClone = (College) co.clone();
            System.out.println(co.getInfo());
            System.out.println(coClone.getInfo());
        } catch (CloneNotSupportedException e) {
            log.error("College克隆发生异常!", e);
        }

        //Department可以克隆
        try {
            Department deClone = (Department) de1.clone();
            System.out.println(de1.getInfo());
            System.out.println(deClone.getInfo());
        } catch (CloneNotSupportedException e) {
            log.error("Department克隆发生异常!", e);
        }

        //SClass不可以克隆, 因为没有实现Cloneable接口
        try {
            SClass scClone = (SClass) sc1.clone();
            System.out.println(sc1.getInfo());
            System.out.println(scClone.getInfo());

            Department scc = new SClass("scc");
            System.out.println(scc.getClass());//父类可以clone, 子类不可clone, 子类不继承父类的克隆能力
            SClass scClone2 = (SClass)((Department) scc).clone();//父类可以clone, 子类不可clone, 子类不继承父类的克隆能力
        } catch (CloneNotSupportedException e) {
            log.error("SClass克隆发生异常!", e);
        }
    }

}

/*学校, 不可克隆, 未实现Cloneable*/
@Data
class School {
    private String name;

    public School() {
    }

    public School(String name) {
        this.name = name;
    }

    public String getInfo() {
        return "School name is: " + this.getName();
    }

}

/*学院, 可以克隆, 实现Cloneable*/
@Data
class College extends School implements Cloneable {
    private String name;

    public College() {
    }

    public College(String name) {
        super(name);
        this.name = name;
    }

    @Override
    public String getInfo() {
        return "College name is: " + this.getName();
    }

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

}

/*专业方向, 可以克隆, 实现Cloneable*/
@Data
class Department extends College implements Cloneable {
    private String name;
    private int depNo;

    public Department() {
    }

    public Department(String name) {
        super(name);
        this.name = name;
    }

    public Department(String name, int depNo) {
        super(name);
        this.name = name;
        this.depNo = depNo;
    }

    @Override
    public String getInfo() {
        return "Department name is: " + this.getName() + ", Department depNo is: " + this.getDepNo();
    }

    @Override
    public Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

}

/*班级, 不可克隆, 实现Cloneable*/
@Data
class SClass extends Department implements Cloneable {
    private String name;
    private int id;
    private int stuNo;

    public SClass() {
    }

    public SClass(String name) {
        super(name);
        this.name = name;
    }

    public SClass(String name, int id, int stuNo) {
        super(name);
        this.name = name;
        this.id = id;
        this.stuNo = stuNo;
    }

    @Override
    public String getInfo() {
        return "SClass name is: " + this.getName() + ", SClass id is: " + this.getId()
                + ", SClass stuNo is: " + this.getStuNo();
    }

    //通过操作clone函数,抛出一个异常,而主动停止clone的能力
    @Override
    public Object clone() throws CloneNotSupportedException {
        throw new CloneNotSupportedException("不支持克隆...");
    }

}
```



##### ==和equals

在Java之中, 同一个对象肯定是地址相同, 而内容相同的对象则是equal的. 也就是 ==(地址) 和 equals(内容) 的区别. **Java之中, ==对于对象类型而言, 比较的是地址, 而非内容. 比较内容需要使用equals()**.  赋值例如`Object a = new Object(); Object b = a;` a赋值给b, b对象作为a对象的一个别名, 其地址和内容都是相等的 也就是 a==b 和a.equals(b) 都返回的是true; 两个对象(**对象之中的字段都是基本类型的情况**), a clone自b, 此时a和b的内容是相等的, 但是a和b的地址是不相等的, 因为其是两个对象, 在JVM之中分配了不同的堆, 所以a==b: false, 而a.equals(b): true, 在克隆之中, 我们可以使用== 和equals的关系来测试深克隆和浅克隆.



##### 深克隆和浅克隆

克隆就是复制, 复制要求对象的内容是一致的, 这就叫做复制, 深克隆与浅克隆的区别就是: **浅克隆不会克隆原对象中的引用类型, 仅仅拷贝了引用类型的指向. 深克隆则拷贝了对象之中的所有属性和对象**, *也就是说深克隆能够做到原对象和新对象之间完全没有影响*.  而深克隆的实现就是在引用类型所在的类实现`Cloneable`接口, 并使用public访问修饰符重写clone方法, **浅克隆重写clone方法的时候,只需要调用父类的clone方法即可, 而深克隆, 则需要每一层都调用其上一层的clone方法, 并且返回当前的对象**.
对象类型:
a.一个对象之中的字段有基本类型String, int
b.**一个对象之中的字段有基本类型String, int, Country(国家类,一个自己创建的复杂的类)**
1.浅克隆
对于 a 类型, 只有简单的基本类型字段的时候, 那么就深克隆和浅克隆的效果是一样的
对于 b 类型, 当浅克隆的时候, 此对象和克隆对象的地址不相同, 但是内容相同, 而Country对象, 克隆前后两个对象使用的是同一个, ==, equals都为true
2.深克隆
对于 a 类型, 只有简单的基本类型字段的时候, 那么就深克隆和浅克隆的效果是一样的
对于 b 类型, 当深克隆的时候, 此对象和克隆对象的地址不相同, 内容相同, 而Country对象, 克隆前后两个对象使用的也是两个对象, == 为false, equals为true
深克隆和浅克隆的使用例子如下:
```java
/*深克隆和浅克隆*/
public class ShadowDeepClone {
    /**
     * 说明了如果想要克隆某一个对象, 那么它的类, 要实现了Cloneable接口, 重写了clone方法, 调用父类方法可以实现克隆能力
     * 还有另一种方法, 不实现Cloneable接口, 但是重写了clone方法, 调用了父类clone方法, 也可以实现克隆能力
     **/
    public static void testNoCloneableWithCloneMethod() throws CloneNotSupportedException {
        Tibet t1 = new Tibet("西藏藏语", "西藏");
        System.out.println(t1.getInfo());
        Tibet t2 = (Tibet) t1.clone();
        System.out.println(t2.getInfo());
    }

    public static void testShadowClone() throws CloneNotSupportedException {
        Yu yu1 = new Yu("河南方言郑州话", "中国", 140000000);
        Yu yu2 = new Yu("河南方言安徽北部", "中国", 7006600);
        BeifangDialect bf1 = new BeifangDialect("北方方言河南郑州话", yu1);
        BeifangDialect bf2 = new BeifangDialect("北方方言河南安徽北部话", yu2);
        BeifangDialect bf1Clone = (BeifangDialect) bf1.clone();
        System.out.println(bf1.getInfo());
        System.out.println(bf1Clone.getInfo());

        System.out.println("bf1.equals(bf1Clone): " + (bf1.equals(bf1Clone)));
        System.out.println("bf1 == bf1Clone: " + (bf1 == bf1Clone));

        System.out.println("bf1.getYu().equals(bf1Clone.getYu()): " + (bf1.getYu().equals(bf1Clone.getYu())));
        System.out.println("bf1.getYu() == bf1Clone.getYu(): " + (bf1.getYu() == bf1Clone.getYu()));

        System.out.println("说明bf1之中的Yu和bf1Clone的Yu对象是同一个, 而bf1和bf1Clone是两个对象");
    }

    public static void testDeepClone() throws CloneNotSupportedException {
        Wu wu = new Wu("吴方言", "中国", "环太湖地区");
        JiangnanDialect jnSuzhou = new JiangnanDialect("苏州方言", wu);
        JiangnanDialect jnKunshan = (JiangnanDialect) jnSuzhou.clone();
        System.out.println(jnSuzhou.getInfo());
        System.out.println(jnKunshan.getInfo());

        System.out.println("jnSuzhou.equals(jnKunshan): " + (jnSuzhou.equals(jnKunshan)));
        System.out.println("jnSuzhou == jnKunshan: " + (jnSuzhou == jnKunshan));

        System.out.println("jnSuzhou.getWu().equals(jnKunshan.getWu()): " + (jnSuzhou.getWu().equals(jnKunshan.getWu())));
        System.out.println("jnSuzhou.getWu() == jnKunshan.getWu(): " + (jnSuzhou.getWu() == jnKunshan.getWu()));

        System.out.println("说明jnSuzhou之中的Wu和jnKunshan的Wu对象[[[不是同一个]]], 并且jnSuzhou和jnKunshan是两个对象, 但是内容相等");
    }

    public static void main(String[] args) throws CloneNotSupportedException {

        System.out.println("第二种实现克隆的方法...");
        testNoCloneableWithCloneMethod();

        //浅克隆, 只是克隆表层的对象, 对对象之中的对象不复制
        System.out.println("\n\n浅克隆...");
        testShadowClone();
        //深克隆, 克隆整个的对象, 对对象之中的对象也要复制
        System.out.println("\n\n深克隆...");
        testDeepClone();
    }
}

//江南方言, 深克隆
@Data
class JiangnanDialect implements Cloneable {
    private String name;
    private Wu wu;

    JiangnanDialect(String name, Wu wu) {
        this.name = name;
        this.wu = wu;
    }

    public String getInfo() {
        return "Language name is: " + this.getName() + ", [[[具体小语种 : " + this.getWu().getInfo()
                + "]]], Class name is: " + this.getClass().getName();
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        // 在clone方法之中, 完成了本类层面的字段属性的clone, 从而实现了完整的克隆;
        // 但是如果有多层, 每一层都要嵌套, 才能实现深克隆, 不然仍然是浅克隆
        JiangnanDialect jn = (JiangnanDialect) super.clone();
        jn.wu = (Wu) wu.clone();
        return jn;
    }
}

//北方方言, 浅克隆
@Data
class BeifangDialect implements Cloneable {
    private String name;
    private Yu yu;

    BeifangDialect(String name, Yu yu) {
        this.name = name;
        this.yu = yu;
    }

    public String getInfo() {
        return "Language name is: " + this.getName() + ", [[[具体小语种 : " + this.getYu().getInfo()
                + "]]], Class name is: " + this.getClass().getName();
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}

//下面是语言的一些类
/*Language可以克隆*/
@Data
class Language implements Cloneable {
    private String name;//名称

    Language() {
    }

    Language(String name) {
        this.name = name;
    }

    public String getInfo() {
        return "Language name is: " + this.getName() + ", Class name is: " + this.getClass().getName();
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}

/*Han可以克隆*/
@Data
class Han extends Language implements Cloneable {
    private String name;
    private String country;//国家

    Han() {
        super();
    }

    Han(String name, String country) {
        super(name);
        this.name = name;
        this.country = country;
    }

    @Override
    public String getInfo() {
        return "Language name is: " + this.getName() + ", Country name is: " + this.getCountry()
                + ", Class name is: " + this.getClass().getName();
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }

}

/*Wu可以克隆*/
@Data
class Wu extends Han implements Cloneable {
    private String name;
    private String country;
    private String region;//地区

    Wu() {
        super();
    }

    Wu(String name, String country, String region) {
        super(name, country);
        this.name = name;
        this.country = country;
        this.region = region;
    }

    @Override
    public String getInfo() {
        return "Language name is: " + this.getName() + ", Country name is: " + this.getCountry()
                + ", Region name is: " + this.getRegion() + ", Class name is: " + this.getClass().getName();
    }

    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}

/*Yu不可以克隆*/
@Data
class Yu extends Han {
    private String name;
    private String country;
    private int population;//人口数量

    Yu() {
        super();
    }

    Yu(String name, String country, int population) {
        super(name, country);
        this.name = name;
        this.country = country;
        this.population = population;
    }

    @Override
    public String getInfo() {
        return "Language name is: " + this.getName() + ", Country name is: " + this.getCountry()
                + ", population is: " + this.getPopulation() + ", Class name is: " + this.getClass().getName();
    }

}

/*Tibet克隆, 测试一下其未实现Cloneable接口, 但是实现了clone方法的重写, 看其是否可以克隆*/
@Data
class Tibet extends Language {
    private String name;//名称
    private String region;//地区

    Tibet() {
    }

    Tibet(String name, String region) {
        super(name);
        this.name = name;//调用了super(name), 但还是需要使用this.name=name; 为name赋值, 否则name为null
        this.region = region;
    }

    @Override
    public String getInfo() {
        return "Language name is: " + this.getName() + ", Region name is: " + this.getRegion()
                + ", Class name is: " + this.getClass().getName();
    }

    // 未实现Cloneable接口, 但是实现了clone方法重写
    @Override
    protected Object clone() throws CloneNotSupportedException {
        return super.clone();
    }
}
```



ref:
1.[Java的clone()：深复制与浅复制](https://www.cnblogs.com/acode/p/6306887.html),   2.[Java对象克隆——浅克隆和深克隆的区别](https://blog.csdn.net/jeffleo/article/details/76737560),   3.[java Clone使用方法详解](https://www.cnblogs.com/felixzh/p/6021886.html)

