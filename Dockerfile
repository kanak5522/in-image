# Use an official Ubuntu as a parent image
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and Terraform
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    gnupg \
    lsb-release \
    software-properties-common && \
    # Add HashiCorp GPG key
    curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    # Add HashiCorp repository
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    # Install Terraform
    apt-get install -y terraform && \
    # Install Docker
    curl -fsSL https://get.docker.com | sh

# Set up Docker
RUN usermod -aG docker root

# Set working directory
WORKDIR /workspace

# Define entrypoint
ENTRYPOINT ["/bin/bash"]

