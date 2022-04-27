using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Arcanum
{
    public enum Spells { Fireball, BlackHole, Meteor}

    [RequireComponent(typeof(BlackHoleMaker))]
    [RequireComponent(typeof(FireballMaker))]
    public class SpellFactory : MonoBehaviour
    {
        public void BuildSpell(Spells type)
        {
            if(Spells.BlackHole == type)
            {
                var blackHole = this.GetComponent<BlackHoleMaker>().Make();
                blackHole.transform.position = this.transform.position;
            }
            else if (Spells.Fireball == type)
            {
                var fireball = this.GetComponent<FireballMaker>().Make();
                fireball.transform.position = this.transform.position;
            }
            else if (Spells.Meteor == type)
            {
                var fireball = this.GetComponent<MeteorMaker>().Make();
                fireball.transform.position = this.transform.position;
            }
        }

        public void Update()
        {
            if (Input.GetButtonDown("Jump"))
            {

                this.BuildSpell(Spells.BlackHole);
            }
            else if(Input.GetButtonDown("Fire1"))
            {
                this.BuildSpell(Spells.Fireball);
            }
            else if (Input.GetButtonDown("Fire2"))
            {
                this.BuildSpell(Spells.Meteor);
            }
         }

    }

}
