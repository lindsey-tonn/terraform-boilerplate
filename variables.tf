# AWS Config
variable "aws_region" {
  default = "us-east-1"
}

variable "aws_s3_bucket_name" {
  default     = "fake-template-bucket"
  description = "the name of bucket"
}

variable "aws_s3_acl" {
  default     = "public-read"
  description = "the acl of bucket"
}

variable "aws_s3_enable_versioning" {
  description = "enable bucket versioning"
  default     = "false"
}

variable "aws_s3_bucket_tags" {
  description = "tags of bucket"
  default     = {}
}

# NETWORK
variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  description = "the vpc range"
}

variable "public_subnet_cidr" {
  default     = "10.20.0.0/24"
  description = "the range of subnet public"
}

variable "private_subnet_cidr" {
  default     = "10.20.1.0/24"
  description = "the range of subnet private"
}

#APP Configuration
variable "app_image" {
  description = "Docker image to run in the ECS cluster"
  default     = "lindseytonn/app-nginx:1.0.0"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  default     = 80
}

variable "app_count" {
  description = "Number of docker containers to run"
  default     = 1
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = "256"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = "512"
}
