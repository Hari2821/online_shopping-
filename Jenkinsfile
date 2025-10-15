pipeline {
    agent any

    environment {
        IMAGE_NAME = 'hari2821/online-shopping'
        IMAGE_TAG = 'latest'
        DOCKER_CREDENTIALS_ID = 'dockerhub-creds'   // Jenkins DockerHub credentials ID
        SSH_CREDENTIALS_ID = 'ec2-ssh-key'          // Jenkins credential ID for your PEM key
        EC2_IP = '54.235.25.165'                   // EC2 public IP
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'dev', url: 'https://github.com/Hari2821/online_shopping-.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: "${DOCKER_CREDENTIALS_ID}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                        docker logout
                    """
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                script {
                    echo "🚀 Deploying latest Docker image to EC2 (${EC2_IP})..."
                    sshagent (credentials: ["${SSH_CREDENTIALS_ID}"]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ubuntu@${EC2_IP} '
                                sudo docker pull ${IMAGE_NAME}:${IMAGE_TAG} &&
                                sudo docker stop online-shopping || true &&
                                sudo docker rm online-shopping || true &&
                                sudo docker run -d -p 80:80 --name online-shopping ${IMAGE_NAME}:${IMAGE_TAG}
                            '
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Build, push, and deployment completed successfully! 🎉"
        }
        failure {
            echo "❌ Build or deploy failed. Check Jenkins logs for details."
        }
    }
}
