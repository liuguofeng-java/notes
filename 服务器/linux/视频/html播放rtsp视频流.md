## html播放rtsp视频流

##### 1.安装ffmpeg

##### 2.新建一个node项目

```sh
npm init
npm install rtsp2web
```

##### 3.在目录下新建index.js

```js
const RTSP2web = require('rtsp2web')

// 服务端长连接占据的端口号；端口号可以自定义
const port = 9999
// 分辨率
const videoSize = '1920x1080'

new RTSP2web({
    port 
})

```

##### 4.在页面中使用

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport"
    content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no,viewport-fit=cover">
  <script src="https://jsmpeg.com/jsmpeg.min.js" charset="utf-8"></script>
  <title>播放rtsp</title>
</head>

<body>
  <canvas id="canvas" style="width: 600px; height: 600px;"></canvas>
</body>
<script>
  var rtsp = 'rtsp://admin:jingyou2020@192.168.1.64:554/cam/realmonitor?channel=1&subtype=0'
  window.onload = () => {
    // 将rtsp视频流地址进行btoa处理一下
    new JSMpeg.Player("ws://localhost:9999/rtsp?url=" + btoa(rtsp), {
      canvas: document.getElementById("canvas")
    })
  }
</script>

</html>
```

