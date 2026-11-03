# ==============================================================================
# EC2 Compute & Elastic IP Guide (terraform/ec2.tf)
# ==============================================================================
# This file provisions the virtual machine in AWS and attaches a static public IP.
#
# Resources to declare when you write this file:
#
# 1. data "aws_ami" "ubuntu":
#    - Finds the latest official Ubuntu 22.04 LTS AMI.
#    - most_recent = true
#    - owners = ["099720109477"] (Canonical)
#    - filter for name matching "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
#
# 2. resource "aws_instance" "server":
#    - ami = data.aws_ami.ubuntu.id
#    - instance_type = var.instance_type
#    - key_name = var.ssh_key_name
#    - subnet_id = aws_subnet.public.id
#    - vpc_security_group_ids = [aws_security_group.gateway_sg.id]
#    - iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
#    - root_block_device { volume_size = 25, volume_type = "gp3" }
#
# 3. resource "aws_eip" "gateway_eip":
#    - An Elastic IP gives you a permanent, static public IPv4 address that does
#      not change when the instance restarts (crucial for pointing your DNS record).
#    - instance = aws_instance.server.id
#    - domain = "vpc"
