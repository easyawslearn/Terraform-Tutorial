#! /bin/bash
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo service httpd start
sudo service httpd enable
echo "<h1>Welcome to apche server</h1>" | sudo tee /var/www/html/index.html
