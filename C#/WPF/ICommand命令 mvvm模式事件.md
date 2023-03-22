## ICommand命令 mvvm模式事件

> mvvm 模式,用于代替控件事件, 可以使代码结构更清晰；还能更好的控制各个UI的状态(启用/禁用)

1. `nuget` 安装 `Microsoft.Xaml.Behaviors.Wpf`,用于定义控件事件,并在xaml中引用

   ```xaml
   xmlns:i=“http://schemas.microsoft.com/xaml/behaviors”
   ```

2. 定义一个`CommandBase`工具类,继承`ICommand`

   ```C#
   public class CommandBase : ICommand
   {
       public event EventHandler CanExecuteChanged;
   
       public bool CanExecute(object parameter)
       {
           return DoCanExecute.Invoke(parameter);
       }
   
       public void Execute(object parameter)
       {
           DoExecute?.Invoke(parameter);
       }
   
       public Action<object> DoExecute { get; set; }
       public Func<object,bool> DoCanExecute { get; set; }
   }
   ```

3. 在ViewModel中定义事件,并初始化

   ```C#
   public class SongPlayListViewModel
   {
       //定义命令
       public CommandBase PlaySongClickCommand { get; set; }
       public SongPlayListViewModel()
       {
           //初始化命令
           PlaySongClickCommand = new CommandBase();
           PlaySongClickCommand.DoExecute = new Action<object>((o) =>
   		{
               //命令触发逻辑
               //.....
           });
           //按钮是否是在启用状态                           
           PlaySongClickCommand.DoCanExecute = new Func<object, bool>((o) => { return true; });
       }
   }
   ```

4. 在xaml 中使用

   ```xaml
   <behaviors:Interaction.Triggers>
       <!--双击播放音乐,绑定刚刚定义好的命令. EventName是事件名称, CommandParameter是要传的参数  -->
       <behaviors:EventTrigger EventName="MouseDoubleClick">
           <behaviors:InvokeCommandAction Command="{Binding PlaySongClickCommand}" 
                                          CommandParameter="{Binding Model.SelectdIndex}"/>
       </behaviors:EventTrigger>
   </behaviors:Interaction.Triggers>
   ```

   