variable "billing_tag" {
  description = "billing tag of the bucket"
  default = "00000"
}

variable "domain_name" {
  description = "bucket name has to be domain name for hosting static web"
  }

variable "path_to_index" {
  description = "path to html index file"
}

variable "path_to_error" {
  description = "path to html error file"
}

variable "path_to_bucket_policy" {
  description = "path to S3 web bucket policy"
}

variable "path_to_routing_rules" {
  description = "path to S3 web bucket routing rules"
}

