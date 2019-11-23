pipeline {
    agent {
      kubernetes {
      // cloud 'kubernetes'
        //label 'mypod'
        yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: kubectl
    image: lachlanevenson/k8s-kubectl
    command: ['cat']
    tty: true
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
        DOCKER_IMAGE_NAME = "docker-registry:1.2"
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
        stage ('push Docker image to aws ecr') {          
            steps {
                container('docker') {                 
                    script {
                        docker.withRegistry('https://187498025781.dkr.ecr.eu-west-1.amazonaws.com', 'ecr:eu-west-1:awscredentials') {
                        docker.image(DOCKER_IMAGE_NAME).push('1.2')                          
                        }
                    }
                }
            }
        }   
        stage ('Deploy to Staging') {          
            steps {
                container('kubectl') { 
                    script {
                        withKubeConfig([credentialsId: 'k8ssvcaccount', serverUrl: 'https://70B4D06120D06637B6DCA508BCC00B56.sk1.eu-west-1.eks.amazonaws.com', namespace: 'jenkins', clusterName: 'eks-cluster@myeks.eu-west-1.eksctl.io', contextName: 'eks-cluster@myeks.eu-west-1.eksctl.io']) {
                            sh 'kubectl apply -f myweb.yaml'
                        }
                    }
                }
            }
        }           
  
    }
}
