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

variable "vpc_id"{}
variable "internet_gw_name"{}
variable "route_table_name"{}