### Java可变参数与main函数解析
- - -

##### Java可变参数
&nbsp;&nbsp;&nbsp;&nbsp;在Java5中提供了==可变长参数==，即方法定义中可以使用个数不确定的参数，对于同一方法可以使用不同个数的参数调用。比如有如下的例子：
`print("hello");`
`print("hello","lisi");`
`print("banana","grape", "peach");`
下面介绍如何定义可变长参数 以及如何使用可变长参数。
- 定义
  `访问控制符 返回值类型 函数名(参数类型... args);`
  定义方法如上，与普通方法的区别就是*参数类型*后面紧跟着==**...**==，++不定数量的参数使用**数组**封装++，
- 使用
  1.可变长参数调用的时候可以给出任意多个参数也可不给参数；
  2.在方法调用时，如果可以和固定参数的方法匹配，也能够与可变长参数的方法匹配，则**首先选择固定参数的方法**；
  3.要调用的方法**不可以同时和两个可变参数的方法匹配**；
  4.一个方法只能有一个可变长参数，并且该可变长参数必须是此方法的最后一个参数；
  `fun1(String... args)`
  `fun2(para1,String... args)`
  `fun3(para1,para2,String... args)`
  ++以上示例中后两条的可变参数如果在`para1`,`para2`前面，就会出错。++
  5.可变参数的类型都相同，如`fun6(para1,,String... args)`args数组之中的数值变量类型都为String类型；
  6.经常使用`for`或者`foreach`来对可变参数的数组进行相关的操作。
    ```java
      print("hello");`
      print("hello","lisi");`
      print("banana","grape", "peach");
    ```

- 注意点
  1.**尽量避免带有可变长参数的方法重载**,如若重载，*参数列表必须与被重写方法相同*，**各项权限不能超出父类权限**;
  2.*null不要直接出现在边长方法调用之中*(可以代替，如str=null).

- 例子
```java
    import static java.lang.System.out;
    public class myparameter
    {
        private static final String TAG = "myparameter";
        public static void print(String... args)//定义可变参数方法
        {
            for (int i = 0; i < args.length; i++)//for
            {
                out.println(args[i]);
            }
        }
        public static void print(String args)//定义普通方法
        {
             out.println(args+"hello");
        }
        public static void eating(String fruit1,String fruit2,String... fruits)
        {
            out.println(fruit1+"---");
            out.println(fruit2+"---");
            for(String temp:fruits)//foreach
            {
                System.out.println("fruits:"+temp+"***");
            }
        }
        public static void m1(String s, String... ss)//陷阱方法的示例
        {
            for (int i = 0; i < ss.length; i++) {
                System.out.println(ss[i]+"  qqq");
            }
        }

        static class ABC
        {
            private String name;
            private Integer age;
            private String addr;
            ABC(String n,Integer a,String ad) {
                this.name=n;
                this.age=a;
                this.addr=ad;
            }

            public String getName()
            {
                return name;
            }

            public Integer getAge()
            {
                return age;
            }

            public String getAddr()
            {
                return addr;
            }
            public void printinfo(String... args)
            {
                int n=0;
                for(String info:args)
                {
                    out.print(String.valueOf(info)+(n++)+", ");
                }
                out.println("---");
            }
        }
        public static void main(String[] args)
        {
            print("固定参数优先！");//固定参数优先
            print("123","nihao","India","daoist","coca cola");//可变参数
            eating("banana","apple");
            eating("banana","apple","orange","peach","grape");

            m1("");
            m1("aaa");
            m1("aaa", "bbb");

            ABC abc1=new ABC("zhangsan",22,"hangzhou");
            abc1.printinfo(abc1.getName(),String.valueOf(abc1.getAge()),abc1.getAddr());
        }
    }
```
- - -



##### main()函数解析
// todo

- - -
ref:
1.[Java中可变长参数的使用及注意事项](http://www.cnblogs.com/lanxuezaipiao/p/3190673.html)