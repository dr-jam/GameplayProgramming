using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MeteorMotion : MonoBehaviour
{
    private bool firsthit = false;
    [SerializeField] private GameObject prefab;
    private Rigidbody Meteor;
    private Vector3 Force;

    void Start()
    {
        Meteor = GetComponent<Rigidbody>();
        Force = new Vector3(Random.Range(-50,50), Random.Range(-50, -20), Random.Range(-50,50));
    }

    void FixedUpdate()
    {
        Meteor.AddForce(Force);
    }

    void OnCollisionEnter(Collision col)
    {
        if (firsthit == true)
        {
            Debug.Log(gameObject.name + " was Collided with" + col.gameObject.name);
            Instantiate(this.prefab, this.gameObject.transform.position, Quaternion.identity);
            Destroy(this.gameObject);
        }

        firsthit = true;
    }
}
