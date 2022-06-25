using UnityEngine;
using UnityEngine.UI;
using UnityStandardAssets.Vehicles.Car;

public class Speedometer : MonoBehaviour
{
    private Text speedometer;
    public CarController playerCar;
    public Slider revBar;
    public Image revBarFill;

    private void Awake()
    {
        speedometer = GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {
        if (speedometer != null && playerCar != null)
        {
            speedometer.text = string.Format("SPEED: {0} MPH | GEAR: {1}", playerCar.CurrentSpeed.ToString("000"), (playerCar.m_GearNum + 1).ToString("0"));
            revBar.value = playerCar.Revs;
            if (revBar.value > 0.8f)
                revBarFill.color = Color.red;
            else
                revBarFill.color = Color.white;
        }
    }
}
