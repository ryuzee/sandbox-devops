#!/bin/sh
echo "================================================="
uname -a
echo "================================================="

yum install -y httpd php php-mbstring php-pdo php-mysql mysql-server
/sbin/chkconfig --level 2345 mysqld on
/sbin/chkconfig --level 2345 httpd on
\rm /etc/httpd/conf.d/welcome.conf
echo "<?php phpinfo(); ?>" > /var/www/html/index.php
/etc/rc.d/init.d/httpd start
/etc/rc.d/init.d/mysqld start
 
cat << END > /etc/sysconfig/iptables
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 22 -j ACCEPT
-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
END
 
/etc/rc.d/init.d/iptables restart
