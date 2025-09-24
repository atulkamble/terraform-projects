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
  ami           = "ami-0e3c2921641a4a215"
  instance_type = "t3.medium"
  count         = "1"

  tags = {
    Name = "windows"
  }
}
