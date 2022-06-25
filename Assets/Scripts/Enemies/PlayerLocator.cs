using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerLocator : MonoBehaviour
{

    #region Singleton
    public static PlayerLocator instance;
    void Awake()
    {
        instance = this;
    }
    #endregion

    public GameObject player;
}
