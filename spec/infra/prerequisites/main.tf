
module "base_network" {
  source  = "infrablocks/base-networking/aws"
  version = "0.8.0-rc.2"

  region = "${var.region}"
  vpc_cidr = "${var.vpc_cidr}"
  availability_zones = "${var.availability_zones}"

  component = "${var.component}"
  deployment_identifier = "${var.deployment_identifier}"

  private_zone_id = "${var.private_zone_id}"

  infrastructure_events_bucket = "${var.infrastructure_events_bucket}"
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.component}-${var.deployment_identifier}"
  description = "${var.component}-${var.deployment_identifier} REST API"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}