
#----Create new IAM user----
resource "aws_iam_user" "user10"{
  name = "km10"
  
  #tags = "${var.default_tags}"
  #tags = {
  #  "Created by" = "tf test",
  #  "used for" = "test"
  #}
  tags = merge(
    var.default_tags,{
      "Extra tag" = "extra"
    }
  )
}

#print out
output "user10-arn" {
  value = aws_iam_user.user10.arn
}