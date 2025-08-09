## 📸 Screenshot

![Terraform-EC2](https://github.com/atulkamble/ec2-terraform-project/blob/main/terraform-ec2.png)


![Terraform-Configuration](https://github.com/atulkamble/ec2-terraform-project/blob/main/terraform-configuration.png)


---




## 📖 Terraform Installation & Configuration on AWS EC2

This guide walks you through installing and configuring Terraform on an EC2 instance, and provisioning a simple AWS EC2 instance using Terraform.

---
# install terraform on windows 
```
powershell run as admin 

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install terraform 

terraform -v
```
```
sudo yum install git -y 
git clone https://github.com/atulkamble/ec2-terraform-project.git
cd ec2-terraform-project
terraform init
terraform plan
terraform apply
terraform destroy
```

## 📌 Prerequisites

* AWS account with **Admin** access.
* SSH key pair for EC2 instance access.
* Basic knowledge of EC2, SSH, and AWS CLI.

---

## ⚙️ Steps to Install and Configure Terraform on EC2

---

### 🔐 0️⃣ Create IAM User with Admin Access

* Go to **IAM Console** → **Users** → **Add Users**.
* Assign user to **Admin group**.
* Generate **Access Key ID** and **Secret Access Key**.
* Note down the credentials safely.

---

### 🖥️ 1️⃣ Launch EC2 Instance

* Instance Type: `t2.medium`
* AMI: Amazon Linux 2
* Security Group:

  * SSH: 22
* Create and download `terraform.pem` key pair.

---

### 🔑 2️⃣ SSH into EC2

```bash
cd Downloads
chmod 400 terraform.pem
ssh -i "terraform.pem" ec2-user@<EC2_PUBLIC_IP>
```

---

### ⚙️ 3️⃣ Install Dependencies & Terraform

```bash
# Update packages
sudo yum update -y

# Install Python
sudo yum install python -y
python3 --version

# Install AWS CLI
sudo yum install awscli -y
aws --version

# Configure AWS CLI
aws configure
```

**Enter your Access Key, Secret Access Key, region (e.g. us-east-1) and output format (json)**

```bash
# Install yum-utils and add HashiCorp repo
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo

# Install Terraform
sudo yum -y install terraform

# Verify Terraform installation
terraform --version
```

---

## 📦 4️⃣ Create and Run a Terraform Project

### 📁 Project Setup

```bash
mkdir project
cd project
touch main.tf
nano main.tf
```

### 📝 Sample `main.tf`

```hcl
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
```

---

### 📌 Initialize Terraform

```bash
terraform init
```

---

### 📊 Plan Terraform Deployment

```bash
terraform plan
```

---

### 🚀 Apply Terraform Configuration

```bash
terraform apply
```

Type `yes` to confirm.

---

### 🗑️ Destroy Infrastructure

```bash
terraform destroy
```

Type `yes` to confirm.

---

## ✅ Project Complete

You now have a fully functional Terraform installation on an EC2 instance, capable of provisioning AWS resources via infrastructure-as-code.

---

## 📎 Notes

* Replace `<EC2_PUBLIC_IP>` with your actual EC2 instance public IP.
* Update the `ami` ID in `main.tf` if a newer Amazon Linux 2 AMI is available in your region.

---
## 👨‍💻 Author

**Atul Kamble**

- 💼 [LinkedIn](https://www.linkedin.com/in/atuljkamble)
- 🐙 [GitHub](https://github.com/atulkamble)
- 🐦 [X](https://x.com/Atul_Kamble)
- 📷 [Instagram](https://www.instagram.com/atuljkamble)
- 🌐 [Website](https://www.atulkamble.in)

