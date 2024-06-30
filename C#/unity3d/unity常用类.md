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