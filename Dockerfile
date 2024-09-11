# Use Docker's official Docker-in-Docker base image
FROM docker:20.10-dind

# Install required packages
RUN apk add --no-cache \
    curl \
    unzip \
    bash \
    git

# Install Terraform
ARG TERRAFORM_VERSION="1.4.6"
RUN curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o terraform.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform.zip

# Set environment variables for Docker
ENV DOCKER_HOST=tcp://docker:2375

# Define a default command
CMD ["sh"]
