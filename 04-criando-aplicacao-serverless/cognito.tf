resource "aws_cognito_user_pool" "this" {
  name = var.cg_pool
}

resource "aws_cognito_user_pool_client" "this" {
  name            = var.cg_client
  user_pool_id    = aws_cognito_user_pool.this.id
  generate_secret = true

  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
  # force an interpolation expression to be interpreted as a list by wrapping it
  # in an extra set of list brackets. That form was supported for compatibility in
  # v0.11, but is no longer supported in Terraform v0.12.
  #
  # If the expression in the following list itself returns a list, remove the
  # brackets to avoid interpretation as a list of lists. If the expression
  # returns a single list item then leave it as-is and remove this TODO comment.
  allowed_oauth_scopes = aws_cognito_resource_server.this.scope_identifiers
}

resource "aws_cognito_user_pool_domain" "this" {
  domain       = "${var.cg_domain}-${random_id.bucket.dec}"
  user_pool_id = aws_cognito_user_pool.this.id
}

resource "aws_cognito_resource_server" "this" {
  identifier = var.cg_client
  name       = var.cg_client

  scope {
    scope_name        = "read_todo"
    scope_description = "Read todos"
  }

  scope {
    scope_name        = "create_todo"
    scope_description = "Create todos"
  }

  scope {
    scope_name        = "delete_todo"
    scope_description = "Delete todos"
  }

  user_pool_id = aws_cognito_user_pool.this.id
}

