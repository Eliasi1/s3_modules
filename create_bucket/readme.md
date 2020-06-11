This module create a bucket.

required variables:
bucket_name - bucket name
write_user_arn - user's arn to have read write permission on this bucket
acl - the access list of the bucket. can be "public-read" or "private"

example:

module "create_bucket" {
  source = "../s3/create_bucket"

  bucket_name = "${var.bucket_name}"
  write_user_arn = "${var.write_user_arn}"
}