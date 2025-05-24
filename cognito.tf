resource "aws_cognito_user_pool" "user_pool" {
  name = "cpf-auth-user-pool"

  auto_verified_attributes = []

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = false
  }

  admin_create_user_config {
    allow_admin_create_user_only = false
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "cpf-auth-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH"
  ]

  supported_identity_providers = ["COGNITO"]

  allowed_oauth_flows_user_pool_client = false
}
