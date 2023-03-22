## 布局

## 1.LinearLayout(线性布局)

```java
<LinearLayout
              android:orientation="horizontal" 
              android:layout_height="wrap_content" 
              android:layout_width="wrap_content"
              android:gravity="center"
              android:layout_weight="1"
              >
    
</LinearLayout>
```

- android:orientation="horizontal"  排序方向：horizontal横向排序 ，vertical纵向排序
- match_parent 跟随父元素的大小
- wrap_content 跟随子元素内容变化
- android:gravity="center" 在容器里的位置 如: left,right,center,top,bottom等
- android:layout_weight="1" 权重分配容器大小

## 2.RelativeLayout(相对定位) 相对于父元素或者同级元素定位

- **android: layout_alignParentLeft：**靠左边显示。
- **android: layout_alignParentTop：**靠顶部显示。
- **android: layout_alignParentRight：**靠右边显示。
- **android: layout_alignParentBottom：**靠底部显示。
- **android: layout_centerInParent：**居中显示。
- **android: layout_centerHorizontal：**水平居中显示。
- **android: layout_centerVertical：**垂直居中显示。
- **android: layout_alignWithParentIfMissing：**如果对应的兄弟元素找不到的话就以父元素做参照物。
- **android: layout_alignParentStart：**和layout_alignParentLeft的功能类似，Android 4.1引入的，是为了更好支持right-to-left布局方式（适配从右到左的语言，比如阿拉伯语）。
- **android: layout_alignParentEnd：**和layout_alignParentRight的功能类似，Android 4.1引入的，是为了更好支持right-to-left布局方式（适配从右到左的语言，比如阿拉伯语）。

##### 相对其他控件位置属性

这里属性类型全部都是其他兄弟控件的ID

- **android: layout_toLeftOf：**在另外一个 View 的左边
- **android: layout_toRightOf：**在另外一个 View 的右边
- **android: layout_above：**在另外一个 View 的上方
- **android: layout_below：**在另外一个 View 的下方
- **android: layout_toStartOf：**和 layout_toLeftOf 用法类似，支持right-to-left布局
- **android: layout_toEndOf：**和 layout_toRightOf 用法类似，支持right-to-left布局

##### 相对其他控件对齐方式

这里属性类型全部都是其他兄弟控件的ID

- **android: layout_alignBaseline：**该 View 的 baseline 和另外一个 View 的 baseline 对齐。
- **android: layout_alignLeft：**将该 View 的左边边缘与另外一个 View 的左边边缘
- **android: layout_alignTop：**将该 View 的顶部边缘与另外一个 View 的顶部边缘
- **android: layout_alignRight：**将该 View 的右边边缘与另外一个 View 的右边边缘
- **android: layout_alignBottom：**将该 View 的底部边缘与另外一个 View 的底部边缘
- **android: layout_alignStart：**和 layout_alignLeft 类似，支持right-to-left布局
- **android: layout_alignEnd：**和 layout_alignRight 类似，支持right-to-left布局

## 3.TextView（文字）

```java
<TextView
        android:layout_width="100dp"
        android:layout_height="100dp"
        android:text="viewTextActivity"
        android:textColor="#006633"
        android:textSize="18sp"
        android:maxLines="1"
        android:ellipsize="end"
        android:singleLine="true"/>
```



- android:text 文字内容

- android:textColor 文字

- android:textSize 文字大小

- android:maxLines 限制行数

- android:ellipsize 显示"....."

- android:singleLine 新版本sdk 为true android:ellipsize才生效

一般容器宽度、长度使用 dp ,字体大小使用sp

## 4.EditText（输入框）

```java
<EditText
        android:id="@+id/password"
        android:layout_width="match_parent"
        android:layout_height="50dp"
        android:layout_margin="15dp"
        android:inputType="textPassword"
        android:textColor="#339966"
        android:hint="密码"
        android:background="@drawable/input_style"
        android:paddingLeft="15dp"/>
```

- android:inputType 类型 textPassword、number 等

- android:textColor 文字颜色

-  android:hint 提示信息

## 5.RadioGroup(单选框)

```java
<RadioGroup
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:orientation="horizontal">
    <RadioButton
            android:id="@+id/but_radio1"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:checked="true"
            android:button="@null"
            android:textColor="#006633"
            android:text="男"/>
    <RadioButton
            android:id="@+id/but_radio2"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:button="@null"
            android:textColor="#006633"
            android:text="女"/>
</RadioGroup>
```

- android:orientation="horizontal"  排序方向：horizontal横向排序 ，vertical纵向排序

-  android:checked="true" 默认是否选中

- android:textColor 文字颜色

- android:text="女" 文字

- android:button="@null" 自定义样式用

## 6.imageButon（图片容器）

```java
<ImageButton
        android:layout_width="match_parent"
        android:layout_height="200dp"
        android:layout_margin="20dp"
        android:src="@drawable/image1"
        android:scaleType="fitXY"/>
```

- android:src 图片路径

- android:scaleType 图片在容器的比例 fitXY：xy轴拉伸、fitCenter：完全按原来比例展示、centerCrop：占满屏幕，保持图片比例，多余裁剪掉



## 7.ScrollView 和 HorizontalScrollView （滚动条）

```java
<ScrollView
        xmlns:android="http://schemas.android.com/apk/res/android"
        android:layout_width="match_parent"
        android:layout_height="match_parent"></ScrollView>
<HorizontalScrollView
        android:layout_width="match_parent"
        android:layout_height="match_parent"></HorizontalScrollView>
```

- ScrollView 滚动条标签内只能包含一个控件

- HorizontalScrollView 纵向滚动条

## 8.GridView (网格布局)

```java
<GridView
        android:id="@+id/listview"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:numColumns="3"
        android:verticalSpacing="10dp"
        android:horizontalSpacing="10dp">
</GridView>
```

- android:numColumns 列数

- android:verticalSpacing 垂直间距

- android:horizontalSpacing 水平间距

## 9.ListView （列表）

```java
<ListView
        android:id="@+id/listview"
        android:layout_width="match_parent"
        android:layout_height="wrap_content">
</ListView>
```

## 10.WebView (网页)

```java
<WebView
        android:id="@+id/web_view"
        android:layout_width="match_parent"
        android:layout_height="match_parent">
</WebView>

WebView webView = findViewById(R.id.web_view);
webView.setWebViewClient(new WebViewClient() {//解决在高版本访问网络会跳到外部浏览器问题
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        view.loadUrl(url);
        return true;
    }
});
webView.getSettings().setJavaScriptEnabled(true);//允许加载js
//webView.loadUrl("http://www.baidu.com");//加载网络
webView.loadUrl("file:///android_asset/index.html");//加载本地
```

- android:usesCleartextTraffic="true"  在AndroidManifest.xml 全局配置文件上的 application节点上添加 ，解决访问网络页面失败问题

## 11. Toast (弹出框)

```java
//普通弹框
Toast.makeText(ToastActivity.this, "这是默认效果的Toast",  Toast.LENGTH_LONG).show();

//自定义位置
Toast toast = Toast.makeText(ToastActivity.this, "这是自定义位置的Toast", Toast.LENGTH_LONG);
//设置Toast在屏幕上显示的位置
toast.setGravity(Gravity.CENTER, 20,80);
toast.show();


```

