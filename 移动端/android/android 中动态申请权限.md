## android 中动态申请权限

#### 1.在清单文件中添加要申请的权限

>  <uses-permission android:name="android.permission.CAMERA"/> 这句是申请相机的权限

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.activitdomo">

    <uses-permission android:name="android.permission.CAMERA"/>

    <application
        android:allowBackup="true"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:supportsRtl="true"
        android:theme="@style/Theme.MyAndroidApplication">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
```

#### 2.点击按钮时申请权限



```java
public class MainActivity extends AppCompatActivity {

    //申请时的code
    private static final int REQUEST_CODE = 1;

    private static final String[] permission = new String[]{
            Manifest.permission.CAMERA,//相机
            Manifest.permission.BODY_SENSORS //传感器
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //跳转子页面按钮
        Button but = findViewById(R.id.but01);
        //点击跳转子页面时
        but.setOnClickListener((view1) -> {
            for (String s : permission) {
                //检查权限
                int check = ContextCompat.checkSelfPermission(this, s);
                if (check != PackageManager.PERMISSION_GRANTED) {
                    //进入到这里代表没有权限.
                    ActivityCompat.requestPermissions(
                            this, permission ,REQUEST_CODE);
                    break;
                }
            }
        });
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == REQUEST_CODE) {
            for (String s : permission) {
                int check = ContextCompat.checkSelfPermission(this, s);
                if (check != PackageManager.PERMISSION_GRANTED) {
                    if(Manifest.permission.CAMERA.equals(s)){//申请相机失败
                        Toast.makeText(this,"申请相机失败",Toast.LENGTH_LONG).show();
                    }
                    if(Manifest.permission.BODY_SENSORS.equals(s)){//申请传感器失败
                        Toast.makeText(this,"申请传感器失败",Toast.LENGTH_LONG).show();

                    }
                }
            }


        }
    }
}
```

#### 3.危险权限列表权限

```java
group:android.permission-group.CONTACTS
  permission:android.permission.WRITE_CONTACTS
  permission:android.permission.GET_ACCOUNTS
  permission:android.permission.READ_CONTACTS
 
group:android.permission-group.PHONE
  permission:android.permission.READ_CALL_LOG
  permission:android.permission.READ_PHONE_STATE
  permission:android.permission.CALL_PHONE
  permission:android.permission.WRITE_CALL_LOG
  permission:android.permission.USE_SIP
  permission:android.permission.PROCESS_OUTGOING_CALLS
  permission:com.android.voicemail.permission.ADD_VOICEMAIL
 
group:android.permission-group.CALENDAR
  permission:android.permission.READ_CALENDAR
  permission:android.permission.WRITE_CALENDAR
 
group:android.permission-group.CAMERA
  permission:android.permission.CAMERA
 
group:android.permission-group.SENSORS
  permission:android.permission.BODY_SENSORS
 
group:android.permission-group.LOCATION
  permission:android.permission.ACCESS_FINE_LOCATION
  permission:android.permission.ACCESS_COARSE_LOCATION
 
group:android.permission-group.STORAGE
  permission:android.permission.READ_EXTERNAL_STORAGE
  permission:android.permission.WRITE_EXTERNAL_STORAGE
 
group:android.permission-group.MICROPHONE
  permission:android.permission.RECORD_AUDIO
 
group:android.permission-group.SMS
  permission:android.permission.READ_SMS
  permission:android.permission.RECEIVE_WAP_PUSH
  permission:android.permission.RECEIVE_MMS
  permission:android.permission.RECEIVE_SMS
  permission:android.permission.SEND_SMS
  permission:android.permission.READ_CELL_BROADCASTS
```

