using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class FPSCounter : MonoBehaviour
{
    private Text textUI;
    private float fpsCurrent = 0f;
    private float fpsAvg = 0f;
    private float frameCount = 0f;
    private float dt = 0f;

    //The rate that the avg FPS is calculated
    public float updateRate = 1f;

    // Start is called before the first frame update
    void Start()
    {
        //Get reference to this gameobjects Text component
        textUI = gameObject.GetComponent<Text>();
    }

    // Update is called once per frame
    void Update()
    {
        //Calculate the current FPS at this update
        fpsCurrent = 1f / Time.deltaTime;

        //Add the current frame and elapsed time
        frameCount++;
        dt += Time.deltaTime;

        //If the elapsed time has passed the update rate, calculate the average FPS
        if (dt > 1f / updateRate)
        {
            fpsAvg = frameCount / dt;
            frameCount = 0;
            dt -= 1f / updateRate;
        }

        //Set the text in the Text component
        textUI.text = string.Format("FPS:  \t\t{0} \nFPS avg:\t{1}", fpsCurrent, fpsAvg);
    }
}
