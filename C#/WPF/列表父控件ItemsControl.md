# 列表父控件ItemsContro

> `ItemsControl`是用来表示一些条目集合的控件，它的成员是一些其它控件的集合
>
> 像是`ListBox`、`ListView`、`ComboBox`都是继承于`ItemsControl`
>
> `ItemsControl`可以很好的控制列表的 形状、方向、可以定义包裹的组件的容器



##### ItemsControl的最重要的3个属性

1. ItemsSource：主要用来绑定到数据源，以将数据填充到ItemsControl中

2. ItemsPanel：设置包裹items的父组件, 如：是以`StackPanel`的形式，还是以`Grid`的形式来显示`ItemsControl`包含的所有元素。

3. ItemTemplate：其类型为DataTemplate，主要定义数据模板用



##### 例子:

```xaml
<ItemsControl ItemsSource="{Binding Model.Playlist.tags}">
    <!---定义父容器-->
    <ItemsControl.ItemsPanel>
        <ItemsPanelTemplate>
            <StackPanel Orientation="Horizontal"/>
        </ItemsPanelTemplate>
    </ItemsControl.ItemsPanel>
    <!--定义数据模板-->
    <ItemsControl.ItemTemplate>
        <DataTemplate>
            <StackPanel Orientation="Horizontal">
                <Button Style="{DynamicResource DefaultButtonStyle}"  Content="{Binding}" Margin="0 2 0 2" FontSize="12" Foreground="#517eaf"/>
                <Label Content="/" FontSize="12" Foreground="#5a5a5a"/>
            </StackPanel>
        </DataTemplate>
    </ItemsControl.ItemTemplate>
</ItemsControl>
```

![image-20221111104129247](../../assets/image-20221111104129247.png)