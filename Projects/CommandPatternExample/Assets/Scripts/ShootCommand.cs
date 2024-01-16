using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using CommandPattern;

namespace CommandPattern 
{ 
    public class ShootCommand : ScriptableObject, ICommand
    {
        private Object ProjectilePrefab;
        private float SpeedFactor = 50.0f;

        public void OnEnable()
        {
            ProjectilePrefab = Resources.Load("prefabs/Projectile");
        }

        public void execute(GameObject gameObject)
        {
            var projectile = (GameObject) Instantiate (ProjectilePrefab, gameObject.transform.localPosition, gameObject.transform.rotation);
            var projectileRigidBody = projectile.GetComponent<Rigidbody>();
            projectileRigidBody.velocity = projectile.transform.forward * Random.value * SpeedFactor;
            projectile.transform.localScale = new Vector3(Random.value, Random.value, Random.value);
            projectile.GetComponent<Renderer>().material.color = new Color(Random.value, Random.value, Random.value);
        }
    }
}
