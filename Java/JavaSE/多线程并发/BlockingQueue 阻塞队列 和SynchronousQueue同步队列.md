## BlockingQueue 阻塞队列 和SynchronousQueue同步队列

#### 1.概念

> `队列`->有序排列元素FIFO（先进先出）.`阻塞`->如果当前空间满了使用`put()`则阻塞当前线程,如果空间一个数据都没有使用`take()`也阻塞当前线程

#### 2.成员
`ArrayBlockingQueue` 和 `LinkedBlockingQueue`


返回值 | 方法名称 | 说明
---|---|---
boolean | add(E e) | 将指定的元素插入到此队列中，如果可以立即执行此操作，而不会违反容量限制， true在成功后返回,失败则抛出异常(`异常`)
E | remove() | 检索并删除此队列的头。(`异常`)
E | element() | 检索，但不删除，这个队列的头(`异常`)
boolean | offer(E e) |如果在不违反容量限制的情况下立即执行，则将指定的元素插入到此队列中(`正常`)
E | peek() | 检索但不删除此队列的头，如果此队列为空，则返回 null(`正常`)
E | poll() | 检索并删除此队列的头，如果此队列为空，则返回 null(`正常`)
void | put(E e) | 在该队列的尾部插入指定的元素，如果需要，等待空格变为可用(`阻塞`)
E | take() | 检索并删除此队列的头，如有必要，等待元素可用(`阻塞`)


#### 3.SynchronousQueue 
>`SynchronousQueue`容量为一的一个队列,只有`put()`和`take()`,只能存一个取一个