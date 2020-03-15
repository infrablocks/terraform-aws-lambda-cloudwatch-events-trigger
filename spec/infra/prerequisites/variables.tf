variable "region" {}
variable "component" {}
variable "deployment_identifier" {}

variable "vpc_cidr" {}
variable "availability_zones" {
  type = list(string)
}
variable "private_zone_id" {}
variable "infrastructure_events_bucket" {}

variable "account_id" {}

variable "lambda_zip_path" {}
variable "lambda_ingress_cidr_blocks" {
  type = list(string)
}
variable "lambda_egress_cidr_blocks" {
  type = list(string)
}
variable "lambda_environment_variables" {
  type = map(string)
}
variable "lambda_function_name" {}
variable "lambda_handler" {}


