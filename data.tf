data "aws_vpc" "default" {
  id = ""
}

data "aws_subnet" "subnet_1" {
  id = ""
}

data "aws_subnet" "subnet_2" {
  id = ""
}

data "aws_subnet" "subnet_3" {
  id = ""
}

data "aws_internet_gateway" "default" {
  filter {
    name   = "attachment.vpc-id"
    values = [""]
  }
}