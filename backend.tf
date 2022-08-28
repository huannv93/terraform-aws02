#terraform {
#  backend "remote" {
#    organization = "Sgsvn"
#
#    workspaces {
#      name = "huannv-terraform"
#    }
#  }
#}
terraform {
  backend "local" {
  }
}

// phan nay de sync to : https://app.terraform.io/app