resource "aws_api_gateway_rest_api" "this" {
  name = local.namespaced_service_name
}

resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "v1"
}

resource "aws_api_gateway_resource" "todos" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "todos"
}

resource "aws_api_gateway_authorizer" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  name          = "CognitoUserPoolAuthorizer"
  type          = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.this.arn]
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.todos.id
  authorization = "COGNITO_USER_POOLS"
  http_method   = "ANY"
  authorizer_id = aws_api_gateway_authorizer.this.id
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.todos.id
  http_method             = aws_api_gateway_method.any.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_dynamodb.invoke_arn
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = var.environment

  depends_on = [aws_api_gateway_integration.this]
}

resource "aws_api_gateway_domain_name" "this" {
  count = local.create_resource_based_on_domain_name

  regional_certificate_arn = aws_acm_certificate_validation.api[0].certificate_arn
  domain_name              = aws_acm_certificate.api[0].domain_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "this" {
  count = local.create_resource_based_on_domain_name

  api_id      = aws_api_gateway_rest_api.this.id
  domain_name = aws_api_gateway_domain_name.this[0].domain_name
  stage_name  = aws_api_gateway_deployment.this.stage_name
}
