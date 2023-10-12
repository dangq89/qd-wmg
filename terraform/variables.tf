# variable "tags" {
#   description = "Map of tags to add to each resource."
#   type        = map(string)
# }

variable "name" {
  description = "name of bucket"
  type        = string
}

# variable "timeout" {
#   description = "Seconds before function times out."
#   type        = number
#   default     = 3
# }

# variable "memory_size" {
#   description = "Amount of memory in MB for Lambda funciton."
#   type        = number
#   default     = 128
# }

# variable "ecr_repo_name" {
#   description = "Name of ECR repository that containes image for function."
#   type        = string
# }

# variable "ecr_image_tag" {
#   description = "Image tag to use from Lambda ECR repository."
#   type        = string
#   default     = "latest"
# }

# variable "lambda_function_name" {
#   description = "Name of lambda function."
#   type        = string
# }