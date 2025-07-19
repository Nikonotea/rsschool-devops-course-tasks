pipeline {
    triggers {
        pollSCM('H/1 * * * *')
    }

    agent {
        kubernetes {
            yaml """
            apiVersion: v1
            kind: Pod
            spec:
              containers:
                - name: jnlp
                  image: jenkins/inbound-agent:latest

                - name: python
                  image: python:3.13
                  command: ["cat"]
                  tty: true

                - name: docker
                  image: docker:28
                  command: ["cat"]
                  tty: true
                  volumeMounts:
                    - name: docker-sock
                      mountPath: /var/run/docker.sock
              volumes:
                - name: docker-sock
                  hostPath:
                    path: /var/run/docker.sock
                    type: Socket
            """
        }
    }

    stages {
         stage('Checkout') {
            steps {
                git(
                    url: 'https://github.com/Nikonotea/rsschool-devops-course-tasks.git',
                    branch: 'task_6',
                    credentialsId: 'github-creds'
                )
            }
        }

        stage('Build App') {
            steps {
                container('python') {
                    sh 'pip install -r flask_app/requirements.txt --break-system-packages'
                }
            }
        }

        stage('Test Application') {
            steps {
                container('python') {
		            dir('flask_app') {
                        sh 'pytest test_application.py'
	                }
                }
            }
        }

        stage('Security check with SonarCloud') {
            steps {
                container('python') {
                    withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                        sh '''
                            apt-get update -qq && apt-get install -y --no-install-recommends unzip wget openjdk-17-jre-headless
                            wget -q https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip
                            unzip -q sonar-scanner-cli-*.zip
                            mv sonar-scanner-5.0.1.3006-linux sonar-scanner
                            export PATH=$PWD/sonar-scanner/bin:$PATH
                            sonar-scanner \
                                -Dsonar.projectKey=mykola_rsschool-devops-course-tasks \
                                -Dsonar.organization=mykola \
                                -Dsonar.sources=flask_app \
                                -Dsonar.host.url=https://sonarcloud.io \
                                -Dsonar.login=$SONAR_TOKEN
                        '''
                    }
                }
            }
        }

        stage('Docker build and push to Docker Hub') {
            steps {
                container('docker') {
                    dir('flask_app') {
                        script {
                            def dockerhub_username = 'nmykola'
                            def image_name = 'rsschool-flask-app'
                            def image_tag = "${BUILD_NUMBER}" //
                            def full_image = "${dockerhub_username}/${image_name}:${image_tag}"

                            sh "docker build -t ${full_image} ."
                            sh "docker tag ${full_image} ${dockerhub_username}/${image_name}:latest"
                            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials',
                                                            usernameVariable: 'DOCKER_USERNAME',
                                                            passwordVariable: 'DOCKER_PASSWORD')]) {
                                sh "echo \$DOCKER_PASSWORD | docker login --username \$DOCKER_USERNAME --password-stdin"
                            }

                            sh "docker push ${full_image}"
                            sh "docker push ${dockerhub_username}/${image_name}:latest"
                        }
                    }
                }
            }
        }

        stage('Install Helm') {
            steps {
                sh '''
                curl -LO https://get.helm.sh/helm-v3.18.4-linux-amd64.tar.gz
                tar -zxvf helm-v3.18.4-linux-amd64.tar.gz
                mv linux-amd64/helm ./helm
                chmod +x ./helm
                '''
            }
        }

        stage('Deploy App to minikube from Docker Hub') {
            steps {
                sh """
                    ./helm upgrade --install flask-app ./helm_charts/flask-app \
                        --namespace jenkins \
                        --set image.repository=nmykola/rsschool-flask-app \
                        --set image.tag=\${BUILD_NUMBER} \
                        --set image.pullPolicy=IfNotPresent
                        --set serviceAccount.create=false
                """
            }
        }
        stage('Verify App') {
            steps {
                sh 'curl -v http://flask-app.jenkins.svc.cluster.local:8080/'
            }
        }
    }
    post {
        success {
            script {
                withCredentials([
                    string(credentialsId: 'TELEGRAM_BOT_TOKEN', variable: 'BOT_TOKEN'),
                    string(credentialsId: 'TELEGRAM_CHAT_ID', variable: 'CHAT_ID')
                ]) {
                    sh """
                        curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
                            -d chat_id=${CHAT_ID} \
                            -d text="[SUCCESS] The application has been deployed successfully!"
                    """
                }
            }
        }

        failure {
            script {
                withCredentials([
                    string(credentialsId: 'TELEGRAM_BOT_TOKEN', variable: 'BOT_TOKEN'),
                    string(credentialsId: 'TELEGRAM_CHAT_ID', variable: 'CHAT_ID')
                ]) {
                    sh """
                        curl -s -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" \
                            -d chat_id=${CHAT_ID} \
                            -d text="[ERROR] Deployment of the application failed!"
                    """
                }
            }
        }
    }
}