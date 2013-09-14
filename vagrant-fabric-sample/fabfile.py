from fabric.api import run
from fabric.api import sudo

def kernel_name():
  run('uname -a')

def hostname():
  run('hostname')

def network_info():
  run('/sbin/ifconfig')

def install_pp():
  sudo('yum -y install httpd php php-mbstring')
  sudo('/sbin/chkconfig --level 23454 httpd on')
  sudo('/etc/rc.d/init.d/httpd start')
