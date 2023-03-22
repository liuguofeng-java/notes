

## mysql统计多张表中的总数

#### 答案1：

```sql
select sum(a) from (select count(*) a from tb1 union select count(*) a from tb2 union select count(*) a from tb3) as tb;
```

#### 答案2：

```sql
select count(*) a from tb1 union select count(*) b from tb2 union select count(*) c from tb3;
```

#### 答案3：

```sql
select a.countNum,b.countNum,c.countNum
from( 
 (select COUNT(*) as countNum from tb1) a,
 (select COUNT(*) as countNum from tb2) b,
 (select COUNT(*) as countNum from tb3) c
)
```

