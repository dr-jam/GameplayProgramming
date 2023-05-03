using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public class FireballMotion : MonoBehaviour
    {
        [SerializeField] private float Speed = 5.0f;

        void Update()
        {
            var pos = this.transform.position;
            pos += this.Speed * Time.deltaTime * this.transform.forward;
            this.transform.position = pos;
        }
    }
}