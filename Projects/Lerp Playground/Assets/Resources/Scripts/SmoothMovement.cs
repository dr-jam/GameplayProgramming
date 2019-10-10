using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SmoothDampMovement : MonoBehaviour
{
    private Vector3 StartPosition;
    private Vector3 EndPosition;
    [SerializeField] private Vector3 Movement = new Vector3(-10f, 0f, 0f);
    [SerializeField] private float Duration = 5.0f;
    private float StartTime;

    // Start is called before the first frame update
    void Start()
    {
        this.StartPosition = this.gameObject.GetComponent<Transform>().position;
        this.EndPosition = this.StartPosition + this.Movement;
        this.StartTime = Time.time;
    }

    // Update is called once per frame
    void Update()
    {
        this.transform.position = Vector3.Lerp(this.StartPosition, this.EndPosition, Mathf.SmoothStep(0.0f, 1.0f, (Time.time - this.StartTime) / this.Duration));
    }
}
