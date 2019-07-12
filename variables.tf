variable "region" {
  description = "AWS region"
}

variable "component" {}
variable "deployment_identifier" {}

variable "account_id" {
  description = "AWS account id where the lambda execution"
}

variable "vpc_id" {
  description = "VPC to deploy the lambda to"
}

variable "lambda_subnet_ids" {
  description = "Subnet ids to deploy the lambda to"
  type = "list"
}


variable "lambda_zip_path" {}

variable "lambda_ingress_cidr_blocks" {
  type = "list"
}

variable "lambda_egress_cidr_blocks" {
  type = "list"
}

variable "lambda_environment_variables" {
  description = "Environment variables to be provied to the lambda function."
  type = "map"
}

variable "lambda_function_name" {}

variable "lambda_handler" {}

variable "lambda_runtime" {
  default = "nodejs10.x"
}

variable "lambda_timeout" {
  default = 30
}

variable "lambda_memory_size" {
  default = 128
}

