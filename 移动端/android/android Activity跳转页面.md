## android Activity跳转页面

#### 1.跳转页面

1. 跳转代码

   ```java
   //方法1
   Button but = findViewById(R.id.but01);
   but.setOnClickListener((view) -> {
       Intent intent = new Intent();
       				//当前页面this      要跳转页面的class
       intent.setClass(MainActivity.this,TabledActivity.class);
       startActivity(intent);
   });
   
   //方法2
   Button but = findViewById(R.id.but01);
   but.setOnClickListener((view) -> {
       Intent intent = ;
       						//当前页面this      要跳转页面的class
       startActivity(new Intent(MainActivity.this,TabledActivity.class));
   });
   ```

2. 返回页面使用`finish()`

   ```java
   finish()
   ```

#### 2.父子Activity传值

##### 1.父传子

1. 父页面代码

   ```java
   Button but = findViewById(R.id.but01);
   but.setOnClickListener((view) -> {
       Intent intent = new Intent(MainActivity.this, MainActivity2.class);
   
       Bundle bundle = new Bundle();
   
       String dateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
       bundle.putString("dateTime", dateTime);
   
       intent.putExtras(bundle);
       startActivity(intent);
   });
   ```

2. 子页面

   ```java
   Bundle extras = getIntent().getExtras();
   String dateTime = extras.getString("dateTime");
   System.out.println(dateTime);
   ```

##### 2.子传父

1. 父页面代码

   ```java
    //跳转子页面按钮
   Button but = findViewById(R.id.but01);
   // 子页面返回时触发(要注意不要放在onclick内)
   ActivityResultLauncher<Intent> launcher = registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), (res) -> {
       Intent data = res.getData();
       Bundle extras = data.getExtras();
       String msg = extras.getString("msg");
       ((TextView)findViewById(R.id.tv_msg)).setText(msg);
   });
   //点击跳转子页面时
   but.setOnClickListener((view) -> {
       Intent intent = new Intent(MainActivity.this, MainActivity2.class);
       //页面数据
       Bundle bundle = new Bundle();
       bundle.putString("msg", "我是父页面,你好!");
       intent.putExtras(bundle);
       //把Intent添加
       launcher.launch(intent);
   
   });
   ```

2. 子页面代码

   ```java
   //返回按钮
   Button but = findViewById(R.id.back);
   //返回按钮点击时
   but.setOnClickListener((view) -> {
       //设置值
       Intent intent = new Intent();
       Bundle bundle = new Bundle();
       bundle.putString("msg","我是子页面,你好!");
       intent.putExtras(bundle);
       //返回值
       setResult(Activity.RESULT_OK,intent);
       //退回上一个页面
       finish();
   });
   
   //父页面传过来的数据
   Bundle extras = getIntent().getExtras();
   String msg = extras.getString("msg");
   TextView tvShow = findViewById(R.id.tv_show);
   tvShow.setText(msg);
   ```

   

