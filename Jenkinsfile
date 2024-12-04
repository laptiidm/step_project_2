
pipeline {
    agent { label 'step_2_label' } // агент Jenkins
    environment {
        IMAGE_NAME = "step_project_2:latest"  // лок. назва Docker-образу
        DOCKER_REPO = "admindl/step_project_2" // репо Docker Hub
    }
    stages {
        stage('Pull Code') {
            steps {
                // забираємо код з репозиторію
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/main']],
                          userRemoteConfigs: [[url: 'https://github.com/laptiidm/step_project_2.git']]])
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // білд 
                    sh '''
                    docker build -t $IMAGE_NAME .
                    '''
                }
            }
        }
        stage('Run Tests') {
            steps {
                script {
                    // запускаємо контейнер для тестів
                    sh '''
                    docker run --rm $IMAGE_NAME npm run test
                    '''
                }
            }
        }
        stage('Push to Docker Hub') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                script {
                    withCredentials([string(credentialsId: 'docker-hub-credentials-id', variable: 'DOCKER_PASSWORD')]) {
                        sh '''
                        echo $DOCKER_PASSWORD | docker login --username admindl --password-stdin
                        docker tag $IMAGE_NAME $DOCKER_REPO:latest
                        docker push $DOCKER_REPO:latest
                        '''
                    }
                }
            }
        }
    }
    post {
        always {
            // чистка після запуску
            echo 'Cleaning up...'
            sh 'docker system prune -f || true'
        }
        success {
            echo 'Build, tests, and push to Docker Hub completed successfully!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
