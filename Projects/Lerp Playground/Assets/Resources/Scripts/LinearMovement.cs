using System.Collections;
using System.Collections.Generic;
using UnityEngine;


/* This is a demonstration of the basic use of Vector3.Lerp.
 * https://docs.unity3d.com/ScriptReference/Vector3.Lerp.html
 */
public class LinearMovement : MonoBehaviour
{
    private Vector3 StartPosition;
    private Vector3 EndPosition;
    [SerializeField] private Vector3 Movement = new Vector3(-10f, 0f, 0f);
    [SerializeField] private float Duration = 5.0f;

    // Start is called before the first frame update
    void Start()
    {
        this.StartPosition = new Vector3(this.transform.position.x, this.transform.position.y, this.transform.position.z);
        this.EndPosition = this.StartPosition + this.Movement;
    }

    // Update is called once per frame
    void Update()
    {
        var distanceCovered = this.Movement * Time.deltaTime / this.Duration;
        float fractionOfJourney = Vector3.Distance(this.StartPosition, this.transform.position + distanceCovered) / Vector3.Distance(this.StartPosition, this.EndPosition);
        this.transform.position = Vector3.Lerp(this.StartPosition, this.EndPosition, fractionOfJourney);
    }
}
