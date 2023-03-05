data "aws_vpc" "selected" {
  id = var.vpc_id
}
resource "aws_subnet" "main_subnet"{
    for_each = var.subnets
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
  subnet_id      = aws_subnet.main_subnet["sub-1-public"].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "association2" {
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.public.id
}

# pass public subnet id to another module
output "subnet_id" {
  value = "${aws_subnet.main_subnet["sub-1-public"].id}"
}
