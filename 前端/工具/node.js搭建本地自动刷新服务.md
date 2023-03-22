## node.js搭建本地自动刷新服务
```shell
#用npm 或者cnpm进行全局安装
cnpm install -g live-server 
#运行后就可以直接给你虚拟一个本地服务器，而且还可以热同步
运行
#live-server 
```

####  推荐使用browser-sync

```shell
npm install -g browser-sync   

#安装完之后运行命令
browser-sync start --server --files "**" --port 8092

#具体配置 可参考地址 http://www.browsersync.cn/docs/command-line/
```

