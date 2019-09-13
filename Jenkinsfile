pipeline {
    agent {
    kubernetes {
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: some-label-value
spec:
  containers:
  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
"""
    }
  }
    environment {
        DOCKER_IMAGE_NAME = "sunnynehar56/simpleweb"
    }
    stages {       
        stage('Build docker image') {        
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }
        stage ('push Docker image to nexus') {
            when {
                branch 'master'
            }
            steps {
                 sh 'docker login -u ${AWSECRUserName} -p ${AWSECRPassword} https://187498025781.dkr.ecr.eu-west-1.amazonaws.com'
                 sh 'docker tag app 187498025781.dkr.ecr.eu-west-1.amazonaws.com/docker-registry'
                 sh 'docker push 187498025781.dkr.ecr.eu-west-1.amazonaws.com/docker-registry'                                 
            }
        }       
  
    }
}
