
#default_vpc = "km-vpc-tfvars"
variable "default_vpc" {
 description = "default vpc to use"
 default = "vpc-123456"   #used when no value is assigned by other means (env file or tfvars file)
 type = string
}

output "default_vpc" {
  value = var.default_vpc
}


variable "default_tags" {
  type = map
  default = {
    "Created By" = "km tf"
  }
}
