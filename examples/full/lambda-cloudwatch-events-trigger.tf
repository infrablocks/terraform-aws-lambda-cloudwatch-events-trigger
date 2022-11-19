module "lambda_trigger" {
  source = "../../"

  region = var.region
  component = var.component
  deployment_identifier = var.deployment_identifier

  lambda_arn = module.lambda.lambda_arn
  lambda_function_name = module.lambda.lambda_arn

  lambda_schedule_expression = "rate(2 minutes)"
}
