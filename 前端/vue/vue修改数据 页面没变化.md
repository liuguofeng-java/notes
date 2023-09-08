#### 方法1（推荐）：用JSON.parse(JSON.stringify(objectOrArray))
通常是某个渲染的数组改变了层级较深的数据导致页面没有实时渲染

就这么写  this.items=JSON.parse(JSON.stringify(this.items));

#### 方法2：用$set

```js
data() {
    return {
        d: { a: "旧的值" }
    };
},
    
this.$set(this.d,"a","新的值");
```

#### 方法3：用 $forceUpdate
在修改数据之后加入this.$forceUpdate();即可 
```js
this.$forceUpdate()
```

