variable "aws_region" {
  description = "AWS region to deploy to"
  default     = "us-west-2"
  type        = string
}

variable "aws_profile" {
  description = "AWS profile in config file to use for deployments"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "name" {
  description = "Name of to use for various resources"
  type        = string
}

# ECR
variable "timeout" {
  description = "Seconds before function times out."
  type        = number
  default     = 3
}

variable "memory_size" {
  description = "Amount of memory in MB for Lambda funciton."
  type        = number
  default     = 128
}

variable "image_mutability" {
  description = "Image tags can be overwritten with other image versions or if each image tag can only be used once"
  type        = string
}

variable "ecr_image_tag" {
  description = "Tag to attach to ECR image"
  type        = string
}

# S3
variable "long_term_storage" {
  description = "Enables standard lifecycel policy on s3 objects"
  type        = string
}

variable "versioning" {
  description = "Allows user to store tore multiple versions of an object in the same bucket"
  type        = string
}

# Lambda
variable "architecture" {
  description = "Type of computer processor that Lambda uses to run the function"
  type        = list(string)
}

variable "publish" {
  description = "AWS Lambda assigns a unique version number to the code and configuration"
  type        = string
}
