output "stage_execution_arn" {
  value = "${aws_api_gateway_stage.stage.execution_arn}"
}

output "stage_invoke_url" {
  value = "${aws_api_gateway_stage.stage.invoke_url}"
}

output "stage_name" {
  value = "${aws_api_gateway_stage.stage.stage_name}"
}