## unity常用类

##### 1.`GameObject`当前游戏对象

###### 常用方法

- `GameObject.Find(string name):`通过游戏对象的名称找对象

  - 缺点1:如果出现重名,可能就找不到你想要的那个对象了

  - 缺点2:如果对象很多,太消耗性能制

    ```c#
    // 找到名称为Cube的对象
    GameObject cube = GameObject.Find("Cube");
    ```

- `GameObject.FindWithTag(string tag)`:通过标签找游戏对象

  - 缺点：如果出现重名，可能就找不到你想要的那个对象了

  - 优点:不太消耗性能

    ```c#
    // 通过标签`Player`找游戏对象
    GameObject player = GameObject.FindWithTag("Player");
    ```

- `GameObject.FindGameObjectsWithTag(string tag)`:通过标签找游戏对象

  - 缺点：如果出现重名，可能就找不到你想要的那个对象了

  - 优点:不太消耗性能

    ```c#
    // 通过标签`Player`找多个游戏对象
    GameObject[] players = GameObject.FindGameObjectsWithTag("Player");
    ```

- `SetActive(bool):` 设置组件激活状态

- `AddComponent<?>(): `添加为游戏对象添加一个组件

  ```c#
  // 为游戏对象添加一个脚本为Test的组件
  Test test = gameObject.AddComponent<Test>();
  ```

- `GetComponent<?>():`获取游戏对象组件

  ```C#
  // 获取游戏对象的MeshRenderer组件
  MeshRenderer meshRenderer = gameObject.GetComponent<MeshRenderer>();
  ```

  

###### 常用属性

- `activeSelf:` gameobject的本地活动状态。(只读)
- `transform:`获取游戏对象的Transform



##### 2.transform

###### 常用方法

- `RotateAround(Vector3 point, Vector3 axis, float angle): `绕着点旋转，point:坐标、axis:轴、angle:度数
- `LookAt(Vector3 worldPosition): `看向某个物体
- ` GetChild(int index): `根据下标获取子对象
- `Find(string n): `根据名称n查找子节点并返回它,例如:`transform.Find("Cube")`,也可以通过路径方式查找:`transform.Find("Cube/Sphere")`

###### 常用属性

- `position :`世界坐标位置(可赋值)

- `localPosition :`本地坐标位置(可赋值)

- `eulerAngles: `世界欧拉角旋转位置(可赋值)

- `localEulerAngles: `本地欧拉角旋转位置(可赋值)

- `rotation: `世界四元数旋转位置(可赋值)

- `localRotation: `本地四元数旋转位置(可赋值)

- `localScale: `本地缩放(可赋值)

- `up: `向自身前方移动 (y)

- `forward: `向自身前方移动 (z)

- `right: `向自身右方移动 (x)

- `parent: `获取或设置父对象，如果当前对象没有父对象，则parent为null

- `root: `获取根对象,如果当前对象没有父对象，则root为自己

- `childCount :`获取子对象个数

  