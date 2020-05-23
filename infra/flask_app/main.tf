resource "aws_iam_role" "lambda_iam_role" {
  force_detach_policies = true
  name                  = "flask-lambda-iam-role"
  assume_role_policy    = data.aws_iam_policy_document.assume_role_lambda.json
  path                  = "/${var.project_name}/api-gateway/"
}

resource "aws_iam_policy" "inline_policy" {
  name   = "flask-lambda-iam-role-policy"
  policy = data.aws_iam_policy_document.lambda_access_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_iam_to_policy_attachment" {
  policy_arn = aws_iam_policy.inline_policy.arn
  role       = aws_iam_role.lambda_iam_role.name
}

resource "random_string" "flask-secret" {
  length  = 16
  special = true
}

resource "random_string" "jwt-secret" {
  length  = 16
  special = true
}

resource "random_string" "jwt-private-key" {
  length  = 16
  special = true
}
