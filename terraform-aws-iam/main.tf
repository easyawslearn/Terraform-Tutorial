resource "aws_iam_user" "lb" {
  name = "iam_user_example"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "iam_user_policy"
  user = "${aws_iam_user.lb.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
