data "aws_caller_identity" "current" {
}

resource "aws_iam_role" "proxy_lambda_execution_role" {
  description               = "proxy_lambda_execution_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "proxy_lambda_execution_policy" {
  role = aws_iam_role.proxy_lambda_execution_role.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:DescribeNetworkInterfaces",
        "ec2:CreateNetworkInterface",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs"
      ],
      "Resource": [
        "*"
      ]
    },
    {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:eu-west-1:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:eu-west-1:702464176885:*"
            ]
        }
  ]
}
EOF

}

resource "aws_security_group" "sg_lambda" {
description = "proxy-lambda-${var.deployment_identifier}"
vpc_id      = var.vpc_id

ingress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = var.lambda_ingress_cidr_blocks
}

egress {
from_port   = 0
to_port     = 0
protocol    = "-1"
cidr_blocks = var.lambda_egress_cidr_blocks
}
}

resource "aws_lambda_function" "lambda" {
filename         = var.lambda_zip_path
function_name    = var.lambda_function_name
role             = aws_iam_role.proxy_lambda_execution_role.arn
handler          = var.lambda_handler
source_code_hash = "${base64sha256(filebase64(var.lambda_zip_path))}"
runtime          = var.lambda_runtime
timeout          = var.lambda_timeout
memory_size      = var.lambda_memory_size
environment {
  variables = var.lambda_environment_variables
}

vpc_config {
  security_group_ids = ["${aws_security_group.sg_lambda.id}"]
  subnet_ids = var.lambda_subnet_ids
}

}

