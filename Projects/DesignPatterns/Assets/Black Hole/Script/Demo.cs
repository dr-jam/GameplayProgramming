using UnityEngine;

public class Demo : MonoBehaviour
{
	public Material m_Mat = null;
	[Range(0.01f, 0.2f)] public float m_DarkRange = 0.1f;
	[Range(-2.5f, -1f)] public float m_Distortion = -2f;
	float m_MouseX = 0f;
	float m_MouseY = 0f;
	bool m_TraceMouse = false;
	int m_ID_Center = 0;
	int m_ID_DarkRange = 0;
	int m_ID_Distortion = 0;
	
	void Start ()
	{
		if (!SystemInfo.supportsImageEffects)
			enabled = false;
		m_MouseX = m_MouseY = 0.5f;
		m_ID_Center = Shader.PropertyToID ("_Center");
		m_ID_DarkRange = Shader.PropertyToID ("_DarkRange");
		m_ID_Distortion = Shader.PropertyToID ("_Distortion");
	}
	void OnRenderImage (RenderTexture sourceTexture, RenderTexture destTexture)
	{
		m_Mat.SetVector (m_ID_Center, new Vector4 (m_MouseX, m_MouseY, 0f, 0f));
		m_Mat.SetFloat (m_ID_DarkRange, m_DarkRange);
		m_Mat.SetFloat (m_ID_Distortion, m_Distortion);
		Graphics.Blit (sourceTexture, destTexture, m_Mat);
	}
	void Update ()
	{
		if (Input.GetMouseButtonDown (1))
		{
			m_TraceMouse = true;
		}
		else if (Input.GetMouseButtonUp (1))
		{
			m_TraceMouse = false;
		}
		else if (Input.GetMouseButton (1))
		{
			if (m_TraceMouse)
			{
				m_MouseX = Input.mousePosition.x / Screen.width;
//#if UNITY_5
//				m_MouseY = 1f - Input.mousePosition.y / Screen.height;
//#else
				m_MouseY = Input.mousePosition.y / Screen.height;
//#endif
			}
		}
	}
	void OnGUI ()
	{
		GUI.Box (new Rect (10, 10, 160, 25), "Black Hole Demo");
	}
}