using UnityEngine;

public class GenericFactory<T> : MonoBehaviour where T : MonoBehaviour
{

    [SerializeField] private T Prefab;

    public T GetNewInstance()
    {
        return Instantiate(this.Prefab);
    }
}