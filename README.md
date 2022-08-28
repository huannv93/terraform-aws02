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

 The "remote" backend does not support setting run variables at this time. Currently the only to way to pass variables to the remote backend is by creating a '*.auto.tfvars'
│ variables file. This file will automatically be loaded by the "remote" backend when the workspace is configured to use Terraform v0.10.0 or later.

neu hard code value trong main.tf thi ko can file tfvars
```
