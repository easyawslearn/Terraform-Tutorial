resource "aws_s3_bucket" "iam_demo_bucket_name" {
    bucket = "iambucketdemo-dfredf"
    acl="private"

    tags = {
    Name        = "My bucket"
    Environment = "Demo"
  }
  
}