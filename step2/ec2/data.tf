data "aws_availability_zones" "available" {
  # state는 가용 영역의 상태로 필터링 (아래 설정은 사용 가능한 availability zone들을 필터링)
  state = "available"
}

data "terraform_remote_state" "vpc_data" {
    backend = "local"
    config = {
        path = "${path.module}/../vpc/terraform.tfstate"
    }
}

data "terraform_remote_state" "sg_data" {
    backend = "local"
    config = {
        path = "${path.module}/../security_group/terraform.tfstate"
    }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.ubuntu["name"]]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.ubuntu["owner"]]
}

data "aws_ami" "windows" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.windows["name"]]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = [var.windows["owner"]]
}