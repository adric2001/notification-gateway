#!/usr/bin/env bash
# ==============================================================================
# Bootstrap Automation Guide (scripts/bootstrap.sh)
# ==============================================================================
# This script automates end-to-end server provisioning:
# 1. Runs Terraform to create the AWS VPC, EC2 instance, and Elastic IP.
# 2. Extracts the public IP output from Terraform.
# 3. Injects that IP into Ansible's inventory.
# 4. Runs Ansible to harden the OS and install Docker & K3s.
#
# Steps to write this script:
#
# 1. Enable bash strict mode:
#    set -euo pipefail
#
# 2. Provision AWS Infrastructure with Terraform:
#    echo "==> Running Terraform Apply..."
#    cd terraform
#    terraform init
#    terraform apply -auto-approve
#
# 3. Retrieve Server Public IP:
#    SERVER_IP=$(terraform output -raw instance_public_ip)
#    echo "==> Provisioned server at: $SERVER_IP"
#    cd ..
#
# 4. Wait for SSH to become ready on the instance:
#    echo "==> Waiting for SSH connectivity..."
#    while ! nc -z -w 5 "$SERVER_IP" 22; do
#        sleep 5
#    done
#
# 5. Execute Ansible Configuration Playbook:
#    echo "==> Running Ansible Playbook..."
#    cd ansible
#    ansible-playbook -i "$SERVER_IP," playbooks/site.yml
#    echo "==> Bootstrap complete! K3s cluster is online."
