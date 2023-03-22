## IO流

#### 1.File类

1. 操作文件或目录的一个类

2. 常用方法：

   `exists()`						        文件或目录是否存在，返回boolean

   `delete()`						        删除文件或目录，返回boolean

   `createNewFile()`				 若文件不存在就创建

   `getName()`					         返回string的文件名或路径名

   `isFile()`						       是否是文件

   `isDirectory()`					 是否是目录

#### 2.输入流和输出流

1. 分类

   | 抽象类     | 文件流           | 缓冲流              | 转换流             |
   | ---------- | ---------------- | ------------------- | ------------------ |
   | 字节输入流 | FileInputStream  | BufferdInputStream  |                    |
   | 字节输出流 | FileOutputStream | BufferdOutputStream |                    |
   | 字符输入流 | FileReader       | BufferdReader       | InputStreamReader  |
   | 字符输出流 | FileWriter       | BufferWriter        | OutputStreamWriter |

   > 文本时我们要用到字符流。比如，查看文本的中文时就是需要采用字符流更为方便。所以Java IO流中提供了两种用于将字节流转换为字符流的转换流, 如:InputStreamReader和OutputStreamWriter					



2. 常用方法

   - InputStream

     `available()`				                                返回从该输入流中可以读取（或跳过）的字节数的估计值

     `close()`					                                    释放流资源

     `read(byte[])`				                              从该流读入一些字节，如果没有数据则返回-1

   

   - OutputStream

     `close()`					                                  释放流资源

     `writer(byte[],int  off,int len)`	从指定的字节数组写入 len个字节，从偏移 off开始输出到此输出流



#### 3.实例

```java
InputStream is = null;
OutputStream os = null;
try {
    is = new FileInputStream("C:\\Users\\liuguofeng\\Desktop\\android-sdk.rar");
    os = new FileOutputStream("C:\\Users\\liuguofeng\\Desktop\\android-sdk2.rar");
    byte[] bytes = new byte[1024];
    int len;
    while ((len = is.read(bytes)) != -1){
        os.write(bytes,0,len);
    }
} catch (IOException e) {
    e.printStackTrace();
} finally {
    if(is != null)
        is.close();
    if(os != null)
        os.close();
}
```

