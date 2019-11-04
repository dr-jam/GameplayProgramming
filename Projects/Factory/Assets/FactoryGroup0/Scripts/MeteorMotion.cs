using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeteorMotion : MonoBehaviour
{
    private bool firsthit = false;
    [SerializeField] private GameObject prefab;




    void OnCollisionEnter(Collision col)
    {
        if (firsthit == true)
        {
            Debug.Log(gameObject.name + " was Collided with" + col.gameObject.name);
            Destroy(this.gameObject);
            Instantiate(this.prefab);
        }

        firsthit = true;
    }
}
