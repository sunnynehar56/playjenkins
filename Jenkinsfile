pipeline {
    agent any
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
                script {
                    docker.withRegistry('https://registry-1docker.io', 'nexus-login') {
                        // nexus login should be given in the jenkins credentials with same name 'nexus-login'
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'myweb.yaml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}
