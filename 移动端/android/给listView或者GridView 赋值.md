## 给listView或者GridView 赋值

```java
@Override
protected void onCreate(@Nullable Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_list_view);

    String[] theme = {"张明", "李明", "李明"};
    String[] content = {"600 602 501", "666 620 502", "666 620 503"};

    //需要把图片和文字(一个单元中的东西)用Map对应起来，必须这样做，这是下面要用到的适配器的一个参数
    List<Map<String, Object>> lists = new ArrayList<>();
    for (int i = 0; i < theme.length; i++) {
        Map<String, Object> map = new HashMap<>();
        map.put("image", R.mipmap.ic_launcher);
        map.put("theme", theme[i]);
        map.put("content", content[i]);
        lists.add(map);
    }

    //适配器指定应用自己定义的xml格式
    SimpleAdapter adapter = new SimpleAdapter(this, lists,
            R.layout.activity_list_view_item,
            new String[]{"image", "theme", "content"},
            new int[]{R.id.image, R.id.title, R.id.phone});
    ListView listView = findViewById(R.id.listview);
    listView.setAdapter(adapter);
}
```



### activity_list_view.xml

```java
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent">

    <ListView
            android:id="@+id/listview"
            android:layout_width="match_parent"
            android:layout_height="wrap_content">
    </ListView>


</LinearLayout>
```

### activity_list_view_item.xml

```java
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:orientation="horizontal">
    <ImageButton
            android:id="@+id/image"
            android:layout_width="100dp"
            android:layout_height="100dp"
            android:layout_margin="20dp"
            android:src="@mipmap/ic_launcher_round"
            android:scaleType="centerCrop"/>
    <RelativeLayout
            android:layout_width="wrap_content"
            android:layout_height="wrap_content">
        <TextView
                android:id="@+id/title"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginLeft="10dp"
                android:layout_marginTop="25dp"
                android:textSize="20sp"
                android:text="张三"/>
        <TextView
                android:id="@+id/phone"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginLeft="10dp"
                android:layout_marginTop="30dp"
                android:textSize="15sp"
                android:text="13386459867"
                android:layout_below="@id/title"/>
    </RelativeLayout>
</LinearLayout>
```

