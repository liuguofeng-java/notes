## docker rabbitmq 设置 consumer_timeout

#### 一.暂时修改

1. 在 Docker 容器中运行 RabbitMQ。可以使用以下命令运行 RabbitMQ 容器：`docker run -d --hostname my-rabbit --name some-rabbit rabbitmq:3-management`。
2. 进入 RabbitMQ 容器。您可以使用以下命令进入 RabbitMQ 容器：`docker exec -it some-rabbit bash`。
3. 在 RabbitMQ 容器中设置 consumer_timeout。您可以使用以下命令动态修改 consumer_timeout：`rabbitmqctl eval 'application:set_env (rabbit,consumer_timeout,720000).'`。修改后，您可以使用以下命令验证 consumer_timeout 是否已更改：`rabbitmqctl eval 'application:get_env (rabbit,consumer_timeout).'`。

#### 二.永久修改

1. 在宿主机上创建一个 RabbitMQ 配置文件。您可以在宿主机上的 /etc 目录下创建一个文件，/etc/rabbitmq.conf。然后在文件中设置 consumer_timeout = 720000（根据需要来决定）。
2. 将 RabbitMQ 配置文件挂载到 Docker 容器中。您可以使用以下命令运行 RabbitMQ 容器，并将宿主机上的 RabbitMQ 配置文件挂载到容器中：`docker run -d --hostname my-rabbit --name some-rabbit -v /etc/rabbitmq.conf:/etc/rabbitmq/rabbitmq.conf rabbitmq:3-management`。
3. 重新启动 RabbitMQ 容器。您可以使用以下命令重新启动 RabbitMQ 容器：`docker restart some-rabbit`。