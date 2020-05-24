resource "aws_cognito_user_pool" "user_pool" {
  name                     = "flask-example-pool"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  username_configuration {
    case_sensitive = false
  }

  admin_create_user_config {
    invite_message_template {
      email_subject = "Your super secret temporary password"
      email_message = "{username} your temp password is {####}"
      sms_message   = "{username} your temp password is {####}"
    }
  }
  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "Verification code: {####}"
    email_subject        = "Cognito verification code"
  }
  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_uppercase                = true
    require_numbers                  = true
    require_symbols                  = true
    temporary_password_validity_days = 7
  }
  device_configuration {
    device_only_remembered_on_user_prompt = true
    challenge_required_on_new_device      = true
  }
}

resource "aws_cognito_user_pool_client" "client" {
  name                                 = "flask-example-client"
  user_pool_id                         = aws_cognito_user_pool.user_pool.id
  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["code"]
  allowed_oauth_scopes                 = ["email", "openid"]
  prevent_user_existence_errors        = "ENABLED"
  supported_identity_providers         = ["COGNITO"]
  # TODO: What if prod is on a custom domain?
  callback_urls = [join("", [var.url, "/loggedin"])]
  logout_urls   = [var.url]
}


resource "aws_cognito_user_pool_domain" "main" {
  domain       = "martincampbell"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}
