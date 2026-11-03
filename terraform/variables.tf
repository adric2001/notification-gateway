# ==============================================================================
# Terraform Variables Guide (terraform/variables.tf)
# ==============================================================================
# Input variables let you parameterize your Terraform configuration so you don't
# hardcode regions, IPs, or instance sizes.
#
# Variables to declare when you write this file:
#
# 1. AWS Region:
#    variable "aws_region" {
#      type        = string
#      description = "AWS region for resources"
#      default     = "us-east-1"
#    }
#
# 2. Project Name (used to prefix resource names):
#    variable "project_name" {
#      type        = string
#      description = "Prefix for resource naming"
#      default     = "notification-gateway"
#    }
#
# 3. EC2 Instance Size (t3.micro is AWS free tier, t3.small is great for K3s):
#    variable "instance_type" {
#      type        = string
#      description = "EC2 instance type"
#      default     = "t3.small"
#    }
#
# 4. SSH Key Pair Name (pre-created in AWS EC2 Console):
#    variable "ssh_key_name" {
#      type        = string
#      description = "Name of EC2 Key Pair for SSH access"
#    }
#
# 5. Allowed SSH IP (restrict SSH access to your own IP):
#    variable "allowed_ssh_ip" {
#      type        = string
#      description = "Your IP address in CIDR format (e.g. 1.2.3.4/32) to allow SSH"
#      default     = "0.0.0.0/0"
#    }
