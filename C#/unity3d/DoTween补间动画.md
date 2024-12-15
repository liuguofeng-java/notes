## DoTween补间动画

> DOTween是一个快速，高效，完全类型安全的面向对象的Unity动画引擎，针对c#用户进行了优化，免费和开源，具有大量高级功能
>
> 官方网站: https://dotween.demigiant.com/getstarted.php

##### 1.调用方式

1. `DOTween` 可以完全通用的方式使用，如下所示：

   ```C#
   // () => myValue：这部分是获取 myValue 当前的值，告诉 DOTween 从哪个值开始动画。
   // x => myValue = x：这是每一帧更新的回调，DOTween 会根据这个设置修改 myValue，逐渐达到目标值 100。
   // 100：最终目标值，动画会将 myValue 逐渐改变为 100。
   // 1：动画的持续时间是 1 秒，表示在 1 秒钟内，myValue 会从当前值过渡到 100。
   float myValue = 0
   DOTween.To(()=> myValue, x=> myValue = x, 100, 1);ا
   ```

2. 可以利用快捷方式，如下所示：

   ```C#
   // 100：最终目标值，动画会将 myValue 逐渐改变为 100。
   // 1：动画的持续时间是 1 秒，表示在 1 秒钟内，myValue 会从当前值过渡到 100。
   transform.DOMoveX(100, 1);
   ```

##### 2.常用方法

1. **重置所有动画**： 到初始状态，通常用于将所有正在播放的动画恢复到它们的起始位置。

   ```C#
   // 重置所有动画
   DOTween.RewindAll();
   
   // 根据id重置
   DOTween.Rewind(myId);
   ```

2. **反向移动** 

   ```c#
   // 物体从当前位置（比如 X = 0）平滑地移动到目标位置 X = 2，动画持续 1 秒。
   image.transform.DOMoveX(2, 1);
   // 反向移动到物体的当前 X 位置（假设为 X = 0）。也就是说，这会产生一个反向动画，从 X = 2 移动到物体当前的 X（X = 0）。
   image.transform.DOMoveX(2, 1).From();
   // 搞不清？？？
   image.transform.DOMoveX(2, 1).From(true);
   ```

3. **动画循环次数**

   ```C#
   SetLoops(int loops, LoopType loopType);
   
   //这会让物体沿着 X 轴移动 10，持续 1 秒，并且动画会重复 3 次，每次都会从 X = 0 开始到达 X = 10。
   image.transform.DOMoveX(10, 1)
       .SetLoops(3, LoopType.Restart);
   ```

   **`loops`**：指定动画的循环次数。

   - 如果你设置为 `-1`，那么动画将会 **无限循环**，直到你手动暂停或停止它。
   - 如果设置为 `1`，表示动画 **只播放一次**（即不循环）。
   - 设置为任意大于 `1` 的数字时，动画会 **重复播放该次数**。

   **`loopType`**：指定动画循环的类型。常用的循环类型有：

   - **`LoopType.Restart`**：每次循环时，动画会 **从头开始**。这是默认的循环方式。
   - **`LoopType.Yoyo`**：动画会来回循环，**正向播放一次后反向播放一次**。例如，动画先从起点到终点，接着从终点回到起点，然后再继续循环。
   - **`LoopType.Incremental`**：每次循环时，动画的 **起始值会递增**。这对于想要在每次循环时稍微改变动画的行为非常有用。

4. **缓动函数** 自定义参数随时间变化的速率。

   > 传递一个默认的ease，或者一个自定义的ease函数：
   >
   > https://easings.net/zh-cn#

   ```C#
   SetEase(Ease easeType);
   
   // 匀速运动，动画的速度始终保持一致。
   transform.DOMoveX(10, 1).SetEase(Ease.Linear);
   // 缓慢开始，然后加速。
   transform.DOMoveX(10, 1).SetEase(Ease.InQuad);
   // 加速开始，然后慢下来
   transform.DOMoveX(10, 1).SetEase(Ease.OutQuad);
   
   ```
   

5. **回调方法**

   **`OnComplete`**: 动画完成时调用。如`SetLoops`执行完成一下后触发

   **`OnKill`**: 动画被强制停止时调用。

   **`OnPlay`**: 动画开始播放时调用。

   **`OnPause`**: 动画暂停时调用。

   **`OnRewind`**: 动画倒放时调用。

   **`OnStart`**: 动画开始前调用。

   **`OnStepComplete`**: 每一步动画完成时调用。

   **`OnUpdate`**: 每次动画更新时调用。

   **`OnWaypointChange`**: 当路径动画到达路径点时调用。
