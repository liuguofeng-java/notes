## jenkins调用docker构建

```groovy


pipeline {
    
    agent any

    environment{
        harborUrl = '192.168.1.118:100'
        harborCredentialsId = 'f0c207c2-b70a-489a-a0f9-248a45928857'
        k8sMaster = '192.168.1.118'
    }
    
    stages {
        stage('拉取代码') {
            steps {
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'a71f61a0-1f08-4454-8132-6eb47c0f6bdf', url: 'https://gitee.com/liu_guo_feng/jenkins-pig-ui.git']])
            }
        }
        stage('node版本') {
            agent {
                docker { 
                    image 'node:16'
                    args """-v /home/jenkins/data/workspace/pig-jenkins-ui:/home/project"""
                }
            }
            steps {
                sh """
                node -v 
                npm -v
                cd /home/project
                ls -lh
                
                npm install --registry=https://registry.npmmirror.com/
                npm run build:docker
                """
            }
        }
        
        stage('推送镜像') {
            steps {
                withCredentials([usernamePassword(credentialsId: """${harborCredentialsId}""", usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh """
                    docker login -u ${USERNAME} -p ${PASSWORD} ${harborUrl}
                    docker build -t pig-ui:${version} docker
                    docker tag pig-ui:${version} ${harborUrl}/pig/pig-ui:${version}
                    docker push ${harborUrl}/pig/pig-ui:${version}
                    docker rmi -f pig-ui:${version}
                    docker rmi -f ${harborUrl}/pig/pig-ui:${version}
                    """
                }
            }
        }
        
        stage('运行') {
            steps {
                 sh """
                sed -i 's/\$VERSION/${version}/g' docker/deploy.yaml
                sed -i 's/\$HARBOR_URL/${harborUrl}/g' docker/deploy.yaml
                """
                sshPublisher(publishers: [sshPublisherDesc(configName: """${k8sMaster}""", transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/home/k8s/pig-ui', remoteDirectorySDF: false, removePrefix: 'docker/', sourceFiles: 'docker/deploy.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                sh """
                ssh root@${k8sMaster} kubectl apply -f /home/k8s/pig-ui/deploy.yaml
                """
            }
        }
        
        
    }
}

```

1. `agent`: 这是一个指令，用于指定执行此 Pipeline 的代理。Jenkins 支持多种代理类型，如 `docker`、`kubernetes` 等。
2. `docker`: 这是指定代理类型为 Docker 的子指令。Jenkins 会尝试在 Docker 容器中执行此 Pipeline。
3. `image 'node:16'`: 这是指定要使用的 Docker 镜像。在这个例子中，Jenkins 将使用带有 Node.js v16 的官方 Node.js Docker 镜像。这意味着您的构建将在具有 Node.js v16 的环境中执行。
4. `args """-v /home/jenkins/data/workspace/pig-jenkins-ui:/home/project"""`: 这是传递给 Docker 容器的参数。`-v` 参数用于挂载 Docker 宿主机上的目录到容器内部。具体来说，它将宿主机上的 `/home/jenkins/data/workspace/pig-jenkins-ui` 目录挂载到容器内的 `/home` 目录。这样，容器内的应用可以访问这个目录，并且任何对容器内 `/home/project` 目录的更改都会反映到宿主机上的对应目录。
