# Terraform-Tutorial


## Introduction

This module will create:
- Elasticsearch cluster with the specified node count in aws
- Elasticsearch domain policy that accepts a list of IAM role ARNs from which to permit management traffic to the cluster

__NOTE:__ To enable [zone awareness](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-managedomains.html#es-managedomains-zoneawareness) to deploy Elasticsearch nodes into two different Availability Zones, you need to set `zone_awareness_enabled` to `true`
If you don't enable zone awareness, Amazon ES places an endpoint into only one subnet.

## Usage

Basic [example](examples/basic)

```hcl
module "elasticsearch" {
  source                  = "git::https://github.com/easyawslearn/Terraform-Tutorial/terraform-aws-elasticsearch.git"
  domain_name             = "eg"
  elasticsearch_version   = "6.5"
  zone_awareness_enabled  = "false"
  instance_type           = "t2.small.elasticsearch"
  instance_count          = 2
  encrypt_at_rest_enabled = true

  advanced_options {
    "rest.action.multi.allow_explicit_index" = "true"
  }
}
```


## Developing

- **Terraform**: v0.11.14
- **Terraform Docs**: https://www.terraform.io/docs/configuration-0-11/index.html



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| advanced_options | Key-value string pairs to specify advanced configuration options | map(string) | `<map>` | no |
| automated_snapshot_start_hour | Hour at which automated snapshots are taken, in UTC | number | `0` | no |
| availability_zone_count | Number of Availability Zones for the domain to use. | number | `2` | no |
| dedicated_master_count | Number of dedicated master nodes in the cluster | number | `0` | no |
| dedicated_master_enabled | Indicates whether dedicated master nodes are enabled for the cluster | bool | `false` | no |
| dedicated_master_type | Instance type of the dedicated master nodes in the cluster | string | `t2.small.elasticsearch` | no |
| ebs_iops | The baseline input/output (I/O) performance of EBS volumes attached to data nodes. Applicable only for the Provisioned IOPS EBS volume type | number | `0` | no |
| ebs_volume_size | EBS volumes for data storage in GB | number | `0` | no |
| ebs_volume_type | Storage type of EBS volumes | string | `gp2` | no |
| elasticsearch_version | Version of Elasticsearch to deploy | string | `6.5` | no |
| enabled | Set to false to prevent the module from creating any resources | bool | `true` | no |
| encrypt_at_rest_enabled | Whether to enable encryption at rest | bool | `true` | no |
| encrypt_at_rest_kms_key_id | The KMS key ID to encrypt the Elasticsearch domain with. If not specified, then it defaults to using the AWS/Elasticsearch service KMS key | string | `` | no |
| instance_count | Number of data nodes in the cluster | number | `4` | no |
| instance_type | Elasticsearch instance type for data nodes in the cluster | string | `t2.small.elasticsearch` | no |
| log_publishing_application_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log for ES_APPLICATION_LOGS needs to be published | string | `` | no |
| log_publishing_application_enabled | Specifies whether log publishing option for ES_APPLICATION_LOGS is enabled or not | bool | `false` | no |
| log_publishing_index_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log for INDEX_SLOW_LOGS needs to be published | string | `` | no |
| log_publishing_index_enabled | Specifies whether log publishing option for INDEX_SLOW_LOGS is enabled or not | bool | `false` | no |
| log_publishing_search_cloudwatch_log_group_arn | ARN of the CloudWatch log group to which log for SEARCH_SLOW_LOGS needs to be published | string | `` | no |
| log_publishing_search_enabled | Specifies whether log publishing option for SEARCH_SLOW_LOGS is enabled or not | bool | `false` | no |
| domain_name | Name of the application | string | - | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | string | `` | no |
| node_to_node_encryption_enabled | Whether to enable node-to-node encryption | bool | `false` | no |
| zone_awareness_enabled | Enable zone awareness for Elasticsearch cluster | bool | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| domain_arn | ARN of the Elasticsearch domain |
| domain_endpoint | Domain-specific endpoint used to submit index, search, and data upload requests |
| domain_hostname | Elasticsearch domain hostname to submit index, search, and data upload requests |
| domain_id | Unique identifier for the Elasticsearch domain |
| elasticsearch_user_iam_role_arn | The ARN of the IAM role to allow access to Elasticsearch cluster |
| elasticsearch_user_iam_role_name | The name of the IAM role to allow access to Elasticsearch cluster |





## References

For additional context, refer to some of these links.

- [What is Amazon Elasticsearch Service](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/what-is-amazon-elasticsearch-service.html) - Complete description of Amazon Elasticsearch Service
- [Amazon Elasticsearch Service Access Control](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-ac.html) - Describes several ways of controlling access to Elasticsearch domains
- [VPC Support for Amazon Elasticsearch Service Domains](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html) - Describes Elasticsearch Service VPC Support and VPC architectures with and without zone awareness
- [Creating and Configuring Amazon Elasticsearch Service Domains](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html) - Provides a complete description on how to create and configure Amazon Elasticsearch Service (Amazon ES) domains
- [Kibana and Logstash](https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-kibana.html) - Describes some considerations for using Kibana and Logstash with Amazon Elasticsearch Service
- [Control Access to Amazon Elasticsearch Service Domain](https://aws.amazon.com/blogs/security/how-to-control-access-to-your-amazon-elasticsearch-service-domain/) - Describes how to Control Access to Amazon Elasticsearch Service Domain
- [elasticsearch_domain](https://www.terraform.io/docs/providers/aws/r/elasticsearch_domain.html) - Terraform reference documentation for the `elasticsearch_domain` resource
- [elasticsearch_domain_policy](https://www.terraform.io/docs/providers/aws/r/elasticsearch_domain_policy.html) - Terraform reference documentation for the `elasticsearch_domain_policy` resource
