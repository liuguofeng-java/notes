## flutter android 打包.

#### 1.在java jre/bin执行

```java
keytool -genkey -v -keystore /key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias key
```

#### 2.在项目android 目录下新建 key.properties 文件

```java
storePassword=<password from previous step>    //输入上一步创建KEY时输入的 密钥库 密码
keyPassword=<password from previous step>    //输入上一步创建KEY时输入的 密钥 密码
keyAlias=key
storeFile=<E:/key.jks>    //key.jks的存放路径
```

#### 3.在build.gradle文件中进行配置

进入项目目录的/android/app/build.gradle文件，在android{这一行前面,加入如下代码：

```java
def keystorePropertiesFile = rootProject.file("key.properties")
def keystoreProperties = new Properties()
keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
```

把如下代码进行替换

```java
buildTypes {
    release {
        signingConfig signingConfigs.debug
    }
}
```

替换成的代码：

```java
signingConfigs {
    release {
        keyAlias keystoreProperties['keyAlias']
        keyPassword keystoreProperties['keyPassword']
        storeFile file(keystoreProperties['storeFile'])
        storePassword keystoreProperties['storePassword']
    }
}
buildTypes {
    release {
        signingConfig signingConfigs.release
    }
}
```

生成apk

直接在终端中输入：

```java
flutter build apk
```

