using UnityEngine;

public class Factory : MonoBehaviour
{
    public enum Spells { Fireball, BlackHole, Meteor}

    //You can add id values to each manufactured item.
    //private static int SerialID = 0;

    public MonoBehaviour GetNewInstance(Spells type)
    {
        //return Instantiate(GameObject);
        return null;
    }
}