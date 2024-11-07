## unity瓦片地图

##### 1.简单的瓦片地图

- 在`Hierarchy`面板,右击新建`2D Object -> Tilemap -> Rectangular`

  <img src="../../assets/image-20241107222332421.png" alt="image-20241107222332421" style="zoom:50%;" />

- 选择菜单`Window -> 2D -> Tile Palette` 调出`Tile Palette`面板，选择`Create New Tile Palette -> Create`

  <img src="../../assets/image-20241107225131820.png" alt="image-20241107225131820" style="zoom:50%;" />

- 在project视图中`Tlies`文件夹中，右击`Create -> 2D -> Tiles -> Rule Tile`，并起名叫 `BrickTile`

  <img src="../../assets/image-20241107222103986.png" alt="image-20241107222103986" style="zoom: 50%;" />

- 选择`BrickTile`,在`Inspector`面板中，`Default Sprite`选择自己的精灵图，然后把设置好的 `BrickTile`拖到`Tile Palette`绘制地图

<img src="../../assets/image-20241107230222327.png" alt="image-20241107230222327" style="zoom:50%;" />

- 如果出现图片占不满格子的情况，需要找到精灵图把`Pixels Per Unit`设置成图片大小



<img src="../../assets/image-20241107230731573.png" alt="image-20241107230731573" style="zoom:50%;" />