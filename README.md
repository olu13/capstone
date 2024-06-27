# AWS Stateless Web Application

This repository contains the code to build and deploy a stateless web application on AWS using Docker, ECS with Fargate, an Application Load Balancer, and Route 53.

## Prerequisites

- Docker
- AWS CLI
- Terraform

## Steps

### 1. Build and Push Docker Image

- docker build -t my-web-app .
- aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <aws_account_id>.dkr.ecr.<your-region>.amazonaws.com
- aws ecr create-repository --repository-name my-web-app
- docker tag my-web-app:latest <aws_account_id>.dkr.ecr.<your-region>.amazonaws.com/my-web-app:latest
- docker push <aws_account_id>.dkr.ecr.<your-region>.amazonaws.com/my-web-app:latest

### 2. Deploy Infrastructure with Terraform

- terraform init
- terraform apply

### 3. Access the Web Application

- Navigate to http://www.example.com/page1
- Navigate to http://www.example.com/page2

### Cleanup
- terraform destroy




