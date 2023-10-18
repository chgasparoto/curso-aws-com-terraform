# AWS S3 Object Terraform module

Terraform module to handle S3 bucket objects resources on AWS.

These types of resources are supported:

- [S3 Bucket Object](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object)

## Usage

```hcl
module "bucket" {
  source = "github.com/chgasparoto/terraform-s3-object-notification/modules/object"

  bucket     = aws_s3_bucket.this.bucket
  filepath   = var.filepath
  key_prefix = var.key_prefix
}
```

## Examples

- [S3 Notifications](../../examples/static-website)

## Requirements

| Name      | Version    |
| --------- | ---------- |
| terraform | >= 0.12.10 |
| aws       | >= 3.0     |

## Inputs

| Name       | Description                                                                                       |   Type   | Default | Required |
| ---------- | ------------------------------------------------------------------------------------------------- | :------: | :-----: | :------: |
| bucket     | Bucket unique name                                                                                | `string` | `null`  |    ✅    |
| filepath   | string                                                                                            | `string` | `null`  |    ✅    |
| key_prefix | Prefix to put your key(s) inside the bucket. E.g.: logs -> all files will be uploaded under logs/ | `string` |         |          |

## Outputs

| Name    | Description                                   |
| ------- | --------------------------------------------- |
| objects | Set of objects created on the given S3 bucket |

## Authors

Module managed by [Cleber Gasparoto](https://github.com/chgasparoto)

## License

[MIT](LICENSE)
