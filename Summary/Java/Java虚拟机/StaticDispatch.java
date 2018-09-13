/**
 * 测试静态分派
 * @author zgy
 */
public class StaticDispatch {
    static class Human {
    }

    static class Man extends Human {
    }

    static class Woman extends Human {
    }

    public void sayHello(Human guy) {
        System.out.println("Hello guy");
    }

    public void sayHello(Man man) {
        System.out.println("Hello man");
    }

    public void sayHello(Woman woman) {
        System.out.println("Hello woman");
    }

    public static void main(String[] args) {
        Human man=new Man();
        Human woman=new Woman();
        StaticDispatch sr=new StaticDispatch();
        sr.sayHello(man);
        sr.sayHello(woman);
    }


}
