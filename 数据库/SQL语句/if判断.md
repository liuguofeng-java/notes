## if判断

```sql
#判断 permission 是否等于 null ,如果是null则返回'为null'
select ifnull(permission,'为null') from sys_menu
```



```sql
#如果sex=1返回男，否则返回女
select if(sex=1,'男','女') from users
```



```sql
#判断星座
select  case 
when constellation = 1 then '处女座'
when constellation = 2 then '狮子座'
when constellation = 3 then '白羊座'
when constellation = 4 then '双子座'
else '未知' end '星座'
from users
```

