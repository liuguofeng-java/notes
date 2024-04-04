## k8s使用yaml创建资源

##### 1命名空间

>  **NameSpace（命名空间）**：用来对集群资源进行划分；默认只隔离资源，不隔离网络。 （-n）
>
>  创建文件hello.yaml
>
>  ```yaml
>  # 版本号
>  apiVersion: v1
>  # 类型
>  kind: Namespace
>  # 元数据
>  metadata:
>  # Namespace（命名空间） 的 名称
>  name: hello
>  ```

```sh
# 部署
kubectl apply -f hello-yaml.yaml
# 查看命名空间
kubectl get ns
# 把对应的yaml资源删除掉
kubectl delete -f hello.yaml
```

##### 2.Pod

> **Pod**：运行的一组容器，是 kubernetes 找那个应用的最小单位。（工作负载）
>
> 创建文件nginx-test.yaml
>
> ```yaml
> apiVersion: v1
> kind: Pod
> metadata:
>   labels:
>     run: nginx-test
>   # Pod 的 名字  
>   name: nginx-test
>   # 指定命名空间 （不写是 默认 default）
>   namespace: default
> spec:
>   containers:
>   # 多个 容器，多个 - 
>   - image: nginx
>     # 容器的名字
>     name: nginx-test
> ```
>
> 

```sh
# 将上述内容 粘贴进来
kubectl apply -f nginx-test.yaml

kubectl describe pod nginx-test

# 配置文件创建的资源 用配置文件 删
kubectl delete -f nginx-test.yaml

# 进入pod中，类似docker exec
kubectl exec -it nginx-test -- /bin/bash
```



