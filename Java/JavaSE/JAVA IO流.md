## JAVA IO流

## dows1. File类

```csharp
File file = new File("C:\\Desktop\\新建文本文档.txt");//File的实例
常用方法：
file.getName();  //获取文件名
file.getPath();  //获取文件路径
file.getAbsoluteFile();  //获取文件的绝对路径，getAbsoluteFile返回File类对象
file.getAbsolutePath();  //获取文件的绝对路径，getAbsolutePath返回代表路径的字符串
file.getParent();  //获取所在的文件夹的名字
file.exists();  //判断文件是否存在
file.isFile();  //判断是否是一个文件
file.isDirectory();  //判断是否是一个文件夹
new Date( file.lastModified());//最后修改时间(创建一个Date类对象输出)
file.length();  //文件的大小(字节)
file.createNewFile();//创建新文件
file.mkdirs();//新建多个文件夹
file.mkdir();//新建一个文件夹
```

## 2.FileInputStream和FileOutputStream

```csharp
public static void IOStream() {
    InputStream in = null;
    OutputStream out = null;
    try {
        in = new FileInputStream(new File("C:\\Users\\13961\\Desktop\\新建文本文档.txt"));
        out = new FileOutputStream(new File("1.txt"));
        byte[] bytes = new byte[1024];
        int length = 0;
        while ((length = in.read(bytes)) != -1) {
            out.write(bytes, 0, length);
        }
    } catch (IOException e) {
        e.getMessage();
    } finally {
        try {
            if (in == null) {
                in.close();
            }
        } catch (IOException e) {
            e.getMessage();
        }
        try {
            if (out == null) {
                out.close();
            }
        } catch (IOException e){
            e.getMessage();
        }
    }
}
```

## 3.FileReader和FileWriter

```csharp
public static void RwStream(){
    Reader reader = null;
    Writer writer = null;
    try{
        reader = new FileReader(new File("C:\\Users\\13961\\Desktop\\新建文本文档.txt"));
        writer = new FileWriter(new File("2.txt"));
        char[] chars = new char[1024];
        int length = 0;
        while ((length = reader.read(chars)) != -1){
            System.out.println(new String(chars,0,length));
            writer.write(chars,0,length);
        }
    }catch (IOException e){
        e.getMessage();
    }finally {
        try {
            if(reader != null){
                reader.close();
            }
        }catch (IOException e){
            e.getMessage();
        }
        try {
            if(writer != null){
                writer.close();
            }
        }catch (IOException e){
            e.getMessage();
        }
    }
}
```

## 4.BufferedInputStream和BufferedOutputStream

```csharp
public static void BufferedIOStream() {
    BufferedInputStream in = null;
    BufferedOutputStream out = null;
    try {
        in = new BufferedInputStream(new FileInputStream("C:\\Users\\13961\\Desktop\\新建文本文档.txt"));
        out = new BufferedOutputStream(new FileOutputStream("3.txt"));
        byte[] bytes = new byte[1024];
        int length = 0;
        while ((length = in.read(bytes)) != -1) {
            System.out.println(new String(bytes, 0, length));
            out.write(bytes, 0, length);
        }
    } catch (IOException e) {
        e.getMessage();
    } finally {
        try {
            if (in != null) {
                in.close();
            }
        } catch (IOException e) {
            e.getMessage();
        }
        try {
            if (out != null) {
                out.close();
            }
        } catch (IOException e) {
            e.getMessage();
        }
    }
}
```

## 5.BufferedReaderStream和BufferedWriterStram

```csharp
public static void BufferedRWStream() {
    BufferedReader in = null;
    BufferedWriter out = null;
    try {
        in = new BufferedReader(new FileReader("C:\\Users\\13961\\Desktop\\新建文本文档.txt"));
        out = new BufferedWriter(new FileWriter("4.txt"));
        char[] chars = new char[1024];
        String length = null;
        int i = 0;
        while ((length = in.readLine()) != null) {
            if (i != 0) {
                out.newLine();
            }
            i++;
            System.out.println(length);
            out.write(length);
        }
    } catch (IOException e) {
        e.getMessage();
    } finally {
        try {
            if (in != null) {
                in.close();
            }
        } catch (IOException e) {
            e.getMessage();
        }
        try {
            if (out != null) {
                out.close();
            }
        } catch (IOException e) {
            e.getMessage();
        }
    }
}
```

