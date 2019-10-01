#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo yum service httpd start
sudo yum service httpd enable
echo "<h1>Deployed via Terraform</h1>" | yum tee /var/www/html/index.html
