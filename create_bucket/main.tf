###################################################################################
# DATA
#################################################################################

data "template_file" "bucket_policy" {
  template = "${file("${path.module}\\templates\\bucket_policy.tpl")}"

  vars = {
    full_access_user_arn = "${var.write_user_arn}"
    bucket_name          = "${var.bucket_name}"
  }
}


##################################################################################
# RESOURCES
##################################################################################

# S3 Bucket config#

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.bucket_name}"
  acl = "${var.acl}"
  region = "us-east-1"
  force_destroy = true
  policy = "${data.template_file.bucket_policy.rendered}"
  tags = {
    billing = "${var.billing_tag}"
  }

}


