## electron-vue安装

安装

```shell
npm install -g electron #安装electron
npm install -g electron-forge #安装electron-forge
electron-forge init my-project #创建项目
#使用 electron-forge init 初始化项目时可能由于 npm 版本问题，
#删除工程中 node_modules 目录及其内容。
#在 package.json 文件中追加 "electron-prebuilt-compile": "2.0.4" 到环境依赖（devDependencies）
#重新执行安装 npm install 后即可。
#electron-vue
npm install -g vue-cli                            #全局安装
vue init simulatedgreg/electron-vue my-project    #创建工程
npm run dev  #运行
npm run build  #打包
```

Visual Studio Code调试工具

```shell
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Main Process",
      "type": "node",
      "request": "launch",
      "cwd": "${workspaceRoot}",
      "runtimeExecutable": "${workspaceRoot}/node_modules/.bin/electron",
      "windows": {
        "runtimeExecutable": "${workspaceRoot}/node_modules/.bin/electron.cmd"
      },
      "args" : ["."],
      "outputCapture": "std"
    }
  ]
}
```



```javascript
frame: false,
transparent: true,
mainWindow.setIgnoreMouseEvents(true)
```

