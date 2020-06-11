

variable "bucket_name" {
    description = "the name of the bucket to put the file in. S3 access point can be specified."
    default = "dev-bucket"
  }

variable "path_to_file" {
  description = " The path to a file that will be read and uploaded as raw bytes for the object content"
}

variable "key" {
  description = "The name of the object once it is in the bucket"
}

