## WPF 布局标签.md

##### 1.Grid定义由列和行组成的灵活的网格区域。

```xml
<Grid VerticalAlignment="Top" HorizontalAlignment="Left" ShowGridLines="True" Width="250" Height="100">
  <Grid.ColumnDefinitions>
    <ColumnDefinition />
    <ColumnDefinition />
    <ColumnDefinition />
  </Grid.ColumnDefinitions>
  <Grid.RowDefinitions>
    <RowDefinition />
    <RowDefinition />
    <RowDefinition />
    <RowDefinition />
  </Grid.RowDefinitions>

  <TextBlock FontSize="20" FontWeight="Bold" Grid.ColumnSpan="3" Grid.Row="0">2005 Products Shipped</TextBlock>
  <TextBlock FontSize="12" FontWeight="Bold" Grid.Row="1" Grid.Column="0">Quarter 1</TextBlock>
  <TextBlock FontSize="12" FontWeight="Bold" Grid.Row="1" Grid.Column="1">Quarter 2</TextBlock>
  <TextBlock FontSize="12" FontWeight="Bold" Grid.Row="1" Grid.Column="2">Quarter 3</TextBlock>
  <TextBlock Grid.Row="2" Grid.Column="0">50000</TextBlock>
  <TextBlock Grid.Row="2" Grid.Column="1">100000</TextBlock>
  <TextBlock Grid.Row="2" Grid.Column="2">150000</TextBlock>
  <TextBlock FontSize="16" FontWeight="Bold" Grid.ColumnSpan="3" Grid.Row="3">Total Units: 300000</TextBlock>
</Grid>
```

##### 2.Border 只能有一个子级。 

- Background: 设置背景

- BorderBrush 设置边框颜色 
- BorderThickness 设置边框宽度

- CornerRadius 设置边框圆角半径
- ClipToBounds 若此属性设为True，则其中元素超过其宽高位置时隐藏。

```xml
<!--设置背景图片,并设置板件-->
<Border CornerRadius="5" Height="160" Width="160" VerticalAlignment="Top">
    <Border.Background>
        <ImageBrush ImageSource="{Binding Model.Playlist.coverImgUrl}" Stretch="Fill"/>
    </Border.Background>
</Border>
```

##### 3.DockPanel支持让元素简单地停靠在整个面板的某一条边上，然后拉伸元素以填满全部宽度或高度。它也支持让一个元素填充其他已停靠元素没有占用的剩余空间.最后的子元素将加入一个DockPanel并填满所有剩余的空间，除非DockPanel的LastChildFill属性为false

```xml
<DockPanel LastChildFill="True">
    <Button DockPanel.Dock="Top">Top</Button>
    <Button DockPanel.Dock="Bottom">Bottom</Button>
    <Button DockPanel.Dock="Left">Left</Button>
    <Button DockPanel.Dock="Right">Right</Button>
    <Button DockPanel.Dock="Bottom" >Fill</Button>
    <Button >Fill</Button>
</DockPanel>
```

##### 4.StackPanel 栈面板,可以将元素排列成一行或者一列，其特点是：每个元素各占一行或者一列，

```xml
<StackPanel>
    <Button>Button 1</Button>
    <Button>Button 2</Button>
</StackPanel>
```

##### 5.WrapPanel布局面板将各个控件从左至右按照行或列的顺序罗列，当长度或高度不够时就会自动调整进行换行，后续排序按照从上至下或从右至左的顺序进行。

```xml
<WrapPanel Background="LightBlue">
    <Button Width="200">Button 1</Button>
    <Button>Button 2</Button>
    <Button>Button 3</Button>
    <Button>Button 4</Button>
</WrapPanel>
```

##### 6.UniformGrid 提供一种在网格(网格中的所有单元格都具有相同的大小)中排列内容的方法。

```xml
 <UniformGrid>
    <Button Content="Button"></Button>
    <Button Content="Button"></Button>
    <Button Content="Button"></Button>
    <Button Content="Button"></Button>
    <Button Content="Button"></Button>
    <Button Content="Button"></Button>
    <Button Content="Button"></Button>
</UniformGrid>
```

