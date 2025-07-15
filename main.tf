terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-0150ccaf51ab55a51"
  instance_type = "t3.micro"

  tags = {
    Name = "one"
  }
}
