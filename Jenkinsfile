pipeline {
    agent {
      kubernetes {
      //cloud 'kubernetes'
        //label 'mypod'
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
  - name: kubectl
    image: lachlanevenson/k8s-kubectl
    command: ['cat']
    tty: true
  volumes:
  - name: dockersock
    hostPath:
      path: /var/run/docker.sock
"""
      }
    }
    environment {
        DOCKER_IMAGE_NAME = "docker-registry:1.3"
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
    }
}
