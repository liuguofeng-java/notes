## Lock锁

#### 1.Lock和syncronized的区别

1. `synchronized`不需要用户去手动释放锁,发生异常或者线程结束时自动释放锁;`Lock`则必须要用户去手动释放锁,如果没有主动释放锁，就有可能导致出现死锁现象
2. `Lock`可以配置公平策略,实现线程按照先后顺序获取锁
3. 提供了`try catch finally` 使用 `lock()`和`unlock()`方法添加锁和解锁,可以试图获取锁,获取到或获取不到时,返回不同的返回值 让程序可以灵活处理

#### 2. Lock常用方法

返回值 | 方法名称 | 说明
---|---|---
void | lock() | 获得锁
void | unlock() | 释放锁
Condition | newCondition()| 返回一个新Condition绑定到该实例Lock实例
boolean | tryLock() | 尝试获取锁,失败返回false
boolean | tryLock(long time, TimeUnit unit) | 在一定时间内等待直到获取锁否则返回false

#### 3.使用
```java
   Lock l = ...; 
   l.lock(); 
   try { 
        // 业务 
   } finally { 
        l.unlock(); 
   } 
```

#### 4.使用Condition精准唤醒线程

> `Condition` 的方法`await()`和`signal()` `signalAll()`;就类似 object 中的`wait()` `notify()` `notifyAll()`

```java
/**
 * @author liuguofeng
 * @version 1.0
 */
public class Demo05Text {
    public static void main(String[] args)  {
        ThreadLock threadLock = new ThreadLock();
        for (int i = 0; i < 100; i++) {
            new Thread(() -> {
                try {
                    threadLock.print1();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            },"A").start();
        }
        for (int i = 0; i < 100; i++) {
            new Thread(() -> {
                try {
                    threadLock.print2();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            },"B").start();
        }
        for (int i = 0; i < 100; i++) {
            new Thread(() -> {
                try {
                    threadLock.print3();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
            },"C").start();
        }
    }
}

class ThreadLock{
    private final Lock lock = new ReentrantLock();
    private final Condition condition1 = lock.newCondition();
    private final Condition condition2 = lock.newCondition();
    private final Condition condition3 = lock.newCondition();
    int number = 1;
    public void print1() throws InterruptedException {
        lock.lock();
        try {
            while (number != 1){
                condition1.await();
            }
            System.out.println("线程"+Thread.currentThread().getName()+"执行"+number);
            condition2.signal();
        } finally {
            number = 2;
            lock.unlock();
        }
    }
    public void print2() throws InterruptedException {
        lock.lock();
        try {
            while (number != 2){
                condition2.await();
            }
            System.out.println("线程"+Thread.currentThread().getName()+"执行"+number);
            condition3.signal();
        } finally {
            number = 3;
            lock.unlock();
        }
    }
    public void print3() throws InterruptedException {
        lock.lock();
        try {
            while (number != 3){
                condition3.await();
            }
            System.out.println("线程"+Thread.currentThread().getName()+"执行"+number);
            System.out.println("-------------------------------");
            condition1.signal();
        } finally {
            number = 1;
            lock.unlock();
        }
    }
}
```


>结果
```txt
线程A执行1
线程B执行2
线程C执行3
-------------------------------
线程A执行1
线程B执行2
线程C执行3
-------------------------------
线程A执行1
线程B执行2
线程C执行3
-------------------------------
线程A执行1
线程B执行2
线程C执行3
-------------------------------
线程A执行1
线程B执行2
线程C执行3
-------------------------------
线程A执行1
线程B执行2
线程C执行3
-------------------------------
```
