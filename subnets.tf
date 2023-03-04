data "aws_vpc" "selected" {
  id = var.vpc_id
}
resource "aws_subnet" "main_subnet"{
    for_each = var.subnets
    availability_zone_id = each.value["az"]
    cidr_block = each.value["cidr"]
    vpc_id =  data.aws_vpc.selected.id
    
    tags={
        Name = "mairam subnet-${each.key}"
    }
