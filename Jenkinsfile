pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'your-image-name' // Replace with your desired Docker image name
        DOCKER_TAG = 'latest' // Tag for the image (can use a version number or commit hash)
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                git branch: 'main', url: 'https://github.com/ShanukaLakshan/devops-automation.git' // Replace with your repository URL
            }
        }

        stage('Build') {
            steps {
                // Run Maven to build the project
                script {
                    sh 'mvn clean package -DskipTests' // Skip tests if desired
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_TAG} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub (or any other registry)
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                    }

                    // Push the image to the Docker registry
                    sh "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo 'Build and Docker image creation successful!'
        }
        failure {
            echo 'Build or Docker image creation failed!'
        }
    }
}
