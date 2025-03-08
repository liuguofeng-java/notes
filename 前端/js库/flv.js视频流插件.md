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
      lastDecodedFrame: 0
    }
  },
  props: {
    streamUrl: {
      type: String
    }
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
          autoCleanupMinBackwardDuration: 10, //对SourceBuffer进行自动清理
          stashInitialSize: 128,  // 减少初始缓冲大小
          autoCleanupMaxBackwardDuration: 30, // 对SourceBuffer进行自动清理
          enableStashBuffer: false, //关闭IO隐藏缓冲区
        })
        this.player.attachMediaElement(this.$refs.player)
        this.player.load()
        this.player.play()

        // 事件触发视频自动播放时
        this.player.addEventListener("canplay", () => {
          this.player.play();
        });
          
        // 播放错误时从新初始化
        this.player.on(flvjs.Events.ERROR, (errorType, errorDetail, errorInfo) => {
          console.log("errorType:", errorType);
          console.log("errorDetail:", errorDetail);
          console.log("errorInfo:", errorInfo);
          //视频出错后销毁重新创建
          if (this.player) {
            this.destroyPlayer()
            this.init();
          }
        });

        // 解决视频卡顿问题
        this.player.on("statistics_info", function (res) {
          if (this.lastDecodedFrame == 0) {
            this.lastDecodedFrame = res.decodedFrames;
            return;
          }
          if (this.lastDecodedFrame != res.decodedFrames) {
            this.lastDecodedFrame = res.decodedFrames;
          } else {
            this.lastDecodedFrame = 0;
            if (this.player) {
              this.destroyPlayer()
              this.init();
            }
          }
        });
      }
    },
    // 销毁方法
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
    beforeDestroy() {
      this.destroyPlayer()
    },
    deactivated() {
      this.destroyPlayer()
    },
    activated() {
      this.init()
    }
  }
}
</script>

```

