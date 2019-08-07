#!/bin/sh

ENV="dev"

if [ "$1" = "prod" ]; then
  ENV="prod"
fi

terraform destroy -var-file="${ENV}/terraform.tfvars" -auto-approve
rm -rf .terraform