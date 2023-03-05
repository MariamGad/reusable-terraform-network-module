# public subnets map
variable "public_subnets" {
    type= map
    description = "creating map of map for public subnets"
    default = {
      sub-1-public = {
         az = ""
         cidr = ""
      }
   }
  
}

# private subnets map
variable "private_subnets" {
    type= map
    description = "creating map of map for private subnets"
    default = {
      sub-1-private = {
         az = ""
         cidr = ""
      }
      sub-2-private = {
         az = ""
         cidr = ""
      }
   }
  
}

variable vpc_id{
   description="To get vpc id"
}
variable internet_gw_name{
   description="internet gateway name"
}
variable route_table_name{
   description="route table name"
}
variable db_subent_group_name{
   description="database subnet group"
}