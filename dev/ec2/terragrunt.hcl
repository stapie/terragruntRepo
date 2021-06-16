locals {
  env = read_terragrunt_config(find_in_parent_folders("env.hcl")).locals
}

################ HERE you can specify a terraform repo or just call a command "terragrunt run-all apply --terragrunt-source ../../modules" ############################
terraform {
  source = "git@github.com:stapie/terraformRepo.git//ec2"
}


include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../vpc"
}


inputs = {
  name          = "jenkins-ec2-${local.env.environment}"
  profile = local.env.aws_profile
  region = local.env.aws_region

  instance-type = "t3.micro"
  vpc_id = dependency.vpc.outputs.jenkins_vpc_id
  security_group_id = dependency.vpc.outputs.security_group_id
  subnet_id = dependency.vpc.outputs.subnet_id
  main_route_table_association = dependency.vpc.outputs.aws_main_route_table_association_id
}
