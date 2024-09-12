pipeline {
    agent {
        docker {
            image 'my-terraform-docker-image'
            args '--privileged'
        }
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    docker.build('my-terraform-docker-image')
                }
            }
        }
        stage('Deploy with Docker') {
            steps {
                script {
                    // Checkout code
                    checkout scm

                    // Run Terraform commands
                    sh 'terraform init'
                    sh 'terraform plan'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
    post {
        always {
            // Archive Terraform state files
            archiveArtifacts artifacts: '**/terraform.tfstate', allowEmptyArchive: true
        }
    }
}
