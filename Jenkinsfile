pipeline {
    agent {
        docker {
            image 'my-terraform-docker-image:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock -v /usr/local/bin/docker:/usr/local/bin/docker' // Mount Docker socket and CLI
        }
    }

    environment {
        AWS_REGION = 'eu-west-1'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Define Docker image name and tag
                    def imageName = 'my-terraform-docker-image'
                    def imageTag = 'latest'

                    // Build Docker image inside Docker container
                    sh "docker build -t ${imageName}:${imageTag} ."

                    // Optionally push to a Docker registry
                    withCredentials([usernamePassword(credentialsId: 'kanakdocker', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'echo $DOCKER_PASSWORD | docker login my-docker-registry -u $DOCKER_USERNAME --password-stdin'
                        sh "docker tag ${imageName}:${imageTag} my-docker-registry/${imageName}:${imageTag}"
                        sh "docker push my-docker-registry/${imageName}:${imageTag}"
                    }
                }
            }
        }

        stage('Deploy with Terraform') {
            steps {
                script {
                    // Define Docker image name and tag for deployment
                    def imageName = 'my-terraform-docker-image'
                    def imageTag = 'latest'

                    // Define AWS credentials
                    withCredentials([aws(credentialsId: 'kanakaws', region: AWS_REGION)]) {
                        // Run Terraform inside the Docker container
                        sh """
                        docker run --rm -v \$(pwd):/workspace -w /workspace my-docker-registry/${imageName}:${imageTag} /bin/bash -c '
                            terraform init &&
                            terraform apply -auto-approve
                        '
                        ""
