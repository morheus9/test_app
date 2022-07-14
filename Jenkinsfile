#!groovy
/* groovylint-disable DuplicateStringLiteral, LineLength */
//  Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
    agent {
        label 'master'
    }
    environment {
        VERSION = "${env.GIT_COMMIT}-${env.BUILD_ID}"
        IMAGE = "${NAME}:${VERSION}"
    }

    stages {
        stage('docker login') {
            steps {
                echo '===================== docker login ====================='
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh 'docker login -u $USERNAME -p $PASSWORD'
                }
            }
        }

        stage('images for master') {
            steps {
                echo '===================== building images for master ====================='
                sh 'docker build -t test_app .'
                sh "docker tag morheus/test_app:master_${VERSION}"
                sh "docker push morheus/test_app:master_${VERSION}"
                echo '===================== running images for master ====================='
                sh '$export PORT=4200'
                sh "docker pull morheus/test_app:master_${VERSION}"
                sh 'docker container rm -f master_latest || true'
                sh "docker run -d -p 4200:4200 --name deployment_latest morheus/test_app:master_${VERSION}"
            }
        }

        stage('images for deployment') {
            when {
                branch 'development'
            }
            steps {
                echo '===================== building images for development ====================='
                sh 'docker build -t test_app .'
                sh "docker tag ${IMAGE_REPO}/test_app:deployment_${VERSION}"
                sh "docker push ${IMAGE_REPO}/test_app:deployment_${VERSION}"
                echo '===================== running images for development ====================='
                sh '$export PORT=4201'
                sh "docker pull ${IMAGE_REPO}/test_app:deployment_${VERSION}"
                sh 'docker container rm -f deployment_latest || true'
                sh "docker run -d -p 4201:4201 --name deployment_latest ${IMAGE_REPO}/test_app:deployment_${VERSION}"
            }
        }
    }
}
