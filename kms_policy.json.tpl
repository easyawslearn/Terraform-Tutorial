{
  "Version": "2012-10-17",
  "Id": "kms-key-policy",
  "Statement": [
    {
      "Sid": "Enable IAM User Permissions",
      "Effect": "Allow",
      "Principal": {"AWS": "arn:aws:iam::${account_id}:root","Service": "logs.us-east-1.amazonaws.com"},
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
