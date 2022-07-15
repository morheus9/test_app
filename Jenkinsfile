#!groovy
/* groovylint-disable DuplicateStringLiteral, LineLength */
//  Check ub1 properties
properties([disableConcurrentBuilds()])

pipeline {
    agent {
        label 'master'
    }
    environment {
        VERSION = "${env.GIT_COMMIT}_${env.BUILD_ID}"
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
            when {
                branch 'master'
            }
            steps {
                echo '===================== building images for master ====================='
                sh "docker build -t morheus/testapp:master_${VERSION} ."
                sh "docker push morheus/testapp:master_${VERSION}"
                echo '===================== running images for master ====================='
                sh "docker pull morheus/testapp:master_${VERSION}"
                sh 'docker container rm -f master_latest || true'
                sh "docker run -d -p 4200:4200 -e PORT=4200 -v const_directory:/usr/src/app --name master_latest morheus/testapp:master_${VERSION}"
            }
        }

        stage('images for development') {
            when {
                branch 'development'
            }
            steps {
                echo '===================== building images for development ====================='
                sh "docker build -t morheus/testapp:deployment_${VERSION} ."
                sh "docker push morheus/testapp:deployment_${VERSION}"
                echo '===================== running images for development ====================='
                sh "docker pull morheus/testapp:deployment_${VERSION}"
                sh 'docker container rm -f deployment_latest || true'
                sh "docker run -d -p 4201:4201 -e PORT=4201 -v const_directory:/usr/src/app --name deployment_latest morheus/testapp:deployment_${VERSION}"
            }
        }
        stage('nginx') {
            steps {
                echo '===================== building images for nginx ====================='
                sh 'docker build -t morheus/testapp:nginx_latest ./nginx'
                sh 'docker push morheus/testapp:nginx_latest'
                echo '===================== running image of nginx ====================='
                sh 'docker pull morheus/testapp:nginx_latest'
                sh 'docker container rm -f nginx_latest || true'
                sh 'docker run -d -p 80:80 --name nginx_latest morheus/testapp:nginx_latest'
                sh 'docker network create my_net | echo "this network already exist"'
            }
        }
    }
}
