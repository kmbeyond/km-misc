# provider
provider "aws" {
  region  = "us-east-1"
  profile = "usr-admin-1"

  #access_key = ""
  #secret_key = ""

  assume_role {
    role_arn = "arn:aws:iam::377569489066:role/km-adm-role"
    #  session_name = "SESSION_NAME"
    #  external_id  = "EXTERNAL_ID"
  }
}

terraform {
  #terraform version
  #required_version = "1.6.0"

  #(optional) to use specific version of provider version
  #required_providers {
  #  aws = {
  #    source = "hashicorp/aws"
  #    #version = "4.6.1"
  #    version = "~> 4.0"  #>4.0.0 <5.0.0
  #  }
  #}

  #(optional) location where to copy/save state to backend
  #backend "s3" {
  #  bucket = "kiranbkt-development" #MUST be existing bucket
  #  key = "tf/learning/tf_state_2023-11.tfstate"
  #  region = "us-east-1"
  #  dynamodb_table = "tf-state-lock"
  #}
}