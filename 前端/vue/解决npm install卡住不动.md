## 解决npm install卡住不动

#### 方案一：安装cnpm镜像

1. 这个是比较常用的方法，我首先也是使用了这个方法。cnpm的安装方法，参考http://npm.taobao.org/

```sh
#npm install -g cnpm --registry=https://registry.npm.taobao.org

npm install -g cnpm --registry=https://registry.npmmirror.com/
```

2. cmd输入以上命令就可以了，然后输入

```javascript
cnpm install -g @angular/cli
```



#### 方案二：使用代理registry

```javascript
设置淘baix,宝的是：du
npm config set registry https://registry.npm.taobao.org
不想用他们的，再设置回原来的就zhuan可以shu了：
npm config set registry https://registry.npmjs.org
//新国内地址
npm config set registry https://registry.npmmirror.com/
```

#### 方案三：使用代理registry

1. nrm安装

```javascript
npm install -g nrm
```

2. 查看

```javascript
nrm ls
```

3. 设置

```javascript
nrm use taobao
```



