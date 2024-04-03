## vue防抖节流

##### 1.安装

> 官方: https://www.vueusejs.com/shared/useDebounceFn/

```sh
npm install @vueuse/core
```

##### 2.使用

```vue
<template
  <a-select
    v-model:value="keyword"
    show-search
    placeholder="输入关键字搜索"
    style="width: 300px"
    :default-active-first-option="false"
    :show-arrow="false"
    :filter-option="false"
    :not-found-content="null"
    @search="debounceSearchChange"
  >
</template>
 
<script lang="ts" setup>
  import { ref } from 'vue';
  import { useDebounceFn, useClipboard } from '@vueuse/core';
 
  const keyword = ref('');
  const debounceSearchChange = useDebounceFn(handleSearch, 200);
  
  function handleSearch(str) {
    console.log(str)
    // 处理搜索的逻辑
  }
 
</script>
```

