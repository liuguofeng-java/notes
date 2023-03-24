## jenkins的pipeline构建

如:

```java
pipeline {
    agent any

    stages {
        stage('git拉取') {
            steps {
                git credentialsId: '319b988e-ebfe-4448-a9a9-e9d1c24c4b59', url: 'https://gitee.com/liu_guo_feng/jenkins-demo.git'
            }
        }
        stage('maven构建') {
            steps {
                sh '''
                /home/apache-maven-3.8.6/bin/mvn package
                '''
            }
        }
        stage('删除远程文件') {
            steps {
                sshPublisher(publishers: [sshPublisherDesc(configName: '192.168.130.132',
                transfers: [sshTransfer(cleanRemote: false, excludes: '', 
                execCommand: '''
                cd /home/jenkins
                docker rm -f demo
                docker rmi -f demo:01
                rm -rf *
                ''',
                execTimeout: 120000, flatten: false, makeEmptyDirs: false, 
                noDefaultExcludes: false, patternSeparator: '[, ]+', 
                remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '', sourceFiles: '')],
                usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }

        stage('上传文件并部署') {
            steps {
               sshPublisher(publishers: [sshPublisherDesc(configName: '192.168.130.132',
               transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', 
               execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, 
               patternSeparator: '[, ]+', remoteDirectory: '', remoteDirectorySDF: false, removePrefix: '',
               sourceFiles: 'dockerfile'), sshTransfer(cleanRemote: false, excludes: '', 
               execCommand: '''
                cd /home/jenkins
                docker build -t demo:01 .
                docker run -d --name demo -p 80:9098 demo:01''',
                execTimeout: 120000, flatten: false, makeEmptyDirs: false, 
                noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/',
                remoteDirectorySDF: false, removePrefix: 'target/', sourceFiles: '*/*.jar')], 
                usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
            }
        }
    }
}

```

