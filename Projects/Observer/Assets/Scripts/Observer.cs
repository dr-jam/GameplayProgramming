using UnityEngine;
using System.Collections;

namespace ObserverPattern
{
    //Wants to know when another object does something interesting 
    public abstract class Observer
    {
        public abstract void OnNotify();
    }

    public class Box : Observer
    {
        //The box gameobject which will do something
        GameObject boxObj;
        //What will happen when this box gets an event
        BoxEvents boxEventSubscribedTo;

        public Box(GameObject boxObj, BoxEvents boxEventToSubTo)
        {
            this.boxObj = boxObj;
            this.boxEventSubscribedTo = boxEventToSubTo;
        }

        //What the box will do if the event fits it (will always fit but you will probably change that on your own)
        public override void OnNotify()
        {
            Jump(boxEventSubscribedTo.GetJumpForce());
        }

        //The box will always jump in this case
        void Jump(float jumpForce)
        {
            //If the box is close to the ground
            if (boxObj.transform.position.y < 0.55f)
            {
                boxObj.GetComponent<Rigidbody>().AddForce(Vector3.up * jumpForce);
            }
        }
    }
}