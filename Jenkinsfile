pipeline {
  agent { label 'master' }
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('profan97-dockerhub')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t profan97/testoms .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push profan97/testoms'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
