#!/bin/sh

ENV="dev"

if [ "$1" = "prod" ]; then
  ENV="prod"
fi

echo "----------------------------------------"
echo "Formatting terraform files"
terraform fmt
echo "----------------------------------------"
terraform init -backend=true -backend-config="${ENV}/backend.hcl"
echo "----------------------------------------"
echo "Validating terraform files"
terraform validate
echo "----------------------------------------"
echo "Planning..."
terraform plan -var-file="$ENV/terraform.tfvars" -out="plan.tfout"
echo "----------------------------------------"
echo "Applying..."
terraform apply plan.tfout
echo "----------------------------------------"
echo "Cleaning up plan file"
rm -rf plan.tfout
echo "----------------------------------------"
