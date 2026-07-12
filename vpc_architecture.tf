provider "aws" {
  region = "us-east-1"
}

# The Main VPC
resource "aws_vpc" "tkh_fortress" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "TKH-Fortress-VPC"
  }
}

# The Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.tkh_fortress.id
}

# The Private Subnet (The Vault)
resource "aws_subnet" "private_vault" {
  vpc_id     = aws_vpc.tkh_fortress.id
  cidr_block = "10.0.2.0/24"
}

# The Route Table
resource "aws_route_table" "corrupted_route" {
  vpc_id = aws_vpc.tkh_fortress.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# SABOTAGE: The Private Subnet is associated with the Internet Route Table!
resource "aws_route_table_association" "sabotage_association" {
  subnet_id      = aws_subnet.private_vault.id
  route_table_id = aws_route_table.corrupted_route.id
}
