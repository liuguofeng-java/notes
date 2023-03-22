## android定义形状背景等标签

> 这些标签都有一个父标签<shape>
>
> 也就是说定义这些标签要在<shape>下面定义

#### 1.`solid` 设置背景颜色

```xml
<solid android:color="#fc0119" />
```

- color 定义背景

#### 2.`corners` 设置圆弧

```xml
<corners android:radius="10dp" />
```

- radius 定义圆弧半径

#### 3.`padding`设置内边距

```xml
<padding
    android:bottom="10dp"
    android:left="10dp"
    android:right="10dp"
    android:top="10dp" />
```

#### 4.`stroke`设置边框

````xml
<stroke android:width="2dp"
    android:color="#086ffc"
    android:dashGap="20dp"
    android:dashWidth="20dp"/>
````

- width 边框宽度
- color 边框类型
- dashGap 和 dashWidth 定义边框为 划水线 `dashGap `定义实线部分,`dashWidth`定义虚线部分

#### 5.`gradient`设置渐变色

```xml
<gradient  android:angle="5"
    android:startColor="#FF0000"
    android:endColor="#00FF00"
    android:type="linear"/>
```

- angle 开始的角度
- startColor 开始颜色
- endColor 结束颜色
- type 类型:`linear`从开始位置到结束位置向一条直线,`sweep`中心到边界让一圈