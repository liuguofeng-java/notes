## electron进程之间通讯

主进程向渲染进程通讯

1.主进程使用 `win.webContents.send` 发送消息

- 渲染进程使用 `ipcRenderer.on` 接收消息

2.渲染进程向主进程通信

- 渲染进程使用 `ipcRenderer.send` 或者 `ipcRenderer.invoke` 发送消息

- 主进程使用 `ipcMain.on`或者`ipcMain.handle` 接收消息