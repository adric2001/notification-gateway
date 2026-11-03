# ==============================================================================
# AWS VPC Networking Guide (terraform/vpc.tf)
# ==============================================================================
# This file sets up an isolated virtual network in AWS for your server.
#
# Components you need to declare:
#
# 1. aws_vpc:
#    - cidr_block = "10.0.0.0/16"
#    - enable_dns_hostnames = true
#    - enable_dns_support = true
#
# 2. aws_internet_gateway:
#    - Connects your VPC to the public internet.
#    - vpc_id = aws_vpc.main.id
#
# 3. aws_subnet (public subnet):
#    - vpc_id = aws_vpc.main.id
#    - cidr_block = "10.0.1.0/24"
#    - map_public_ip_on_launch = true
#    - availability_zone = "${var.aws_region}a"
#
# 4. aws_route_table:
#    - vpc_id = aws_vpc.main.id
#    - route block pointing destination "0.0.0.0/0" to gateway_id = aws_internet_gateway.gw.id
#
# 5. aws_route_table_association:
#    - Links the subnet to the route table so instances in that subnet can reach the internet.
#    - subnet_id = aws_subnet.public.id
#    - route_table_id = aws_route_table.public.id
