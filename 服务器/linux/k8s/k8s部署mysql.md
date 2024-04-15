## k8s部署mysql

##### 1.创建PVC持久卷

```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: mysql-pvc
  namespace: pig
  annotations:
    kubesphere.io/creator: liuguofeng
    kubesphere.io/description: mysql持久卷
spec:
  accessModes:
  	# 读写
    - ReadWriteOnce
  resources:
    requests:
      # 分配10g空间
      storage: 10Gi
  storageClassName: nfs-storage
```

##### 2.常见configMap

```sh
# 创建配置，nginx保存到k8s的etcd；(指定文件方式)
kubectl create cm mysql-conf --from-file=/conf/nginx.conf
# 创建配置，nginx保存到k8s的etcd；(指定一个目录方式)
kubectl create cm mysql-conf --from-file=/conf/
```

**或者**

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: pig
  labels: {}
  name: mysql-conf
  annotations:
    kubesphere.io/description: mysql-conf 配置文件
data:
  # key=文件夹名称
  my.conf: ''
```

##### 3.创建mysql

```yaml
apiVersion: apps/v1
# 有状态服务
kind: StatefulSet
metadata:
  namespace: pig
  labels:
    app: mysql-server
  name: mysql-server
spec:
  serviceName: "mysql"
  replicas: 1
  selector:
    matchLabels:
      app: mysql-server
  template:
    metadata:
      labels:
        app: mysql-server
    spec:
      # 镜像信息
      containers:
        - name: mysql-8
          image: 'mysql:8'
          # 暴露环境变量
          env:
            - name: MYSQL_ROOT_PASSWORD
              value: lbf123
          # 映射卷
          volumeMounts:
            - name: host-time
              mountPath: /etc/localtime
              readOnly: true
            - name: volume-jo0noc
              mountPath: /var/lib/mysql
            - name: volume-8mt2hs
              readOnly: true
              mountPath: '/etc/mysql/conf.d'
      # 挂载卷
      volumes:
      	# 解决容器时间同步问题
        - hostPath:
            path: /etc/localtime
            type: ''
          name: host-time
        # 挂载pvc
        - name: volume-jo0noc
          persistentVolumeClaim:
            claimName: mysql-pvc
        # 挂载配置文件
        - name: volume-8mt2hs
          configMap:
            name: mysql-conf
---
apiVersion: v1
kind: Service
metadata:
  namespace: pig
  labels:
    app: mysql-server
  name: mysql-server
spec:
  selector:
    app: mysql-server
  ports:
    - name: tcp-3306
      protocol: TCP
      port: 3306
      targetPort: 3306
  clusterIP: None
  
---
apiVersion: v1
kind: Service
metadata:
  namespace: pig
  labels:
    app: mysql-server-node
  name: mysql-server-node
spec:
  selector:
    app: mysql-server
  ports:
    - name: tcp-3306
      protocol: TCP
      port: 3306
      targetPort: 3306
      # 指定外部暴露的端口号
      nodePort: 30000
  # 外部暴露
  type: NodePort
```

