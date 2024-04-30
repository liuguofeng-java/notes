## 解决npm install卡住不动

##### 1.安装时指定npm远程仓库

```sh
npm install --registry=https://registry.npmmirror.com/
```

##### 2.全局配置npm远程仓库

```sh
# 新国内地址
npm config set registry https://registry.npmmirror.com/

# 设置回原来的远程仓库
npm config set registry https://registry.npmjs.org
```

##### 3.使用pnpm

```sh
# 安装
npm install pnpm

# 使用
pnpm install
```
