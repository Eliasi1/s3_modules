output "s3_write_user_access_key" {
    value = "${aws_iam_access_key.write_user.id}"
}

output "s3_write_user_secret_key" {
    value = "${aws_iam_access_key.write_user.secret}"
}

output "s3_write_user_arn" {
  value = "${aws_iam_user.write_user.arn}"
}