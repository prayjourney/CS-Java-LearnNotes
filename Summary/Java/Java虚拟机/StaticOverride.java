/**
 * 测试重写
 * @author zgy
 */
public class StaticOverride
{
    private static final String TAG = "StaticOverride";

    static abstract class Human
    {
        abstract void sayHello();
    }

    static class Man extends Human
    {
        @Override
        void sayHello()
        {
            System.out.println("Hello Man");
        }
    }

    static class Woman extends Human
    {
        @Override
        void sayHello()
        {
            System.out.println("Hello Woman");
        }
    }

    public static void main(String[] args)
    {
        Human man = new Man();
        Human woman = new Woman();
        StaticOverride so = new StaticOverride();
        man.sayHello();
        woman.sayHello();

    }


} 