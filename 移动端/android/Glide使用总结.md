## Glide使用总结

首先，添加依赖

```java
implementation 'com.github.bumptech.glide:glide:4.5.0'
annotationProcessor 'com.github.bumptech.glide:compiler:4.5.0'
```

之后添加访问网络权限

```java
<uses-permission android:name="android.permission.INTERNET" />
```

一、常用的方法

```java
1、加载图片到imageView
Glide.with(Context context).load(Strint url).into(ImageView imageView);
2、各种形式的图片加载到ImageView
// 加载本地图片
File file = new File(getExternalCacheDir() + "/image.jpg");
Glide.with(this).load(file).into(imageView);

// 加载应用资源
int resource = R.drawable.image;
Glide.with(this).load(resource).into(imageView);

// 加载二进制流
byte[] image = getImageBytes();
Glide.with(this).load(image).into(imageView);

// 加载Uri对象
Uri imageUri = getImageUri();
Glide.with(this).load(imageUri).into(imageView);
3、加载带有占位图
Glide.with(this).load(url).placeholder(R.drawable.loading).into(imageView);
占位图目的为在目的图片还未加载出来的时候，提前展示给用户的一张图片；
4、加载失败 放置占位符
Glide.with(this).load(url).placeholder(R.drawable.loading).error(R.drawable.error)
     .diskCacheStrategy(DiskCacheStrategy.NONE)//关闭Glide的硬盘缓存机制
     .into(imageView);


//DiskCacheStrategy.NONE： 表示不缓存任何内容。
//DiskCacheStrategy.SOURCE： 表示只缓存原始图片。
//DiskCacheStrategy.RESULT： 表示只缓存转换过后的图片（默认选项）。
//DiskCacheStrategy.ALL ： 表示既缓存原始图片，也缓存转换过后的图片。
5、加载指定格式的图片--指定为静止图片
Glide.with(this)
     .load(url)
     .asBitmap()//只加载静态图片，如果是git图片则只加载第一帧。
     .placeholder(R.drawable.loading)
     .error(R.drawable.error)
     .diskCacheStrategy(DiskCacheStrategy.NONE)
     .into(imageView);
6、加载动态图片
Glide.with(this)
     .load(url)
     .asGif()//加载动态图片，若现有图片为非gif图片，则直接加载错误占位图。
     .placeholder(R.drawable.loading)
     .error(R.drawable.error)
     .diskCacheStrategy(DiskCacheStrategy.NONE)
     .into(imageView);
7、加载指定大小的图片
Glide.with(this)
     .load(url)
     .placeholder(R.drawable.loading)
     .error(R.drawable.error)
     .diskCacheStrategy(DiskCacheStrategy.NONE)
     .override(100, 100)//指定图片大小
     .into(imageView);
8、关闭框架的内存缓存机制
Glide.with(this)
     .load(url)
     .skipMemoryCache(true)  //传入参数为false时，则关闭内存缓存。
     .into(imageView);
9、关闭硬盘的缓存
Glide.with(this)
     .load(url)
     .diskCacheStrategy(DiskCacheStrategy.NONE)     //关闭硬盘缓存操作
     .into(imageView);

//其他参数表示：
//DiskCacheStrategy.NONE： 表示不缓存任何内容。
//DiskCacheStrategy.SOURCE： 表示只缓存原始图片。
//DiskCacheStrategy.RESULT： 表示只缓存转换过后的图片（默认选项）。
//DiskCacheStrategy.ALL ： 表示既缓存原始图片，也缓存转换过后的图片。
10、当引用的 url 存在 token 时解决方法-->重写 Glide 的 GlideUrl 方法
public class MyGlideUrl extends GlideUrl {

    private String mUrl;

    public MyGlideUrl(String url) {
        super(url);
        mUrl = url;
    }

    @Override
    public String getCacheKey() {
        return mUrl.replace(findTokenParam(), "");
    }

    private String findTokenParam() {
        String tokenParam = "";
        int tokenKeyIndex = mUrl.indexOf("?token=") >= 0 ? mUrl.indexOf("?token=") : mUrl.indexOf("&token=");
        if (tokenKeyIndex != -1) {
            int nextAndIndex = mUrl.indexOf("&", tokenKeyIndex + 1);
            if (nextAndIndex != -1) {
                tokenParam = mUrl.substring(tokenKeyIndex + 1, nextAndIndex + 1);
            } else {
                tokenParam = mUrl.substring(tokenKeyIndex);
            }
        }
        return tokenParam;
    }

}
然后加载图片的方式为：
Glide.with(this)
     .load(new MyGlideUrl(url))
     .into(imageView);
11、利用Glide将图片加载到不同控件或加载成不同使用方式
（1）、拿到图片实例
//1、通过自己构造 target 可以获取到图片实例
SimpleTarget<GlideDrawable> simpleTarget = new SimpleTarget<GlideDrawable>() {
    @Override
    public void onResourceReady(GlideDrawable resource, GlideAnimation glideAnimation) {
        imageView.setImageDrawable(resource);
    }
};

//2、将图片实例记载到指定的imageview上，也可以做其他的事情
public void loadImage(View view) {
    String url = "http://cn.bing.com/az/hprichbg/rb/TOAD_ZH-CN7336795473_1920x1080.jpg";
    Glide.with(this)
         .load(url)
         .into(simpleTarget);
}
（2）、将图片加载到任何位置
/*
*将图片加载为控件背景
*/
public class MyLayout extends LinearLayout {

    private ViewTarget<MyLayout, GlideDrawable> viewTarget;

    public MyLayout(Context context, AttributeSet attrs) {
        super(context, attrs);
        viewTarget = new ViewTarget<MyLayout, GlideDrawable>(this) {
            @Override
            public void onResourceReady(GlideDrawable resource, GlideAnimation glideAnimation) {
                MyLayout myLayout = getView();
                myLayout.setImageAsBackground(resource);
            }
        };
    }

    public ViewTarget<MyLayout, GlideDrawable> getTarget() {
        return viewTarget;
    }

    public void setImageAsBackground(GlideDrawable resource) {
        setBackground(resource);
    }

}


//引用图片到指定控件作为背景
public class MainActivity extends AppCompatActivity {

    MyLayout myLayout;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        myLayout = (MyLayout) findViewById(R.id.background);
    }

    public void loadImage(View view) {
        String url = "http://cn.bing.com/az/hprichbg/rb/TOAD_ZH-CN7336795473_1920x1080.jpg";
        Glide.with(this)
             .load(url)
             .into(myLayout.getTarget());
    }

}
12、Glide 实现预加载
//a、预加载代码
Glide.with(this)
     .load(url)
     .diskCacheStrategy(DiskCacheStrategy.SOURCE)
     .preload();

//preload() 有两种重载
 // 1、带有参数的重载,参数作用是设置预加载的图片大小；
//2、不带参数的表示加载的图片为原始尺寸；

//b、使用预加载的图片
Glide.with(this)
     .load(url)
     .diskCacheStrategy(DiskCacheStrategy.SOURCE)
     .into(imageView);
```

