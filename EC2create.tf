variable "network_address_space" {
    default = "10.1.0.0/16"
}

variable "subnet1_address_space" {
    default = "10.1.0.0/24"
}

variable "subnet2_address_space" {
  default = "10.1.2.0/24"
}

data "aws_availability_zones" "available" { }

data "aws_ami" "aws-linux" {
    owners      = ["amazon"]
    most_recent = "true"

    filter {
      name = "root-device-type"
      values = ["ebs"]
    }

    filter {
      name= "name"
      values = ["amzn-ami-hvm*"]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
  }


######################
# Resources

####################

/*
Networking

*/
 resource "aws_vpc" "vpc" {
   cidr_block = var.network_address_space
   enable_dns_hostnames = "true"
   tags = {
     Name        = "${var.app_name}"
   }
 }
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_subnet" "subnet1" {
  cidr_block = var.subnet1_address_space
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_subnet" "subnet2" {
  cidr_block = var.subnet2_address_space
  vpc_id = aws_vpc.vpc.id
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.available.names[0]
}

resource "aws_route_table" "rtb" {
  vpc_id         = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "rta-subnet" {
  subnet_id = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rtb.id
}
resource "aws_security_group" "nginx-sg" {
  name = "nginx-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 22
    protocol  = "TCP"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    protocol  = "TCP"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "nginx" {
  ami = data.aws_ami.aws-linux.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  key_name = var.key_name
  tags = {
    Name        = "${var.app_name}"
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key= file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
       " sudo yum install nginx -y",
       " sudo sudo yum install docker -y",
       " sudo service docker start",
       " sudo usermod -a -G docker ec2-user",
       " sudo docker run -dp 80:80 huannv93/cv:v3"
    ]
  }
}

#############################
# OUTPUT

#####################

output "aws_instance_public_dns" {
  value = aws_instance.nginx.public_dns
}

output "aws_instance_public_ip" {
  value = aws_instance.nginx.public_ip
}






