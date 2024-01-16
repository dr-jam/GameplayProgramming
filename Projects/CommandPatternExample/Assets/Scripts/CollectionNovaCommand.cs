    using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using CommandPattern;

namespace CommandPattern
{
    public class CollectionNovaCommand : ScriptableObject, ICommand
    {
        public void execute(GameObject gameObject)
        {
            //Collect all projectiles
            var projectileList = GameObject.FindGameObjectsWithTag("Projectile");

            foreach (var projectile in projectileList)
            {
                projectile.transform.position = new Vector3(Random.value * 5.0f - 2.5f, 1.5f, Random.value * 5.0f - 2.5f);
                projectile.GetComponent<Rigidbody>().velocity = new Vector3(Random.value, Random.value, Random.value);
            }
        }
    }
}