using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using CommandPattern;

public class InputMap : MonoBehaviour
{
    private ICommand fire1;
    private ICommand fire2;

    // Start is called before the first frame update
    void Start()
    {
        this.fire1 = new ShootCommand();
        this.fire2 = new CollectionNovaCommand();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetButton("Fire1"))
        {
            this.fire1.execute(this.gameObject);
        }
        if (Input.GetButton("Fire2"))
        {
            this.fire2.execute(this.gameObject);
        }
    }
        
}
