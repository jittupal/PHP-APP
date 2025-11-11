pipeline {
    agent any

    environment {
        ECR_REPO = '838693051190.dkr.ecr.eu-north-1.amazonaws.com/php-app-web'
        AWS_REGION = 'eu-north-1'
        EC2_IP = '51.21.1.243'
        SSH_KEY = '$HOME/.ssh/php.pem'  // Private key to access EC2
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/jittupal/PHP-APP.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t php-app-web .'
                sh "docker tag php-app-web:latest ${ECR_REPO}:latest"
            }
        }

        stage('Login to ECR') {
            steps {
                sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REPO}"
            }
        }

        stage('Push to ECR') {
            steps {
                sh "docker push ${ECR_REPO}:latest"
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh """
                ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ec2-user@${EC2_IP} \\
                'docker pull ${ECR_REPO}:latest && \\
                 docker stop php-app-web || true && \\
                 docker rm php-app-web || true && \\
                 docker run -d --name php-app-web -p 80:80 ${ECR_REPO}:latest'
                """
            }
        }
    }
}
