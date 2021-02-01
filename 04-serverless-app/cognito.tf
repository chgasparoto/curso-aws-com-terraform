resource "aws_cognito_user_pool" "this" {
  name = var.service_name
  tags = local.common_tags
}

resource "aws_cognito_user_pool_client" "this" {
  name                = "website"
  user_pool_id        = aws_cognito_user_pool.this.id
  generate_secret     = false
  explicit_auth_flows = ["ADMIN_NO_SRP_AUTH"]
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = var.service_domain
  user_pool_id = aws_cognito_user_pool.this.id
}
