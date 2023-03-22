## postgres设置自增
```sql
create sequence sys_user_user_id_seq start with 1 increment by 1 no minvalue no maxvalue cache 1;

alter table sys_user alter column user_id set default nextval('sys_user_user_id_seq')
```

