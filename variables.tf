variable "region" {
  description = "AWS region"
}

variable "component" {}
variable "deployment_identifier" {}

variable "lambda_arn" {
  description = "Lambda ARN"
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
}

variable "lambda_schedule_expression" {
  description = "Lambda schedule expression. Defaults to every 5 minutes"
  default     = "rate(5 minutes)"
}




