pipeline {
    agent {
        label 'maven'
    }
    environment {
        DOCKER_IMAGE_NAME = "sunnynehar56/simpleweb"
    }
    stages {
        stage('Checkout Source') {
            when {
                branch 'master'
            }
            steps {
                git 'https://github.com/sunnynehar56/playjenkins.git'
            }
        }    
        stage('Build docker image') {
            when {
                branch 'master'
            }
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
