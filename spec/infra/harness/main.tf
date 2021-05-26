data "terraform_remote_state" "prerequisites" {
  backend = "local"

  config = {
    path = "${path.module}/../../../../state/prerequisites.tfstate"
  }
}

module "lambda_trigger" {
  # This makes absolutely no sense. I think there's a bug in terraform.
  source = "./../../../../../../../"
  region = var.region
  component = var.component
  deployment_identifier = var.deployment_identifier

  lambda_arn = data.terraform_remote_state.prerequisites.outputs.lambda_arn
  lambda_function_name = data.terraform_remote_state.prerequisites.outputs.lambda_function_name

  lambda_schedule_expression = "rate(10 minutes)"
}
