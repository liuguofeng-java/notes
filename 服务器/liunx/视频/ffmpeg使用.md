## ffmpeg使用

##### 1.介绍

> FFmpeg是一套可以用来记录、转换数字音频、视频，并能将其转化为流的开源计算机程序

##### 2.简单使用

1. nginx + ffmpeg 制作 hls 推流

   ```shell
   ffmpeg -re -i 47276514.mp4 -f hls -vcodec libx264 -r 25 -s 1280x720 -an -b:v 2048k -f segment -segment_list_type m3u8 -segment_list_size 0 -segment_time 5.0 -segment_time_delta 0.1 -segment_list D:\nginx-1.18.0\html\hls\10-27-08-56\2020.m3u8 D:\nginx-1.18.0\html\hls\10-27-08-56\2020%5d.ts
   ```

2. 图片转MP4 

   ```shell
   ffmpeg -y -r 0.5 -i d:/a.jpg -vcodec mpeg4 d:/video5.mp4
   ```

4. 视频合成

   ```shell
   ffmpeg -y -i "concat:d://a.mp4|d://b.mp4" -acodec copy -vcodec copy -absf aac_adtstoasc d://c.mp4
   ```

5. rtmp推流

   ```shell
   ffmpeg -i test.mp4  -b 4096k  -ss 60 -f flv -r 25 -s 1280x720 -an "rtmp://localhost/oflaDemo/hello"
   ```

6. 获取MP4信息

   ```shell
   ffmpeg -i tset.mp4
   ```

7. 录屏

   ```shell
   ffmpeg -f gdigrab -i desktop -f mp4 -vcodec libx264 ./out.mp4
   ```


8. 获取时长

   ```shell
   ffprobe -i 1.mp4 -show_entries format=duration -v quiet -of csv=\"p=0\"
   ```

9. 截取视频

   ```shell
   ffmpeg -i o.mp4 -ss 00:00:00 -to 00:01:20 -c:v libx264 -crf 30 c.mp4
   ```

10. 去水印

    ```shell
    ffmpeg -i 1.mp4 -vf "delogo=x=50:y=30:w=200:h=70:show=0" -y o.mp4
    ```

11. 添加字幕

    ```shell
    ffmpeg -i o.mp4 -i o.ass -vf ass=o.ass -c:v libx264 a.mp4
    ```

12. 多张图片合成视频

    ```shell
    ffmpeg -f image2 -framerate 60 -i %d.png -qscale:v 1100 -b:v 5626k ../out.avi
    ffmpeg -f image2 -i %d.png -c:v libx264 -r 60 -pix_fmt yuv420p -b:v 5000k ../out2.mp4
    ```

13. MP4转图片(  -vf fps=6 代表1秒6帧 )

    ```shell
    ffmpeg -i 1.mp4 -f image2 -vf fps=6 -qscale:v 2 ./img/%d.jpg
    ```

14. 多个MP4合并一个

    ```shell
    #新建文件夹list.txt
    file 1.mp4
    file 2.mp4
    #执行命令
    ffmpeg -f concat -i list.txt -c copy merge.mp4
    #更准确
    ffmpeg -f concat -safe 0 -i list.txt -acodec aac -b:a 128K -f mp4 -movflags faststart -y merge.mp4
    ```

15. 提取MP4音频

    ```shell
    ffmpeg -i input.mp4 -f mp3 -vn output.mp3
    ```

16. MP3倍数播放

    ```shell
     ffmpeg -n  -i vv.mp3 -filter:a "atempo=1.419" v.mp3
    ```

    
