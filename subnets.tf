# get vpc id
data "aws_vpc" "selected" {
  id = var.vpc_id
}

# create public subnet
resource "aws_subnet" "public-subnet"{
    for_each = var.public_subnets
    availability_zone_id = each.value["az"]
    cidr_block = each.value["cidr"]
    vpc_id =  data.aws_vpc.selected.id
    
    tags={
        Name = "mairam-subnet-${each.key}"
    }
    
}

#create private subnets
resource "aws_subnet" "private-subnet"{
    for_each = var.private_subnets
    availability_zone_id = each.value["az"]
    cidr_block = each.value["cidr"]
    vpc_id =  data.aws_vpc.selected.id
    
    tags={
        Name = "mairam-subnet-${each.key}"
    }
    
}

# create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = var.internet_gw_name
  }
}

# Create route table for public subnet
resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = var.route_table_name
  }
}

#Associate public subnet with route table
resource "aws_route_table_association" "association1" {
  for_each = aws_subnet.public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

# Associate internet gateway with route table
resource "aws_route_table_association" "association2" {
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.public.id
}

# Create subnet group , DB requires two subnets or more
resource "aws_db_subnet_group" "db-subent-group"{
  name= var.db_subent_group_name
  subnet_ids= [for subnet in aws_subnet.private-subnet:subnet.id]
}