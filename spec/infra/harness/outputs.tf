output "security_group_name" {
  value = "${module.lambda.security_group_name}"
}

output "iam_role_name" {
  value = "${module.lambda.iam_role_name}"
}
output "iam_role_policy_name" {
  value = "${module.lambda.iam_role_policy_name}"
}