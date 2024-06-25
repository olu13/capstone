# Stateless AWS Web Application

This project demonstrates how to deploy a stateless web application on AWS using ECS with high resilience, security, and fault tolerance.

## Steps

1. **Build and Push Docker Image**
   ```bash
   docker build -t my-web-app .
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <your_account_id>.d
