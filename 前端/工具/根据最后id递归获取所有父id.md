## 根据最后id递归获取所有父id

> data 是树形结构  id是值

```js
getParentsIds (data, id) {
    for (const i in data) {
        if (data[i].id === id) {
            return [data[i].id]
        }
        if (data[i].children) {
            const result = this.getParentsIds(data[i].children, id)
            if (result !== undefined) {
                return result.shift(data[i].id)
            }
        }
    }
}
```

