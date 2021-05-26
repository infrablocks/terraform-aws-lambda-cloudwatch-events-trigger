module "base_network" {
  source = "infrablocks/base-networking/aws"
  version = "3.0.0"

  region = var.region
  vpc_cidr = var.vpc_cidr
  availability_zones = var.availability_zones

  component = var.component
  deployment_identifier = var.deployment_identifier

  private_zone_id = var.private_zone_id
}

module "lambda" {
  source  = "infrablocks/lambda/aws"
  version = "0.14.0"

  region = var.region
  component = var.component
  deployment_identifier = var.deployment_identifier

  account_id = var.account_id
  vpc_id = module.base_network.vpc_id

  lambda_subnet_ids = module.base_network.private_subnet_ids
  lambda_zip_path = var.lambda_zip_path
  lambda_ingress_cidr_blocks = var.lambda_ingress_cidr_blocks
  lambda_egress_cidr_blocks = var.lambda_egress_cidr_blocks
  lambda_environment_variables = var.lambda_environment_variables
  lambda_function_name = var.lambda_function_name
  lambda_handler = var.lambda_handler
}
