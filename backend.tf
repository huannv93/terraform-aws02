terraform {
  backend "remote" {
    organization = "Sgsvn"

    workspaces {
      name = "huannv-terraform"
    }
  }
}


// phan nay de sync to : https://app.terraform.io/app