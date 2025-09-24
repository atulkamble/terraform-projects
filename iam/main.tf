terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

variable "names" {
  default = ["hari", "om", "rohit"]
}

resource "aws_iam_user" "my_iam_users" {
  for_each = toset(var.names)
  name = each.value
}
