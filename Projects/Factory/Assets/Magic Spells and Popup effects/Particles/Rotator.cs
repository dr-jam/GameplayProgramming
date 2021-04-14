using UnityEngine;
using System.Collections;

public class Rotator : MonoBehaviour {
	
	public AnimationCurve curve;
	public float speed;
	
	private float time = 0f;
	
	void Update () 
	{
		time += Time.deltaTime;
		
		float temp = curve.Evaluate(time);
		
		transform.rotation = Quaternion.Euler(new Vector3(0,transform.rotation.eulerAngles.y + temp * speed,0));
		
	}
}
