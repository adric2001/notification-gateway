# ==============================================================================
# IAM Permissions & Instance Profile Guide (terraform/iam.tf)
# ==============================================================================
# Best practice: Do NOT put AWS secret keys on the server. Instead, assign an IAM
# Role to the EC2 instance so AWS handles temporary credential rotation automatically.
#
# Resources to declare when you write this file:
#
# 1. resource "aws_iam_role" "ec2_role":
#    - assume_role_policy allowing service "ec2.amazonaws.com" to perform "sts:AssumeRole"
#
# 2. resource "aws_iam_role_policy_attachment" "cloudwatch_policy":
#    - role = aws_iam_role.ec2_role.name
#    - policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
#
# 3. resource "aws_iam_instance_profile" "ec2_profile":
#    - The bridge attaching the IAM role to the EC2 instance.
#    - role = aws_iam_role.ec2_role.name
