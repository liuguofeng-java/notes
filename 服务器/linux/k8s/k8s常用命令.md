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

