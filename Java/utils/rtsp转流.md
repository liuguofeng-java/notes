## rtsp转流

1. 可以使用socket + ffmpeg（不推荐）

   ```xml
          <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-starter-test</artifactId>
               <scope>test</scope>
           </dependency>
   
           <dependency>
               <groupId>org.bytedeco</groupId>
               <artifactId>javacv-platform</artifactId>
               <version>1.5.7</version>
           </dependency>
   
           <dependency>
               <groupId>org.bytedeco</groupId>
               <artifactId>javacv</artifactId>
               <version>1.4.1</version>
           </dependency>
           <dependency>
               <groupId>org.bytedeco</groupId>
               <artifactId>javacpp</artifactId>
               <version>1.4.1</version>
           </dependency>
           <dependency>
               <groupId>org.bytedeco.javacpp-presets</groupId>
               <artifactId>opencv-platform</artifactId>
               <version>3.4.1-1.4.1</version>
           </dependency>
   
           <!-- 阿里JSON解析器 -->
           <dependency>
               <groupId>com.alibaba.fastjson2</groupId>
               <artifactId>fastjson2</artifactId>
               <version>2.0.34</version>
           </dependency>
   ```

   ```java
       //存放用户session,并且是线程安全的
       private final static Map<String, SocketInfo> sessionPools = new ConcurrentHashMap<>();
       private final Java2DFrameConverter java2DFrameConverter = new Java2DFrameConverter();
   
       @OnOpen
       public void onOpen(Session session) {
           new Thread(() -> {
               FFmpegFrameGrabber grabber = null;
               try {
                   String url = "rtsp://localhost:8554/mystream";
                   grabber = new FFmpegFrameGrabber(url);
                   grabber.start();
                   Frame frame;
                   while ((frame = grabber.grabImage()) != null) {
                       BufferedImage convert = java2DFrameConverter.convert(frame);
                       ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                       ImageIO.write(convert, "jpg", byteArrayOutputStream);
                       byte[] imageBytes = byteArrayOutputStream.toByteArray();
                       session.getBasicRemote().sendBinary(ByteBuffer.wrap(imageBytes));
                       byteArrayOutputStream.close();
                   }
               } catch (IOException e) {
                   System.out.println(e.getMessage());
                   e.printStackTrace();
               } finally {
                   if (grabber != null) {
                       try {
                           grabber.close();
                       } catch (FrameGrabber.Exception e) {
                           System.out.println(e.getMessage());
                       }
                   }
               }
           }).start();
       }
   ```

