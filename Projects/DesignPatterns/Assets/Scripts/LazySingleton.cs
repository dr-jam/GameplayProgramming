public class LazySingleton
{
    private static LazySingleton Instance = null;

    private LazySingleton() { }

    public static LazySingleton GetInstance()
    {
        if (LazySingleton.Instance == null)
        {
            LazySingleton.Instance = new LazySingleton();
        }
        return LazySingleton.Instance;
    }
}
