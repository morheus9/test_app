#!groovy
//  Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
    agent {
            label 'master'
    }
    stages {
        stage('create docker login') {
            steps {
                echo '===================== docker login ====================='
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
              
                }
            }
        }
        stage('create docker image') {
            steps {
                echo '===================== start building image ====================='
                sh 'docker build -t morheus/fastapi:latest . '
            }
        }
        stage('push docker image') {
            steps {
                echo '===================== push building image ====================='
                sh 'docker push morheus/fastapi:latest'
            }
        }
    }
}
