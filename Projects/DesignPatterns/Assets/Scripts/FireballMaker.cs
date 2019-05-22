using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class FireballMaker : MonoBehaviour, IFactorySpell
    {
        private GameObject prefab;

        public void Start()
        {
            this.prefab = (GameObject)Resources.Load("FireballPrefab");
        }

        public GameObject Make()
        {
            GameObject newGameObject = Instantiate(this.prefab);
            return newGameObject;
        }
    }
}
