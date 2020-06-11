variable "billing_tag" {
  description = "billing tag of the bucket"
  default = "123456"
}

variable "bucket_name" {
  description = "bucket name"
  }

variable "write_user_arn" {
  description = "user's arn to have read write permission on this bucket"
}

variable "acl" {
  default = "public-read" 
}


