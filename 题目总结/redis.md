## redis

### 1.redis缓存雪崩、击穿、穿透

- 雪崩: 大量key集体到期，导致大量请求被数据库处理 
  - **解决:在redis存数据是加上随机数**

- 击穿: 请求没有的数据redis返回null，导致一直请求数据库
  -  **解决: 1.在请求参数上加限制,2.没有查到的数据也在redis中存上并且加上短过期时间**

- 穿透: 第一次没有缓存,用户大量访问,导致大部分请求访问数据库 
  - **解决:加锁,第一个用户拿到数据并且让他再把数据存上redis上在释放锁**

### 2.redis 类型

- String： 缓存、计数器、分布式锁等（底层是简单动态字符串）。
- List： 链表、队列、微博关注人时间轴列表等。
- Hash： 用户信息、Hash 表等（数据结构是hashtable或者ziplist）。
- Set： 去重、赞、踩、共同好友等（数据结构是intset或hashtable）。
- Zset： 访问量排行榜、点击量排行榜等（数据结构是 ziplist或zkiplist）。

### 2.Redis都有哪些使用场景？