module "lambda" {
  source  = "infrablocks/lambda/aws"
  version = "2.0.0-rc.4"

  region = var.region

  component = var.component
  deployment_identifier = var.deployment_identifier

  lambda_function_name = var.lambda_function_name
  lambda_description = var.lambda_description

  lambda_runtime = "nodejs20.x"

  lambda_zip_path = var.lambda_zip_path
  lambda_handler = var.lambda_handler
}
