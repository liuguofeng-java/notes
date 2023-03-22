## android 设置图片大小
```java
Drawable userNameDrawable = getResources().getDrawable(R.drawable.filtrate);//drawable下的资源
userNameDrawable.setBounds(0,0,40,40);//设置大小
userNameEditText.setCompoundDrawables(userNameDrawable,null,null,null);//设置位置
```

