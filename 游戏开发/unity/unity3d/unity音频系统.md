## unity音频系统

##### 1.音频系统 主要包括三个部分：音频剪辑 (Audio Clips)、音频源 (Audio Sources) 和音频监听器 (Audio Listener)。

- **音频剪辑 (Audio Clips)** 是诸如 MP3 之类的资源，其中包含与特定声音相关的所有数据。

- **音频源 (Audio Sources)** 是在游戏世界中充当声音起源的组件。在游戏中发出声音的大多数事物都应具有音频源 (Audio Source) 组件，以便声音具有位置。
- **音频监听器 (Audio Listener)** 作为场景中的单个组件，其功能类似于玩家的虚拟耳朵（就像 Camera 组件的作用也类似于玩家的虚拟眼睛一样）。默认情况下，音频监听器 (Audio Listener) 组件位于主摄像机 (Main Camera) 上。