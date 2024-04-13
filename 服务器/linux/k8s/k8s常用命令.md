## k8s常用命令

##### 1.查看节点

```sh
# 查看 全部节点信息
kubectl get nodes
```

##### 2.命名空间（增删改查）

> **NameSpace（命名空间）**：用来对集群资源进行划分；默认只隔离资源，不隔离网络。 （-n）

```sh
# 查看所有命名空间
kubectl get ns
# 创建命名空间
kubectl create ns xxx
# 删除命名空间
kubectl delete ns xxx
```

##### 3.Pod

> **Pod**：运行的一组容器，是 kubernetes 找那个应用的最小单位。（工作负载）

```sh
# 查看 部署全部的pod 默认查看default,-A:查看全部,-w:堵塞查看类似tail -f
kubectl get pods -A -w
# 查看 每个 Pod 分配的 IP，IP 范围 在下图配置的
kubectl get pod -owide
# nginx-test 是自定义的名称，nginx 镜像; 默认到 default 命名空间
kubectl run nginx-test --image=nginx
# STATUS 是 ContainerCreating 的，查看进度（Events 属性）
kubectl describe pod nginx-test
# 删除 Pod（默认的命名空间），kubectl delete pod mynginx-k8s -n 命名空间  （非默认命名空间）
kubectl delete pod nginx-test -n default
# 查看容器日志，-f:堵塞查看类似tail -f
kubectl logs nginx-test -f
```

##### 4.Deployment

> **Deployment**：控 Pod，使 Pod 拥有多副本、自愈、扩缩容 等能力。（工作负载）

```sh
# 查看 deployment 创建的资源
kubectl get deploy
# 查看 deployment 创建时的yaml文件内容
kubectl get deploy -oyaml
# 创建一个deployment资源
kubectl create deployment mynginx --image=nginx
# 删除 deployment 创建的资源
kubectl delete deploy mynginx
# --replicas=3，部署 3个 Pod mynginx
kubectl create deployment mynginx --image=nginx --replicas=3
# 扩缩容或者使用: `kubectl edit deploy mynginx` 命令
kubectl scale deploy/mynginx --replicas=5
# 改变 mynginx 中 nginx 的版本 （最新 -> 1.16.1）   --record 在 rollout histroy 中记录
kubectl set image deployment/mynginx nginx=nginx:1.16.1 --record
# 查看历史记录
kubectl rollout history deploy/mynginx
# 查看某个版本的详情
kubectl rollout history deploy/mynginx --revision=5
# 回退某个版本
kubectl rollout undo deploy/mynginx --to-revision=1
```

##### 5.Service

> **Service**：Pod 的服务发现 与 负载均衡；将一组 Pods 公开为 网络服务的抽象方法。（服务）

```sh
# 域名：默认是 service 名称 注意只能在pod内访问,例如: curl myngix:8000
# kubectl expose 暴露端口，只能在集群内部 ClusterIP 访问。--type=ClusterIP 不传默认就是 ClusterP，target-port 目标端口（源端口） 
kubectl expose deploy myngix --port=8000 --target-port=80
# 只能集群内部访问（--type不写 默认 ClusterIP）
kubectl expose deploy mynginx --port=8000 --target-port=80 --type=ClusterIP
# 集群外部也可以访问
kubectl expose deploy mynginx --port=8000 --target-port=80 --type=NodePort
# 获取服务
kubectl get service
# 删除服务
kubectl delete svc mynginx
```

##### 6.ConfigMap

> **ConfigMap**：抽取应用配置，并且可以自动更新。挂载配置文件， PV 和 PVC 是挂载目录的。

```sh
vi redis.conf
# 写
appendonly yes

# 创建配置，nginx保存到k8s的etcd；(指定文件方式)
kubectl create cm nginx-conf --from-file=/nginx/conf/nginx.conf
# 创建配置，nginx保存到k8s的etcd；(指定一个目录方式)
kubectl create cm nginx-conf --from-file=/nginx/conf/
# 查看
kubectl get cm
# 查看配置文件具体内容
kubectl get cm redis-conf -oyaml
```

**使用创建好的configMap**

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx-pv-demo
  name: nginx-pv-demo
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nginx-pv-demo
  template:
    metadata:
      labels:
        app: nginx-pv-demo
    spec:
      containers:
      - image: nginx:1.19.0
        name: nginx
        volumeMounts:
        - name: conf
          mountPath: /usr/share/nginx/conf # 挂载目录
      volumes:
        # 和 volumeMounts.name 一样
        - name: conf
      	configMap:
      	  # 创建 configMap 名字(kubectl create cm nginx-conf --from-file=/nginx/conf/nginx.conf)
          name: nginx-conf
          # 当前item内容可以省略,省略后就按照kubectl get cm redis-conf -oyaml内容key value创建
          items:
            #使用kubectl get cm redis-conf -oyaml查看中的key
            - key: nginx.conf
            # 映射到pod内部文件吗
              path: nginx.conf
```

##### 8.StatefulSet

> **StatefulSet** 是用来管理有状态的应用。一般用于管理数据库、缓存等。



```sh
kubectl get statefulset
kubectl create statefulset myredis --image=redis
kubectl delete statefulset myredis
```

