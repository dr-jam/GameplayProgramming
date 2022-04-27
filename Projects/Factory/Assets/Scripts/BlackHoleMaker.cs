using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class BlackHoleMaker : MonoBehaviour, IFactorySpell
    {
        [SerializeField] private GameObject prefab;

        public void Start()
        {

        }

        public GameObject Make()
        {
            Debug.Log("here");
            GameObject newGameObject = (GameObject)Instantiate(this.prefab);
            return newGameObject;
        }
    }
}