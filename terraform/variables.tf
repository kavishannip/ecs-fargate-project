variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "ecs-fargate-app"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 8080
}

variable "app_count" {
  description = "Number of tasks"
  type        = number
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate CPU units"
  type        = string
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate memory in MB"
  type        = string
  default     = "512"
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/health"
}

variable "github_repository" {
  description = "GitHub repository in format: owner/repo-name"
  type        = string
  default     = "kavishannip/ecs-fargate-project"
}