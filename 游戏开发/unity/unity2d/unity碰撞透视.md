## unity碰撞透视

##### 1.设置透视排序规则

1. 在`Edit -> Project Settings -> Graphics` 找到`Transparency Sort Mode`设置为`Custom Axis`, `Transparency Sort Axis`设置为 x:0 y:1 z:0

   <img src="../../assets/image-20241109102932039.png" alt="image-20241109102932039" style="zoom:50%;" />



2. 设置图片中心点位，点击图片在`Inspector`中把`Sprite Sort Point`改成`Pivot`,并点击`Open Sprite Editor`设置中心点位位置,并点击`Apply`

<img src="../../assets/image-20241109105204338.png" alt="image-20241109105204338" style="zoom:50%;" />

3. 设置碰撞器和刚体

   <img src="../../assets/image-20241109110258816.png" alt="image-20241109110258816" style="zoom:50%;" />
