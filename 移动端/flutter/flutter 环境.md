## flutter 环境

#### 下载安装 FlutterSDK

1. 去官网下载Flutter安装包，下载地址:https://flutter.io/sdk-archive/#windows (这个官方会经常改动，如果不可用，请通知我，我再进行修改。)我选择的版本是0.9.4。

1. 将安装包zip解压到你想安装Flutter SDK的路径（如： E:\fluter\flutter；注意，不要将flutter安装到需要一些高权限的路径如C:\Program Files\，这个没必要跟我一样，凭借自己喜好设置就好）。

1. 在Flutter安装目录的flutter文件下找到flutter_console.bat，双击运行并启动flutter命令行，接下来，你就可以在Flutter命令行运行flutter命令了。

1. 配置环境变量，Flutter的执行是要进行联网的，由于国内的原因，所以你需要设置环境变量（墙翻的好，这步可以省略.视频中有具体讲解）

```java
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
```

1. 如果你想在任何地方都可以执行Flutter命令，你需要把Flutter SDK的目录配到环境变量中的path条目下。（这个也看视频吧）

进行Flutter doctor 的测试

在终端中输入flutter doctor，你可能会得到下面类似的结果。

```java
Android toolchain - develop for Android devices
    • Android SDK at D:\Android\sdk
    ✗ Android SDK is missing command line tools; download from https://goo.gl/XxQghQ
    • Try re-installing or updating your Android SDK,
      visit https://flutter.io/setup/#android-setup for detailed instructions.
```

这时候你得到的x比这个会多一些，因为我们还没有安装Android studio那下一步就是进行Android Studio的安装。

#### 安装Android证书

安装好Android Studio后，再次打开终端（命令行），输入flutter doctor,这时候的x会明显减少，但是你还是会遇到1-2个，其中有一个就是提示没有安装证书。安装证书只要在终端里执行下面的命令。

```java
flutter doctor --android-licenses
```

然后会提示你选Y/N，不要犹豫，一律选择Y，就可以把证书安装好。（说的都是一大堆一大堆的英文，我也看不懂是啥）

到这里windows的开发环境就安装的差不多了，但是你不要高兴的太早，我们下节课安装虚拟机，并在虚拟机上运行也许你会碰上很大的麻烦。（如果你跟着学，一定要把这节课做完，再继续学习）