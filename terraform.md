Here is a complete Terraform script that:

✅ Generates an SSH key pair (`terraform.key` & `terraform.key.pub`)
✅ Launches an EC2 instance
✅ Connects via the private key
✅ Installs Terraform on the instance using a provisioner

---

## 📁 Directory Structure

```
terraform-ec2-terraform-install/
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.key (generated after running)
```

---

## 📜 `main.tf`

```hcl
provider "aws" {
  region = var.aws_region
}

# Generate a key pair
resource "tls_private_key" "terraform_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content  = tls_private_key.terraform_key.private_key_pem
  filename = "${path.module}/terraform.key"
  file_permission = "0600"
}

resource "local_file" "public_key" {
  content  = tls_private_key.terraform_key.public_key_openssh
  filename = "${path.module}/terraform.key.pub"
}

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = tls_private_key.terraform_key.public_key_openssh
}

# Fetch latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Security group allowing SSH
resource "aws_security_group" "ssh_access" {
  name        = "allow_ssh"
  description = "Allow SSH"

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

# Launch EC2 instance
resource "aws_instance" "terraform_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.ssh_access.id]

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y yum-utils",
      "sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo",
      "sudo yum -y install terraform",
      "terraform version"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.terraform_key.private_key_pem
      host        = self.public_ip
    }
  }

  tags = {
    Name = "Terraform-Instance"
  }
}
```

---

## 📜 `variables.tf`

```hcl
variable "aws_region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}
```

---

## 📜 `outputs.tf`

```hcl
output "ec2_public_ip" {
  value = aws_instance.terraform_ec2.public_ip
}

output "ssh_command" {
  value = "ssh -i terraform.key ec2-user@${aws_instance.terraform_ec2.public_ip}"
}
```

---

## ✅ How to Use

### 1. Initialize

```bash
terraform init
```

### 2. Apply

```bash
terraform apply -auto-approve
```

### 3. Connect to EC2

```bash
chmod 600 terraform.key
ssh -i terraform.key ec2-user@<PUBLIC_IP_FROM_OUTPUT>
```

---

Would you like me to help with adding this to a GitHub-ready repo with a `README.md` and practice exercises as well?
