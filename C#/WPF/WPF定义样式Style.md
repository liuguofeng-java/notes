## WPF定义样式

##### 1.在页面定义`<Window.Resources>`标签

```xaml
 <Window.Resources>
     <Style x:Key="but" TargetType="Button">
         <Setter Property="Content" Value="button1"/>
         <Setter Property="FontSize" Value="20"/>
         <Setter Property="Background" Value="red"/>
     </Style>
</Window.Resources>
```

2.使用

```xaml
<Button Style="{StaticResource but}" />
```

- `Style` 定义样式

  - `x:Key` 相当于css的id

  - `TargetType` 定义控件类型
- `Setter ` 定义属性默认值
  - `Property`属性名
  - `Value` 属性值