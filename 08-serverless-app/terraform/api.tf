resource "aws_api_gateway_rest_api" "this" {
  name = local.namespaced_service_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Logs
resource "aws_api_gateway_account" "this" {
  count = var.create_logs_for_apigw ? 1 : 0

  cloudwatch_role_arn = aws_iam_role.apigw_send_logs_cw[0].arn
}

resource "aws_api_gateway_authorizer" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  name          = "CognitoUserPoolAuthorizer"
  type          = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.this.arn]
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

resource "aws_api_gateway_resource" "todo" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.todos.id
  path_part   = "{todoId}"
}

resource "aws_api_gateway_method" "todos" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.todos.id
  authorization = "COGNITO_USER_POOLS"
  http_method   = "ANY"
  authorizer_id = aws_api_gateway_authorizer.this.id
}

resource "aws_api_gateway_method" "todo" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.todo.id
  authorization = "COGNITO_USER_POOLS"
  http_method   = "ANY"
  authorizer_id = aws_api_gateway_authorizer.this.id

  request_parameters = {
    "method.request.path.todoId" = true
  }
}

resource "aws_api_gateway_integration" "todos" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.todos.id
  http_method             = aws_api_gateway_method.todos.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_dynamodb.invoke_arn
}

resource "aws_api_gateway_integration" "todo" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.todo.id
  http_method             = aws_api_gateway_method.todo.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = module.lambda_dynamodb.invoke_arn

  request_parameters = {
    "integration.request.path.todoId" = "method.request.path.todoId"
  }
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    # NOTE: The configuration below will satisfy ordering considerations,
    #       but not pick up all future REST API changes. More advanced patterns
    #       are possible, such as using the filesha1() function against the
    #       Terraform configuration file(s) or removing the .id references to
    #       calculate a hash against whole resources. Be aware that using whole
    #       resources will show a difference after the initial implementation.
    #       It will stabilize to only change when resources change afterwards.
    redeployment = sha1(jsonencode([
      aws_api_gateway_account.this,
      aws_api_gateway_resource.todos,
      aws_api_gateway_resource.todo,
      aws_api_gateway_method.todos,
      aws_api_gateway_method.todo,
      aws_api_gateway_integration.todos,
      aws_api_gateway_integration.todo,
      aws_api_gateway_method.cors,
      aws_api_gateway_integration.cors,
      aws_api_gateway_method_response.cors,
      aws_api_gateway_integration_response.cors,
      aws_api_gateway_method.cors_todo,
      aws_api_gateway_integration.cors_todo,
      aws_api_gateway_method_response.cors_todo,
      aws_api_gateway_integration_response.cors_todo,
      aws_api_gateway_gateway_response.cors_4xx,
      aws_api_gateway_gateway_response.cors_5xx,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  deployment_id = aws_api_gateway_deployment.this.id
  stage_name    = var.environment

  dynamic "access_log_settings" {
    for_each = var.create_logs_for_apigw ? [1] : []
    content {
      destination_arn = aws_cloudwatch_log_group.api_gw_logs[0].arn
      format = jsonencode({
        "requestId" : "$context.requestId",
        "extendedRequestId" : "$context.extendedRequestId",
        "ip" : "$context.identity.sourceIp",
        "caller" : "$context.identity.caller",
        "user" : "$context.identity.user",
        "requestTime" : "$context.requestTime",
        "httpMethod" : "$context.httpMethod",
        "resourcePath" : "$context.resourcePath",
        "status" : "$context.status",
        "protocol" : "$context.protocol",
        "responseLength" : "$context.responseLength"
      })
    }
  }
}

resource "aws_api_gateway_domain_name" "this" {
  count = local.create_resource_based_on_domain_name

  domain_name              = aws_acm_certificate.api[0].domain_name
  regional_certificate_arn = aws_acm_certificate_validation.api[0].certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_base_path_mapping" "this" {
  count = local.create_resource_based_on_domain_name

  api_id      = aws_api_gateway_rest_api.this.id
  domain_name = aws_api_gateway_domain_name.this[0].domain_name
  stage_name  = aws_api_gateway_stage.this.stage_name
}

# CORS
resource "aws_api_gateway_method" "cors" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.todos.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cors" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.todos.id
  http_method = aws_api_gateway_method.cors.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "cors" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.todos.id
  http_method = aws_api_gateway_method.cors.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Credentials" = true
    "method.response.header.Access-Control-Allow-Headers"     = false
    "method.response.header.Access-Control-Allow-Methods"     = false
    "method.response.header.Access-Control-Allow-Origin"      = false
  }
}

resource "aws_api_gateway_integration_response" "cors" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.todos.id
  http_method = aws_api_gateway_method.cors.http_method
  status_code = aws_api_gateway_method_response.cors.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers"     = local.formatted_cors.headers
    "method.response.header.Access-Control-Allow-Methods"     = local.formatted_cors.methods
    "method.response.header.Access-Control-Allow-Origin"      = local.formatted_cors.origins
    "method.response.header.Access-Control-Allow-Credentials" = local.formatted_cors.credentials
  }

  depends_on = [aws_api_gateway_integration.cors]
}

resource "aws_api_gateway_gateway_response" "cors_4xx" {
  response_type = "DEFAULT_4XX"
  rest_api_id   = aws_api_gateway_rest_api.this.id

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers"     = local.formatted_cors.headers
    "gatewayresponse.header.Access-Control-Allow-Methods"     = local.formatted_cors.methods
    "gatewayresponse.header.Access-Control-Allow-Origin"      = local.formatted_cors.origins
    "gatewayresponse.header.Access-Control-Allow-Credentials" = local.formatted_cors.credentials
  }
}

resource "aws_api_gateway_gateway_response" "cors_5xx" {
  response_type = "DEFAULT_5XX"
  rest_api_id   = aws_api_gateway_rest_api.this.id

  response_templates = {
    "application/json" = "{\"message\":$context.error.messageString}"
  }

  response_parameters = {
    "gatewayresponse.header.Access-Control-Allow-Headers"     = local.formatted_cors.headers
    "gatewayresponse.header.Access-Control-Allow-Methods"     = local.formatted_cors.methods
    "gatewayresponse.header.Access-Control-Allow-Origin"      = local.formatted_cors.origins
    "gatewayresponse.header.Access-Control-Allow-Credentials" = local.formatted_cors.credentials
  }
}

resource "aws_api_gateway_method" "cors_todo" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.todo.id
  http_method   = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "cors_todo" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.todo.id
  http_method = aws_api_gateway_method.cors_todo.http_method
  type        = "MOCK"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "cors_todo" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.todo.id
  http_method = aws_api_gateway_method.cors_todo.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Credentials" = false
    "method.response.header.Access-Control-Allow-Headers"     = false
    "method.response.header.Access-Control-Allow-Methods"     = false
    "method.response.header.Access-Control-Allow-Origin"      = false
  }
}

resource "aws_api_gateway_integration_response" "cors_todo" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  resource_id = aws_api_gateway_resource.todo.id
  http_method = aws_api_gateway_method.cors_todo.http_method
  status_code = aws_api_gateway_method_response.cors_todo.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers"     = local.formatted_cors.headers
    "method.response.header.Access-Control-Allow-Methods"     = local.formatted_cors.methods
    "method.response.header.Access-Control-Allow-Origin"      = local.formatted_cors.origins
    "method.response.header.Access-Control-Allow-Credentials" = local.formatted_cors.credentials
  }

  depends_on = [aws_api_gateway_integration.cors_todo]
}
