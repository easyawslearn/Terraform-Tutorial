# aws-instance-with-ebs-volume

A Terraform module for creating AWS EC2 instance with userdata for creating EBS.

## Usage

```hcl
module "ec2_instance" {
  source     = "git::https://github.com/easyawslearn/Terraform-Tutorial.git/ebc-with-userdata"

  region    = "us-west-2"
  key-name  = "ec2-demo"
  instance_type = "t2.micro"
  ebs_size = "20"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | AWS region | string | us-east-1 | yes |
| key-name | ec2 access key name | string | ec2-demo | yes |
| instance_type | ec2 instance_type | string | t2.micro | yes |
| ebs_size | EBS volume size | string | 20 | yes |
