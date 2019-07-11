variable "region" {}
variable "component" {}
variable "deployment_identifier" {}


variable "account_id" {}
variable "resource_path_part" {}

variable "lambda_zip_path" {}
variable "lambda_ingress_cidr_blocks" {
  type = "list"
}
variable "lambda_egress_cidr_blocks" {
  type = "list"
}
variable "lambda_environment_variables" {
  type = "map"
}
variable "lambda_function_name" {}
variable "lambda_handler" {}

variable "api_gateway_stage_name" {}