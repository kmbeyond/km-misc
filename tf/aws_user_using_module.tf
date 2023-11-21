module "user1" {
  source = "./km_modules/new_user"

  user_name = "tf_user1"
  user_tags = {}
}

output "user1_arn" {
  value = module.user1.user_arn
}

module "user2" {
  source = "./km_modules/new_user"

  user_name = "tf_user2"
  user_tags = {}
}
output "user2_arn" {
  value = module.user2.user_arn
}
