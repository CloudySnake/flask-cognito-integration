resource "aws_ssm_parameter" "user_pool_id" {
  name  = "/${var.project_name}/user-pool-id"
  type  = "String"
  value = aws_cognito_user_pool.user_pool.id
}

resource "aws_ssm_parameter" "user_pool_client_id" {
  name  = "/${var.project_name}/user-pool-client-id"
  type  = "String"
  value = aws_cognito_user_pool_client.client.id
}

resource "aws_ssm_parameter" "user_pool_client_secret" {
  name  = "/${var.project_name}/user-pool-client-secret"
  type  = "String"
  value = aws_cognito_user_pool_client.client.client_secret
}

resource "aws_ssm_parameter" "cognito_domain" {
  name  = "/${var.project_name}/cognito-domain"
  type  = "String"
  value = join("", [aws_cognito_user_pool_domain.main.domain, ".auth.eu-west-1.amazoncognito.com"])
}
