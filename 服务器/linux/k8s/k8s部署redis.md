## k8s部署redis

##### 1.创建redis

```yaml
apiVersion: apps/v1
# 有状态服务
kind: StatefulSet
metadata:
  namespace: pig
  labels:
    app: redis-server
  name: redis-server
spec:
  serviceName: "redis"
  replicas: 1
  selector:
    matchLabels:
      app: redis-server
  template:
    metadata:
      labels:
        app: redis-server
    spec:
      # 镜像信息
      containers:
        - name: redis
          image: 'redis:7.2.4'
          # 容器启动时执行的命令
          command: ['redis-server']
          # 容器启动时执行的命令的产生
          args: ['/etc/redis/redis.conf']
          # 映射卷
          volumeMounts:
            - name: host-time
              mountPath: /etc/localtime
              readOnly: true
            - name: volume-redis-conf
              readOnly: true
              mountPath: '/etc/redis'
            - name: volume-data
              mountPath: /data
      # 挂载卷
      volumes:
        - hostPath:
            path: /etc/localtime
            type: ''
          name: host-time
        # 挂载配置文件
        - name: volume-redis-conf
          configMap:
            name: redis-conf
         # 挂载pvc
        - name: volume-data
          persistentVolumeClaim:
            claimName: redis-pvc
---

apiVersion: v1
kind: ConfigMap
metadata:
  namespace: pig
  labels: {}
  name: redis-conf
  annotations:
    kubesphere.io/description: redis-conf 配置文件
data:
  # key=文件夹名称
  redis.conf: |
    bind 0.0.0.0
    protected-mode no
    requirepass 123456
---

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: redis-pvc
  namespace: pig
  annotations:
    kubesphere.io/creator: liuguofeng
    kubesphere.io/description: redis持久卷
spec:
  accessModes:
    # 读写
    - ReadWriteOnce
  resources:
    requests:
      # 分配2g空间
      storage: 2Gi
  storageClassName: nfs-storage
```

##### 2.开放端口

```yaml
apiVersion: v1
kind: Service
metadata:
  namespace: pig
  labels:
    app: redis-server
  name: redis-server
spec:
  selector:
    app: redis-server
  ports:
    - name: tcp-6379
      protocol: TCP
      port: 6379
      targetPort: 6379
  clusterIP: None

---
apiVersion: v1
kind: Service
metadata:
  namespace: pig
  labels:
    app: redis-server-node
  name: redis-server-node
spec:
  selector:
    app: redis-server
  ports:
    - name: tcp-6379
      protocol: TCP
      port: 6379
      targetPort: 6379
      # 指定外部暴露的端口号
      nodePort: 30001
  # 外部暴露
  type: NodePort

```

