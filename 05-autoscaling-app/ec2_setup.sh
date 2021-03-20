#!/bin/bash
sudo apt-get update
sudo apt-get install -y apache2
echo 'Hello from Terraform' > /var/www/html/index.html
service httpd start

sudo apt-get install -y stress-ng

# sudo stress-ng --cpu 32 --timeout 180 --metrics-brief
