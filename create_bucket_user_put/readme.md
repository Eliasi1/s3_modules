this module will create iam user with r/w permission to a bucket, a bucket, and will put an object in the bucket. 

required variables:
bucket_name - the bucket name to which the user will have access to
write_user_arn - user's arn to have read write permission on this bucket
acl - the access list of the bucket. can be "public-read" or "private"
path_to_file - The path to a file that will be read and uploaded as raw bytes for the object content
key - The name of the object once it is in the bucket