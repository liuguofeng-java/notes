## sql时间加减
```sql
//时间转成年月日时分秒
select date_format(now(),'%Y%m%d%H%i%S')
//时间转成年月日
select date_format(now(),'%Y%m%d')
//去年此时
select DATE_ADD(now(), Interval -1 year)
//上月此时
select DATE_ADD(now(), Interval -1 month)
//昨天此时
select DATE_ADD(now(), Interval -1 day)
//7天后
select DATE_ADD(now(), Interval 7 day)
//一小时前
select DATE_ADD(now(), Interval -1 hour)
//一分钟前
select DATE_ADD(now(), Interval -1 minute)
//一秒钟前
select DATE_ADD(now(), Interval -1 second)
//昨天（年月日）
select date_format(DATE_ADD(now(), Interval 1 day),'%Y%m%d')
```

```sql
//上个月第一天和最后一天
select date_sub(date_sub(date_format(now(),'%Y%m%d'),interval extract( day from now())-1 day),interval 1 month);
select date_sub(date_sub(date_format(now(),'%Y%m%d'),interval extract(day from now()) day),interval 0 month);
  
//某个字符串
select date_format(DATE_ADD('20090605123020', Interval 20 minute),'%Y%m%d')
//第几周
select weekofyear( now() )
select weekofyear('20090606')

在mysql中，会把'20090707123050'和'20090707'格式的字符串作为date类型转换。

在mysql中，没有类似oracle的to_char(num,format)函数，所以涉及到数字前面补0的情况需要特殊处理。

如select left(concat('00'),@num),3)就会显示三位数字的字符串， @num=1时显示001，为123是显示123。

CONCAT(YEAR(a.createtime),LEFT(CONCAT('0',WEEKOFYEAR(a.createtime)),2))
```

