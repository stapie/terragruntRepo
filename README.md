# test Jenkins Environment using Terragrunt

# Several steps to create infrastructure in AWS:
## 1) Create Free Tier account in AWS and create user with privileges in IAM.
## 2) Install awscli using pip3 and configure it with command 'aws configure --user default', pass the credentials which you gain when create a user IAM.
## 3) Install ansible, terraform and terragrunt module.
## 4) Create a bucket on s3 for store your terraformstatefile with command 'aws s3api create-bucket --bucket <yourBucketName> --create-bucket-configuration LocationConstraint=eu-central-1'.
## 5) Create infrastructure with command "terragrunt run-all apply" or "terragrunt run-all apply --terragrunt-source ../../modules" in /dev folder.
## 6) Enjoy
