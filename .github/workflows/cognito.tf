resource "aws_cognito_user_pool" "user_pool" {
  name = "cpf-auth-user-pool"

  alias_attributes = ["email", "preferred_username"]

  schema {
    name = "cpf"
    attribute_data_type = "String"
    mutable = false
    required = true
    string_attribute_constraints {
      min_length = 11
      max_length = 11
    }
  }

  auto_verified_attributes = ["email"]  # Se quiser auto-verificar email

  password_policy {
    minimum_length = 8
    require_lowercase = false
    require_numbers = false
    require_symbols = false
    require_uppercase = false
  }

  mfa_configuration = "OFF"
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name         = "cpf-auth-client"
  user_pool_id = aws_cognito_user_pool.user_pool.id
  generate_secret = false

  allowed_oauth_flows = ["implicit"]
  allowed_oauth_scopes = ["email", "openid", "profile"]
  allowed_oauth_flows_user_pool_client = true

  supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "user_pool_domain" {
  domain       = "cpf-auth-${random_string.suffix.result}"
  user_pool_id = aws_cognito_user_pool.user_pool.id
}

resource "random_string" "suffix" {
  length  = 6
  special = false
}
