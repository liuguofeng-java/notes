## electron 快捷键

- 本地快捷键

应用键盘快捷键仅在应用程序被聚焦时触发

```csharp
const { app, BrowserWindow, MenuItem, Menu } = require('electron')

const menu = new Menu()
menu.append(new MenuItem({
  label: 'Electron',
  submenu: [{
    role: 'help',
    accelerator: 'Alt+Shift+I',
    click: () => {
      console.log('Alt+Shift+I')
    }
  }]
}))
```





- 全局快捷键

要配置全局键盘快捷键， 您需要使用 globalShortcon 模块来检测键盘事件，即使应用程序没有获得键盘焦点。

```csharp
const { app, globalShortcut } = require('electron')

app.whenReady().then(() => {
  globalShortcut.register('Alt+CommandOrControl+I', () => {
    console.log('Electron loves global shortcuts!')
  })
}).then(createWindow)
```





- 在浏览器窗口内的快捷方式

如果您想要在 BrowserWindow 中处理键盘快捷键，你可以在渲染进程中使用 addEventListener() API来监听 kepup 和 keydown DOM事件。

```csharp
window.addEventListener('keyup', doSomething, true)
```





- 拦截页面上的事件

```csharp
win.webContents.on('before-input-event', (event, input) => {
    console.log(input.key)
    event.preventDefault()
  })
```

