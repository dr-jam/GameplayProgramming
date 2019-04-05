using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TreeGrower : MonoBehaviour {


    private List<GameObject> tips;

    //What happens when you make these member variables public?
    private float growChance = 0.94f;
    private float splitChance = 0.99f;
    private Vector3 SplitRotation = new Vector3(0.0f, 0.0f, -15.0f);
    private Vector3 GrowthRotation = new Vector3(0.0f, 0.0f, 0.5f);
    private Object GrowthPrefab;

	// Use this for initialization
	void Start () {
        this.tips = new List<GameObject>();
        this.GrowthPrefab = Resources.Load("growth");
        GameObject newGrowthAtOrigin;
        //What is the (GameObject) casting bad practice?
        newGrowthAtOrigin = (GameObject)Instantiate(this.GrowthPrefab, new Vector3(0, 0, 0), Quaternion.identity);
        this.tips.Add(newGrowthAtOrigin);
    }
	
	// Update is called once per frame
	void Update () {
        var tipsToRemove = new List<GameObject>();
        var tipsToAdd = new List<GameObject>();
        foreach (var tip in this.tips)
        {
            float rnd = Random.value;
            if(rnd < this.growChance)
            {
                var newTip = (GameObject)Instantiate(this.GrowthPrefab, tip.transform);
                newTip.transform.Rotate(this.GrowthRotation);
                newTip.transform.Translate(Vector3.up * 1.0f);
                tipsToRemove.Add(tip);
                tipsToAdd.Add(newTip);

            }
            else if(rnd < this.splitChance)
            {
                var splitTip = (GameObject)Instantiate(this.GrowthPrefab, tip.transform);
                splitTip.transform.Rotate(this.SplitRotation);
                tipsToAdd.Add(splitTip);
            } else
            {
                tipsToRemove.Add(tip);
            }
        }
        //Why is this.tips being modified outside of the first foreach loop in this function?
        foreach (var tip in tipsToRemove)
        {
            this.tips.Remove(tip);
        }
        foreach (var tip in tipsToAdd)
        {
            this.tips.Add(tip);
        }
    }
}
