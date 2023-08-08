## android代码混淆配置：ProGuard

#### 一. 配置文件中打开混淆

在build.gradle文件中配置如下代码：



```csharp
android {
    buildTypes {
    debug {
            ...
        }
        release {
            //混淆开关
            minifyEnabled true
            // 是否zip对齐
            zipAlignEnabled true
            // 移除无用的resource文件
            shrinkResources false
            // 是否打开debuggable开关
            debuggable false
            // 是否打开jniDebuggable开关
            jniDebuggable false
            proguardFiles 'proguard-rules.pro'
            signingConfig signingConfigs.release
        }
    }
}
```

从上述代码中可以看到配置混淆开关的是`minifyEnabled`,设置为true可以打开混淆。

混淆一般是配置在release包中，原因是因为debug包一般来说是开发者在开发需要时运行调试的，混淆会减慢打包速度，对于开发程序效率有所影响。但是这不表示我们在开发程序时不注重混淆设置，在混淆设置不正确的情况下可能会发生查找不到某个类的异常，因此如果项目中有打开混淆，在需求完成后添加混淆并自测是必要步骤。

#### 二. 配置混淆文件

ProGuard在AS中默认的配置文件是`proguard-rules.pro`，因此我们只需要配置此文件即可。

ProGuard配置比较繁琐，但是其核心内容主要包括下面几个部分：

1. 基本配置，如混淆算法，压缩等级，混淆的范围等等。
2. 需要keep不能混淆的项，warning处理。

ProGuard文件的语法是比较多的，具体内容可以参考[ProGuard的官方文档](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.guardsquare.com%2Fen%2Fproducts%2Fproguard%2Fmanual%2Frefcard)，本文在此不再赘述，仅举例说明常见的apk混淆文件配置。

我们常见的ProGuard文件主要包含如下几个部分：

1. 基本配置，设定混淆的规则等，基本配置是每个混淆文件必须存在的，并且此块内容大部分通用，可以直接copy。
2. 基本的keep项，多数Android工程都需要非混淆的内容，包括有四大组件等内容，此项内容也大部分通用，也可以直接copy。
3. 三方引入的lib包混淆，这个内容需要去各自的官网去查找对应的混淆添加代码。
4. 其他需要不混淆的内容，包括：实体类，json解析类，WebView及js的调用模块，与反射相关的类和方法。

下面将会对上述的几项内容分别示例说明：

##### 1. 基本配置

基本配置基本上变化不大，一般的项目可以直接copy，示例如下：



```ruby
#指定压缩级别
-optimizationpasses 5

#不跳过非公共的库的类成员
-dontskipnonpubliclibraryclassmembers

#混淆时采用的算法
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

#把混淆类中的方法名也混淆了
-useuniqueclassmembernames

#指定不去忽略非公共的库的类
-dontskipnonpubliclibraryclasses

#不做预检验，preverify是proguard的四大步骤之一,可以加快混淆速度
#-dontpreverify

# 忽略警告（？）
#-ignorewarnings

#混淆时不使用大小写混合，混淆后的类名为小写(大小写混淆容易导致class文件相互覆盖）
-dontusemixedcaseclassnames

#优化时允许访问并修改有修饰符的类和类的成员
-allowaccessmodification

#将文件来源重命名为“SourceFile”字符串
#-renamesourcefileattribute SourceFile
#保留行号
-keepattributes SourceFile,LineNumberTable
#保持泛型
-keepattributes Signature
# 保持注解
-keepattributes *Annotation*,InnerClasses

# 保持测试相关的代码
-dontnote junit.framework.**
-dontnote junit.runner.**
-dontwarn android.test.**
-dontwarn android.support.test.**
-dontwarn org.junit.**
```

##### 2. 基本的项目配置

多数是包括序列化，Android四大组件等基本内容的混淆keep，对于常规的项目而言区别不大，也可以进行copy。示例如下：



