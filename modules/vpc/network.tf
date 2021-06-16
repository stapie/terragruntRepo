
terraform {

  required_version = "= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.7.0"
    }
  }
}

resource "aws_vpc" "jenkins-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "jenkins-vpc"
  }
}


resource "aws_internet_gateway" "igw_jen" {
  vpc_id   = aws_vpc.jenkins-vpc.id
}

resource "aws_route_table" "internet_route_jen" {
  vpc_id   = aws_vpc.jenkins-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_jen.id
  }
  lifecycle {
    ignore_changes = all
  }
}

resource "aws_main_route_table_association" "set-master-default-rt-assoc_jen" {
  vpc_id         = aws_vpc.jenkins-vpc.id
  route_table_id = aws_route_table.internet_route_jen.id
}

resource "aws_security_group" "jenkins-sg" {
  name        = "jenkins-sg"
  vpc_id      = aws_vpc.jenkins-vpc.id
  description = "Allow TCP/8080 & TCP/22"

  ingress {
    description = "Allow 22 from our public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow anyone on port 8080"
    from_port   = var.ingress-port
    to_port     = var.ingress-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.egress-port
    to_port     = var.egress-port
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_subnet" "subnet_1_jen" {
  availability_zone = element(data.aws_availability_zones.azs_jen.names, 0)
  vpc_id            = aws_vpc.jenkins-vpc.id
  cidr_block        = "10.0.1.0/24"
}

resource "aws_subnet" "subnet_2_jen" {
  availability_zone = element(data.aws_availability_zones.azs_jen.names, 1)
  vpc_id            = aws_vpc.jenkins-vpc.id
  cidr_block        = "10.0.2.0/24"
}


data "aws_availability_zones" "azs_jen" {
  state    = "available"
}
