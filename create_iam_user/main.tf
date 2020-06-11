###################################################################################
# DATA
#################################################################################


data "template_file" "s3_user_policy_rw" {
  template = "${file("${path.module}\\templates\\s3_user_policy_rw.tpl")}"

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


