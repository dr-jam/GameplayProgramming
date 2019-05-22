using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class BlackHoleMaker : MonoBehaviour, IFactorySpell
    {
        private GameObject prefab;

        public void Start()
        {
            this.prefab = (GameObject)Resources.Load("BlackHolePrefab");
            //this.prefab = (GameObject)Resources.Load("SimpleBlackHolePrefab");
        }

        public GameObject Make()
        {
            Debug.Log("here");
            GameObject newGameObject = (GameObject)Instantiate(this.prefab);
            return newGameObject;
        }
    }
}