# provider
provider "aws" {
  region = "us-east-1"
  access_key = "AKIAVP2HFGCVKB2QFXFQ"
  secret_key = "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"

  #assume_role {
  #  role_arn     = "arn:aws:iam::ACCOUNT_ID:role/ROLE_NAME"
  #  session_name = "SESSION_NAME"
  #  external_id  = "EXTERNAL_ID"
  #}
}


variable "default_tags" {
  type = map
  default = {
    "Created By" = "km tf"
  }
}


