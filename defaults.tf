locals {
  # default for cases when `null` value provided, meaning "use default"
  lambda_schedule_expression = var.lambda_schedule_expression == null ? "rate(5 minutes)" : var.lambda_schedule_expression
}
