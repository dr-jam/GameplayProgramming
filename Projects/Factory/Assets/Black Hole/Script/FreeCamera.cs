using UnityEngine;

[RequireComponent(typeof(Camera))]
public class FreeCamera : MonoBehaviour
{
    public float m_MoveSpeed = 0f;
    public float m_RotateSpeed = 0f;
    public KeyCode m_ForwardButton = KeyCode.W;
    public KeyCode m_BackwardButton = KeyCode.S;
    public KeyCode m_RightButton = KeyCode.D;
    public KeyCode m_LeftButton = KeyCode.A;
    public KeyCode m_UpButton = KeyCode.Q;
    public KeyCode m_DownButton = KeyCode.E;

	void Update ()
    {
        // translation
        {
            Vector3 dir = Vector3.zero;
			Move (m_ForwardButton, ref dir, transform.forward);
			Move (m_BackwardButton, ref dir, -transform.forward);
			Move (m_RightButton, ref dir, transform.right);
			Move (m_LeftButton, ref dir, -transform.right);
			Move (m_UpButton, ref dir, transform.up);
			Move (m_DownButton, ref dir, -transform.up);
			transform.position += dir * m_MoveSpeed * Time.deltaTime;
        }
        // rotation
        {
            if (Input.GetMouseButton (0))
            {
                Vector3 eulerAngles = transform.eulerAngles;
				eulerAngles.x += -Input.GetAxis("Mouse Y") * 359f * m_RotateSpeed;
				eulerAngles.y += Input.GetAxis("Mouse X") * 359f * m_RotateSpeed;
                transform.eulerAngles = eulerAngles;
            }
        }
    }
    void Move (KeyCode key, ref Vector3 moveTo, Vector3 dir)
    {
        if (Input.GetKey (key))
			moveTo = dir;
    }
}
