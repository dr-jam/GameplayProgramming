using UnityEngine;

// A ball that bounces three times, then rests. It counts the collision
// messages Unity sends: Enter when it touches the ground, Exit when it leaves.
public class Ball : MonoBehaviour
{
    public int bounces;
    public int landings;

    void OnCollisionEnter2D(Collision2D collision)
    {
        landings = landings + 1;
        Debug.Log("landed " + landings);
        if (bounces < 3)
        {
            bounces = bounces + 1;
            GetComponent<Rigidbody2D>().velocity = new Vector2(0, 6);
        }
    }

    void OnCollisionExit2D(Collision2D collision)
    {
        Debug.Log("left the ground");
    }
}
