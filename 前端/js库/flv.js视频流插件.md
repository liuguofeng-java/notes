## flv.js视频流插件

> flv.js是B站开源的JavaScript库，用于在浏览器中通过HTML5播放FLV格式的视频流，主要依赖于Media Source Extensions。

##### 1.通过 npm 安装

```sh
npm install flv.js
```

##### 2. 引入

```js
import flvjs from 'flv.js';
```

##### 3.示例

```vue
<template>
	<video ref="player" muted autoplay></video>
</template>

<script>
import flvjs from '../../../../utils/flvjs/flv'
export default {
  data() {
    return {
      player: null,
      lastDecodedFrame: 0,
      timeout: null
    }
  },
  props: {
    streamUrl: {
      type: String,
      required: true
    },
  },
  watch: {
    streamUrl: {
      handler(newValue, oldValue) {
        console.log('user变化了', newValue);
        if (!newValue) return
        this.$nextTick(() => {
          this.init()
        })
      },
      deep: true,
      immediate: true
    },
  },
  beforeDestroy() {
    this.destroyPlayer()
  },
  deactivated() {
    this.destroyPlayer()
  },
  activated() {
    this.init()
  },
  methods: {
    init() {
      if (flvjs.isSupported()) {
        this.destroyPlayer()
        if (this.player) {
          this.player.pause(); // 暂停当前播放
          this.player.src = ""; // 清空当前 src
        }
        this.player = flvjs.createPlayer({
          type: 'flv',
          isLive: true,
          hasAudio: false, // 关闭声音
          url: this.streamUrl
        }, {
          enableWorker: true,  // 启用分离线程
          // autoCleanupSourceBuffer: true,  // 自动清理缓存
          autoCleanupMinBackwardDuration: 30,
          // stashInitialSize: 128,  // 减少初始缓冲大小
          autoCleanupMaxBackwardDuration: 60, //    当向后缓冲区持续时间超过此值（以秒为单位）时，请对SourceBuffer进行自动清理
          enableStashBuffer: true, //关闭IO隐藏缓冲区
        })
        this.player.attachMediaElement(this.$refs.player)

        this.player.load()
        this.player.play()

        this.player.on("canplay", () => {
          this.player.play();
        });

        const _this = this
        this.player.on(flvjs.Events.ERROR, (errorType, errorDetail, errorInfo) => {
          console.log("errorType:", errorType);
          console.log("errorDetail:", errorDetail);
          console.log("errorInfo:", errorInfo);
          //视频出错后销毁重新创建
          _this.destroyPlayer()
          _this.init();
        });

        if (_this.timeout) {
          clearTimeout(_this.timeout)
        }
        // 5秒后检查视频流，预留缓冲时间
        _this.timeout = setTimeout(() => {
          _this.player.on("statistics_info", function (res) {
            if (_this.lastDecodedFrame == 0) {
              _this.lastDecodedFrame = res.decodedFrames;
              return;
            }
            if (_this.lastDecodedFrame != res.decodedFrames) {
              _this.lastDecodedFrame = res.decodedFrames;
            } else {
              _this.lastDecodedFrame = 0;
              _this.destroyPlayer()
              _this.init();
              console.log("--->>> 重新拉流")
            }
          });
        }, 5000)
      }
    },
    destroyPlayer() {
      if (this.player) {
        try {
          this.player.pause()
          this.player.unload();
          this.player.detachMediaElement();
          this.player.destroy();
        } catch (error) {
          console.log(error);
        }
        this.player = null;
      }
    },
    
  }
}
</script>
```

