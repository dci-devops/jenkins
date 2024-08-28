pipeline {
    agent any

    stages {
        stage("Build") {
            steps {
                echo "Building the Docker image"
                sh "docker build -t jenkins ."
            }
        }

        stage("Push to Docker Hub") {
            steps {
                echo "Pushing image to Docker Hub"
                    sh "docker tag jenkins ${env.dockerHubUser}/jenkins:latest"
                    sh "docker push ${env.dockerHubUser}/jenkins:latest"
                }
            }
    }

        stage ("Deploy") {
            steps {
                echo "Deploying the container"
                sh "sudo docker compose down && docker compose up -d"
            }
        }
    }
}