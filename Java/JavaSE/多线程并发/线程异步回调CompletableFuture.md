## 线程异步回调CompletableFuture

> CompletableFuture类似于前端的ajax,可以接收多线程中的返回值

##### 1.无返回值的

```java
CompletableFuture<Void> future = CompletableFuture.runAsync(() -> {
    System.out.println("CompletableFuture 方法执行了");
});
//执行或接收返回值
future.get();
```

##### 2.有返回值的信息

```java
CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
	//业务
    return "结果";
}).whenComplete((t, u) -> {
    //回调结果
    System.out.println("t-> " + t);
    //抛出异常信息
    System.out.println("u-->" + u);
}).exceptionally((e) -> {
    //错误信息
    e.printStackTrace();
    return "错误返回";
});
```

##### 3.执行多个无返回值

```java
ThreadPoolExecutor executor = new ThreadPoolExecutor(20, 20,
                0L, TimeUnit.MILLISECONDS,
                new LinkedBlockingQueue<>());
CompletableFuture<Void> future = CompletableFuture.allOf(
    CompletableFuture.runAsync(() -> {
        //业务一
        System.out.println("111");
    }, executor),
    CompletableFuture.runAsync(() -> {
        //业务二
        System.out.println("222");
    }, executor),
    CompletableFuture.runAsync(() -> {
        //业务三
        System.out.println("333");
    }, executor)
);
future.get();
```

