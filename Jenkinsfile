pipeline {
    agent {
    kubernetes {
      //cloud 'kubernetes'
      label 'mypod'
      yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: docker
    image: docker:1.11
    command: ['cat']
    tty: true
    volumeMounts:
    - name: dockersock
      mountPath: /var/run/docker.sock
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
    }
  }
    environment {
        DOCKER_IMAGE_NAME = "sunnynehar56/simpleweb"
    }
    stages {       
        stage('Build docker image') {        
            steps {
                container('docker') {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
               }
            }
        }
        stage ('push Docker image to nexus') {          
            steps {
                container('docker') {
                 sh 'docker login -u ${AWSECRUserName} -p ${AWSECRPassword} https://187498025781.dkr.ecr.eu-west-1.amazonaws.com'
                 sh 'docker tag app 187498025781.dkr.ecr.eu-west-1.amazonaws.com/docker-registry'
                 sh 'docker push 187498025781.dkr.ecr.eu-west-1.amazonaws.com/docker-registry' 
                }
            }
        }       
  
    }
}
