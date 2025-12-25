## godot补间动画



> 官方：https://docs.godotengine.org/zh-cn/4.3/classes/class_tween.html#

##### 1.基本用法

```py
var tween = create_tween()

# 延迟0.5秒后执行动画
tween.tween_interval(0.5)

# 从当前颜色改变为#ffffff 持续两秒
tween.tween_property($Sprite, "modulate", Color("#ffffff"), 2)

# parallel() 与上一个并行执行, 旋转360 持续2秒
tween.parallel().tween_property($Sprite, "rotation_degrees", 360.0, 2)

# 设置颜色 a通道 从当前值改变为 1.0持续2秒
tween.parallel().tween_property($Sprite, "modulate:a", 1.0, 2)

# 当前位置移动到 50位置上，持续2秒
tween.tween_property($Sprite, "position:x", 50, 2)

# 当时缩放到 Vector2(1.0, 1.0),持续1秒
tween.parallel().tween_property($Sprite, "scale", Vector2(1.0, 1.0), 1)

# 从Vector2(225, 0)移动到Vector2(0, 0) ，持续0.6秒
tween.tween_property($Sprite, "position", Vector2(0, 0), 0.6).from(Vector2(225, 0))

# 当前大小变化为Vector2(180.0, 95.0),持续2秒，其中set_ease:缓动效果,set_trans:过渡类型
tween.tween_property($Sprite, "size", Vector2(180.0, 95.0), 2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)

# 判断当前动画是否运行,运行中将结束,然后重新创建
if tween and tween.is_running():
    tween.kill()
tween = create_tween()

# 配置 tween_method：数值从 0→1500，持续1.5秒，回调绑定后的 set_text
tween.tween_method(set_text.bind($Sprite, true), 0, 1500, 1.5)
# 数值更新函数：接收 Tween 自动传递的 value，设置 Label 文本
func set_text(value: int, label: Label, add: bool = false) -> void:
    if add:
        label.text = "+" + str(value)
    else:
        label.text = str(value)
        
# 当前动画执行完毕  
tween.tween_callback(tween_callback)
func tween_callback() -> void:
	star_particles.restart()
	print('---->>>>当前动画播放完毕')
	pass
```

##### 2.`set_ease`和`set_trans`

1. `set_ease()` 用于定义动画**在过渡曲线上的侧重方向**，即「变化速度在动画的开始、中间、结束阶段如何分布」。它的参数是 `Tween.EaseType` 枚举，常用取值包括：

   - `Tween.EASE_IN`：动画开始时慢，逐渐加速（侧重「进入」时的缓冲）
   - `Tween.EASE_OUT`：动画开始时快，逐渐减速（侧重「退出」时的缓冲，最常用）
   - `Tween.EASE_IN_OUT`：开始和结束都慢，中间快（两头缓冲，过渡更柔和）
   - `Tween.EASE_OUT_IN`：开始和结束都快，中间慢（较少用，适合特定节奏）

2. `set_trans()` 用于定义动画**数值变化的数学曲线类型**，可以参考:[tween_cheatsheet](https://raw.githubusercontent.com/godotengine/godot-docs/master/img/tween_cheatsheet.webp)。它的参数是 `Tween.TransitionType` 枚举，常用取值包括：
   - `TRANS_LINEAR `： 动画是线性插值的。
   - `TRANS_SINE`：动画使用正弦函数进行插值。
   - `TRANS_QUINT`：动画使用五次（5 次方）函数进行插值。
   - `TRANS_QUART` ：动画使用四次（4 次方）函数进行插值。
   - `TRANS_QUAD`：动画使用二次（2 次方）函数进行插值。
   - `TRANS_EXPO`：动画使用指数（x 次方）函数进行插值。
   - `TRANS_ELASTIC`：动画弹性插值，在边缘摆动。
   - `TRANS_CUBIC`：动画使用三次（3 次方）函数进行插值。
   - `TRANS_CIRC`：动画使用平方根的函数进行插值。
   - `TRANS_BOUNCE`：动画通过在末尾弹跳插值。
   - `TRANS_BACK`：动画在末端回放插值。
   - `TRANS_SPRING`：动画像朝着末尾的弹簧一样插值。

##### 3.常用方法

- **`create_tween()`**
  创建一个 Tween 实例，自动与当前节点绑定（节点销毁时 Tween 自动释放），无需手动管理生命周期。
  示例：`var tween = create_tween()`
- **`tween_interval(duration)`**
  在动画序列中插入指定时长（秒）的等待间隔，需跟在其他动画方法后，作为序列的一部分。
  示例：`tween.tween_property(...)`.tween_interval (0.5) # 上一个动画结束后等待 0.5 秒
- **`parallel()`**
  使后续动画与上一个动画**同时执行**（并行），默认情况下动画为按顺序执行（串行）。
  示例：`tween.tween_property(...)`.parallel ().tween_property (...) # 两个动画同时进行
- **`is_running()`**
  返回布尔值，判断 Tween 是否正在执行动画（包括等待、插值过程），用于避免重复触发动画。
  示例：`if not tween.is_running(): tween.tween_property(...)`
- **`kill()`**
  立即终止 Tween 的所有动画（包括未执行的序列），释放动画资源。
  示例：`tween.kill()` # 强制结束当前所有动画
- **`tween_callback(func)`**
  在动画执行到该位置时触发指定函数（无参数），常用于动画结束后执行后续逻辑。
  示例：`tween.tween_property(...)`.tween_callback (on_anim_finish) # 动画结束后调用函数
- **`tween_method(func, start, end, duration)`**
  将数值从 `start` 到 `end` 的平滑过渡过程绑定到自定义函数，每帧将当前插值传递给函数，适用于数值动画、进度更新等。
  示例：`tween.tween_method(update_score, 0, 1000, 2.0)` # 2 秒内从 0 到 1000，实时更新分数
- **`tween_property(node, property, target, duration).from(start)`**
  对节点的指定属性执行动画，默认从当前属性值开始；用 `.from(start)` 可强制指定起始值。
  示例：`tween.tween_property(node, "position", Vector2(100,100), 1.0).from(Vector2(0,0))`
- **`set_loops(count)`**
  设置动画序列的循环次数，`-1` 表示无限循环。
  示例：`tween.set_loops(3).tween_property(...)` # 动画循环执行 3 次