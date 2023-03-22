## electron 窗体

- 加载一个网络页面

```csharp
win.loadURL('http://www.baidu.com')
```



- 加载一个无边框的窗体 frame:false 是控制无边框显示

```csharp
const win = new BrowserWindow({ width: 800, height: 600, frame: false })
```



- 使用ready-to-show事件

在加载页面时，渲染进程第一次完成绘制时，如果窗口还没有被显示，渲染进程会发出 ready-to-show 事件 。 在此事件后显示窗口将没有视觉闪烁：

```csharp
const { BrowserWindow } = require('electron')
const win = new BrowserWindow({ show: false })
win.once('ready-to-show', () => {
  win.show()
})
```

这个事件通常在 did-finish-load 事件之后发出，但是页面有许多远程资源时，它可能会在 did-finish-load之前发出事件。

如果您使用 paintWhenInitiallyHidden: false，此事件将永远不会被触发。



- 设置 backgroundColor

设置启动时的颜色

```csharp
const { BrowserWindow } = require('electron')

const win = new BrowserWindow({ backgroundColor: '#2e2c29' })
win.loadURL('https://github.com')
```

请注意，即使是使用 ready-to-show 事件的应用程序，仍建议使用设置 backgroundColor 使应用程序感觉更原生。



- 父子窗口

通过使用 parent 选项，你可以创建子窗口：

```csharp
const { BrowserWindow } = require('electron')

const top = new BrowserWindow()
const child = new BrowserWindow({ parent: top })
child.show()
top.show()
```

child 窗口将总是显示在 top 窗口的顶部.





- 模态窗口

模态窗口是禁用父窗口的子窗口，创建模态窗口必须设置 parent 和 modal 选项：

```csharp
const { BrowserWindow } = require('electron')

const child = new BrowserWindow({ parent: top, modal: true, show: false })
child.loadURL('https://github.com')
child.once('ready-to-show', () => {
  child.show()
})
```







