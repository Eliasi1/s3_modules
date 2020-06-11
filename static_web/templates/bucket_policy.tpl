{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": ["arn:aws:s3:::${bucket_name}/*","arn:aws:s3:::${bucket_name}"]
        },
        {
            "Sid": "Stmt1585152564410",
            "Effect": "Allow",
            "Principal": {
                "AWS": [
                  "${full_access_user_arn}",
                  "arn:aws:iam::351455087885:user/eliasi"
                  ]
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::${bucket_name}",
                "arn:aws:s3:::${bucket_name}/*"
            ]
        }
    ]
}