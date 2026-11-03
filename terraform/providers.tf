# ==============================================================================
# Terraform Providers Guide (terraform/providers.tf)
# ==============================================================================
# Providers are plugins Terraform downloads to communicate with cloud platforms like AWS.
#
# Steps to write this file:
#
# 1. Lock down the required Terraform version and AWS provider version:
#    terraform {
#      required_version = ">= 1.5.0"
#      required_providers {
#        aws = {
#          source  = "hashicorp/aws"
#          version = "~> 5.0"
#        }
#      }
#    }
#
# 2. Configure the AWS Provider block with your target region:
#    provider "aws" {
#      region = var.aws_region
#
#      # Optional: Add default tags applied to every AWS resource automatically
#      default_tags {
#        tags = {
#          Project = "notification-gateway"
#        }
#      }
#    }
