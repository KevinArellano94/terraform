resource "aws_appsync_graphql_api" "example" {
  authentication_type = "API_KEY"
  name                = "example"
}

resource "aws_appsync_api_cache" "example" {
  api_id               = aws_appsync_graphql_api.example.id
  api_caching_behavior = "FULL_REQUEST_CACHING"
  type                 = "LARGE"
  ttl                  = 900
}

resource "aws_appsync_api_key" "example" {
  api_id  = aws_appsync_graphql_api.example.id
  expires = "2018-05-03T04:00:00Z"
}