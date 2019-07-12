resource "aws_security_group" "sg_lambda" {
  description = "${var.deployment_identifier}-lambda"
  vpc_id = var.vpc_id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = var.lambda_ingress_cidr_blocks
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = var.lambda_egress_cidr_blocks
  }
}
