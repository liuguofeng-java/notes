## SpringBoot内置的定时

- 添加依赖

```csharp
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter</artifactId>
</dependency>
```

- 启动类上添加注解

```csharp
@SpringBootApplication
@EnableScheduling
public class SpringbootQuartzApplication {
}
```



- 方式一:

```csharp
@Component
public class SchedulerTask {
    
    private int count = 0;
    
    /**
     * @Author Smith
     * @Description 设置没6秒执行一次
     * @Date 14:23 2019/1/24
     * @Param 
     * @return void
     **/
    @Scheduled(cron = "*/6 * * * * ?")
    private void process(){
        System.out.println("this is scheduler task running " + (count++));
    }
    
}
```

- 方式二:

```csharp
@Component
public class SchedulerTask2 {
    
    private static final SimpleDateFormat dateFormat =
            new SimpleDateFormat("HH:mm:ss");
    
    /**
     * @Author Smith
     * @Description 设置没6秒执行一次
     * @Date 14:22 2019/1/24
     * @Param 
     * @return void
     **/
    @Scheduled(fixedRate = 6000)
    private void process(){
        System.out.println("now time is " + dateFormat.format(new Date()));
    }
    
}

```

参数说明

@Scheduled 参数可以接受两种定时的设置，一种是我们常用的 cron="*/6 * * * * ?"，一种是 fixedRate = 6000，两种都可表示固定周期执行定时任务。

fixedRate说明

- @Scheduled(fixedRate = 6000)：上一次开始执行时间点之后 6 秒再执行。

- @Scheduled(fixedDelay = 6000)：上一次执行完毕时间点之后 6 秒再执行。

- @Scheduled(initialDelay=1000, fixedRate=6000)：第一次延迟 1 秒后执行，之后按 fixedRate 的规则每 6 秒执行一次。

cron说明

cron一定有七位数,最后一位是年,SpringBoot定时方案只需要设置六位即可:

- 第一位, 表示秒, 取值是0 ~ 59

- 第二位, 表示分. 取值是0 ~ 59

- 第三位, 表示小时, 取值是0 ~ 23

- 第四位, 表示天/日, 取值是0 ~ 31

- 第五位, 表示月份, 取值是1 ~ 12

- 第六位, 表示星期, 取值是1 ~ 7, 星期一，星期二...， 还有 1 表示星期日

- 第七位, 年份, 可以留空, 取值是1970 ~ 2099

cron中,还有一些特殊的符号,含义如下:

- (*) 星号，可以理解为每的意思，每秒、每分、每天、每月、每年...。

- (?)问号，问号只能出现在日期和星期这两个位置，表示这个位置的值不确定，每天 3 点执行，因此第六位星期的位置，是不需要关注的，就是不确定的值；同时，日期和星期是两个相互排斥的元素，通过问号来表明不指定值，比如 1 月 10 日是星期一，如果在星期的位置另指定星期二，就前后冲突矛盾了。

- （-）减号，表达一个范围，如在小时字段中使用“10 - 12”，则表示从 10 到 12 点，即 10、11、12。

- （,）逗号，表达一个列表值，如在星期字段中使用“1,2,4”，则表示星期一、星期二、星期四。

- （/）斜杠，如 x/y，x 是开始值，y 是步长，比如在第一位（秒），0/15 就是从 0 秒开始，每隔 15 秒执行一次，最后就是 0、15、30、45、60，另 */y，等同于 0/y。

举几个例子熟悉一下:

- 0 0 3 * * ? ：每天 3 点执行；

- 0 5 3 * * ?：每天 3 点 5 分执行；

- 0 5 3 ? * *：每天 3 点 5 分执行，与上面作用相同；

- 0 5/10 3 * * ?：每天 3 点的 5 分、15 分、25 分、35 分、45 分、55分这几个时间点执行；

- 0 10 3 ? * 1：每周星期天，3 点 10 分执行，注，1 表示星期天；

- 0 10 3 ? * 1#3：每个月的第三个星期，星期天执行，# 号只能出现在星期的位置。

基本上SpringBoot自带的定时就是这么简单了.