using UnityEngine;
using System.Collections;

public class DemoController : MonoBehaviour 
{
	public GameObject[] m_Particles;
	private GameObject m_OldParticle;
	private int m_Index = 0;
	
	public void ChangeParticle(int btnIndx)
	{
		if(btnIndx == 0)
		{
			if(m_Index == m_Particles.Length - 1)
				m_Index = -1;

			m_Index++;
		}
		else
		{
			if(m_Index == 0)
				m_Index = m_Particles.Length;
		
			m_Index--;
		}

		if(m_OldParticle != null)
			Destroy (m_OldParticle);
		
		m_OldParticle = Instantiate (m_Particles[m_Index]) as GameObject;

	}

}
