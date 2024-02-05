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

    