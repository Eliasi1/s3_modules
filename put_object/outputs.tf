
output "s3_object_id" {
  value = "${aws_s3_bucket_object.put_object.id}"
}
