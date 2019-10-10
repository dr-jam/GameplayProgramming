using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SmoothMovement : MonoBehaviour
{

    private Vector3 StartPosition;
    private Vector3 EndPosition;
    [SerializeField] private Vector3 Movement = new Vector3(-10f, 0f, 0f);
    [SerializeField] private float Duration = 5.0f;
    private Vector3 Velocity = new Vector3(0f, 0f, 0f);

    // Start is called before the first frame update
    void Start()
    {
        this.StartPosition = this.gameObject.GetComponent<Transform>().position;        
        this.EndPosition = this.StartPosition + this.Movement;
    }

    // Update is called once per frame
    void Update()
    {
        var xPos = Mathf.SmoothDamp(this.transform.position.x, this.EndPosition.x, ref this.Velocity.x, this.Duration);
        var yPos = Mathf.SmoothDamp(this.transform.position.y, this.EndPosition.y, ref this.Velocity.y, this.Duration);
        var zPos = Mathf.SmoothDamp(this.transform.position.z, this.EndPosition.z, ref this.Velocity.z, this.Duration);
        this.transform.position = new Vector3(xPos, yPos, zPos);
    }
}
