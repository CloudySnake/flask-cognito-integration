resource "aws_ssm_parameter" "flask_iam_role" {
  name  = "/${var.project_name}/lambda-iam-role/arn"
  type  = "String"
  value = aws_iam_role.lambda_iam_role.arn
}

resource "aws_ssm_parameter" "flask_secret" {
  name  = "/${var.project_name}/flask-secret"
  type  = "String"
  value = random_string.flask-secret.id
}

resource "aws_ssm_parameter" "jwt_secret" {
  name  = "/${var.project_name}/jwt-secret"
  type  = "String"
  value = random_string.jwt-secret.id
}

resource "aws_ssm_parameter" "jwt_private_key" {
  name  = "/${var.project_name}/jwt-private-key"
  type  = "String"
  value = random_string.jwt-private-key.id
}
