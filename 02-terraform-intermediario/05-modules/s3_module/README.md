# AWS S3 Terraform module

Terraform module which creates S3 bucket and S3 bucket objects resources on AWS.

These types of resources are supported:

* [S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
* [S3 Bucket Object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object)

## Usage

```hcl
module "bucket" {
  source = "./s3_module"

  name = "my-super-bucket-name"
}
```

## Examples

```hcl
module "bucket" {
  source = "./s3_module"

  name  = random_pet.this.id
  files = "${path.root}/website"

  website = {
    index_document = "index.html"
    error_document = "error.html"
  }
}
```

## Conditional creation




## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
|name|Bucket unique name|string|null| ✅ |
|acl|Bucket ACL|string|private|  |
|files|File path to read and upload to the bucket|string|null|  |

## Outputs

| Name | Description |
|------|-------------|
|name|Bucket name|
|arn|Bucket ARN|
|files|List of files uploaded to the bucket|



## Authors

Module managed by [Cleber Gasparoto](https://github.com/chgasparoto)

## License
