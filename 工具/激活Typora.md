## 激活Typora

#### 1.安装 Typora
[typora安装包](../assets/typora-setup-x64.exe)

#### 2. 激活 Typora
找到Typora安装目录，依次找到这个文件

``` sh
resources\page-dist\static\js\LicenseIndex.**********.********.chunk.js
```

用记事本打开它，

查  找 `【e.hasActivated="true"==e.hasActivated,】`

替换为`【e.hasActivated="true"=="true",】`

#### 3. 关闭软件每次启动时的已激活弹窗
注意：这个时候打开软件已经提示激活成功了

由于每次打开软件都会弹出“已激活”的窗口，下面是关闭这个弹窗。

在Typora安装目录依次找到这个文件

`resources\page-dist\license.html`

用记事本打开它，

查  找`【</body></html>】`

替换为`【</body><script>window.οnlοad=function(){setTimeout(()=>{window.close();},5);}</script></html>】`

04、去除软件左下角“未激活”提示
在Typora安装目录依次找到这个文件

`resources\locales\zh-Hans.lproj\Panel.json `

查  找`【"UNREGISTERED":"未激活",】`

替换为`【"UNREGISTERED":" ",】`
