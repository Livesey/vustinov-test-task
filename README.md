# Terraform IAM Test Task

## Overview
This project provisions IAM resources across two AWS accounts (**acc0** and **acc1**) using Terraform and the official [`terraform-aws-modules/iam`](https://registry.terraform.io/modules/terraform-aws-modules/iam/aws) modules.

## What is provisioned

### IAM Users
- **Group1 users**: CLI/API-only users with **PowerUser** access (no console access).
- **Group2 users**: Full-access users (console + CLI/API) with password reset enforced.

### IAM Groups
- **Group1**:  
  - AWS managed policy: `PowerUserAccess`  
  - Custom policy: `deny-console-access` (blocks console logins)
- **Group2**:  
  - AWS managed policies: `PowerUserAccess`, `IAMUserChangePassword`

### IAM Roles
- **roleA** (acc0):  
  - `AdministratorAccess`  
  - Explicit deny on all `iam:*` actions
- **roleB** (acc0):  
  - Trusts acc0 root  
  - Allows `sts:AssumeRole` into roleC
- **roleC** (acc1):  
  - Trusts only **roleB** from acc0  
  - Grants S3 access to an existing bucket

### IAM Policies
- **deny-console-access**: denies all console-related actions  
- **deny-iam-all**: denies all IAM actions (used by roleA)  
- **s3-access**: read/write access to a specific S3 bucket  
- **allow-assume-roleC**: allows roleB to assume roleC  

## File Structure
