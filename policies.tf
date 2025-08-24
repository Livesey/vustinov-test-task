# Deny console access
module "policy_deny_console_access" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.39.0"

  providers = {
    aws = aws.acc0
  }

  name = "deny-console-access"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Deny",
      Action = [
        "iam:CreateLoginProfile",
        "iam:UpdateLoginProfile",
        "iam:ChangePassword",
        "iam:CreateVirtualMFADevice",
        "iam:EnableMFADevice",
        "iam:ResyncMFADevice",
        "iam:DeactivateMFADevice",
        "iam:DeleteVirtualMFADevice"
      ],
      Resource = "*"
    }]
  })
}

module "policy_deny_iam_all" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.2.0"

  providers = {
    aws = aws.acc0
  }

  name = "deny-iam-all"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Deny",
      Action   = ["iam:*"],
      Resource = "*"
    }]
  })
}


# Outputs
output "deny_console_access_policy_arn" {
  description = "ARN of deny-console-access policy"
  value       = module.policy_deny_console_access.arn
}

output "policy_deny_iam_all_arn" {
  description = "ARN of deny-iam-all policy"
  value       = module.policy_deny_iam_all.arn
}