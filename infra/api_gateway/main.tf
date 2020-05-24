resource "aws_api_gateway_rest_api" "flask_gateway" {
  name = "flask-api-gateway"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "execute-api:Invoke",
      "Resource": "arn:aws:execute-api:*/*/*/*"
    }
  ]
}
EOF
}


resource "aws_api_gateway_deployment" "stage_deployment" {
  rest_api_id = aws_api_gateway_rest_api.flask_gateway.id
  stage_name  = var.stage_name
}

resource "aws_api_gateway_resource" "test_resource" {
  rest_api_id = aws_api_gateway_rest_api.flask_gateway.id
  parent_id   = aws_api_gateway_rest_api.flask_gateway.root_resource_id
  path_part   = "test"
}

resource "aws_api_gateway_method" "test_method" {
  rest_api_id   = aws_api_gateway_rest_api.flask_gateway.id
  resource_id   = aws_api_gateway_resource.test_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "test_integration" {
  rest_api_id = aws_api_gateway_rest_api.flask_gateway.id
  resource_id = aws_api_gateway_resource.test_resource.id
  http_method = aws_api_gateway_method.test_method.http_method
  type        = "MOCK"
}
