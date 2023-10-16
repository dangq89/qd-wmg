# # Roles
resource "aws_iam_role" "lambda_role" {
  name = "${var.name}-role"

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
      }
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
          "s3:Get*",
          "s3:Put*",
          "s3:List*"
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
        Resource = "${aws_ecr_repository.wmg.arn}"
      }
    ]
  })
}

# data "aws_iam_policy_document" "lambda_invoke_policy" {
#   statement {
#     sid     = "LambdaInvoke"
#     actions = ["lambda:InvokeFunction"]
#     effect  = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["s3.amazonaws.com"]
#     }


#     condition {
#       test     = "StringEquals"
#       variable = "AWS:SourceAccoun"
#       values   = ["881700076394"]
#     }

#     condition {
#       test     = "ArnLike"
#       variable = "AWS:SourceArn"
#       values   = ["${module.watchmaer_input_bucker.bucket_arn}"]
#     }
#   }
# }

resource "aws_iam_role_policy_attachment" "lambda_role_attach_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_role_policy.arn
}