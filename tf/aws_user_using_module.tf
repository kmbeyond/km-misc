module "user1" {
  source = "./km_modules/new_user"

  user_name = "tf_user1"
  user_tags = {}
}

module "user2" {
  source = "./km_modules/new_user"

  user_name = "tf_user2"
  user_tags = {}
}

