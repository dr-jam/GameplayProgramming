using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationCurveMovement : MonoBehaviour
{
    [SerializeField] private AnimationCurve MotionCurve;
    [SerializeField] private Vector3 Movement = new Vector3(-10f, 0f, 0f);
    [SerializeField] private float Duration = 5.0f;
    private Vector3 StartPosition;
    private Vector3 EndPosition;
    private float StartTime = 0f;

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
        //evaluates the y value of the animation curve given the input ranging from 0 to 1.
        var fractionOfJourney = this.MotionCurve.Evaluate((Time.time - this.StartTime) / this.Duration);
        this.transform.position = Vector3.Lerp(this.StartPosition, this.EndPosition, fractionOfJourney);
    }
}
