
#default_vpc = "km-vpc-tfvars"
variable "default_vpc" {
  description = "default vpc to use"
  default     = "vpc-123456" #used when no value is assigned by other means (env file or tfvars file)
  type        = string
}




variable "default_tags" {
  type = map(any)
  default = {
    "Created By" = "km tf"
  }
}

variable "user_group_training" {
  type    = string
  default = "training"
}

variable "user10" {
  type    = string
  default = "km10"
}