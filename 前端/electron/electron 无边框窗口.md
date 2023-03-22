## electron 无边框窗口

- 透明窗口

通过将 transparent 选项设置为 true, 还可以使无框窗口透明(控制台会影响):

```csharp
const { BrowserWindow } = require('electron')
const win = new BrowserWindow({ transparent: true, frame: false })
win.show()
```





- 点击穿透窗口

要创建一个点击穿透窗口，也就是使窗口忽略所有鼠标事件，可以调用 win.setIgnoreMouseEvents(ignore) API：

```csharp
const { BrowserWindow } = require('electron')
const win = new BrowserWindow()
win.setIgnoreMouseEvents(true)
```



- 可拖拽区

默认情况下, 无边框窗口是不可拖拽的。 应用程序需要在 CSS 中指定 -webkit-app-region: drag 来告诉 Electron 哪些区域是可拖拽的（如操作系统的标准标题栏），在可拖拽区域内部使用 -webkit-app-region: no-drag 则可以将其中部分区域排除。 请注意, 当前只支持矩形形状。

在无框窗口中, 拖动行为可能与选择文本冲突。 例如, 当您拖动标题栏时, 您可能会意外地选择标题栏上的文本。 为防止此操作, 您需要在可区域中禁用文本选择, 如下所选:

-webkit-user-select: none;

要使整个窗口可拖拽, 您可以添加 -webkit-app-region: drag 作为 body 的样式:

```csharp
<body style="-webkit-app-region: drag">
</body>
```

或者

```css
body{
    -webkit-app-region: drag
}
```

请注意，如果您使整个窗口都可拖拽，则必须将其中的按钮标记为不可拖拽，否则用户将无法点击它们：

```csharp
button {
  -webkit-app-region: no-drag;
}
```

