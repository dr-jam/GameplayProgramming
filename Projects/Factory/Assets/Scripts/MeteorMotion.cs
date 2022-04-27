using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeteorMotion : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField] private Vector3 Movement;
    [SerializeField] private float Speed = 9.81f;

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        this.gameObject.transform.position += Time.deltaTime * this.Movement * this.Speed;
    }
}
