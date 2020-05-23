resource "aws_ssm_parameter" "flask-assets" {
  name  = "/${var.project_name}/static-assets"
  type  = "String"
  value = aws_s3_bucket.flask_static_assets.id
}
