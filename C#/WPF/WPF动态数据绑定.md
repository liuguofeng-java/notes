## WPF动态数据绑定

如:定义一个`ListBox`

```xaml
<ListBox x:Name="listBox">
    <ListBox.ItemTemplate>
        <DataTemplate>
            <StackPanel Orientation="Horizontal">
                <Border Background="{Binding color}" Height="10" Width="10" />
                <TextBlock Text="{Binding name}" Margin="10,0"/>
            </StackPanel>
        </DataTemplate>
    </ListBox.ItemTemplate>
</ListBox>
```

```c#
 public partial class MainWindow : Window
 {
     public MainWindow()
     {
         InitializeComponent();

         List<ColorLsit> list = new List<ColorLsit>();
         list.Add(new ColorLsit("浅粉红", "#FFB6C1"));
         list.Add(new ColorLsit("脸红的淡紫色", "#FFF0F5"));
         list.Add(new ColorLsit("兰花的紫色", "#DA70D6"));

         listBox.ItemsSource = list;
     }
 }


public class ColorLsit
{
    public ColorLsit(string name,string color)
    {
        this.name = name;
        this.color = color;
    }
    public string name { get; set; }
    public string color { get; set; }
}
```

