## js WebSocket 使用

```javascript
if (!"WebSocket" in window) {
    alert("您的浏览器不支持 WebSocket!");
}
// 打开一个 web socket
var ws = new WebSocket("ws://localhost:9090/webSocket/liuguofeng");

ws.onopen = function () {
    // Web Socket 已连接上，使用 send() 方法发送数据
    ws.send("发送数据");
    alert("数据发送中...");
};

ws.onmessage = function (evt) {
    var msg = evt.data;
    console.log(msg);
};

ws.onclose = function () {
    // 关闭 websocket
    alert("连接已关闭...");
};
```

