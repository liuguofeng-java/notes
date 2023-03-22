## android 事件

- android 点击跳转页面

```java
Button but_1 = findViewById(R.id.but_1); // 找到xml 标签id
but_1.setOnClickListener(v -> {
    Intent intent = new Intent(MainActivity.this,ViewTextActivity.class);
    startActivity(intent);
});
```



- android 点击事件

```java
//第一种方法
<Butto android:onClick="onClick"/>
@SuppressLint("ShowToast")
public void onClick(View view){
    Toast.makeText(this,"点击了",Toast.LENGTH_SHORT).show();//弹出提示框
}

//第二种方法
Button but_1 = findViewById(R.id.but_1);
but_1.setOnClickListener(v -> {
    Toast.makeText(this,"点击了1",Toast.LENGTH_LONG).show();
});
```

