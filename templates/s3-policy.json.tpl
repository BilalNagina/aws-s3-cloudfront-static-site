{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowCloudFrontToRead",
      "Effect": "Allow",
      "Principal": {
        "Service": "cloudfront.amazonaws.com"
      },
      "Action": "s3:GetObject",
      "Resource": "${bucket_arn_all}",
      "Condition": {
        "StringEquals": {
          "AWS:SourceArn": "${distribution_arn}"
        }
      }
    }
  ]
}

