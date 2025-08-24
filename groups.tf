# group1 (CLI-only)
module "group1" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group"
  version = "6.0.0"

  providers = {
    aws = aws.acc0
  }

  name  = local.group1_name
  users = local.group1_users

  policies = {
    DenyConsoleMgmt = module.policy_deny_console_access.arn
  }
}

# group2 (console users)
module "group2" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-group"
  version = "6.0.0"

  providers = {
    aws = aws.acc0
  }

  name  = local.group2_name
  users = local.group2_users

  policies = {
    PowerUserAccess       = "arn:aws:iam::aws:policy/PowerUserAccess"
    IAMUserChangePassword = "arn:aws:iam::aws:policy/IAMUserChangePassword"
  }
}

output "group1_arn" {
  description = "ARN of IAM group1"
  value       = module.group1.arn
}

output "group2_arn" {
  description = "ARN of IAM group2"
  value       = module.group2.arn
}
