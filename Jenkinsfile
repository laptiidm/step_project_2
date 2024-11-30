pipeline {
  agent any
  stages {
    stage('Pull the code.') {
      steps {
        git(url: 'https://github.com/laptiidm/step_project_2', branch: 'main')
      }
    }

    stage('Build the Docker image on the Jenkins worker.') {
      steps {
        sh 'ls -la'
      }
    }

  }
}