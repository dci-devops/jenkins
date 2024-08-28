pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "jenkins"
        DOCKER_TAG = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Build') {
            steps {
                script {
                    echo "Building the Docker image"
                    sh "sudo docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} https://github.com/dci-devops/jenkins.git"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "Logging in to Docker Hub"
                    withCredentials([usernamePassword(credentialsId: "dockerHub", passwordVariable: "dockerHubPass", usernameVariable: "dockerHubUser")]) {
                        sh "echo $dockerHubPass | docker login -u $dockerHubUser --password-stdin"
                    }

                    echo "Pushing image to Docker Hub"
                    sh "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"

                    echo "Pushing latest tag"
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
                    sh "docker push ${DOCKER_IMAGE}:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    echo "Deploying the container"
                    sh "docker compose down && docker compose up -d"
                }
            }
        }
    }
}