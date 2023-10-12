variable "name" {
  description = "Name of bucket."
  type        = string
}

variable "bucket_used_for_FTP" {
  description = "This bucket will be used for FTP transfer, and should deploy a policy for access."
  default     = false
}

variable "enable_versioning" {
  description = "Whether or not the bucket will have versioning enabled."
  default     = false
}

variable "long_term_storage" {
  description = "Whether or not we transfer data to long-term storage."
  default     = false
}

variable "IA_storage_interval" {
  description = "The number of days until S3 data gets transitioned to IA."
  default     = 90
}

variable "glacier_storage_interval" {
  description = "The number of days until S3 data gets transitioned to Glacier."
  default     = 180
}

variable "block_public_acls" {
  description = "Block new public ACLs and uploading public objects."
  default     = true
}

variable "ignore_public_acls" {
  description = "Retroactively remove public access granted through public ACLs."
  default     = true
}

variable "block_public_policy" {
  description = "Block new public bucket policies"
  default     = true
}

variable "restrict_public_buckets" {
  description = "Retroactivley block public and cross-account access if bucket has public policies."
  default     = true
}

