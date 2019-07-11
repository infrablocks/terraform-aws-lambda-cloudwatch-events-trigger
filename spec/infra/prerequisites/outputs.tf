output "vpc_id" {
  value = "${module.base_network.vpc_id}"
}

output "vpc_cidr" {
  value = "${module.base_network.vpc_cidr}"
}

output "public_subnet_ids" {
  value = "${module.base_network.public_subnet_ids}"
}

output "private_subnet_ids" {
  value = "${module.base_network.private_subnet_ids}"
}

output "api_gateway_id" {
  value = "${aws_api_gateway_rest_api.api.id}"
}

output "api_gateway_root_resource_id" {
  value = "${aws_api_gateway_rest_api.api.root_resource_id}"
}