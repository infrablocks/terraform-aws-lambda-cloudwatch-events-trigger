variable "region" {
  description = "The region into which to deploy the lambda."
  type        = string
}

variable "component" {
  description = "The name of the component or service."
  type        = string
}

variable "deployment_identifier" {
  description = "An identifier for this instantiation."
  type        = string
}

variable "lambda_arn" {
  description = "The ARN of the lambda function to trigger."
  type        = string
}

// TODO: we probably only need one of ARN or function name; remove
//       during next major upgrade
variable "lambda_function_name" {
  description = "The name of the lambda function to trigger."
  type        = string
}

variable "lambda_schedule_expression" {
  description = "The lambda schedule expression. Defaults to every 5 minutes."
  type        = string
  default     = "rate(5 minutes)"
}




