#who is executing the current tf plan
data "aws_caller_identity" "current" {}

output "current_caller_account_id" {
  value = "${data.aws_caller_identity.current.account_id}"
}

output "current_caller_arn" {
  value = "${data.aws_caller_identity.current.arn}"
}

output "current_caller_access_id" {
  value = "${data.aws_caller_identity.current.user_id}"
}