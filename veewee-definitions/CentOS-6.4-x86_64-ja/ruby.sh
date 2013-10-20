# Install Ruby
yum -y install git patch 
yum -y install libffi-devel bison libxml2-devel libxslt-devel libyaml-devel

wget --no-check-certificate -O rvm-installer https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer
chmod 755 ./rvm-installer && ./rvm-installer

source /etc/profile.d/rvm.sh

/usr/local/rvm/bin/rvm --skip-autoreconf pkg install readline
/usr/local/rvm/bin/rvm --skip-autoreconf pkg install zlib --verify-downloads 1
/usr/local/rvm/bin/rvm --skip-autoreconf pkg install openssl
/usr/local/rvm/bin/rvm --skip-autoreconf pkg install libyaml
/usr/local/rvm/bin/rvm install ruby-1.9.3-p392 --with-libyaml-dir=/usr/local/rvm/usr/ --with-readline-dir=/usr/local/rvm/usr --with-openssl-dir=/usr/local/rvm/usr/ --with-zlib-dir=/usr/local/rvm/usr/
/usr/local/rvm/bin/rvm alias create default ruby-1.9.3-p392
