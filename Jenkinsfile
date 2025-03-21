pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
        git 'https://github.com/heavyeste/jenkins_test'
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'npm install'
      }
    }

    stage('Build Angular Application') {
      steps {
        sh 'ng build --prod'
      }
    }

    stage('Build Docker Image') {
      steps {
        sh 'docker build -t 192.168.20.20:5000/jenkins01:0.0.1 .'
      }
    }

    stage('Push Docker Image') {
      steps {
        withCredentials(bindings: [usernamePassword(credentialsId: 'docker_private', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
          sh 'docker push 192.168.20.20:5000/jenkins01:0.0.1'
        }

      }
    }

  }
}