provider "aws" {
  region     = var.region
}

resource "aws_iam_role" "s3_access_role" {
  name = "s3-access-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
 
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.s3_access_role.name
}

resource "aws_iam_role_policy" "s3_bcuket_access_policy" {
  name = "s3_bcuket_access_policy"
  role = aws_iam_role.s3_access_role.id

   policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*"
        ],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:s3:::iambucketdemo-dfredf",
          "arn:aws:s3:::iambucketdemo-dfredf/*"
          ]
      }
    ]
  }
  EOF
}
