## mysql 定时器

#### 一、查看MySQL版本号

```csharp
select version();
```

#### 二、查看event的状态

```csharp
show variables like '%sche%';
```

#### 三、开启event功能

```csharp
set global event_scheduler = 1;
```

#### 四、创建存储过程procedure：

```csharp
delimiter //
drop procedure if exists procedureName //
    create procedure procedureName()
begin
    操作语句
end //
delimiter;
```

#### 五、创建要调用procedure的event：

```csharp
drop event if exists eventName;
create event eventName
on schedule every 5 second
on completion preserve disable
do call procedureName();
 
注： 每5秒调用一此procedureName();
```

#### 六、查看自己创建的event

```csharp
select name from mysql.event;
```

注：name并非eventName，name只是一个字段。

#### 七、开启事件

```csharp
alter event eventName on completion preserve enable;
```

#### 八、关闭事件

```csharp
alter event eventName on completion preserve disable;
```

#### 九: 常见的定时时间函数



##### 1.周期执行–关键字 EVERY

单位有：second,minute,hour,day,week(周),quarter(季度),month,year

如：

```csharp
on schedule every 1 second //每秒执行1次
on schedule every 2 minute //每两分钟执行1次
on schedule every 3 day //每3天执行1次
```

##### 2.在具体某个时间执行–关键字 AT

如：

```csharp
on schedule at current_timestamp()+interval 5 day //5天后执行
on schedule at current_timestamp()+interval 10 minute //10分钟后执行
on schedule at '2016-10-01 21:50:00' //在2016年10月1日，晚上9点50执行
```

##### 3.在某个时间段执行–关键字STARTS ENDS

如：

```csharp
on schedule every 1 day starts current_timestamp()+interval 5 day ends current_timestamp()+interval 1 month //5天后开始每天都执行执行到下个月底
on schedule every 1 day ends current_timestamp()+interval 5 day //从现在起每天执行，执行5天
```



