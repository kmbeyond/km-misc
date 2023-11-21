resource "aws_iam_user" "new_user" {
  name = var.user_name
  tags = var.user_tags
}

variable "user_name" {
 description = "user name"
 type = string
}
variable "user_tags" {
 description = "user tags"
 type = map(string)
}

output "user_arn" {
  value = aws_iam_user.new_user.arn
}