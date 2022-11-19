output "lambda_arn" {
  value = module.lambda.lambda_arn
}

output "lambda_function_name" {
  value = module.lambda.lambda_function_name
}

output "cloudwatch_event_rule_id" {
  value = module.lambda_trigger.cloudwatch_event_rule_id
}
