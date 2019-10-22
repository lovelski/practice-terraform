variable "region" {}

variable "ec2" {
   default = {
      key_pair = "aws_lsk"
      password = "demo"
   }
}

variable "ec2_demo" {
   default = {
      name = "demo"
      instance_type = "t2.micro"

   }
}

variable "ec2_es" {
   default = {
      name = "demo_es"
      instance_type = "t2.medium"
   }
}

variable "ec2_grafana" {
   default = {
      name = "demo_grafana"
      instance_type = "t2.medium"
   }
}

variable "ubuntu" {
   default = {
      name = "ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"
      owner = "099720109477"
   }
}

variable "windows" {
   default = {
      name = "Windows_Server-2012-R2_RTM-Hungarian-64Bit-Base-*"
      owner = "amazon"
   }
}