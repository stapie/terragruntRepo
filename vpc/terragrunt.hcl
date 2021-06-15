locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

    # Extract out common variables for reuse
    env = local.environment_vars.locals
}

terraform {
  source = "git@github.com:stapie/terraformRepo.git//vpc"
}

include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  name     = local.env.environment
  region   = local.env.aws_region
  profile  = local.env.aws_profile

  ingress-port = 8080
  egress-port   = 0
}
