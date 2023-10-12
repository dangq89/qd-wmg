# Required
variable "name" {
  description = "Name of Lambda function."
  type        = string
}

variable "ecr_repo_name" {
  description = "Name of ECR repository that containes image for function."
  type        = string
}

variable "ecr_image_tag" {
  description = "Image tag to use from Lambda ECR repository."
  type        = string
  default     = "latest"
}

variable "publish" {
  description = "Whether to publish creation/change as new Lambda Function Version"
  default = false
  type = string
}

variable "timeout" {
  description = "Seconds before function times out."
  type        = number
  default     = 300
}

variable "memory_size" {
  description = "Amount of memory in MB for Lambda funciton."
  type        = number
  default     = 128
}

variable "architecture" {
  description = "Lambda architecture platform"
  type        = list(string)
  default     = ["arm64"]
  
}
