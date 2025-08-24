locals {
  # Accounts
  acc0_account_id = "000000000000"
  acc1_account_id = "111111111111"

  # Users with CLI access only
  group1_users = [
    "engine",
    "ci",
  ]

  # Users with console access
  group2_users = [
    "denys.platon",
    "ivan.petrenko",
  ]

  # Groups
  group1_name = "group1"
  group2_name = "group2"

  # Roles
  roleA_name = "roleA"
  roleB_name = "roleB"
  roleC_name = "roleC"

  # Bucket
  s3_bucket_name = "aws-test-bucket"

  # ARNs
  acc0_root_arn = "arn:aws:iam::${local.acc0_account_id}:root"
  roleC_arn     = "arn:aws:iam::${local.acc1_account_id}:role/${local.roleC_name}"
}

