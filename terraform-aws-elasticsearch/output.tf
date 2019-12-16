
output "domain_arn" {
  value       = join("", aws_elasticsearch_domain.default.*.arn)
  description = "ARN of the Elasticsearch domain"
}

output "domain_id" {
  value       = join("", aws_elasticsearch_domain.default.*.domain_id)
  description = "Unique identifier for the Elasticsearch domain"
}

output "domain_endpoint" {
  value       = join("", aws_elasticsearch_domain.default.*.endpoint)
  description = "Domain-specific endpoint used to submit index, search, and data upload requests"
}

output "elasticsearch_user_iam_role_name" {
  value       = join(",", aws_iam_role.elasticsearch_user.*.name)
  description = "The name of the IAM role to allow access to Elasticsearch cluster"
}

output "elasticsearch_user_iam_role_arn" {
  value       = join(",", aws_iam_role.elasticsearch_user.*.arn)
  description = "The ARN of the IAM role to allow access to Elasticsearch cluster"
}
