terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "webserver" {
  ami           = "ami-08982f1c5bf93d976"
  instance_type = "t3.micro"
  count = "1"

  tags = {
    Name = "linux"
  }
}
