pipeline {
    agent any
    
    environment {
        AWS_ACCOUNT_ID = '509399635098'
        AWS_REGION = 'eu-north-1'
        ECR_REPOSITORY = '509399635098.dkr.ecr.eu-north-1.amazonaws.com/loginwebapprepo'
        ECS_CLUSTER = 'CICD-cluster'
        ECS_SERVICE = 'loginwebappService'
        DOCKER_IMAGE = "${ECR_REPOSITORY}:latest"
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/AnkitKarmakarCkers/3TierWebAppNew.git'
            }
        }
        
        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("509399635098.dkr.ecr.eu-north-1.amazonaws.com/loginwebapprepo:latest")
                }
            }
        }
        
        stage('Login to AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                }
            }
        }
        
        stage('Push Image to ECR') {
            steps {
                script {
                    docker.withRegistry("https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com") {
                        docker.image(DOCKER_IMAGE).push()
                    }
                }
            }
        }
        
        stage('Update ECS Service') {
            steps {
                script {
                    sh "aws ecs update-service --cluster ${ECS_CLUSTER} --service ${ECS_SERVICE} --force-new-deployment --region ${AWS_REGION}"
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
