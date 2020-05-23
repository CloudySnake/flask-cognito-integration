resource "aws_ssm_parameter" "flask_gateway_id" {
  name  = "/${var.project_name}/api-gateway/rest-api-id"
  type  = "String"
  value = aws_api_gateway_rest_api.flask_gateway.id
}

resource "aws_ssm_parameter" "webhook_gateway_root_resource_id" {
  name  = "/${var.project_name}/api-gateway/root-resource-id"
  type  = "String"
  value = aws_api_gateway_rest_api.flask_gateway.root_resource_id
}

resource "aws_ssm_parameter" "flask_gateway_url" {
  name  = "/${var.project_name}/api-gateway/url"
  type  = "String"
  value = aws_api_gateway_deployment.stage_deployment.invoke_url
}

output "flask_url" {
  value = aws_api_gateway_deployment.stage_deployment.invoke_url
}
