## Semaphore 信号灯,只能有一组线程通过

#### 1.概念

>`Semaphore`通过使用计数器来控制对共享资源的访问。 如果计数器大于0，则允许访问。 如果为0，则拒绝访问。 计数器所计数的是允许访问共享资源的许可。 因此，要访问资源，必须从信号量中授予线程许可。


#### 2. Lock常用方法

返回值 | 方法名称 | 说明
---|---|---
void | acquire() | 从信号量获取一个许可，如果无可用许可前将一直阻塞等待
void | release() | 减少锁存器的计数,释放一个许可
int | availablePermits() | 获取当前信号量可用的许可

#### 3. 使用
```java
/**
 * @author liuguofeng
 * @version 1.0
 */
public class Demo04Test {
    @Test
    public void test1()  {
        ExecutorService es = Executors.newCachedThreadPool();

        Semaphore semaphore = new Semaphore(9);
        for (int i = 0; i < 100; i++) {
            es.submit(() -> {
                try {
                    semaphore.acquire();
                    System.out.println("当前线程" + Thread.currentThread().getName());
                    Thread.sleep(2);
                    System.out.println("当前线程" + Thread.currentThread().getName()+"结束");
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                } finally {
                    semaphore.release();
                }
            });
        }
    }

}
```