## android Activity启动模式

> 在android应用开发中，打造良好的用户体验是非常重要的。而在用户体验中，界面的引导和跳转是值得深入研究的重要内容。在开发中，与界面跳转联系比较紧密的概念是Task（任务）和Back Stack（回退栈）。activity的启动模式会影响Task和Back Stack的状态，进而影响用户体验。除了启动模式之外，Intent类中定义的一些标志（以FLAG_ACTIVITY_开头）也会影响Task和Back Stack的状态

#### 1.xml中的四种启动模式

> activity有四种启动模式，分别为standard，singleTop，singleTask，singleInstance。如果要使用这四种启动模式，必须在manifest文件中<activity>标签中的launchMode属性中配置，如：

```xml
    <activity android:name=".app.InterstitialMessageActivity"
              android:label="@string/interstitial_label"
              android:theme="@style/Theme.Dialog"
              android:launchMode="singleTask"
    </activity>
```

- standard 默认值，标准的，特点是：启动一个Activity就进栈一个Activity
- singleTop 独占顶端，特点是Activity在顶端的时候，启动Activity会自动重用Activity，不会进栈，只有在顶端才会被重用
- singleTask 单任务，特点是单任务，同一个栈不会有两个Activity引用，Activity一旦进栈 就不会再次进栈了
- singleInstance 单实例，特点就是：单独开启一个任务栈，再次启动Activity的时候都会重用

#### 2.Intent addFlag 设置Activity启动模式



`FLAG_ACTIVITY_CLEAR_TOP`

如果已设置，并且正在启动的活动已经在当前任务（backstack）中运行，那么，而不是启动该活动的新实例，而且它上面的所有其他活动都将被关闭，而这个意图将作为一个新的意图传递到（现在的顶部）旧活动中.。

`FLAG_ACTIVITY_FORWARD_RESULT`

如果设置这个intent是被用来从一个现有的acitivity启动到新的acitivity，现有activity的回复目标将被转移到新的activity。

`FLAG_ACTIVITY_LAUNCHED_FROM_HISTORY`

这个flag不能正常地被应用程序代码设置，而是系统为你设置，如果这个活动正在展开的历史堆栈（长按 Home键）。

`FLAG_ACTIVITY_MULTIPLE_TASK`

此标志用来创建一个新的task和启动一个活动到此任务

`FLAG_ACTIVITY_NEW_DOCUMENT`

此标志用于将文档打开到一个新的任务中，该任务源于intent启动的活动。

`FLAG_ACTIVITY_NEW_TASK`

设置此标志使activity将成为此历史堆栈上新任务的开始

`FLAG_ACTIVITY_NO_ANIMATION`

如果通过 Context.startactivity()去设置/启动一个Intent，这个标志将阻止系统执行一个活动去下一个活动的过渡动画。

`FLAG_ACTIVITY_NO_HISTORY`

设置此标志activity将不添加到回退栈（backStack）
