using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class FireballMaker : MonoBehaviour, IFactorySpell
    {
        [SerializeField] private GameObject prefab;

        public void Start()
        {
        }

        public GameObject Make()
        {
            GameObject newGameObject = Instantiate(this.prefab, this.gameObject.transform);
            return newGameObject;
        }
    }
}
