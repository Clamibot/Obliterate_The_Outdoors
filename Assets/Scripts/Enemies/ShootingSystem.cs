using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class ShootingSystem : MonoBehaviour
{
    public float fireRate;
    public int damage;
    public float fieldOfView;

    public GameObject projectile;
    public GameObject destructedPrefab;
    public List<GameObject> projectileSpawns;

    List<GameObject> m_lastProjectiles = new List<GameObject>();
    float m_fireTimer = 0.0f;
    public GameObject m_target;
    bool alive = true;
    bool active = false;

    public GPUInstancer.GPUInstancerPrefabManager prefabManager;
    private GPUInstancer.GPUInstancerPrefab allocatedGameObject;

    void Start()
    {
        allocatedGameObject = GetComponent<GPUInstancer.GPUInstancerPrefab>();
    }

    // Update is called once per frame
    void Update()
    {
        if (active)
        {
            m_fireTimer += Time.deltaTime;

            if (m_fireTimer >= fireRate)
            {
                float angle = Quaternion.Angle(transform.rotation, Quaternion.LookRotation(m_target.transform.position - transform.position));

                if (angle < fieldOfView)
                {
                    if (alive == true)
                    {
                        SpawnProjectiles();
                    }
                    m_fireTimer = 0.0f;
                }
            }
        }   
    }

    void SpawnProjectiles()
    {
        if (!projectile)
        {
            return;
        }

        m_lastProjectiles.Clear();

        for (int i = 0; i < projectileSpawns.Count; i++)
        {
            if (projectileSpawns[i])
            {
                GameObject proj = Instantiate(projectile, projectileSpawns[i].transform.position, Quaternion.Euler(projectileSpawns[i].transform.forward)) as GameObject;
                proj.GetComponent<BaseProjectile>().FireProjectile(projectileSpawns[i], m_target, damage, fireRate);

                m_lastProjectiles.Add(proj);
            }
        }
    }

    public void SetTarget(GameObject target)
    {
        m_target = target;
    }

    void RemoveLastProjectiles()
    {
        while (m_lastProjectiles.Count > 0)
        {
            Destroy(m_lastProjectiles[0]);
            m_lastProjectiles.RemoveAt(0);
        }
    }

    void OnCollisionEnter(Collision other)
    {
        if (other.gameObject.tag == ("Player"))
        {
            alive = false;
            GPUInstancer.GPUInstancerAPI.RemovePrefabInstance(prefabManager, allocatedGameObject);
            Instantiate(destructedPrefab, transform.position, transform.rotation);
            Destroy(gameObject);
        }
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.tag == ("Player"))
            active = true;
            
    }

    void OnTriggerExit(Collider other)
    {
        if (other.gameObject.tag == ("Player"))
            active = false;
    }
}