# pass public subnet id to another module
output "subnet_id" {
  value = "${aws_subnet.public-subnet["sub-1-public"].id}"
}

# pass private subnet ids to datbase module
output "private-subnet-ids"{
  value= "${aws_db_subnet_group.db-subent-group.id}"
}