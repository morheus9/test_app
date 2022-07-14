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
                sh 'docker build -t morheus .'
                sh "docker tag morheus:latest morheus/testapp:master_${VERSION}"
                sh "docker push morheus/testapp:master_${VERSION}"
                echo '===================== running images for master ====================='
                sh 'export PORT=4200'
                sh "docker pull morheus/testapp:master_${VERSION}"
                sh 'docker container rm -f master_latest || true'
                sh "docker run -d -p 4200:4200 --name deployment_latest morheus/testapp:master_${VERSION}"
            }
        }

        stage('images for deployment') {
            when {
                branch 'development'
            }
            steps {
                echo '===================== building images for development ====================='
                sh 'docker build -t morheus .'
                sh "docker tag morheus:latest morheus/testapp:deployment_${VERSION}"
                sh "docker push morheus/testapp:deployment_${VERSION}"
                echo '===================== running images for development ====================='
                sh 'export PORT=4201'
                sh "docker pull morheus/testapp:deployment_${VERSION}"
                sh 'docker container rm -f deployment_latest || true'
                sh "docker run -d -p 4201:4201 --name deployment_latest morheus/testapp:deployment_${VERSION}"
            }
        }
        stage('nginx') {
            steps {
                echo '===================== building images for nginx ====================='
                sh 'docker build -t morheus ./nginx'
                sh 'docker tag morheus:latest morheus/testapp:nginx_latest'
                sh 'docker push morheus/testapp:nginx_latest'
                echo '===================== running image of nginx ====================='
                sh 'docker pull morheus/testapp:nginx_latest'
                sh 'docker container rm -f nginx_latest || true'
                sh 'docker run -d -p 80:80 --name nginx_latest morheus/testapp:nginx_latest'
            }
        }
    }
}
