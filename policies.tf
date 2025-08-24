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

# Allow S3 access
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

#Allow S3 access 
module "policy_s3" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.2.0"

  providers = {
    aws = aws.acc1
  }

  name = "s3-access"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:ListBucket"],
        Resource = ["arn:aws:s3:::${local.s3_bucket_name}"]
      },
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject","s3:PutObject","s3:DeleteObject"],
        Resource = ["arn:aws:s3:::${local.s3_bucket_name}/*"]
      }
    ]
  })
}

# Allow assumeRole to roleC (acc1)
module "policy_allow_assume_roleC" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "6.2.0"

  providers = {
    aws = aws.acc0
  }

  name = "allow-assume-roleC"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["sts:AssumeRole"],
      Resource = local.roleC_arn
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

output "policy_s3_arn" {
  description = "ARN of roleC S3 policy (acc1)"
  value       = module.policy_s3.arn
}

output "policy_allow_assume_roleC_arn" {
  description = "ARN of allow-assume-roleC policy"
  value       = module.policy_allow_assume_roleC.arn
}