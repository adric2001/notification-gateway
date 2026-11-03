# ==============================================================================
# Security Groups & Firewall Guide (terraform/security_groups.tf)
# ==============================================================================
# Security groups act as a virtual firewall for your EC2 instance.
#
# Rules to define inside resource "aws_security_group" "gateway_sg":
#
# 1. Ingress - Port 22 (SSH):
#    - Allows Ansible and you to SSH into the instance.
#    - from_port = 22, to_port = 22, protocol = "tcp"
#    - cidr_blocks = [var.allowed_ssh_ip]
#
# 2. Ingress - Port 80 (HTTP):
#    - Allows Let's Encrypt to verify domain ownership (ACME challenge).
#    - from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"]
#
# 3. Ingress - Port 443 (HTTPS):
#    - Allows incoming webhook curl requests securely over TLS.
#    - from_port = 443, to_port = 443, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"]
#
# 4. Egress - Outbound All (0.0.0.0/0):
#    - IMPORTANT: The notification gateway MUST be able to make outbound requests
#      to https://api.telegram.org to send messages to your phone!
#    - from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"]
