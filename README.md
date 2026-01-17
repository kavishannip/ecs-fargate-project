# ECS Fargate Deployment with Terraform & GitHub Actions

A containerized Node.js application deployed on AWS ECS Fargate with automated CI/CD pipeline.

---

## Overview

This project demonstrates deploying a containerized application to AWS ECS Fargate using:

- **Infrastructure as Code**: Terraform
- **Containerization**: Docker
- **CI/CD**: GitHub Actions with AWS OIDC authentication

---

## Architecture

### AWS Resources

- **VPC**: Custom VPC with 2 public subnets across availability zones
- **ECS Fargate**: Container orchestration (1 task)
- **ECR**: Docker image repository
- **IAM**: Roles with OIDC provider for GitHub Actions
- **Security Groups**: Port 8080 access control
- **CloudWatch Logs**: Application logging

## Prerequisites

- AWS Account with CLI configured
- Terraform v1.5.0+
- GitHub Account
- Git installed

---

## Deployment

### 1. Clone Repository

```bash
git clone https://github.com/kavishannip/ecs-fargate-project.git
cd ecs-fargate-project
```

### 2. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform apply -auto-approve
```

### 3. Configure GitHub Secret

1. Go to repository **Settings** → **Secrets and variables** → **Actions**
2. Add secret:
   - **Name**: `AWS_ROLE_ARN`
   - **Value**: Copy from `terraform output github_actions_role_arn`

### 4. Trigger Deployment

```bash
git add .
git commit -m "Deploy application"
git push origin main
```

GitHub Actions automatically builds, pushes to ECR, and deploys to ECS.

### 5. Access Your Application

Once deployment completes, see the **"How to Test the Application"** section below to get the current public IP and test your endpoints.

---

## How to Test the Application

### Step 1: Get Current Public IP

The ECS task uses a dynamic public IP. Run this command to get the current IP address:

```powershell
# PowerShell
$taskArn = (aws ecs list-tasks --cluster ecs-fargate-app --region ap-south-1 --output json | ConvertFrom-Json).taskArns[0]
$eniId = (aws ecs describe-tasks --cluster ecs-fargate-app --tasks $taskArn --region ap-south-1 --output json | ConvertFrom-Json).tasks[0].attachments[0].details | Where-Object { $_.name -eq 'networkInterfaceId' } | Select-Object -ExpandProperty value
$publicIp = (aws ec2 describe-network-interfaces --network-interface-ids $eniId --region ap-south-1 --output json | ConvertFrom-Json).NetworkInterfaces[0].Association.PublicIp
Write-Host "Application available at: http://${publicIp}:8080"
```

### Step 2: Test the Endpoints

Once you have the public IP, test the application:

**Main Endpoint:**

```bash
curl http://<PUBLIC_IP>:8080
```

Expected response:

```json
{
  "message": "Hello from Kavishan Nipun 22ug1-0704",
  "hostname": "...",
  "platform": "linux",
  "uptime": 123.45,
  "timestamp": "2026-01-17T..."
}
```

**Health Check Endpoint:**

```bash
curl http://<PUBLIC_IP>:8080/health
```

Expected response:

```json
{
  "status": "healthy",
  "timestamp": "2026-01-17T..."
}
```

**Info Endpoint:**

```bash
curl http://<PUBLIC_IP>:8080/info
```

Expected response:

```json
{
  "app": "ECS Fargate Node.js App",
  "version": "1.0.0",
  "environment": "production",
  "container": "..."
}
```

---

## Project Structure

```
ecs-fargate-project/
├── .github/workflows/
│   └── deploy.yml           # CI/CD pipeline
├── app/
│   ├── server.js            # Node.js application
│   ├── package.json         # Dependencies
│   └── Dockerfile           # Container build
├── terraform/
│   ├── main.tf              # Provider configuration
│   ├── vpc.tf               # VPC & networking
│   ├── ecs.tf               # ECS cluster & service
│   ├── ecr.tf               # Container registry
│   ├── iam.tf               # IAM roles & OIDC
│   └── security_groups.tf   # Security rules
└── README.md
```

## Technologies Used

- **Cloud**: AWS (ECS Fargate, ECR, VPC, IAM, CloudWatch)
- **IaC**: Terraform
- **Application**: Node.js, Express
- **Containerization**: Docker
- **CI/CD**: GitHub Actions
- **Authentication**: AWS OIDC

---

## Author

**Kavishan Nipun**  
**Index Number:** 22ug1-0704
CCS3316-Cloud Infrastructure Design