切记：diskCacheStrategy() 方法内必须设置参数为：“ DiskCacheStrategy.SOURCE ”，否则可能预加载失败，导致显示图片时，需要重新加载。

```java
13、Glide 实现图片下载
使用 downloadOnly(int width, int height) 或 downloadOnly(Y target) 方法替代 into(view) 方法。
public void downloadImage(View view) {
    new Thread(new Runnable() {
        @Override
        public void run() {
            try {
                String url = "http://cn.bing.com/az/hprichbg/rb/TOAD_ZH-CN7336795473_1920x1080.jpg";
                final Context context = getApplicationContext();
                FutureTarget<File> target = Glide.with(context)
                                                 .load(url)
                                                 .downloadOnly(Target.SIZE_ORIGINAL, Target.SIZE_ORIGINAL);
                final File imageFile = target.get();
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(context, imageFile.getPath(), Toast.LENGTH_LONG).show();
                    }
                });
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }).start();
}
(1)、有两个参数的 downloadOnly(int width, int height) 方法表示指定下载尺寸，用于在子线程内进行下载；
(2)、一个参数的 downloadOnly(Y target) 方法 在主线程内进行下载
(3)、target.get() 方法可以获取到下载文件保存路径；
使用下载完的图片的方式
public void loadImage(View view) {
    String url = "http://cn.bing.com/az/hprichbg/rb/TOAD_ZH-CN7336795473_1920x1080.jpg";
    Glide.with(this)
            .load(url)
            .diskCacheStrategy(DiskCacheStrategy.SOURCE)
            .into(imageView);
}
```

注意： diskCacheStrategy() 方法的参数应该为 DiskCacheStrategy.SOURCE 或者 DiskCacheStrategy.ALL否则可能导致加载图片到控件的时候，需要重新加载。

```java
13、监听 Glide 加载的状态
public void loadImage(View view) {
    String url = "http://cn.bing.com/az/hprichbg/rb/TOAD_ZH-CN7336795473_1920x1080.jpg";
    Glide.with(this)
            .load(url)
            .listener(new RequestListener<String, GlideDrawable>() {
                @Override
                public boolean onException(Exception e, String model, Target<GlideDrawable> target,
                    boolean isFirstResource) {
                    return false;
                }

                @Override
                public boolean onResourceReady(GlideDrawable resource, String model,
                    Target<GlideDrawable> target, boolean isFromMemoryCache, boolean isFirstResource) {
                    return false;
                }
            })
            .into(imageView);
}
（1）、onException() 方法表示加载失败，onResourceReady() 表示加载成功；
（2）、 每个方法都有一个 boolean 的返回值，false表示未处理、true 表示处理。
14、Glide 的图形变换功能
（1）、禁用图形变换功能
Glide.with(this)
     .load(url)
     .dontTransform()
     .into(imageView);
```

这个方法时全局的，导致其他地方的图片也不可进行图形变换了。

```java
修改方法
Glide.with(this)
     .load(url)
     .override(Target.SIZE_ORIGINAL, Target.SIZE_ORIGINAL)
     .into(imageView);
通过 override() 方法设置大小
（2）、简单的图形变换
Glide.with(this)
     .load(url)
     .centerCrop()
     .into(imageView);

Glide.with(this)
     .load(url)
     .fitCenter()
     .into(imageView);
通过 centerCrop()方法 按照原始的长宽比充满全屏和 fitCenter() 方法 对原图的中心区域进行裁剪对图片进行相关设置。
（3）、override() 方法与 centerCrop() 方法配合使用
String url = "http://cn.bing.com/az/hprichbg/rb/AvalancheCreek_ROW11173354624_1920x1080.jpg";
Glide.with(this)
     .load(url)
     .override(500, 500)
     .centerCrop()
     .into(imageView);
```



