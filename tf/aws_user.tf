
#----Create new IAM user----
resource "aws_iam_group" "training" {
  name = var.user_group_training
}


resource "aws_iam_user" "user10"{
  name = var.user10
  
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

  depends_on = [
    aws_iam_user.user10
  ]

}

resource "aws_iam_group_membership" "add_user_to_group" {
  name = "training_group_membership"
  users = [aws_iam_user.user10.name]
  group = aws_iam_group.training.name
}

#print out
output "user10-arn" {
  value = aws_iam_user.user10.arn
}