resource "aws_vpc" "main" {
  cidr_block = "${var.cidr_ip}"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  #region = "us-west-2"
tags = {
    Name = "${var.VPCNAME}"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.main.id
  
  tags = {
    Name = "${var.internetgateway}"
  }
}

resource "aws_subnet" "publicsubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.publicsubnet}"

  tags = {
    Name = "terraformpublicsubnet"
  }
}
resource "aws_eip" "myeip" {
  vpc              = true
  depends_on = [aws_internet_gateway.IGW]
  tags = {
    Name = "${var.elasticip}"
  }
}

resource "aws_nat_gateway" "natgateway" {
  allocation_id = aws_eip.myeip.id
  subnet_id     = aws_subnet.publicsubnet.id

  tags = {
    Name = "terraformNATgateway"
  }

}

resource "aws_subnet" "privatesubnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "${var.privatesubnet}"

  tags = {
    Name = "privatesubnet"
  }

}
resource "aws_route_table" "publicroutetable" {
  vpc_id = aws_vpc.main.id

    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "terraformpublicroutetable"
  }
}

resource "aws_route_table" "privateroutetable"{
  vpc_id = aws_vpc.main.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgateway.id
  }
tags={
    Name = "terraformpublicroutetable"
  }
}