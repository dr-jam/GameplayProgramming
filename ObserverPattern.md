Observer Pattern
=

The Problem
==

```c#
using UnityEngine;
using System.Collections;

namespace ObserverPattern
{
    public class GameController : MonoBehaviour
    {
        public GameObject sphereObj;
        //The boxes that will jump
        public GameObject box1Obj;
        public GameObject box2Obj;
        public GameObject box3Obj;

        //Will send notifications that something has happened to whoever is interested
        Subject subject = new Subject();


        void Start()
        {
            //Create boxes that can observe events and give them an event to do
            Box box1 = new Box(box1Obj, new JumpLittle());
            Box box2 = new Box(box2Obj, new JumpMedium());
            Box box3 = new Box(box3Obj, new JumpHigh());

            //Add the boxes to the list of objects waiting for something to happen
            subject.AddObserver(box1);
            subject.AddObserver(box2);
            subject.AddObserver(box3);
        }


        void Update()
        {
            //The boxes should jump if the sphere is cose to origo
            if ((sphereObj.transform.position).magnitude < 0.5f)
            {
                subject.Notify();
            }
        }
    }
}
```'


== A Solution

Removing the observer from the observed. This breaks a dependency (which is what we want).

```c#
using UnityEngine;

public interface IObserver
{
    void Watch ();
}
```

```c#
using System;
using UnityEngine;

public class Observer :  IObserver
{
    Color value, polledValue;
    private int group;
    private ScriptHome scriptHome;
    private Action<Color> callBack;

    public Observer(ScriptHome scriptHome, int group, Action<Color> Callback )
    {
        this.scriptHome = scriptHome;
        callBack = Callback;
        this.group = group;
        Watch();
    }
    public void Watch ()
    {
        polledValue = scriptHome.GetColor(this.group);
        if (!polledValue.Equals(value))
        {
            callBack(polledValue);
            value = polledValue;
        }
    }
}
```

What's wrong with this solution?
===

