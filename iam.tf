data "aws_caller_identity" "current" {
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = "${var.lambda_assume_role}"

}

resource "aws_iam_role_policy" "lambda_execution_policy" {
  role = aws_iam_role.lambda_execution_role.id
  policy = "${var.lambda_execution_policy}"
}

