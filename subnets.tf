data "aws_vpc" "selected" {
  id = var.vpc_id
}
resource "aws_subnet" "public-subnet"{
    for_each = var.public_subnets
    availability_zone_id = each.value["az"]
    cidr_block = each.value["cidr"]
    vpc_id =  data.aws_vpc.selected.id
    
    tags={
        Name = "mairam-subnet-${each.key}"
    }
    
}

resource "aws_subnet" "private-subnet"{
    for_each = var.private_subnets
    availability_zone_id = each.value["az"]
    cidr_block = each.value["cidr"]
    vpc_id =  data.aws_vpc.selected.id
    
    tags={
        Name = "mairam-subnet-${each.key}"
    }
    
}

resource "aws_internet_gateway" "gw" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = var.internet_gw_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = var.route_table_name
  }
}
resource "aws_route_table_association" "association1" {
  for_each = aws_subnet.public-subnet
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "association2" {
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.public.id
}

resource "aws_db_subnet_group" "db-subent-group"{
  name= var.db_subent_group_name
  subnet_ids= [for subnet in aws_subnet.private-subnet:subnet.id]
}