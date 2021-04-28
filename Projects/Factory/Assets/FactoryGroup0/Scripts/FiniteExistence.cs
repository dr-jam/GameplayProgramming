using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FiniteExistence : MonoBehaviour
{
    // Start is called before the first frame update
    [SerializeField]
    private float Duration = 10.0f;
    private float TimeCounter = 0.0f;

    void Update()
    {
        this.TimeCounter += Time.deltaTime;
        if(this.TimeCounter > this.Duration)
        {
            Destroy(this.gameObject);
        }
    }
}
