## 创建一个简单的electron程序

最小的 Electron 应用程序具有以下结构：

my-electron-app/
├── package.json
├── main.js
└── index.html


安装 Electron

为您的项目创建一个文件夹并安装 Electron：

```javascript
mkdir my-electron-app && cd my-electron-app
npm init -y
npm i --save-dev electron
```

- 创建主脚本文件

主脚本指定了运行主进程的 Electron 应用程序的入口(就我们而言，是main.js 文件)。 通常，在主进程中运行的脚本控制应用程序的生命周期、显示图形用户界面及其元素、执行本机操作系统交互以及在网页中创建渲染进程。 Electron 应用程序只能有一个主进程。

主脚本可以如下所示：

```javascript
const { app, BrowserWindow } = require('electron')

function createWindow () {
  const win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true
    }
  })

  win.loadFile('index.html')
}

app.whenReady().then(createWindow)

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

app.on('activate', () => {
  if (BrowserWindow.getAllWindows().length === 0) {
    createWindow()
  }
})
```



- 创建网页

```javascript
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hello World!</title>
    <meta http-equiv="Content-Security-Policy" content="script-src 'self' 'unsafe-inline';" />
</head>
<body style="background: white;">
    <h1>Hello World!</h1>
    <p>
        We are using node <script>document.write(process.versions.node)</script>,
        Chrome <script>document.write(process.versions.chrome)</script>,
        and Electron <script>document.write(process.versions.electron)</script>.
    </p>
</body>
</html>
```

- 修改 package.json 文件

需要将其更改为这样：

```javascript
{
    "name": "my-electron-app",
    "version": "0.1.0",
    "author": "your name",
    "description": "My Electron app",
    "main": "main.js",
    "scripts": {
        "start": "electron ."
    }
}
```

运行您的应用程序

```javascript
npm start
```

