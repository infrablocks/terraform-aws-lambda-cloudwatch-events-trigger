output "stage_exection_arn" {
  value = "${module.api_gateway_lambda_resource.stage_execution_arn}"
}

output "stage_invoke_url" {
  value = "${module.api_gateway_lambda_resource.stage_invoke_url}"
}