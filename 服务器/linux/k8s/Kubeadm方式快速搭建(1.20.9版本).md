## Kubeadm方式快速搭建

##### 1.在master中修改host文件

```sh
cat >> /etc/hosts<<EOF
192.168.91.132            k8s-master
192.168.91.131            k8s-node1
192.168.91.133            k8s-node2
EOF
```

##### 2.分别设置三台服务器的主机名

```sh
hostnamectl set-hostname k8s-master
hostnamectl set-hostname k8s-node1
hostnamectl set-hostname k8s-node2
```

##### 3.分别关闭swap和seliunx

```sh
#关闭swap
swapoff -a && sed -ri 's/.*swap.*/#&/' /etc/fstab

#关闭seliunx
setenforce 0 && sed -i 's/enforcing/disabled/' /etc/selinux/config
```

##### 4.分别修改Linux内核参数，添加网桥过滤器和地址转发功能

```sh
# 允许 iptables 检查桥接流量 （K8s 官方要求）
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

# 让配置生效
sysctl --system
```

##### 5.分别同步时间

```sh
yum -y install ntpdate
ntpdate ntp1.aliyun.com
```

##### 6.开放端口号

```
sudo ufw allow 53 
sudo ufw allow 179 
sudo ufw allow 6666 
sudo ufw allow 6667
sudo ufw allow 4789
sudo ufw allow 5473
sudo ufw allow 68
sudo ufw allow 10250
sudo ufw allow 10251
sudo ufw allow 10252
sudo ufw allow 10255
sudo ufw allow 6443
```



>###### 集群服务和插件：
>53：集群 DNS 服务。
>179、6666、6667：Calico 网络插件服务。
>4789：Flannel VXLAN overlay 网络服务。
>5473：Weave 网络插件服务。
>
>###### Kubernetes 控制平面组件：
>68：Scheduler。
>10250、10251、10252、10255：Controller Manager 和 kubelet API。
>Kubernetes API 和数据存储：
>6443：Kubernetes API。

##### 6.安装Docker(ubuntu)

```sh
curl -fsSL https://test.docker.com -o test-docker.sh
# 指定安装版本
sh test-docker.sh --version 19.3

#设置代理服务器
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://82m9ar63.mirror.aliyuncs.com"],
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

# 查看是否配置成功
docker info
```

##### 7.安装kubelet、kubeadm、kubectl

```sh
yum install kubelet-1.23.6 kubeadm-1.23.6 kubectl-1.23.6

#如果是ubuntu要执行以下操作
curl https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - 
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF

apt-get update

apt install kubelet=1.23.6-00 kubeadm=1.23.6-00 kubectl=1.23.6-00
#设置开机启动
systemctl enable kubelet
```

##### 8.在master上执行init操作

```sh
kubeadm init \
  --apiserver-advertise-address=192.168.91.132 \
  --image-repository registry.aliyuncs.com/google_containers \
  --kubernetes-version v1.23.6 \
  --service-cidr=10.96.0.0/12 \
  --pod-network-cidr=10.244.0.0/16 
```

- –apiserver-advertise-address 集群通告地址
- –image-repository 由于默认拉取镜像地址[http://k8s.gcr.io](https://link.zhihu.com/?target=http%3A//k8s.gcr.io)国内无法访问，这里指定阿里云镜像仓库地址
- –kubernetes-version K8s版本，与上面安装的一致
- –service-cidr 集群内部虚拟网络，Pod统一访问入口
- –pod-network-cidr Pod网络

##### 9.在master执行

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes
```

##### 10.安装CNI插件

```sh
#下载文件
wget https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml

#安装
kubectl apply -f kube-flannel.yml 

#查看进度
kubectl get pods -n kube-system
```

##### 11.在node中加入Kubernetes Node

```sh
#在node节点中执行,加入master中
kubeadm join 192.168.91.132:6443 --token bbq3i4.gqu935s1ev9eel1f \
        --discovery-token-ca-cert-hash sha256:61c643ec43d37382077954355bdb4aeb0aaf03648c8100e9649942b87679fc51
        
#如果令牌过期了，重新 获取令牌。（在 master 服务器中 执行）
kubeadm token create --print-join-command
```

