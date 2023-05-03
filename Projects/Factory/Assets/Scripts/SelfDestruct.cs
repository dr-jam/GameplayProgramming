using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SelfDestruct : MonoBehaviour
{
    [SerializeField]
    private float timeToSelfDestruct = 5.0f;
    
    void Start()
    {
        //destroy after 5 seconds
        Destroy(this.gameObject, timeToSelfDestruct);
    }
}
