using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class HumanoidMaker : MonoBehaviour, IFactorySpell
    {
        [SerializeField] private GameObject prefab;
        private float humanoidID = 0;

        public GameObject Make()
        {
            GameObject newGameObject = (GameObject)Instantiate(this.prefab);
            Humanoid humanoid = newGameObject.GetComponent<Humanoid>();
            humanoid.setID(humanoidID);
            humanoidID += 1;
            return newGameObject;
        }
    }
}