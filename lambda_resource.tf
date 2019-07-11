resource "aws_api_gateway_resource" "lambda_resource" {
  rest_api_id = "${var.api_gateway_id}"
  parent_id   = "${var.api_gateway_root_resource_id}"
  path_part   = "${var.resource_path_part}"
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = "${var.api_gateway_id}"
  resource_id   = "${aws_api_gateway_resource.lambda_resource.id}"
  http_method   = "POST"
  authorization = "NONE"

  request_models = {
    "application/json" = "Error"
  }
}

resource "aws_api_gateway_integration" "lambda_integration" {
  rest_api_id             = "${var.api_gateway_id}"
  resource_id             = "${aws_api_gateway_resource.lambda_resource.id}"
  http_method             = "${aws_api_gateway_method.any.http_method}"
  integration_http_method = "${var.resource_http_method}"

  type = "AWS_PROXY"
  uri  = aws_lambda_function.lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "apigateway.amazonaws.com"

  source_arn = "arn:aws:execute-api:${var.region}:${var.account_id}:${var.api_gateway_id}/*/${aws_api_gateway_method.any.http_method}${aws_api_gateway_resource.lambda_resource.path}"
}

