## Proxy代理实例

```java
public class InvocationHandlerImpl implements InvocationHandler {

    private final Object subject;
    public InvocationHandlerImpl(Object subject){
        this.subject = subject;
    }

    @Override
    public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
        System.out.println("执行前");
        Object invoke = method.invoke(subject, args);
        System.out.println("执行后");
        return invoke;
    }
}

interface ProxyDome{
    String test();
}

class ProxyDomeImpl implements ProxyDome{
    @Override
    public String test() {
        System.out.println("这是test方法");
        return "这是返回值";
    }
}

class Main{
    public static void main(String[] args){
        ProxyDome poxyDome = new ProxyDomeImpl();
        InvocationHandler invocationHandler = new InvocationHandlerImpl(poxyDome);
        ClassLoader loader = poxyDome.getClass().getClassLoader();
        Class[] interfaces = poxyDome.getClass().getInterfaces();
        ProxyDome dome = (ProxyDome)Proxy.newProxyInstance(loader,interfaces,invocationHandler);
        String test = dome.test();
        System.out.println(test);
    }
}
```

