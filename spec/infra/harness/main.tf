data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}


module "api_gateway_lambda_resource" {
  source                = "../../../../"
  region                = "${var.region}"
  component             = "${var.component}"
  deployment_identifier = "${var.deployment_identifier}"

  account_id = "${var.account_id}"
  vpc_id = "${data.terraform_remote_state.prerequisites.outputs.vpc_id}"
  api_gateway_id = "${data.terraform_remote_state.prerequisites.outputs.api_gateway_id}"
  api_gateway_root_resource_id = "${data.terraform_remote_state.prerequisites.outputs.api_gateway_root_resource_id}"
  api_gateway_stage_name = "${var.api_gateway_stage_name}"

  resource_path_part = "${var.resource_path_part}"
  lambda_subnet_ids = "${split(",",data.terraform_remote_state.prerequisites.outputs.private_subnet_ids)}"
  lambda_zip_path = "${var.lambda_zip_path}"
  lambda_ingress_cidr_blocks = "${var.lambda_ingress_cidr_blocks}"
  lambda_egress_cidr_blocks = "${var.lambda_egress_cidr_blocks}"
  lambda_environment_variables = var.lambda_environment_variables
  lambda_function_name = "${var.lambda_function_name}"
  lambda_handler = "${var.lambda_handler}"
  resource_http_method = "GET"

}
