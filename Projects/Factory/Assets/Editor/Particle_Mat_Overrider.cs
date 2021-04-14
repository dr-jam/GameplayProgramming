using UnityEditor;
using UnityEngine;

class Particle_Mat_Overrider : EditorWindow {
	
	
	ParticleSystem systemParent;
	Material material0;
	Material material1;
	
	[MenuItem ("Unluck/Material Override")]
		
		
	static void ShowWindow () 
	{
		EditorWindow.GetWindow <Particle_Mat_Overrider>();
	}
	
	void OnGUI () 
	{
		if(Selection.activeTransform != null)
		{
			systemParent = Selection.activeTransform.GetComponent<ParticleSystem>();
			
		}
		EditorGUILayout.LabelField("Force 2 or 1 material(s) on shuriken particle system(s)");
		EditorGUILayout.LabelField("(consider using 1 material for slower devices)");
		EditorGUILayout.Space();
		EditorGUILayout.LabelField("Get materials from shuriken particle system in scene");
		// systemParent = EditorGUILayout.ObjectField ("Particle System: ", systemParent, typeof (ParticleSystem), true) as ParticleSystem;
		if (GUILayout.Button("Get Materials"))
		{
			getMaterials();
		}
		
		material0 = EditorGUILayout.ObjectField ("Material 0: ", material0, typeof (Material), true) as Material;
		material1 = EditorGUILayout.ObjectField ("Material 1: ", material1, typeof (Material), true) as Material;
		EditorGUILayout.Space();
		EditorGUILayout.LabelField("Apply materials to selected shuriken particle system(s)");
		if (GUILayout.Button("Set Materials"))
		{
			overideMaterials();
		}
	}
	
	void overideMaterials() 
	{
		
		Material[]  newArray =new Material[2] ;

		if(material0 != null)
		{
			newArray[0] = material0;
		}

		if(material1 != null)
		{
			newArray[1] = material1;
		}

		if(newArray.Length > 0)
		{
			for(int i = 0; i < Selection.transforms.Length; i++)
			{
				//	Debug.Log(i+""+Selection.transforms.Length);
				if(Selection.transforms[i].GetComponent<ParticleSystemRenderer>()!=null)
					Selection.transforms[i].GetComponent<ParticleSystemRenderer>().sharedMaterials= newArray;
			}
			//systemParent.GetComponent(ParticleSystemRenderer).sharedMaterials= newArray;
		}
	}
	
	void getMaterials() 
	{
		if(systemParent != null)
		{
			if(systemParent.GetComponent<ParticleSystemRenderer>().sharedMaterials[0] != null)
			{
				material0=systemParent.GetComponent<ParticleSystemRenderer>().sharedMaterials[0];
			}
			if(systemParent.GetComponent<ParticleSystemRenderer>().sharedMaterials[1] != null)
			{
				material1=systemParent.GetComponent<ParticleSystemRenderer>().sharedMaterials[1];
			}
		}
	}
}