# ==============================================================================
# Terraform Outputs Guide (terraform/outputs.tf)
# ==============================================================================
# Outputs print values in your terminal after `terraform apply` finishes.
#
# Outputs to declare:
#
# 1. Server Public IP (Elastic IP):
#    output "instance_public_ip" {
#      description = "Static public IP of the gateway server"
#      value       = aws_eip.gateway_eip.public_ip
#    }
#
# 2. Handy SSH Command:
#    output "ssh_command" {
#      description = "SSH command to connect to the server"
#      value       = "ssh -i ~/.ssh/${var.ssh_key_name}.pem ubuntu@${aws_eip.gateway_eip.public_ip}"
#    }
#
# 3. Example Webhook Curl Command:
#    output "sample_curl" {
#      description = "Sample curl command to trigger a test alert"
#      value       = "curl -X POST https://${aws_eip.gateway_eip.public_ip}/notify -H 'Authorization: Bearer <KEY>' -d '{\"message\":\"test\"}'"
#    }
