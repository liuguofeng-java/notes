

## electron-vue 报错 process is not defined

1. 在 .electron-vue/webpack.renderer.config.js 和 .electron-vue/webpack.web.config.js 文件中找到 HtmlWebpackPlugin 代码段并更改为如下代码：

```javascript
new HtmlWebpackPlugin({
  ......
  templateParameters(compilation, assets, options) {
    return {
      compilation: compilation,
      webpack: compilation.getStats().toJson(),
      webpackConfig: compilation.options,
      htmlWebpackPlugin: {
        files: assets,
        options: options
      },
      process,
    };
  }
})
```

 