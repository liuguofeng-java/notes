## k8s常用命令

##### 1.查看节点

```sh
# 查看 全部节点信息
kubectl get nodes
```

##### 2.命名空间（增删改查）

> **NameSpace（命名空间）**：用来对集群资源进行划分；默认只隔离资源，不隔离网络。 （-n）

###### 2.1使用命令创建命名空间

```sh
# 查看所有命名空间
kubectl get ns
# 创建命名空间
kubectl create ns xxx
# 删除命名空间
kubectl delete ns xxx
```

###### 2.2使用yaml创建命名空间

>  创建文件hello.yaml
>
> ```yaml
> # 版本号
> apiVersion: v1
> # 类型
> kind: Namespace
> # 元数据
> metadata:
>    # Namespace（命名空间） 的 名称
>    name: hello
> ```

```sh
# 部署
kubectl apply -f hello-yaml.yaml
# 查看命名空间
kubectl get ns
# 把对应的yaml资源删除掉
kubectl delete -f hello.yaml
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
```

