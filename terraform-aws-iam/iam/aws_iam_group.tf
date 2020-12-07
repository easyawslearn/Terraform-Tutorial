resource "aws_iam_group" "admin" {
  name = "developer-admin-group"
}

resource "aws_iam_policy_attachment" "admin-attach" {
  name       = "admin-attachment"
  groups     = [aws_iam_group.admin.name]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
# Customer Policy Attachment
resource "aws_iam_group" "custom_admin" {
  name = "developer-admin-grp-custom-policy-example"
}
resource "aws_iam_group_policy" "Custom_developer_admin_policy" {
  name  = "my_developer_policy"
  group = aws_iam_group.custom_admin.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_group_membership" "admin-users" {
  user = aws_iam_user.demo-user.name

  groups = [
    aws_iam_group.admin.name
  ]
}

resource "aws_iam_user_group_membership" "admin-users1" {
  user = aws_iam_user.demo-user1.name

  groups = [
    aws_iam_group.admin.name
  ]
}
resource "aws_iam_user" "demo-user" {
  name = "demo-user"
}

resource "aws_iam_user" "demo-user1" {
  name = "demo-user1"
}
