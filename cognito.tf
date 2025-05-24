resource "aws_cognito_user_pool" "lanchonete_user_pool" {
  name = "lanchonete-user-pool"

  username_attributes = ["email"]
  alias_attributes    = ["preferred_username"]

  schema {
    name     = "preferred_username"
    required = true
    mutable  = true
    attribute_data_type = "String"
  }

  auto_verified_attributes = []
}

resource "aws_cognito_user_pool_client" "lanchonete_user_pool_client" {
  name         = "lanchonete-user-pool-client"
  user_pool_id = aws_cognito_user_pool.lanchonete_user_pool.id

  generate_secret = false

  explicit_auth_flows = [
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]

  prevent_user_existence_errors = "ENABLED"
  supported_identity_providers  = ["COGNITO"]
}
