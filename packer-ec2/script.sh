#!/bin/sh
sudo sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers
sudo yum upgrade -y
sudo yum install -y httpd php php-mbstring php-pdo php-mysql mysql-server php-xml
sudo /sbin/chkconfig --level 2345 httpd on
sudo \rm /etc/httpd/conf.d/welcome.conf
sudo -c "echo 'OK' > /var/www/html/index.html"
curl -L https://www.opscode.com/chef/install.sh | sudo bash
