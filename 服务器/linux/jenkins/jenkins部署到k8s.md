## jenkins部署到k8s

```groovy
pipeline {
    agent any

    tools {
        maven 'apache-maven-3.9.6'
        jdk 'jdk1.8.0'
    }

    environment{
        harborUrl = '192.168.1.118:100'
    }
    
    stages {
        stage('拉取代码') {
            steps {
               checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'a71f61a0-1f08-4454-8132-6eb47c0f6bdf', url: 'https://gitee.com/liu_guo_feng/jenkins-pig.git']])
                echo '拉取成功'
            }
        }
        stage('编译') {
            steps {
               sh """
                mvn clean
                mvn -DskipTests=true package -P prod
                """
                echo '编译结束'
            }
        }
        stage('打包成docker镜像') {
            parallel {
                
                stage('打包并推送pig-auth') {
                    steps {
                        withCredentials([usernamePassword(credentialsId: 'f0c207c2-b70a-489a-a0f9-248a45928857', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            sh """
                            
                            docker login -u ${USERNAME} -p ${PASSWORD} ${harborUrl}
                            ls
                            docker build -t pig-auth:${version} pig-auth
                            docker tag pig-auth:${version} ${harborUrl}/pig/pig-auth:${version}
                            docker push ${harborUrl}/pig/pig-auth:${version}
                            """
                        }  
                    }
                }
                stage('打包并推送pig-gateway') {
                    steps {
                        withCredentials([usernamePassword(credentialsId: 'f0c207c2-b70a-489a-a0f9-248a45928857', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            sh """
                            
                            docker login -u ${USERNAME} -p ${PASSWORD} ${harborUrl}
                            ls
                            docker build -t pig-gateway:${version} pig-gateway
                            docker tag pig-gateway:${version} ${harborUrl}/pig/pig-gateway:${version}
                            docker push ${harborUrl}/pig/pig-gateway:${version}
                            """
                        }  
                    }
                }
                stage('打包并推送pig-register') {
                    steps {
                        withCredentials([usernamePassword(credentialsId: 'f0c207c2-b70a-489a-a0f9-248a45928857', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            sh """
                            
                            docker login -u ${USERNAME} -p ${PASSWORD} ${harborUrl}
                            ls
                            docker build -t pig-register:${version} pig-register
                            docker tag pig-register:${version} ${harborUrl}/pig/pig-register:${version}
                            docker push ${harborUrl}/pig/pig-register:${version}
                            """
                        }  
                    }
                }
                stage('打包并推送pig-upms-biz') {
                    steps {
                        withCredentials([usernamePassword(credentialsId: 'f0c207c2-b70a-489a-a0f9-248a45928857', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                            sh """
                            
                            docker login -u ${USERNAME} -p ${PASSWORD} ${harborUrl}
                            ls
                            docker build -t pig-upms-biz:${version} pig-upms/pig-upms-biz
                            docker tag pig-upms-biz:${version} ${harborUrl}/pig/pig-upms-biz:${version}
                            docker push ${harborUrl}/pig/pig-upms-biz:${version}
                            """
                        }  
                    }
                }
                
            }
        }
        stage('运行') {
            parallel {
                stage('运行pig-auth') {
                    steps {
                        sh """
                        sed -i 's/\$VERSION/${version}/g' pig-auth/deploy.yaml
                        sed -i 's/\$HARBOR_URL/${harborUrl}/g' pig-auth/deploy.yaml
                        """
                        sshPublisher(publishers: [sshPublisherDesc(configName: '192.168.1.118', transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: 'kubectl apply -f deploy.yaml', execTimeout: 120000, flatten: false, makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/home/k8s', remoteDirectorySDF: false, removePrefix: 'pig-auth/', sourceFiles: 'pig-auth/deploy.yaml')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                    }
                }
            }
            
        }
    }
}

```

