provider "aws" {
  region = "eu-west-2"
  profile = "thomas"
}

# VPC A
resource "aws_vpc" "vpc_a" {
  cidr_block = "10.0.0.0/16"
}

# VPC B
resource "aws_vpc" "vpc_b" {
  cidr_block = "10.1.0.0/16"
}

# VPC Peering
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = aws_vpc.vpc_a.id
  peer_vpc_id   = aws_vpc.vpc_b.id
  auto_accept   = true

  tags = {
    Name = "VPC-A-to-VPC-B"
  }
}

# Route in VPC A
resource "aws_route" "route_to_b" {
  route_table_id         = aws_vpc.vpc_a.default_route_table_id
  destination_cidr_block = aws_vpc.vpc_b.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}

# Route in VPC B
resource "aws_route" "route_to_a" {
  route_table_id         = aws_vpc.vpc_b.default_route_table_id
  destination_cidr_block = aws_vpc.vpc_a.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
}