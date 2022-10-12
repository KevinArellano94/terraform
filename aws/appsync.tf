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

resource "aws_dynamodb_table" "example" {
  name           = "example"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }
}

resource "aws_iam_role" "example" {
  name = "example"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "example" {
  name = "example"
  role = aws_iam_role.example.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_dynamodb_table.example.arn}"
      ]
    }
  ]
}
EOF
}