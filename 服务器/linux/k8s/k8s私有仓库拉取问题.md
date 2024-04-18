## k8s私有仓库拉取问题

##### 1.加入secret资源，名称: secret-harbor-registry (`-n`很重要,要在同一个命名空间内)

```sh
kubectl create secret docker-registry secret-harbor-registry \
  --docker-email="liguofeng-java@qq.com" \
  --docker-username="admin" \
  --docker-password="lbf123" \
  --docker-server="192.168.0.50:80" -n pig
```

##### 2.在yaml中指定名称: secret-harbor-registry

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  namespace: pig
  labels:
    app: pig-register
  name: pig-register
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pig-register
  template:
    metadata:
      labels:
        app: pig-register
    spec:
      # 很重要
      imagePullSecrets:
        - name: secret-harbor-registry
      containers:
        - name: pig-register
          image: '192.168.0.50:80/pig/pig-register:v1.0'
```

