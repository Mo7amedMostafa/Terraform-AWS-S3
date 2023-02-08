
# Terraform_AWS_S3

Terraform to build s3




## PreRequestes

Install Terraform On Ubuntu

```bash
apt-get install wget curl unzip software-properties-common gnupg2 -y
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update -y
apt-get install terraform -y
terraform -v
```

## Build

```bash
terraform init

terraform plan

terraform apply
```
## 🚀 About Me
I'm a DevOps Engineer ...
