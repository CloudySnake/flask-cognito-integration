data "aws_iam_policy_document" "api_gateway_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole", ]

    principals {
      identifiers = ["apigateway.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "api_gateway_access_policy" {
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:FilterLogEvents"
    ]
    resources = ["*"]
  }
}


data "aws_iam_policy_document" "assume_role_lambda" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}

data "aws_iam_policy_document" "lambda_access_policy" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogStream", "logs:CreateLogGroup", "logs:DescribeLogStreams"]
    resources = ["arn:aws:logs:eu-west-1:${var.aws_account_id}:log-group:/aws/lambda/${var.project_name}-*:*"]

  }
  statement {
    effect    = "Allow"
    actions   = ["logs:PutLogEvents"]
    resources = ["arn:aws:logs:eu-west-1:${var.aws_account_id}:log-group:/aws/lambda/${var.project_name}-*:*:*"]
  }
}
