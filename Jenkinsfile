pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    def imageName = 'my-terraform-docker-image'
                    def imageTag = 'latest'
                    
                    sh "docker build -t ${imageName}:${imageTag} ."
                    
                    // Optionally push to a Docker registry
                    sh "docker tag ${imageName}:${imageTag} my-docker-registry/${imageName}:${imageTag}"
                    sh "docker push my-docker-registry/${imageName}:${imageTag}"
                }
            }
        }

        stage('Deploy with Terraform') {
            steps {
                script {
                    // Define your AWS region
                    def awsRegion = 'eu-west-1'
                    
                    // Configure AWS credentials (ensure they are set in Jenkins credentials)
                    withCredentials([aws(credentialsId: 'kanakaws', region: awsRegion)]) {
                        // Pull the Docker image
                        sh "docker pull my-terraform-docker-image:latest"

                        // Run Terraform inside the Docker container
                        sh """
                        docker run --rm -v \$(pwd):/workspace -w /workspace my-terraform-docker-image:latest /bin/bash -c "
                            terraform init &&
                            terraform apply -auto-approve
                        "
                        """
                    }
                }
            }
        }
    }
}
