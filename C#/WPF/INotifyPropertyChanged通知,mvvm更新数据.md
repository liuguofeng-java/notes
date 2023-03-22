### INotifyPropertyChanged通知,mvvm更新数据.

> 在WPF MVVM模式开发中，使用他可以通知数据更新

1. 定义一个`NotifyBase`工具类,继承`INotifyPropertyChanged`

   ```C#
   public class NotifyBase : INotifyPropertyChanged
   {
       public event PropertyChangedEventHandler PropertyChanged;
   
       public void DoNotify([CallerMemberName] string name = "")
       {
           PropertyChanged?.Invoke(this,new PropertyChangedEventArgs(name));
       }
   }
   ```

 2. 在绑定的Model中继承定义好的`NotifyBase`

    ```c#
     public class SongModel : NotifyBase
     {
         /// <summary>
         /// 歌曲url
         /// </summary>
         private string _songUrl;
         public string SongUrl
         {
             get { return this._songUrl; }
             set
             {
                 _songUrl = value;
                 DoNotify();
             }
         }
    
         /// <summary>
         /// 本地下载后的mp3路径
         /// </summary>
         private string _localSongUrl;
         public string LocalSongUrl
         {
             get { return this._localSongUrl; }
             set
             {
                 _localSongUrl = value;
                 DoNotify();
             }
         }
    
         /// <summary>
         /// 歌曲图片
         /// </summary>
         private string _picUrl;
         public string PicUrl
         {
             get { return this._picUrl; }
             set
             {
                 _picUrl = value;
                 DoNotify();
             }
         }
    
    
     }
    ```

    
