## 流媒体服务器rtsp-simple-server

#### 1.安装

> rtsp-simple-server是一个即用型零依赖的实时媒体服务器和媒体代理，允许用户发布、读取和代理实时视频和音频流。它被设想为一种“媒体路由器”，一种路由媒体流的软件。
>
> github地址 https://github.com/bluenviron/mediamtx
>
> 下载地址 https://github.com/bluenviron/mediamtx/releases

windows 解压后直接执行 exe

linux 解压后执行 `./mediamtx`

#### 2.API

修改`mediamtx.yml`

> API配置设为yes，apiAddress是api的地址和端口号，默认127.0.0.1:9997，可以使用本机IP，0.0.0.0表示127.0.0.1和本机实际IP都可以访问

```yml
###############################################
# Global settings -> API

# Enable controlling the server through the API.
api: yes
# Address of the API listener.
apiAddress: 0.0.0.0:9997

###############################################
```

#### 3.API使用

>API文档：https://bluenviron.github.io/mediamtx/

1、 http://127.0.0.1:9997/v2/paths/list 查看当前的视频流，包括yml里面配置的和通过api添加的

```json
{
  "itemCount": 2,
  "pageCount": 1,
  "items": [
    {
      "name": "stream",
      "confName": "all_others",
      "source": {
        "type": "rtspSession",
        "id": "4eafefc6-d719-4987-8ce9-88f19cc2490b"
      },
      "ready": true,
      "readyTime": "2024-02-04T02:44:10.799401193-04:00",
      "tracks": [
        "H264",
        "MPEG-4 Audio"
      ],
      "bytesReceived": 103222917,
      "bytesSent": 96777370,
      "readers": [
        {
          "type": "rtspSession",
          "id": "2da33b12-742a-4026-86e8-5a585932c133"
        }
      ]
    },
    {
      "name": "stream1",
      "confName": "all_others",
      "source": {
        "type": "rtspSession",
        "id": "90506e56-da4e-4a46-b8a7-6989b18652cb"
      },
      "ready": true,
      "readyTime": "2024-02-04T02:44:07.799062687-04:00",
      "tracks": [
        "H264",
        "MPEG-4 Audio"
      ],
      "bytesReceived": 103782668,
      "bytesSent": 0,
      "readers": [
        
      ]
    }
  ]
}
```

#### 4.ffmpeg转流命令

1. ffmpeg MP4转rtsp命令

   ```sh
   ffmpeg -re -i 1181048673-1-192.mp4 -c copy -rtsp_transport tcp -f rtsp rtsp://192.168.198.129:8554/stream
   ```

2. ffmpeg rtsp转rtmp命令

   ```sh
   ffmpeg -i rtsp://192.168.198.129:8554/stream -c copy -f flv rtmp://192.168.198.129:1935/stream
   ```

   

