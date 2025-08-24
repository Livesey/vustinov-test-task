module "roleA" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.2.0"

  providers = {
    aws = aws.acc0
  }

  name = local.roleA_name

  # Trust: allow acc0 root to assume this role
  trust_policy_permissions = {
    Acc0RootCanAssume = {
      principals = [{
        type        = "AWS"
        identifiers = [local.acc0_root_arn]
      }]
    }
  }

  # Attach policies: AWS managed + our custom deny
  policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
    DenyIamAll          = module.policy_deny_iam_all.arn
  }
}



module "roleB" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.2.0"

  providers = {
    aws = aws.acc0
  }

  name = local.roleB_name

  # Trust: allow acc0 root to assume this role
  trust_policy_permissions = {
    Acc0RootCanAssume = {
      principals = [{
        type        = "AWS"
        identifiers = [local.acc0_root_arn]
      }]
    }
  }

  # Attach custom policy: allow assumeRole to roleC
  policies = {
    AllowAssumeRoleC = module.policy_allow_assume_roleC.arn
  }
}

# roleC in acc1
module "roleC" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "6.2.0"

  providers = {
    aws = aws.acc1
  }

  name = local.roleC_name

  # Trust: allow acc0 to assume this role
  trust_policy_permissions = {
    Acc0RoleBCanAssume = {
        principals = [{
        type        = "AWS"
        identifiers = [module.roleB.arn]
        }]
    }
  }

  # Attach S3 policy (defined in policies.tf, acc1 side)
  policies = {
    S3Access = module.policy_s3.arn
  }
}

# Outputs
output "roleA_arn" {
  description = "ARN of roleA"
  value       = module.roleA.arn
}

output "roleB_arn" {
  description = "ARN of roleB"
  value       = module.roleB.arn
}

output "roleC_arn" {
  description = "ARN of roleC"
  value       = module.roleC.arn
}

