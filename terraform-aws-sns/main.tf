provider "aws" {
  region = var.region
}

resource "aws_cloudwatch_event_rule" "default" {
    count = var.enabled == true ? 1 : 0

  name          = var.cloudwatch_event_rule_name
  description   = var.description
  event_pattern = <<EOF
{
  "detail-type": [
    "AWS Console Sign In via CloudTrail"
  ]
}
EOF
  role_arn   = var.role_arn
  is_enabled = var.is_enabled
}

resource "aws_cloudwatch_event_target" "default" {
  count      = var.enabled == true ? 1 : 0
  rule       = aws_cloudwatch_event_rule.default.*.name[0]
  target_id  = var.target_id
  arn        = aws_sns_topic.this[count.index].arn
  input_path = var.input_path != "" ? var.input_path : null
  role_arn   = var.target_role_arn
}

resource "aws_sns_topic" "this" {
  count = var.enabled ? 1 : 0

  name                        = var.sns_name
  display_name                = var.sns_display_name
  kms_master_key_id           = var.kms_master_key_id
  delivery_policy             = var.delivery_policy
  fifo_topic                  = var.fifo_topic
  content_based_deduplication = var.content_based_deduplication
}

resource "aws_sns_topic_subscription" "this" {
  for_each = var.enabled ? var.subscribers : {}

  topic_arn              = join("", aws_sns_topic.this.*.arn)
  protocol               = var.subscribers[each.key].protocol
  endpoint               = aws_lambda_function.terraform_lambda_func.arn
  endpoint_auto_confirms = var.subscribers[each.key].endpoint_auto_confirms
  raw_message_delivery   = var.subscribers[each.key].raw_message_delivery
}

resource "aws_sns_topic_policy" "default" {
  count = var.sns_topic_policy_enabled ? 1 : 0

  arn    = aws_sns_topic.this[count.index].arn
  policy = data.aws_iam_policy_document.sns_topic_policy[count.index].json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  count = var.sns_topic_policy_enabled ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.this[count.index].arn]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "S3cloudHub_Test_Lambda_Function_Role"
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "lambda.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_lambda" {

  name        = "aws_iam_policy_for_terraform_aws_lambda_role"
  path        = "/"
  description = "AWS IAM Policy for managing aws lambda role"
  policy      = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": [
       "logs:CreateLogGroup",
       "logs:CreateLogStream",
       "logs:PutLogEvents"
     ],
     "Resource": "arn:aws:logs:*:*:*",
     "Effect": "Allow"
   }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.iam_policy_for_lambda.arn
}

data "archive_file" "zip_the_python_code" {
  type        = "zip"
  source_dir  = "${path.module}/python/"
  output_path = "${path.module}/python/hello-python.zip"
}

resource "aws_lambda_function" "terraform_lambda_func" {
  filename      = "${path.module}/python/hello-python.zip"
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = var.lambda_function_runtime
  depends_on    = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

# IAM Role Module



data "aws_iam_policy_document" "assume_role" {
  count = var.enabled ? length(keys(var.principals)) : 0

  statement {
    effect  = "Allow"
    actions = var.assume_role_actions

    principals {
        type        = element(keys(var.principals), count.index)
        identifiers = var.principals[element(keys(var.principals), count.index)]
    #   type        = "AWS"
    #   identifiers = ["293328213636"]
    }

    dynamic "condition" {
      for_each = var.assume_role_conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

data "aws_iam_policy_document" "assume_role_aggregated" {
  count                     = var.enabled ? 1 : 0
  override_policy_documents = data.aws_iam_policy_document.assume_role.*.json
}

resource "aws_iam_role" "default" {
  count                = var.enabled ? 1 : 0
  name                 = var.iam_role_name
  assume_role_policy   = join("", data.aws_iam_policy_document.assume_role_aggregated.*.json)
  description          = var.role_description
  max_session_duration = var.max_session_duration
  permissions_boundary = var.permissions_boundary
  path                 = var.path
  tags                 = var.tags_enabled ? var.module_tags : null
}

data "aws_iam_policy_document" "default" {
  count                     = var.enabled && var.policy_document_count > 0 ? 1 : 0
  override_policy_documents = var.policy_documents
}

resource "aws_iam_policy" "default" {
  count       = var.enabled && var.policy_document_count > 0 ? 1 : 0
  name        = var.iam_policy_name
  description = var.policy_description
  policy      = join("", data.aws_iam_policy_document.default.*.json)
  path        = var.path
  tags        = var.tags_enabled ? var.module_tags : null
}

resource "aws_iam_role_policy_attachment" "default" {
  count      = var.enabled && var.policy_document_count > 0 ? 1 : 0
  role       = join("", aws_iam_role.default.*.name)
  policy_arn = join("", aws_iam_policy.default.*.arn)
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each   = var.enabled ? var.managed_policy_arns : []
  role       = join("", aws_iam_role.default.*.name)
  policy_arn = each.key
}

resource "aws_iam_instance_profile" "default" {
  count = var.enabled && var.instance_profile_enabled ? 1 : 0
  name  = var.instance_profile_name
  role  = join("", aws_iam_role.default.*.name)
}