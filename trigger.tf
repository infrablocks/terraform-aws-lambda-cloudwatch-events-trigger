resource "aws_cloudwatch_event_rule" "event_rule" {
  schedule_expression = local.lambda_schedule_expression
}

// TODO: rename this resource during next major upgrade
resource "aws_cloudwatch_event_target" "check_at_rate" {
  rule = aws_cloudwatch_event_rule.event_rule.name
  arn = var.lambda_arn
}

// TODO: rename this resource during next major upgrade
resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
  statement_id = "AllowExecutionFromCloudWatch"
  action = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal = "events.amazonaws.com"
  source_arn = aws_cloudwatch_event_rule.event_rule.arn
}
