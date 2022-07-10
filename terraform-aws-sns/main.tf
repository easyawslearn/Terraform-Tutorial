## Managed By : S3CloudHub
## Description : This Script is used to create SNS Platform Application, SNS Topic, Topic Subscription and Sms Preferences.
## Copyright @ S3CloudHub. All Right Reserved.

#Module      : label
#Description : This terraform module is designed to generate consistent label names and
#              tags for resources. You can use terraform-labels to implement a strict
#              naming convention.
module "labels" {
  source  = "F:/Office_Work/git-clone-easyaws/Terraform-Tutorial\terraform-aws-sns"
  version = "0.15.0"

  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  attributes  = var.attributes
  label_order = var.label_order
}

#Module      : SNS
#Description : Terraform module is used to setup SNS service to manage notifications on
#              application.
resource "aws_sns_platform_application" "default" {
  count = var.enabled && var.enable_sns ? 1 : 0

  name                             = module.labels.id
  platform                         = var.platform
  platform_credential              = length(var.gcm_key) > 0 ? var.gcm_key : file(var.key)
  platform_principal               = length(var.gcm_key) > 0 ? var.gcm_key : file(var.certificate)
  event_delivery_failure_topic_arn = var.event_delivery_failure_topic_arn
  event_endpoint_created_topic_arn = var.event_endpoint_created_topic_arn
  event_endpoint_deleted_topic_arn = var.event_endpoint_deleted_topic_arn
  event_endpoint_updated_topic_arn = var.event_endpoint_updated_topic_arn
  failure_feedback_role_arn        = var.failure_feedback_role_arn
  success_feedback_role_arn        = var.success_feedback_role_arn
  success_feedback_sample_rate     = var.success_feedback_sample_rate
}

#Module      : SNS TOPIC
#Description : Terraform module which creates SNS Topic resources on AWS
#tfsec:ignore:aws-sns-enable-topic-encryption
resource "aws_sns_topic" "default" {
  count = var.enabled && var.enable_topic ? 1 : 0

  name                                     = module.labels.id
  display_name                             = var.display_name
  policy                                   = var.policy
  delivery_policy                          = var.delivery_policy
  application_success_feedback_role_arn    = var.application_success_feedback_role_arn
  application_success_feedback_sample_rate = var.application_success_feedback_sample_rate
  application_failure_feedback_role_arn    = var.application_failure_feedback_role_arn
  http_success_feedback_role_arn           = var.http_success_feedback_role_arn
  http_success_feedback_sample_rate        = var.http_success_feedback_sample_rate
  http_failure_feedback_role_arn           = var.http_failure_feedback_role_arn
  kms_master_key_id                        = var.kms_master_key_id
  lambda_success_feedback_role_arn         = var.lambda_success_feedback_role_arn
  lambda_success_feedback_sample_rate      = var.lambda_success_feedback_sample_rate
  lambda_failure_feedback_role_arn         = var.lambda_failure_feedback_role_arn
  sqs_success_feedback_role_arn            = var.sqs_success_feedback_role_arn
  sqs_success_feedback_sample_rate         = var.sqs_success_feedback_sample_rate
  sqs_failure_feedback_role_arn            = var.sqs_failure_feedback_role_arn
  tags                                     = module.labels.tags
}

#Module      : SNS TOPIC SUBSCRIPTION
#Description : Terraform module which creates SNS Topic Subscription resources on AWS
resource "aws_sns_topic_subscription" "this" {
  for_each                        = var.subscribers
  topic_arn                       = join("", aws_sns_topic.default.*.arn)
  protocol                        = var.subscribers[each.key].protocol
  endpoint                        = var.subscribers[each.key].endpoint
  endpoint_auto_confirms          = var.subscribers[each.key].endpoint_auto_confirms
  raw_message_delivery            = var.subscribers[each.key].raw_message_delivery
  filter_policy                   = var.subscribers[each.key].filter_policy
  delivery_policy                 = var.subscribers[each.key].delivery_policy
  confirmation_timeout_in_minutes = var.subscribers[each.key].confirmation_timeout_in_minutes

}


#Module      : SNS SMS Preferences
#Description : Terraform module which creates SNS SMS Preferences on AWS
resource "aws_sns_sms_preferences" "default" {
  count = var.enabled && var.enable_sms_preference ? 1 : 0

  monthly_spend_limit                   = var.monthly_spend_limit
  delivery_status_iam_role_arn          = var.delivery_status_iam_role_arn
  delivery_status_success_sampling_rate = var.delivery_status_success_sampling_rate
  default_sender_id                     = var.default_sender_id
  default_sms_type                      = var.default_sms_type
  usage_report_s3_bucket                = var.usage_report_s3_bucket
}
