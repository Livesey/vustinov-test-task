# Groups
output "group1_arn" {
  description = "ARN of IAM group1"
  value       = module.group1.arn
}

output "group2_arn" {
  description = "ARN of IAM group2"
  value       = module.group2.arn
}

#Policies
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

# Roles
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

# Users
output "group1_user_arns" {
  description = "group1 user ARNs"
  value       = [for m in module.group1_users : m.iam_user_arn]
}
output "group2_user_arns" {
  description = "group2 user ARNs"
  value       = [for m in module.group2_users : m.iam_user_arn]
}