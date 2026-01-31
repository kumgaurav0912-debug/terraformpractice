terraform {
  required_providers {
    aws = {
        source = "harshicop/aws"
        version = "~>4.50"
    }
  }
  required_version = ">= 1.4.6"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "aws_demo" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.sg_ssh.id,
    aws_security_group.sg_http.id
  ]

  tags = {
    Name = "aws_demo_instance"
  }
}

resource "aws_security_group" "sg_ssh" {
    name        = "allow_ssh"
    description = "Allow SSH inbound traffic"
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

   