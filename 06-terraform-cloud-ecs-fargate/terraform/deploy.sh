#!/bin/sh

ENV="dev"

if [ "$1" = "prod" ]; then
  ENV="prod"
fi

echo "Starting deployment on environemnt $ENV"
echo "----------------------------------------"
echo "Formatting terraform files"
terraform fmt
echo "----------------------------------------"
terraform init
echo "----------------------------------------"
echo "Validating terraform files"
terraform validate
echo "----------------------------------------"
echo "Planning..."
terraform plan -detailed-exitcode -var-file="$ENV/terraform.tfvars" -out="plan"
echo "----------------------------------------"
echo "Applying..."
terraform apply plan
echo "----------------------------------------"
echo "Cleaning up plan file"
rm -rf plan
echo "----------------------------------------"