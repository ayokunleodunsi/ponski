terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "kman" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "hqmain"
  }
}

resource "aws_subnet" "kman" {
  vpc_id     = aws_vpc.kman.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_internet_gateway" "kman" {
  vpc_id = aws_vpc.kman.id

  tags = {
    Name = "igw1"
  }
}


resource "aws_route_table" "kman" {
  vpc_id = aws_vpc.kman.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kman.id
  }

    tags = {
    Name = "rt1"
  }
}

resource "aws_route_table_association" "kman" {
  subnet_id      = aws_subnet.kman.id
  route_table_id = aws_route_table.kman.id
}



/*resource "aws_security_group" "kman" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.kman.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = "0.0.0.0/0"
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
*/