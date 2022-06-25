using System;
using UnityEngine;

namespace UnityStandardAssets.Vehicles.Car
{
    public class BrakeLight : MonoBehaviour
    {
        public CarController car; // reference to the car controller, must be dragged in inspector

        public int BrakeLightMaterialIndex; // reference to the material for the brake light

        private Renderer m_Renderer;


        private void Start()
        {
            m_Renderer = GetComponent<Renderer>();
            m_Renderer.material.EnableKeyword("_EMISSION");
        }


        private void Update()
        {
            // enable the Renderer when the car is braking, disable it otherwise.
            //m_Renderer.enabled = car.BrakeInput > 0f;

            if (car.BrakeInput > 0f)
                m_Renderer.materials[BrakeLightMaterialIndex].SetColor("_EmissionColor", Color.red);
            else
                m_Renderer.materials[BrakeLightMaterialIndex].SetColor("_EmissionColor", Color.black);
        }
    }
}