```cpp
# Parcelable
-keep class * implements android.os.Parcelable {
  public static final android.os.Parcelable$Creator *;
}
# Serializable
-keepnames class * implements java.io.Serializable
-keepclassmembers class * implements java.io.Serializable {
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# 保留R下面的资源
-keep class **.R$* {*;}

# 保留四大组件，自定义的Application,Fragment等这些类不被混淆
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Fragment
-keep public class * extends android.app.Application
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference

## support
-dontwarn android.support.**
-keep class android.support.v4.app.** { *; }
-keep interface android.support.v4.app.** { *;}
-keep public class * extends android.support.v7.**
-keep public class * extends android.support.annotation.**

-keep public class * extends android.support.v4.view.ActionProvider {
    public <init>(android.content.Context);
}

# 保留枚举类不被混淆
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# 保留本地native方法不被混淆
-keepclasseswithmembers class * {
    native <methods>;
}

# 对于带有回调函数的onXXEvent、**On*Listener的，不能被混淆
-keepclassmembers class * {
    void *(**On*Event);
    void *(**On*Listener);
}

-keepclassmembers public class * extends android.view.View {
   void set*(***);
   *** get*();
}

#保留在Activity中的方法参数是view的方法，
-keepclassmembers class * extends android.app.Activity {
   public void *(android.view.View);
}

# For XML inflating, keep views' constructoricon.png    自定义view
-keep public class * extends android.view.View {
    public <init>(android.content.Context);
    public <init>(android.content.Context, android.util.AttributeSet);
    public <init>(android.content.Context, android.util.AttributeSet, int);
    public void set*(...);
}
```

现在Android中使用Androidx是比较常见的，还可以包括Androidx的混淆：



```kotlin
# androidx 混淆
-keep class com.google.android.material.** {*;}
-keep class androidx.** {*;}
-keep public class * extends androidx.**
-keep interface androidx.** {*;}
-dontwarn com.google.android.material.**
-dontnote com.google.android.material.**
-dontwarn androidx.**
-printconfiguration
-keep,allowobfuscation @interface androidx.annotation.Keep

-keep @androidx.annotation.Keep class *
-keepclassmembers class * {
    @androidx.annotation.Keep *;
}
```

##### 3. 三方SDK的混淆

三方SDK的混淆代码需要去各自的SDK官网上去查找，在此仅以`OKHTTP`和`gson`作为示例：



```php
# google gson
-keep class org.json { *; }
-keep class com.google.gson.** { *; }
-keep class sun.misc.Unsafe { *; }
-keep class com.google.** { *;}

# OkHttp3
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
-keep interface com.squareup.okhttp3.** { *;}
-dontwarn okio.**
-keep class okio.**{*;}
-keep interface okio.**{*;}
```

##### 4. 其他混淆内容

其他混淆内容比较杂，包括：实体类，json解析类，WebView及js的调用模块，与反射相关的类和方法。

对于上述的这些内容在项目中的一定要查询清楚并添加到配置文件中，否则可能在程序运行时出现异常，WebView示例代码如下：



```css
# WebView
-dontwarn android.webkit.WebView
-dontwarn android.net.http.SslError
-dontwarn android.webkit.WebViewClient
-keep public class android.webkit.WebView
-keep public class android.net.http.SslError
-keep public class android.webkit.WebViewClient
```

其他内容可以按照下面的格式进行粗暴的设置keep效果：



```cpp
-keep class 类所在的包.** { *; }
```

##### 5. log过滤

混淆文件中还可以配置log过滤效果，示例代码如下：



```cpp
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
}
```

#### 三. 混淆结果

在添加混淆之后，在排查时我们可以对混淆和未混淆的类名进行记录和打印，在混淆文件中添加如下代码可以查看混淆编译的类及文件结构：



```bash
# 混淆映射，生成映射文件
-verbose
-printmapping proguardMapping.txt
#输出apk包内所有的class的内部结构
-dump dump.txt
#未混淆的类和成员
-printseeds seeds.txt
#列出从apk中删除的代码
-printusage unused.txt
```

添加上述代码之后，会在生成release包时也同时生成三个日志文件，我们在排查混淆问题时可以以上述三个文件作为参考，快速排查。

在完成了上述工作之后，必须要彻底的测试你当前的项目，很难保证在你添加的keep选项是否完整，因此必须要对所有的项目内容及类进行排查，确保没有问题之后才能提交。

