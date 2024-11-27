## axios 异步请求下载文件

```javascript
axios({
  url: '/api/app/cloud/exportExcelVideoList',
  method: 'get',
  responseType: 'blob',
  params:{}
}).then(res => {
    // 注意data 必须是Blob类型
    let data = res.data;
    let blob = new Blob([data])
    let downloadElement = document.createElement('a')
    let href = window.URL.createObjectURL(blob)
    downloadElement.href = href
    downloadElement.download = '视频清单.xlsx'
    document.body.appendChild(downloadElement)
    downloadElement.click()
    document.body.removeChild(downloadElement)
    window.URL.revokeObjectURL(href)
})
```

