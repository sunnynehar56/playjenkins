pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "sunnynehar56/simpleweb"
    }
    stages{
        stage('Build docker image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker_image = docker.build(DOCKER_IMAGE_NAME)
                    docker_image.inside {
                        //we are running a small test to check if everything working fine.
                        sh 'echo Hello,world'
                    }
                }
            }
        }
        stage ('push Docker image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        docker_image.push("${env.BUILD_NUMBER}")
                        docker_image.push("latest")
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
