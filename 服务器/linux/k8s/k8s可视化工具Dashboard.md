## k8s可视化工具Dashboard

##### 1.下载并安装

```sh
# 根据 在线配置文件 创建资源
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.3.1/aio/deploy/recommended.yaml
```

使用`kubectl get pods -A -w`,查看pod，等到pod状态全部`Running`

```sh
root@k8s-master:/home/liuguofeng# kubectl get pods -A -w
NAMESPACE              NAME                                         READY   STATUS              RESTARTS   AGE
kube-flannel           kube-flannel-ds-8q67f                        1/1     Running             2          13h
kube-flannel           kube-flannel-ds-9lbb4                        1/1     Running             2          13h
kube-flannel           kube-flannel-ds-gwwtq                        1/1     Running             2          13h
kube-system            coredns-7f89b7bc75-76clx                     1/1     Running             2          13h
kube-system            coredns-7f89b7bc75-vs64n                     1/1     Running             2          13h
kube-system            etcd-k8s-master                              1/1     Running             2          13h
kube-system            kube-apiserver-k8s-master                    1/1     Running             2          13h
kube-system            kube-controller-manager-k8s-master           1/1     Running             2          13h
kube-system            kube-proxy-gz4td                             1/1     Running             2          13h
kube-system            kube-proxy-tgv5q                             1/1     Running             2          13h
kube-system            kube-proxy-wbq2z                             1/1     Running             2          13h
kube-system            kube-scheduler-k8s-master                    1/1     Running             2          13h
kubernetes-dashboard   dashboard-metrics-scraper-79c5968bdc-mn824   0/1     ContainerCreating   0          8s
kubernetes-dashboard   kubernetes-dashboard-658485d5c7-s86kg        0/1     ContainerCreating   0          8s
kubernetes-dashboard   dashboard-metrics-scraper-79c5968bdc-mn824   1/1     Running             0          27s
kubernetes-dashboard   kubernetes-dashboard-658485d5c7-s86kg        1/1     Running             0          33s
```

##### 2. 设置访问端口（https://节点ip:32504）

```sh
# 修改配置文件 找到 type，将 ClusterIP 改成 NodePort
kubectl edit svc kubernetes-dashboard -n kubernetes-dashboard

# 找到端口，在安全组放行
kubectl get svc -A | grep kubernetes-dashboard
```

![image-20240404111619926](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240404111619926.png)

![image-20240404113005702](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240404113005702.png)

##### 3.创建访问账号(master节点)

```sh
# 创建 dash-usr.yaml，加入下面配置
vi dash-usr.yaml

# 创建访问账号，准备一个yaml文件，加入下面配置
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard
  
# 在 k8s 集群中创建资源
kubectl apply -f dash-usr.yaml

# 获取访问令牌
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"
```

##### 4.如果出现 `你的连接不是专用连接`,在空白处输入`thisisunsafe`并回车

![image-20240416134720137](C:\Users\Administrator\AppData\Roaming\Typora\typora-user-images\image-20240416134720137.png)
