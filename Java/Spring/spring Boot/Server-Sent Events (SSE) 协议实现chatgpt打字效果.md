## Server-Sent Events (SSE) 协议实现chatgpt打字效果

SSE 是一种基于 HTTP 协议的单向通信机制，服务器可以在客户端建立连接后，持续不断地向客户端发送事件流。客户端使用 `EventSource` 对象来接收这些事件，并且事件流是文本格式的，易于处理和解析。

`SseEmitter` 是 Spring Framework 提供的一个工具类，用于实现 **Server-Sent Events (SSE)** 协议。SSE 允许服务器通过 HTTP 单向推送事件到客户端（如浏览器），适用于实时更新、通知等场景。以下是 `SseEmitter` 的详细使用步骤：

##### 1.添加依赖

确保项目中包含 Spring Web 依赖（如 Spring Boot）：

```xml
<!-- Maven -->
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-web</artifactId>
</dependency>
```

##### 2.创建 SSE 控制器

在 Spring 控制器中定义 SSE 端点，返回 `SseEmitter` 对象。

```java
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
public class SseController {

    @GetMapping("/sse")
    public SseEmitter handleSse() {
        // 创建 SseEmitter 实例，可设置超时时间（默认 30 秒）
        SseEmitter emitter = new SseEmitter(60_000L); // 60 秒超时

        // 异步处理（模拟业务逻辑）
        new Thread(() -> {
            try {
                for (int i = 0; i < 10; i++) {
                    // 发送数据（事件）
                    emitter.send(
                        SseEmitter.event()
                            .id(String.valueOf(i))      // 事件 ID（可选）
                            .name("my-event")           // 事件名称（可选）
                            .data("Message " + i)       // 事件数据
                            .reconnectTime(5000L)       // 重连时间（毫秒）
                    );
                    Thread.sleep(1000); // 模拟延迟
                }
                // 标记完成
                emitter.complete();
            } catch (Exception e) {
                emitter.completeWithError(e);
            }
        }).start();

        return emitter;
    }
}
```

##### 3. 客户端接收事件

在浏览器中使用 `EventSource` 监听 SSE 事件：

```js
const eventSource = new EventSource('/sse');

// 监听默认事件（未指定 name 的事件）
eventSource.onmessage = (event) => {
    console.log("Received message:", event.data);
};

// 监听自定义事件（如 name="my-event"）
eventSource.addEventListener('my-event', (event) => {
    console.log("Custom event:", event.data, "ID:", event.lastEventId);
});

// 错误处理
eventSource.onerror = (error) => {
    eventSource.close(); // 关闭连接
};
```

##### 4. 关键 API 方法

- **`send(Object data)`**: 发送事件数据（自动转换为文本）。
- **`complete()`**: 标记事件流完成，关闭连接。
- **`completeWithError(Throwable ex)`**: 因错误关闭连接。
- **`SseEmitter.event()`**: 创建事件构造器，设置事件属性。