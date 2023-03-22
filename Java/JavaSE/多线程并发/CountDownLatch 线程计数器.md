## CountDownLatch 线程计数器

#### 1.概念

>允许一个或多个线程等待直到在其他线程中执行的一组操作完成的同步辅助.
`CountDownLatch`构造器传入一个`int`参数`await()`方法可以阻塞当前线程
`countDown()`可以减少计数,当构造器传入的`int`值被减成0时,`await()`方法就放行

#### 2. Lock常用方法

返回值 | 方法名称 | 说明
---|---|---
void | await() | 导致当前线程等到锁存器计数到零
boolean | await(long timeout, TimeUnit unit) | 导致当前线程等到锁存器计数到零,或者时间到 
void | countDown() | 减少锁存器的计数
long | getCount() | 返回当前计数

#### 3. 使用
```java
/**
 * @author liuguofeng
 * @version 1.0
 */
public class Demo04Test {
    @Test
    public void test1() throws InterruptedException {
        ExecutorService es = Executors.newCachedThreadPool();
        int count = 100;//线程数
        CountDownLatch countDownLatch = new CountDownLatch(count);

        for (int i = 0; i < count; i++) {
            int finalI = i;
            es.submit(() -> {
                System.out.println(finalI);
                countDownLatch.countDown();//减少当前计数器
            });
        }
        countDownLatch.await();//阻塞main线程,如果没有清空计数器则一直阻塞
        es.shutdown();//关闭线程池
    }

}
```