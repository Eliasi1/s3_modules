###################################################################################
# DATA
#################################################################################

data "template_file" "bucket_policy" {
  template = "${file("templates/bucket_policy.tpl")}"

  vars = {
    full_access_user_arn = "${aws_iam_user.write_user.arn}"
    bucket_name          = "${var.bucket_name}"
  }
}
# User Policy

data "template_file" "s3_user_policy_rw" {
  template = "${file("templates/s3_user_policy_rw.tpl")}"

  vars = {
    bucket_name       = "${var.bucket_name}"
}
}
##################################################################################
# RESOURCES
##################################################################################

# S3 Bucket config#
resource "aws_iam_user" "write_user" {
    name = "${var.environment_tag}-s3-write-user"
    force_destroy = true
}

resource "aws_iam_access_key" "write_user" {
    user = "${aws_iam_user.write_user.name}"
}

resource "aws_iam_user_policy" "write_user_pol" {
    name = "write"
    user = "${aws_iam_user.write_user.name}"
    policy= "${data.template_file.s3_user_policy_rw.rendered}"

}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}"
  acl = "public-read"
  region = "us-east-1"
  force_destroy = true
  policy = "${data.template_file.bucket_policy.rendered}"
  tags = {
    environment = "${var.environment_tag}"
  }

}

resource "aws_s3_bucket_object" "docker-compose" {
  bucket = "${aws_s3_bucket.s3_bucket.bucket}"
  key    = "./docker-compose.yml"
  source = "${file(var.path_to_dockercompose)}"

}

