variable "key_name" {
  type = string
  description = "This is key using to ssh"
  default = "aws-chuongnguyen"
}

variable "private_key_path" {
  type = string
  description = "This is path to private"
  default = "./aws-chuongnguyen.pem"
}