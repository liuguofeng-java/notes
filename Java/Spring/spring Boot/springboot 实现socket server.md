## springboot 实现socket server

#### 1.配置类,启用socket

```javascript
/**
 * @author liuguofeng
 * @version 1.0
 * @description: TODO
 * @date 2021/12/5 13:51
 */
@Configuration
public class WebSocketConfig {
    /**
     * 注册socket
     * @return
     */
    @Bean
    public ServerEndpointExporter serverEndpointExporter() {
        return new ServerEndpointExporter();
    }
}
```

#### 2.监听socket连接

```javascript
/**
 * @author liuguofeng
 * @version 1.0
 * @description: TODO
 * @date 2021/12/5 13:55
 */
@ServerEndpoint("/webSocket/{username}")
@Component
public class WebSocketServer {
    //存放用户session,并且是线程安全的
    private final static ConcurrentHashMap<String, Session> sessionPools = new ConcurrentHashMap<>();

    //建立连接成功调用
    @OnOpen
    public void onOpen(Session session, @PathParam(value = "username") String userName){
        List<String> data = new ArrayList<>(sessionPools.keySet());
        String jsonString = JSON.toJSONString(data);
        this.sendMessage(session,jsonString);
        //添加到在线用户中
        sessionPools.put(userName, session);

    }

    //关闭连接时调用
    @OnClose
    public void onClose(@PathParam(value = "username") String userName){
        sessionPools.remove(userName);
    }

    //收到客户端信息
    @OnMessage
    public void onMessage(@PathParam(value = "username") String userName,String message){
        System.out.println("server get" + message);


        sendUserInfo(userName, "服务端接收到你的消息:"+message);
    }

    //错误时调用
    @OnError
    public void onError(Session session, Throwable throwable){
        System.out.println("发生错误");
        throwable.printStackTrace();
    }

    //发送消息
    public synchronized void sendMessage(Session session, String message) {
        if(session == null) return;
        System.out.println("发送数据：" + message);
        try {
            session.getBasicRemote().sendText(message);
        }catch (Exception ex){
            ex.printStackTrace();
            System.out.println("发送信息出现异常!");
        }
    }

    //给指定用户发送信息
    public void sendUserInfo(String userName, String message){
        Session session = sessionPools.get(userName);
        try {
            sendMessage(session, message);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static ConcurrentHashMap<String, Session> getSessionPools() {
        return sessionPools;
    }
}
```

