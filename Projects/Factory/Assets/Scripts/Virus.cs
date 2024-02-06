using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class Virus : MonoBehaviour
    { 
        [SerializeField] private float moveSpeed = 20.0f; // Speed of movement
        private Rigidbody rb;

        void Start()
        {
            // Get the Rigidbody component attached to the GameObject
            rb = GetComponent<Rigidbody>();
            rb.useGravity = false;
            rb.freezeRotation = true;
        }

        void FixedUpdate()
        {
            // Calculate a random direction for movement
            Vector3 randomDirection = Random.insideUnitSphere;
            // Apply force in the random direction to make the black hole float around
            rb.AddForce(randomDirection * moveSpeed);
        }

        private void OnCollisionEnter(Collision collision)
        {
            Humanoid otherHumanoid = collision.gameObject.GetComponent<Humanoid>();
            if (otherHumanoid != null)
            {
                Destroy(gameObject);
                otherHumanoid.TriggerExplosion();
            }
        }
    }
}

    