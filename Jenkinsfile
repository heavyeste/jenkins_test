pipeline {
  agent any
  parameters {
        booleanParam(name: 'skip', defaultValue: false, description: 'Set to true to skip the test stage')
    }
  stages {
    stage('Checkout') {
      when { expression { params.skip != true } }
      steps {
        git(url: 'https://github.com/heavyeste/jenkins_test', branch: 'master')
      }
    }

    stage('Install Dependencies') {
       when { expression { params.skip != true } }
      steps {
        sh 'npm install'
      }
    }

    stage('Build Angular Application') {
      //when { expression { params.skip != true } }
      steps {
        sh 'npm run build'
      }
    }

    stage('Build Docker Image') {
      when { expression { params.skip != true } }
      steps {
        sh 'sudo docker build -t 192.168.20.20:5000/jenkins01:0.0.1 .'
      }
    }

    stage('Push Docker Image') {
      when { expression { params.skip != true } }
      steps {
        withCredentials(bindings: [usernamePassword(credentialsId: 'docker_private', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'sudo echo $DOCKER_PASS | sudo docker login 192.168.20.20:5000 -u $DOCKER_USER --password-stdin'
          sh 'sudo docker push 192.168.20.20:5000/jenkins01:0.0.1'
        }

      }
    }

    stage('Deploy') {
      when { expression { params.skip != true } }
      steps {
        withCredentials(bindings: [usernamePassword(credentialsId: 'docker_private', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'sudo echo $DOCKER_PASS | sudo docker login 192.168.20.20:5000 -u $DOCKER_USER --password-stdin'
          sh 'sudo docker push 192.168.20.20:5000/jenkins01:0.0.1'
        }

      }
    }

  }
}
