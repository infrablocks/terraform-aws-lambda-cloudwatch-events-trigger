resource "aws_lambda_function" "lambda" {
  filename = var.lambda_zip_path
  function_name = var.lambda_function_name
  role = aws_iam_role.lambda_execution_role.arn
  handler = var.lambda_handler
  source_code_hash = "${base64sha256(filebase64(var.lambda_zip_path))}"
  runtime = var.lambda_runtime
  timeout = var.lambda_timeout
  memory_size = var.lambda_memory_size
  environment {
    variables = var.lambda_environment_variables
  }

  vpc_config {
    security_group_ids = [
      "${aws_security_group.sg_lambda.id}"]
    subnet_ids = var.lambda_subnet_ids
  }

}