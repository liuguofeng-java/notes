## 流媒体服务器rtsp-simple-server

> rtsp-simple-server是一个即用型零依赖的实时媒体服务器和媒体代理，允许用户发布、读取和代理实时视频和音频流。它被设想为一种“媒体路由器”，一种路由媒体流的软件。
>
> github地址 https://github.com/bluenviron/mediamtx
>
> 下载地址 https://github.com/bluenviron/mediamtx/releases

windows 解压后直接执行 exe

linux 解压后执行 `./mediamtx`



ffmpeg rtsp转rtsp命令

```sh
ffmpeg -i rtsp://120.46.163.203:8554/stream -vcodec copy -acodec copy  -f rtsp rtsp://127.0.0.1:8554/stream
```

ffmpeg rtsp转rtmp命令

```sh
ffmpeg -i rtsp://120.46.163.203:8554/stream -vcodec copy -acodec copy -f flv rtsp://127.0.0.1:8554/stream
```

