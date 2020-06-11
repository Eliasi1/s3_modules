This module will create a write user, with admin permission for a bucket

required variables:
bucket_name - the bucket name to which the user will have access to

example: 

module "create_iam_user" {
  source = "../s3/create_iam_user"

  bucket_name = "${var.bucket_name}"
}

