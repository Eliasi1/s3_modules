this module will put an object in a bucket

variables required:
path_to_file - The path to a file that will be read and uploaded as raw bytes for the object content
key - The name of the object once it is in the bucket
bucket_name - The bucket where to put the object

example:

module "put_object" {
  source = "../s3/put_object"
  
  bucket_name = "${var.bucket_name}"
  key = "${var.key_name}"
  path_to_file = "${var.path_to_file}"

}