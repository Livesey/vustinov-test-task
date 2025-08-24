# In real project you are must have different profiles for different accounts

provider "aws" {
  alias   = "acc0"
  profile = "default"
  region  = "us-east-1"
}

provider "aws" {
  alias   = "acc1"
  profile = "default"
  region  = "us-east-1"
}
