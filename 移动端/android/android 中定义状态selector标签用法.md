## android 中定义状态selector标签用法

> android中selector主要用于在不同的状态下设置不同的背景或者不同的颜色。

| 状态                         | 意义                                                         |
| ---------------------------- | ------------------------------------------------------------ |
| android:state_selected       | 被选择时的状态                                               |
| android:state_focused        | 获得焦点时的状态                                             |
| android:state_pressed        | 被按压时的状态                                               |
| android:state_enabled        | 控件能否处理touch或者click事件时的状态                       |
| android:state_active         | 激活状态，API11及以上才支持，可通过代码调用控件的setActivated(boolean)方法设置是否激活该控件 |
| android:state_checkable      | 是否可以被checked的状态，只有像单选按钮、多选按钮的控件此状态才有效 |
| android:state_checked        | 是否被选中时的状态，也只有在类似单选按钮、多选按钮这样的控   |
| android:state_hovered        | 当光标移动到某一个控件时的状态                               |
| android:state_window_focused | 当前界面是否得到焦点的状态                                   |

如:定义button背景点击和未点击的效果

```xml
<?xml version="1.0" encoding="utf-8"?>
<selector xmlns:android="http://schemas.android.com/apk/res/android">
    <!--定义未点击是的效果-->
    <item android:state_pressed="false">
        <shape>
            <!-- 填充的颜色 -->
            <solid android:color="#278A1C" />
        </shape>
    </item>
    <!--定义点击是的效果-->
    <item android:state_pressed="true">
        <shape>
            <!-- 填充的颜色 -->
            <solid android:color="#fc0119" />
        </shape>
    </item>
</selector>
```

