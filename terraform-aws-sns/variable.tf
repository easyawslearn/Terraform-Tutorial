variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "enabled" {
  type    = bool
  default = true
}

variable "sns_topic_policy_enabled" {
  type    = bool
  default = true
}

variable "lambda_function_name" {
  type = string
  default = ""
}

variable "lambda_function_runtime" {
  type = string
  default = ""
}

variable "sns_display_name" {
  type    = string
  default = ""
}

variable "cloudwatch_event_rule_name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "description" {
  type        = string
  default     = ""
  description = "The description for the rule."
}

variable "role_arn" {
  type        = string
  default     = ""
  description = "The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
}

variable "is_enabled" {
  type        = bool
  default     = true
  description = "Whether the rule should be enabled (defaults to true)."
}

variable "target_id" {
  type        = string
  default     = "SendToSNS"
  description = "The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
}

variable "arn" {
  type        = string
  default     = ""
  description = "The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
}

variable "input_path" {
  type        = string
  default     = ""
  description = "The value of the JSONPath that is used for extracting part of the matched event when passing it to the target."
}

variable "target_role_arn" {
  type        = string
  default     = ""
  description = "The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. Required if ecs_target is used."
}

variable "input_paths" {
  type        = map(any)
  default     = {}
  description = "Key value pairs specified in the form of JSONPath (for example, time = $.time)"

}

variable "sns_name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "subscribers" {
  type = map(object({
    protocol = string
    # The protocol to use. The possible values for this are: sqs, sms, lambda, application. (http or https are partially supported, see below) (email is an option but is unsupported, see below).
    endpoint = string
    # The endpoint to send data to, the contents will vary with the protocol. (see below for more information)
    endpoint_auto_confirms = bool
    # Boolean indicating whether the end point is capable of auto confirming subscription e.g., PagerDuty (default is false)
    raw_message_delivery = bool
    # Boolean indicating whether or not to enable raw message delivery (the original message is directly passed, not wrapped in JSON with the original message in the message property) (default is false)
  }))
  description = "Required configuration for subscibres to SNS topic."
  default     = {}
}

variable "allowed_aws_services_for_sns_published" {
  type        = list(string)
  description = "AWS services that will have permission to publish to SNS topic. Used when no external JSON policy is used"
  default     = []
}

variable "kms_master_key_id" {
  type        = string
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SNS or a custom CMK."
  default     = "alias/aws/sns"
}

variable "encryption_enabled" {
  type        = bool
  description = "Whether or not to use encryption for SNS Topic. If set to `true` and no custom value for KMS key (kms_master_key_id) is provided, it uses the default `alias/aws/sns` KMS key."
  default     = true
}

variable "sqs_queue_kms_master_key_id" {
  type        = string
  description = "The ID of an AWS-managed customer master key (CMK) for Amazon SQS Queue or a custom CMK"
  default     = "alias/aws/sqs"
}

variable "sqs_queue_kms_data_key_reuse_period_seconds" {
  type        = number
  description = "The length of time, in seconds, for which Amazon SQS can reuse a data key to encrypt or decrypt messages before calling AWS KMS again"
  default     = 300
}

variable "allowed_iam_arns_for_sns_publish" {
  type        = list(string)
  description = "IAM role/user ARNs that will have permission to publish to SNS topic. Used when no external json policy is used."
  default     = []
}

variable "sns_topic_policy_json" {
  type        = string
  description = "The fully-formed AWS policy as JSON"
  default     = ""
}

variable "sqs_dlq_enabled" {
  type        = bool
  description = "Enable delivery of failed notifications to SQS and monitor messages in queue."
  default     = false
}

variable "sqs_dlq_max_message_size" {
  type        = number
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB)."
  default     = 262144
}

variable "sqs_dlq_message_retention_seconds" {
  type        = number
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)."
  default     = 1209600
}

variable "delivery_policy" {
  type        = string
  description = "The SNS delivery policy as JSON."
  default     = null
}

variable "fifo_topic" {
  type        = bool
  description = "Whether or not to create a FIFO (first-in-first-out) topic"
  default     = false
}

variable "fifo_queue_enabled" {
  type        = bool
  description = "Whether or not to create a FIFO (first-in-first-out) queue"
  default     = false
}

variable "content_based_deduplication" {
  type        = bool
  description = "Enable content-based deduplication for FIFO topics"
  default     = false
}

variable "redrive_policy_max_receiver_count" {
  type        = number
  description = "The number of times a message is delivered to the source queue before being moved to the dead-letter queue. When the ReceiveCount for a message exceeds the maxReceiveCount for a queue, Amazon SQS moves the message to the dead-letter-queue."
  default     = 5
}

variable "redrive_policy" {
  type        = string
  description = "The SNS redrive policy as JSON. This overrides `var.redrive_policy_max_receiver_count` and the `deadLetterTargetArn` (supplied by `var.fifo_queue = true`) passed in by the module."
  default     = null
}