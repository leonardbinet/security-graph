output "serverless_admin_access_key" {
  value     = aws_iam_access_key.tf-admin.id
  sensitive = true
}

output "serverless_admin_secret_key" {
  value     = aws_iam_access_key.tf-admin.secret
  sensitive = true
}

output "serverless_lambda_role_arn" {
  value = module.serverless.lambda_role_arn
}