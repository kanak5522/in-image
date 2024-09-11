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
    lsb-release && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-get update && apt-get install -y software-properties-common curl unzip gnupg lsb-release
    apt-add-repository "deb https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt-get update && \
    apt-get install -y terraform && \
    curl -fsSL https://get.docker.com | sh

# Set up Docker
RUN usermod -aG docker root

# Set working directory
WORKDIR /workspace

# Define entrypoint
ENTRYPOINT ["/bin/bash"]
