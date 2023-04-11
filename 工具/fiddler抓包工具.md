# Fiddler+雷电模拟器进行APP抓包 


##### 1.雷电模拟器下载地址：
 选择3.0正式版（注意，高版本无法抓包，只能下载3.0正式版） https://www.ldmnq.com/other/version-history-and-release-notes.html?log=3

##### 2.打开Fiddler，点击工具栏中的Tools—>Options

<img src="../assets/image-20220819143658426.png" alt="image-20220819143658426" style="zoom:33%;" />

##### 3、点击HTTPS，勾选Decrypt HTTPS traffic和Ignore server certificate(unsafe)

 <img src="../assets/image-20220819143725834.png" alt="image-20220819143725834" style="zoom:33%;" />
##### 4、点击Actions，点击Export Root Certificate to Desktop(此时电脑上桌面会生成 一个证书)

<img src="../assets/image-20220819143853615.png" alt="image-20220819143853615" style="zoom:33%;" />

##### 5、https设置及connections设置，勾选选择项,然后点击确定

 <img src="../assets/image-20220819144012554.png" alt="image-20220819144012554" style="zoom: 33%;" />





##### 6、安装好后，桌面双击打开雷电模拟器，点击设置

 <img src="../assets/image-20220819144235119.png" alt="image-20220819144235119" style="zoom:33%;" />

##### 7、选择网络设置，勾选桥接模式，点击安装驱动，点击确定，点击保存设置

 <img src="../assets/5a93d9443bb6425598db06824abcc99f.png" alt="在这里插入图片描述" style="zoom:33%;" />

##### 8、打开模拟器，设置代理。找到系统应用，点击设置，点击无线网络WLAN—>左键常按点击已连接网络—>修改网络
 <img src="../assets/image-20220819144622328.png" alt="image-20220819144622328" style="zoom:33%;" />


##### 9、将步骤6导出的证书FiddlerRoot.cer文件复制到模拟器 共享文件夹中
<img src="../assets/image-20220819144756139.png" alt="image-20220819144756139" style="zoom:33%;" />
<img src="../assets/image-20220819144822159.png" alt="image-20220819144822159" style="zoom:33%;" />
<img src="../assets/image-20220819144845356.png" alt="image-20220819144845356" style="zoom:33%;" />

<img src="../assets/image-20220819144908513.png" alt="image-20220819144908513" style="zoom:33%;" />

