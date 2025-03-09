## unity平滑移动

##### 1.介绍

> Vector3.SmoothDamp 是 Unity 中用于平滑地改变一个向量（Vector3）到目标向量的静态方法。它通常用于平滑移动、相机跟随、动画过渡等场景，以避免突兀的变化。

```c#
public static Vector3 SmoothDamp(Vector3 current, Vector3 target, ref Vector3 currentVelocity, float smoothTime, float maxSpeed = Mathf.Infinity, float deltaTime = Time.deltaTime);
```

- current：当前向量（通常表示当前位置或方向）。

- target：目标向量（通常表示目标位置或方向）。

- currentVelocity：当前速度向量，用于存储和更新当前的速度。

- smoothTime：平滑时间，表示达到目标向量所需的时间（以秒为单位）。

- maxSpeed：最大速度，表示向量变化的最大速度（可选，默认为 Mathf.Infinity）。

- deltaTime：时间增量，表示当前帧的时间间隔（可选，默认为 Time.deltaTime）。

##### 2.示例代码

```c#
using UnityEngine;
 
public class SmoothDampExample : MonoBehaviour
{
    public Transform target; // 目标位置
    public float smoothTime = 0.3f; // 平滑时间
    public float maxSpeed = Mathf.Infinity; // 最大速度
 
    private Vector3 velocity = Vector3.zero; // 当前速度
 
    void Update()
    {
        // 计算平滑移动后的位置
        Vector3 newPosition = Vector3.SmoothDamp(transform.position, target.position, ref velocity, smoothTime, maxSpeed);
 
        // 更新物体的位置
        transform.position = newPosition;
    }
}
```

