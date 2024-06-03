## gsap动画库

> 官方文档: https://gsap.com/docs/
>
> gsap非常的灵活，不仅可以设置复杂动画，还可以对3D场景中的相机位置进行动画处理或过滤值，例如可以和`Three.js`配合
>

##### 1.安装

```sh
npm install gsap
```

##### 2.核心模块

```html
<style>
    #app{
    	height: 100px;
		width: 100px;
        background: red;
    }
</style>
<div id="app"></div>
```

`gsap.to(targets,vars)`：从开始的位置到结束的位置

`gsap.from(targets,vars)`：与上面的`gsap.to`相反，这个是从结束的位置到开始的位置

- `targets` - 你需要添加动画的对象，可以是`object`,`array`和选择器`".myClass"`。
- `vars` - 一个对象，里面包含你想要改变的属性，延时，已经回调函数等,例如:
  - `duration`: 动画的持续时间(单位为秒)。默认值:0.5
  - `repeat`: 参数为重复次数 循环为-1
  - `repeatDelay`：两次重复之间的间隔时间（以秒为单位）
  - `yoyo`: 是布尔值 想要有往复效果则为true 默认为false
  - `stagger`: 参数是来控制如果多目标的时候，每个目标动画的时间差
  - `delay`: 动画开始前的延迟量(以秒为单位)。
  - `ease`: 运动状态, 官网上面对于ease属性给出了很多值:  [ease可视化工具](https://gsap.com/docs/v3/Eases/)

例如: 

```js
import gsap from "gsap";

// // 将.green的div旋转360° 并且位移100 动画时间为1s
var tween = gsap.from("#app", {
    duration: 1,
    x: 500,
    rotation: 360,
    ease:"elastic.in(1,1)" // 运动状态
});

// 若想要将所有的方块一起动的话只需要同时选择多个目标就行了
// gsap.to(".green, .purple", { rotation: 360, x: 100, duration: 1 }) 
```

这个参数能帮我们方便的实现执行顺序和执行时间点的精确控制

```js
let tl = gsap.timeline();
// 绿色方块会在整个时间线开始1秒后进行移动
tl.to(".green", { x: 600, duration: 1 }, 1);

// 紫色方块会和之前一个添加的动画同时开始运动
tl.to(".purple", { x: 600, duration: 1 }, "<");

// 紫色方块会和之前一个添加的动画同时结束运动
tl.to(".purple", { x: 600, duration: 1 }, ">");

// 橘色方块会在之前所有动画都结束一秒后再开始运动
tl.to(".orange", { x: 600, duration: 1 }, "+=1");
```

##### 3.回调函数

- **onComplete**：动画完成时调用
- **onStart**：动画开始时调用
- **onUpdate**：每次动画更新时调用（在动画处于活动状态时每帧调用）
- **onRepeat**：每次动画重复时调用一次
- **onReverseComplete**：动画反转后再次到达其起点时调用

```js
import gsap from "gsap";

var tween = gsap.from("#app", {
    duration: 5,
    x: 500,
    ease:"elastic.in(1,1)",
    onComplete:function () { // 动画播放完成时调用
        console.log("111");
    }
});
```

##### 4.控制动画

- `tween.pause();` 暂停
- `tween.resume(); `恢复
- `tween.reverse(); `反向播放
- `tween.seek(0.5);` 跳到0.5s
- `tween.progress(0.25);` 跳到4分之1处
- `tween.timeScale(0.5);` 速度减慢
- `tween.timeScale(2); `速度翻倍
- `tween.kill();` 删除动画

##### 5.timeline(重要)

> timeline无非就是一条时间线，你可以更好的去控制动画，`尤其是复杂动画都会用到timeline`，将他们串联起来，如果说你想让动画有个执行的先后顺序 

```js
import gsap from "gsap";

// 先定义一条时间线
let tl = gsap.timeline({ duration: 1 });
// let tl = gsap.timeline({  };)也是可以的

// 开始基于时间线做一些动画 结合上面的 gsap.to 和 gsap.from
tl.to(".box", { x: 100, opacity: 0.5 }).to(".box", { rotation: 360 });
//你也可以这么写 实现最后的效果是一样的不过写法会麻烦一点
tl.to(".box", { x: 100, opacity: 0.5 });
tl.to(".box", { rotation: 360 });
```

- `duration()`: 动画的持续时间(单位为秒)。默认值:0.5
- `repeat()`: 参数为重复次数 循环为-1
- `repeatDelay()`：两次重复之间的间隔时间（以秒为单位）
- `yoyo()`: 是布尔值 想要有往复效果则为true 默认为false
- `delay()`: 动画开始前的延迟量(以秒为单位)。