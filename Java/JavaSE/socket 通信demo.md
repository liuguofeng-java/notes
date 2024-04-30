## socket 通信demo

#### 1.客户端

```java
@Test
public void clientDemo() {
    Socket socket = null;
    OutputStream os = null;
    try {
        socket = new Socket("localhost", 8087);
        os = socket.getOutputStream();
        os.write("这是客户端！".getBytes());
    } catch (IOException e) {
        e.printStackTrace();
    } finally {
        try {
            if (socket != null)
                socket.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        try {
            if (os != null)
                os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
```



#### 2.服务器端

```java
@Test
public void serverDemo() throws IOException {
    ServerSocket serverSocket = null;
    Socket accept = null;
    InputStreamReader isr = null;
    try {
        serverSocket = new ServerSocket(8087);
        accept = serverSocket.accept();
        isr = new InputStreamReader(accept.getInputStream());
        char[] chars = new char[1024];
        int len;
        while ((len = isr.read(chars)) != -1){
            System.out.print(new String(chars,0,len));
        }
    } catch (IOException e) {
        e.printStackTrace();
    } finally {
        accept.close();
        serverSocket.close();
        isr.close();
    }
}
```

