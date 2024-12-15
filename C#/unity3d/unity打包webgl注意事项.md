## unity打包webgl注意事项

##### 1.设置压缩类型

在发布模式下构建 WebGL 项目时，Unity 会压缩构建输出文件以减少构建的下载大小。可从 Publishing Settings（菜单：__Edit__ > **Project Settings** > **Player** > **WebGL** > **Publishing Settings__）中的** Compression Format 选项中选择其使用的压缩类型：

- __gzip__：这是默认选项。gzip 文件比 Brotli 文件更大，但构建速度更快，且所有浏览器都基于 http 和 https 实现此格式的本机支持。
- __Brotli__：Brotli 压缩提供最佳压缩比。Brotli 压缩文件明显小于 gzip，但需要很长的压缩时间，因此增加了发布版本的迭代时间。Chrome 和 Firefox 原生支持基于 https 的 Brotli 压缩。如需了解更多信息
- __Disabled__：此选项禁用压缩。如果要在后期处理脚本中实现您自己的压缩，请使用此选项。

<img src="../../assets/image-20241207165028686.png" alt="image-20241207165028686" style="zoom:50%;" />



##### 2.关于打包微信小程序Addressables资源不缓存问题

> 文档：https://wechat-miniprogram.github.io/minigame-unity-webgl-transform/Design/FileCache.html#%E4%B8%89%E3%80%81%E7%BC%93%E5%AD%98%E8%A7%84%E5%88%99