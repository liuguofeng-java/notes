## ffmpeg调整音视频音量
##### 音量调整为当前音量的一半

```sh
ffmpeg -i input.wav -filter:a "volume=0.5" output.wav
```

##### 音量调整为当前音量的1.5倍

```sh
ffmpeg -i input.wav -filter:a "volume=1.5" output.wav
```

##### 音量调整为静音

```sh
ffmpeg -i input.wav -filter:a "volume=0" output.wav
```

##### 使用 decibel 来调节音量，增加 10dB

```sh
ffmpeg -i input.wav -filter:a "volume=10dB" output.wav
```

##### 使用 decibel 来调节音量, 减少 5dB

```sh
ffmpeg -i input.wav -filter:a "volume=-5dB" output.wav
```

