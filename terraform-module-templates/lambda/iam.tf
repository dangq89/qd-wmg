# Lambda Assume Role Policy
data "aws_iam_policy_document" "assume_role" {
  version = "2012-10-17"

  statement {
    sid     = "AssumeRole"
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# Main IAM Role and Policy
data "aws_iam_policy_document" "lambda_policy" {
  version = "2012-10-17"

  statement {
    sid = "EcrFullPermissions"
    actions = [
      "ecr:*"
    ]

    effect = "Allow"

    resources = [
      data.aws_ecr_repository.this.arn
    ]
  }

  statement {
    sid = "S3FullPermissions"
    actions = [
      "s3:*",
    ]

    effect = "Allow"

    resources = ["*"]
  }

    statement {
    sid = "LambdaInvoke"
    actions = [
      "lambda:InvokeFunction"
    ]

    effect = "Allow"

    resources = ["*"]
  }
}

resource "aws_iam_role" "this" {
  name               = "${var.name}-role"
  description        = "IAM role for ${var.name} Lambda function."
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_policy" "this" {
  name        = "${var.name}-policy"
  description = "IAM policy for ${var.name} Lambda function."
  policy      = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}
