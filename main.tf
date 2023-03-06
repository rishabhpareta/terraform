# VPC
resource "aws_vpc" "crew-vpc" {
  cidr_block       = "192.162.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "crew-vpc"
  }
}

#SUBNET PUBLIC

resource "aws_subnet" "crew-subnet-pub" {
  vpc_id     = aws_vpc.crew-vpc.id
  cidr_block = "192.162.0.0/24"

  tags = {
    Name = "crew-subnet-pub"
  }
}

#INTERNET GATEWAY

resource "aws_internet_gateway" "crew-IGW" {
  vpc_id = aws_vpc.crew-vpc.id

  tags = {
    Name = "crew-IGW"
  }
}

#ROUTE TABLE

resource "aws_route_table" "crew-route-table" {
  vpc_id = aws_vpc.crew-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crew-IGW.id
  }


  tags = {
    Name = "crew-route-table"
  }
}

#ROUTE TABLE ASSOCIATION 

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.crew-subnet-pub.id
  route_table_id = aws_route_table.crew-route-table.id
}

#PRIVATE SUBNET 

resource "aws_subnet" "crew-subnet-private" {
  vpc_id     = aws_vpc.crew-vpc.id
  cidr_block = "192.162.10.0/24"

  tags = {
    Name = "crew-subnet-private"
  }
}

#PRIVATE INTERNET GATEWAY

resource "aws_internet_gateway" "crew-IGW-private" {
  vpc_id = aws_vpc.crew-vpc.id

  tags = {
    Name = "crew-IGW-private"
  }
}


# PRIVATE ROUTE TABLE

resource "aws_route_table" "crew-route-table-private" {
  vpc_id = aws_vpc.crew-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crew-IGW-private.id
  }


  tags = {
    Name = "crew-route-table-private"
  }
}