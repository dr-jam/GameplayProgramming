using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class Humanoid : MonoBehaviour
    {
        [SerializeField]
        private GameObject humanoidPrefab;
        private float humanoidID;
        private float humanoidSize;
        [SerializeField] private ParticleSystem explosionParticles;


        [SerializeField] private Color explosionColor = Color.green; // Color to change to on explosion
        private MeshRenderer meshRenderer;

        void Start()
        {
            // Get the Mesh Renderer component attached to the GameObject
            meshRenderer = GetComponent<MeshRenderer>();
        }

        void Awake()
        {
            this.humanoidSize = 1;
        }

        private void OnCollisionEnter(Collision collision)
        {
            Humanoid otherHumanoid = collision.gameObject.GetComponent<Humanoid>();
            if (otherHumanoid != null)
            {
                if (this.humanoidSize == otherHumanoid.getSize())
                {
                    Debug.Log($"Humanoid {otherHumanoid.getID()}, touched Humanoid {humanoidID}!");
                    destroyAndUpdate(otherHumanoid);
                }
            }
        }

        private void destroyAndUpdate(Humanoid otherHumanoid)
        {
            if (this.humanoidID > otherHumanoid.getID())
            {
                setSize(humanoidSize * 1.5f);
                Debug.Log($"Destroying humanoid {otherHumanoid.getID()}");
                otherHumanoid.destoryHumanoid();
            }
            else
            {
                otherHumanoid.setSize(otherHumanoid.getSize() * 1.5f);
                Debug.Log($"Destroying humanoid {humanoidID}");
                Destroy(gameObject);
            }
        }

        /* This is the explosion when interacting with the virus */
        public void TriggerExplosion()
        {
            Debug.Log($"Humanoid {humanoidID} exploded!");
            // Implement explosion effects or destruction logic here
            if (explosionParticles != null)
            {
                Debug.Log("explosion");
                explosionParticles.transform.position = transform.position;
                explosionParticles.Play();
            }
            // Change color and then destroy Humanoid
            ChangeColor(explosionColor);
            StartCoroutine(DestroyAfterDelay(4.0f)); // Change 3f to the desired delay in seconds
        }

        private IEnumerator DestroyAfterDelay(float delay)
        {
            // Wait for the specified delay
            yield return new WaitForSeconds(delay);

            // Destroy the GameObject after the delay
            Destroy(gameObject);
        }

        private void ChangeColor(Color newColor)
        {
            if (meshRenderer != null)
            {
                // Change the color of the Mesh Renderer's material
                meshRenderer.material.color = newColor;
            }
            else
            {
                Debug.LogWarning("Mesh Renderer component not found. Color cannot be changed.");
            }
        }



        public void destoryHumanoid()
        {
            Destroy(gameObject);
        }
        public float getSize()
        {
            return humanoidSize;
        }
        public void setSize(float newSize)
        {
            humanoidSize = newSize;
            transform.localScale = new Vector3(humanoidSize, humanoidSize, humanoidSize);
        }
        public float getID()
        {
            return humanoidID;
        }
        public void setID(float iD)
        {
            humanoidID = iD;
        }
    }
}

    