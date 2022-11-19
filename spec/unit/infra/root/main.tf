data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "lambda_trigger" {
  source = "../../../.."

  region = var.region
  component = var.component
  deployment_identifier = var.deployment_identifier

  lambda_arn = data.terraform_remote_state.prerequisites.outputs.lambda_arn
  lambda_function_name = data.terraform_remote_state.prerequisites.outputs.lambda_function_name

  lambda_schedule_expression = var.lambda_schedule_expression
}
