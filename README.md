# terraform-aws02

This is lab which use terraform to create Ec2 on aws


- use https://app.terraform.io/ to control 
- inter accesskey , secrec key ... of aws to cloud terraform
https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication-and-configuration

- command 
```
terraform init 
terraform plan 
terraform apply
terraform login // login to cloud
terraform plan -var-file=s1.tfvars // tro den value cho varible, terraform cloud ko support varible o code ---> dung cho terraform local

neu hard code value trong main.tf thi ko can file tfvars
```
