using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace CommandPattern {

    public interface ICommand
    {
        void execute(GameObject gameObject);
    }
}
