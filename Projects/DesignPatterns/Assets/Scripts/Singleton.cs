//using Foo;

public class Singleton
{
    static Foo.IWidget w;

    private static readonly Singleton Instance = new Singleton();

    private Singleton() {
        w.foo();
    }

    public static Singleton GetInstance()
    {

        return Singleton.Instance;
    }
}

