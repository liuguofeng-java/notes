## TTS文本转语音基础使用方式

##### 1.首先安装edge-tts库：

```shell
pip3 install edge-tts
```

安装成功后，直接在终端运行edge-tts命令：

```shell
edge-tts
```

随后输入命令：

```shell
edge-tts --list-voices
```

> 该命令可以将Edge浏览器中，内置的语言角色列表列出来：

```text
Name: af-ZA-AdriNeural  
Gender: Female  

Name: af-ZA-WillemNeural  
Gender: Male  

Name: am-ET-AmehaNeural  
Gender: Male  

Name: am-ET-MekdesNeural  
Gender: Female  

Name: ar-AE-FatimaNeural  
Gender: Female  

Name: ar-AE-HamdanNeural  
Gender: Male  
```

##### 2.使用合成MP3

> 一望而知，几乎支持所有主流的通用语，Gender字段为合成语音的性别，Male代表男性，Female代表女性，zh开头的就是中文语音角色，这里以微软的小伊为例子：

```sh
edge-tts --voice zh-CN-XiaoyiNeural --text "你好啊，我是智能语音助手" --write-media test.mp3
```

```sh
Downloads edge-tts --voice zh-CN-XiaoyiNeural --text "你好啊，我是智能语音助手" --write-media test.mp3  
WEBVTT  

00:00:00.100 --> 00:00:00.525  
你好  

00:00:00.525 --> 00:00:00.912  
啊  

00:00:01.050 --> 00:00:01.238  
我  

00:00:01.238 --> 00:00:01.375  
是  

00:00:01.387 --> 00:00:01.700  
智能  

00:00:01.700 --> 00:00:02.050  
语音  

00:00:02.062 --> 00:00:02.550  
助手
```

> 程序会自动将时间轴和语音文本匹配输出，如此一来，连字幕文件也有了，可谓是一举两得，一箭双雕。
>
> 与此同时，我们也可以调整合成语音的语速：

```shell
#--rate参数可以通过加号或者减号同步加快或者减慢合成语音的语速。
edge-tts --rate=-50% --voice zh-CN-XiaoyiNeural --text "你好啊，我是智能语音助手" --write-media test.mp3
```

>亦或者，调整合成语音的音量：

```shell
#--volume参数可以调整语音的音量。
edge-tts --volume=-50%  --voice zh-CN-XiaoyiNeural --text "你好啊，我是智能语音助手" --write-media test.mp3
```

