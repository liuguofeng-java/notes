## Process获取pid中断进程cmd问题

```java
<!--线程-->
<dependency>
    <groupId>com.sun.jna</groupId>
    <artifactId>jna</artifactId>
    <version>3.0.9</version>
</dependency>
<dependency>
    <groupId>net.java.dev.jna</groupId>
    <artifactId>jna-platform</artifactId>
    <version>4.1.0</version>
</dependency>
```



```java
public void killProcessTree()
{
    try {
        Field f = process.getClass().getDeclaredField("handle");
        f.setAccessible(true);
        long handl =f.getLong(process);
        Kernel32 kernel = Kernel32.INSTANCE;
        WinNT.HANDLE handle = new WinNT.HANDLE();
        handle.setPointer(Pointer.createConstant(handl));
        int ret =kernel.GetProcessId(handle);
        Long PID = Long.valueOf(ret);
        System.out.println(PID);
        /*String cmd =getKillProcessTreeCmd(PID);
        Runtime rt =Runtime.getRuntime();
        Process killPrcess = rt.exec(cmd);
        killPrcess.waitFor();
        killPrcess.destroy();*/
    }catch(Exception e)
    {
        e.printStackTrace();
    }
}

private static String getKillProcessTreeCmd(Long Pid)
{
    String result = "";
    if(Pid !=null)
        result ="cmd.exe /c taskkill /PID "+Pid+" /F /T ";
    return result;
}
```

