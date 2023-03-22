## vue 解决请求代理问题

在一级目录新建vue.config.js

```javascript
module.exports = {
    devServer: {
        proxy: {
            '/api': {
                target: 'http://elm.cangdu.org/v1/',
                // 允许跨域
                changeOrigin: true,
                ws: true,
                pathRewrite: {
                    '^/api': ''
                }
            }
        }
    }
}
```

