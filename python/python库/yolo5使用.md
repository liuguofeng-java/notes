## yolo5使用

##### 1. 环境配置

确保安装了Python环境

```sh
# 克隆YOLOv5仓库
git clone https://github.com/ultralytics/yolov5.git
cd yolov5

# 安装依赖
pip install -r requirements.txt
```

##### 2.推理（检测）

````sh
# 调用摄像头推理
python detect.py --source 0

# 推理图片image 
python detect.py --source file.jpg  

# 推理视频
python detect.py --source file.mp4

# 指定模型进行推理
python detect.py --source file.jpg  --weights yolov5s.pt
````

