using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TrackingSystem : MonoBehaviour
{
    public float speed = 3.0f;
    public float range = 10f;

    public GameObject m_target;
    public Transform other;
    Vector3 m_lastKnownPosition = Vector3.zero;
    Quaternion m_lookAtRotation;

    // Update is called once per frame
    void Update()
    {
        float dist = Vector3.Distance(other.position, transform.position);
        if (m_target && dist<=range)
        {
            if (m_lastKnownPosition != m_target.transform.position)
            {
                m_lastKnownPosition = m_target.transform.position;
                m_lookAtRotation = Quaternion.LookRotation(m_lastKnownPosition - transform.position);
            }

            if (transform.rotation != m_lookAtRotation)
            {
                transform.rotation = Quaternion.RotateTowards(transform.rotation, m_lookAtRotation, speed * Time.deltaTime);
            }
        }
    }

    public void SetTarget(GameObject target)
    {
        m_target = target;
    }
}
