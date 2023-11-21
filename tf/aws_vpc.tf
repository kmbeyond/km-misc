
#------VPC------------
##create VPC
resource "aws_vpc" "km_tf_vpc_01" {
  cidr_block = "11.0.0.0/16"
  tags = {
    Name = "km-vpc-by-tf"
  }
}

output "vpc_id_new" {
  value = aws_vpc.km_tf_vpc_01.id
}


#Filter for existing VPC
data "aws_vpc" "km_vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["km-vpc"]
  }
}

output "vpc_id_existing" {
  value = data.aws_vpc.km_vpc_id.id
}



