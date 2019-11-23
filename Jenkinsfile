pipeline {
    agent {
      kubernetes {
        idleMinutes 5
        yamlFile 'build-pod.yaml'
        defaultContainer 'docker'
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
