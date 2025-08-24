# Create IAM users from group1 
module "group1_users" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.39.0"

  providers = {
    aws = aws.acc0
  }

  for_each = toset(local.group1_users)

  name                  = each.key
  create_iam_access_key = true
}

# Create IAM users from group2
module "group2_users" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "5.39.0"

  providers = {
    aws = aws.acc0
  }

  for_each = toset(local.group2_users)

  name                          = each.key
  create_iam_access_key         = false
  create_iam_user_login_profile = true
  password_reset_required       = true
}