## html5 webRTC demo
```java
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
</head>
<body>
  <video id="localVideo" autoplay></video>
  <video id="video" autoplay></video>
  
  <script src="./index.js"></script>
</body>
</html>
```



```java
//流连接通道
var PeerConnection = (window.webkitRTCPeerConnection || window.mozRTCPeerConnection || window.RTCPeerConnection || undefined);
//RTC信令
var RTCSessionDescription = (window.webkitRTCSessionDescription || window.mozRTCSessionDescription || window.RTCSessionDescription || undefined);
//摄像头对象
navigator.getUserMedia = (navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia);

//本地视频流
var locatStream = null;
//穿透服务器
var config = {
  iceServers: [
    {
      "url": "turn:1.117.54.66",
      "username": "root",
      "credential": "Lbf123Lbf"
    }
  ],
};


navigator.getUserMedia({
  "audio": true,
  "video": true
}, function success(stream) {
  try {
    document.getElementById("localVideo").srcObject = stream;
  } catch (error) {
    document.getElementById("localVideo").src = window.URL.createObjectURL(stream);
  }
  locatStream = stream;
  init();
}, function error(error) {
  console.log(error);
});

//初始化
let localPeerConnection = new PeerConnection(config);
function init() {
  localPeerConnection.addStream(locatStream);//初始化绑定本地视频流
  //发送offer
  localPeerConnection.createOffer(
    function (offer) {
      console.log(offer)
      offerFun(offer)
      localPeerConnection.setLocalDescription(offer);
    },
    function (error) {
      console.log(error);
    })
  //绑定onicecandidate事件
  localPeerConnection.onicecandidate = function (event) {
    console.log('candidate', event.candidate);
  }
  //绑定onaddstream事件
  localPeerConnection.onaddstream = function (event) {
    console.log('onaddstream', event.stream);
    try {
      document.getElementById("video").srcObject = event.stream;
    } catch (error) {
      document.getElementById("video").src = window.URL.createObjectURL(event.stream);
    }
  }
}



function answerFun(data) {
  console.log('answer', data)
  var rtcs = new RTCSessionDescription(data);
  localPeerConnection.setRemoteDescription(rtcs);
}

function candidateFun(data) {
  if (data == null) return
  localPeerConnection.addIceCandidate(new RTCIceCandidate(data));
}

var peerConnection = new PeerConnection(config);
function offerFun(data) {
  var rtcs = new RTCSessionDescription(data);
  peerConnection.setRemoteDescription(rtcs);
  peerConnection.addStream(locatStream);
  peerConnection.createAnswer(
    function (desc) {
      peerConnection.setLocalDescription(desc);
      answerFun(desc)
      console.log('answer', desc);
    }, function (error) {
      console.log(error);
    });

  peerConnection.onicecandidate = function (event) {
    candidateFun(event.candidate)
    console.log("onicecandidate", event.candidate);
  }

  peerConnection.onaddstream = function (event) {
    try {
      document.getElementById("video").srcObject = event.stream;
    } catch (error) {
      document.getElementById("video").src = window.URL.createObjectURL(event.stream);
    }
  }
}

```

