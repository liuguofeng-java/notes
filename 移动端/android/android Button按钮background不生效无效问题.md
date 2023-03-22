## android Button按钮background不生效无效问题

在res/values/themes.xml 中：

```java
    <style name="Theme.Bookkeeping" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
```



把后面的parent修改为:

```java
<style name="Theme.Bookkeeping" parent="Theme.MaterialComponents.DayNight.NoActionBar.Bridge" >
```



