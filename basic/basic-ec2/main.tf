terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "linux" {
  ami           = "ami-08982f1c5bf93d976" # Amazon Linux 2 AMI
  instance_type = "t3.micro"

  tags = {
    Name = "linux"
  }
}
