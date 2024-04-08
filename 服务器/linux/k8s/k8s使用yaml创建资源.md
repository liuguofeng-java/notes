## k8s使用yaml创建资源

```sh
# 部署
kubectl apply -f hello-yaml.yaml
# 查看命名空间
kubectl get ns
# 把对应的yaml资源删除掉
kubectl delete -f hello.yaml
```

##### 1命名空间

>  **NameSpace（命名空间）**：用来对集群资源进行划分；默认只隔离资源，不隔离网络。 （-n）

```yaml
# 版本号
apiVersion: v1
# 类型
kind: Namespace
# 元数据
metadata:
 # Namespace（命名空间） 的 名称
 name: hello
```

##### 2.Pod

> **Pod**：运行的一组容器，是 kubernetes 找那个应用的最小单位。（工作负载）

```yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: mynginx
  # Pod 的 名字  
  name: mynginx
  # 指定命名空间 （不写是 默认 default）
  namespace: default
spec:
  containers:
  # 多个 容器，多个 - 
  - image: nginx
    # 容器的名字
    name: mynginx
```

##### 3.Deployment

> **Deployment**：控制 Pod，使 Pod 拥有多副本、自愈、扩缩容 等能力。（工作负载）

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: mynginx
  name: mynginx
spec:
  # 创建3个副本
  replicas: 3
  selector:
    matchLabels:
      app: mynginx
  template:
    metadata:
      labels:
        app: mynginx
    spec:
      containers:
      - image: nginx
        name: mynginx
```

##### 4.Service

> **Service**：Pod 的服务发现 与 负载均衡；将一组 Pods 公开为 网络服务的抽象方法。（服务）

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    k8s-app: mynginx
  name: mynginx
spec:
  selector:
    app: mynginx
  ports:
    - port: 8000
      protocal: TCP
      targetPort: 80
  # ClusterIP=只能集群内部访问（不写默认 ClusterIP）,NodePort=集群外部也可以访问
  type: NodePort
```

