# # Roles
resource "aws_iam_role" "lambda_role" {
  name = "lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}

# Policies
resource "aws_iam_policy" "lambda_role_policy" {
  name        = "wmg-lambda-role"
  description = "Allows the dashboard stg bucket to copy data to the dashboard prod bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*"
        ]
        Effect = "Allow"
        Resource = [
          "${module.watchmaker_input_bucket.bucket_arn}",
          "${module.watchmaker_input_bucket.bucket_arn}/*",
          "${module.watchmaker_output_bucket.bucket_arn}",
          "${module.watchmaker_output_bucket.bucket_arn}/*",
        ]
      },
      {
        Action = [
          "ecr:*"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:logs:us-west-2:881700076394:log-group:/aws/lambda/wmg-count:*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_role_attach_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_role_policy.arn
}
