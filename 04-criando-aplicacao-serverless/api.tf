resource "aws_api_gateway_rest_api" "this" {
  name        = "${var.api_name}"
  description = "${var.api_description}"
}

resource "aws_api_gateway_resource" "this" {
  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  parent_id   = "${aws_api_gateway_rest_api.this.root_resource_id}"
  path_part   = "todos"
}

resource "aws_api_gateway_authorizer" "this" {
  name          = "CognitoUserPoolAuthorizer"
  type          = "COGNITO_USER_POOLS"
  rest_api_id   = "${aws_api_gateway_rest_api.this.id}"
  provider_arns = ["${aws_cognito_user_pool.this.arn}"]
}

resource "aws_api_gateway_method" "any" {
  rest_api_id   = "${aws_api_gateway_rest_api.this.id}"
  resource_id   = "${aws_api_gateway_resource.this.id}"
  http_method   = "ANY"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = "${aws_api_gateway_authorizer.this.id}"

  authorization_scopes = ["${local.rs_scopes}"]
}

resource "aws_api_gateway_integration" "this" {
  rest_api_id             = "${aws_api_gateway_rest_api.this.id}"
  resource_id             = "${aws_api_gateway_resource.this.id}"
  http_method             = "${aws_api_gateway_method.any.http_method}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.dynamo.invoke_arn}"
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = "${aws_api_gateway_rest_api.this.id}"
  stage_name  = "${var.env}"

  depends_on = ["aws_api_gateway_integration.this"]
}
