using UnityEngine;
using System.Collections;

public class LightAnimation : MonoBehaviour
{
	public AnimationCurve lightIntenseCurve;
	public float m_DefaultIntensity;
	public bool disableOnAnimEnd;
	public bool m_LoopAnimation = false;
	private float lightIntenseAnimTime = 0.0f;

	// Use this for initialization
	void Start()
	{
	}
	
	// Update is called once per frame
	void Update()
	{
		if(lightIntenseAnimTime <= lightIntenseCurve[lightIntenseCurve.length - 1].time)
		{
			GetComponent<Light>().intensity = lightIntenseCurve.Evaluate(lightIntenseAnimTime);
			lightIntenseAnimTime += Time.deltaTime;
		}
		else if(lightIntenseAnimTime > lightIntenseCurve[lightIntenseCurve.length - 1].time && m_LoopAnimation) 
		{
			GetComponent<Light>().intensity = m_DefaultIntensity;
			lightIntenseAnimTime = 0;
		}
		else if(disableOnAnimEnd)
			GetComponent<Light>().enabled = false;
	}
}
